From: Abhijit Menon-Sen <ams@toroid.org>
Subject: absurdly slow git-diff
Date: Sat, 8 Nov 2008 01:31:27 +0530
Message-ID: <20081107200126.GA20284@toroid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 07 21:23:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyXrO-00054V-CZ
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 21:23:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758AbYKGUWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 15:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbYKGUWA
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 15:22:00 -0500
Received: from fugue.toroid.org ([85.10.196.113]:50603 "EHLO fugue.toroid.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751716AbYKGUV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 15:21:59 -0500
X-Greylist: delayed 1215 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Nov 2008 15:21:59 EST
Received: from penne.toroid.org (penne-vpn [10.8.0.6])
	by fugue.toroid.org (Postfix) with ESMTP id 636B4558541
	for <git@vger.kernel.org>; Fri,  7 Nov 2008 21:01:39 +0100 (CET)
Received: by penne.toroid.org (Postfix, from userid 1000)
	id 2C7FC3880C3; Sat,  8 Nov 2008 01:31:27 +0530 (IST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100329>

I have a 240k-line file, and I change one character on every sixth line.
The resulting diff gives git serious indigestion:

$ git --version
git version 1.6.0.3.640.g6331a
$ mkdir a; cd a; git init
Initialized empty Git repository in /home/ams/a/.git/
$ cp ../1 .; git add 1; git commit -q -m 1
$ cp ../2 1; git add 1; git commit -q -m 2 
$ time git show HEAD > x
git show HEAD > x  309.88s user 0.46s system 97% cpu 5:17.06 total

(I use commit -q above not only for brevity; for the second commit,
calculating the diffstat takes the same five minutes that git show,
git log -p, git log --stat etc. all take.)

Note that diff(1) can handle the patch fine:

$ time diff -u ../1 ../2 >/dev/null
diff -u ../1 ../2 > /dev/null  0.30s user 0.06s system 69% cpu 0.519 total

If anyone's interested, the files are http://toroid.org/misc/1 and
http://toroid.org/misc/2

Does anyone understand why this slowdown might happen or have
suggestions about where I should look for it?

Thanks.

-- ams
