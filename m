From: "Gaer, A." <Andreas.Gaer@baslerweb.com>
Subject: git performance after directory copy
Date: Mon, 20 Sep 2010 11:20:44 +0200
Message-ID: <C5A8FDEFF7647F4C9CB927D7DEB307730F33B7C9@ahr075s.basler.corp>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 20 11:20:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxcYO-0002dp-TT
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 11:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756033Ab0ITJUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 05:20:47 -0400
Received: from mail01.baslerweb.com ([80.156.24.166]:1213 "EHLO
	mail01.baslerweb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755678Ab0ITJUr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Sep 2010 05:20:47 -0400
Received: from mail.baslerweb.com ([80.156.24.162])
  by mail01-out.baslerweb.com with ESMTP; 20 Sep 2010 11:21:31 +0200
Received: (from smtpd@127.0.0.1) by mail.baslerweb.com (8.13.4/8.13.4)
	id o8K9KjsZ012519 for <git@vger.kernel.org>; Mon, 20 Sep 2010 11:20:45 +0200
Received: from unknown [80.156.24.166] by gateway id /processing/kwNR4Ln9; Mon Sep 20 11:20:45 2010
Received: from unknown (HELO AHR075S.basler.corp) ([172.16.20.75])
  by mail01-out.baslerweb.com with ESMTP; 20 Sep 2010 11:21:31 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git performance after directory copy
Thread-Index: ActYovLGQazmCQdjTNmfdA3XvlVOoAAAfBDQ
X-SecurE-Mail-Gateway: Version: 5.00.3.1 (smtpd: 6.53.8.7) Date: 20100920092045Z
Content-class: urn:content-classes:message
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156603>

Hello all,

while moving a project directory around I stumbled over an interesting
phenomenon. On a copied source directory "git status" seems to be about
3 times slower than on the original directory. Only after a "git reset"
both copies behave the same again. Is this connected to the timestamps
of files & directories? Actually I would like to move the project
directories of several software developers to a new partition and
forcing them all to "git reset" in all of their repos is a little bit
annoying. Any suggestions how to "repair" the repos less intrusive?

Here's how I measured. The trees reside on an ext3 FS. I have lots of
free RAM, so after the first operation all further "git status" seem to
run from FS cache in RAM.

$ git clone <path to your preferred kernel>
$ cd kernel
$ time git status # several times!
...
$ time git status
# On branch master
nothing to commit (working directory clean)

real    0m0.691s
user    0m0.256s
sys     0m0.356s

$ cd ..
$ rsync -a kernel/ kernel2/
$ cd kernel2
$ time git status # several times!
...
$ time git status
# On branch master
nothing to commit (working directory clean)

real    0m2.705s
user    0m1.724s
sys     0m0.816s

$ git reset
$ time git status
# On branch master
nothing to commit (working directory clean)

real    0m0.704s
user    0m0.296s
sys     0m0.348s

Regards,
 Andreas.
