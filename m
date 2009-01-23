From: Pixel <pixel@mandriva.com>
Subject: bug: transform a binary file into a symlink in one commit => invalid binary patch
Date: Fri, 23 Jan 2009 13:25:30 +0100
Message-ID: <lyhc3q9pl1.fsf@leia.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 23 13:53:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQLXN-0000OR-5p
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 13:53:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754837AbZAWMwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 07:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754766AbZAWMwF
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 07:52:05 -0500
Received: from mx1.moondrake.net ([212.85.150.166]:46497 "EHLO
	mx1.mandriva.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754717AbZAWMwE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 07:52:04 -0500
X-Greylist: delayed 1611 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Jan 2009 07:52:04 EST
Received: by mx1.mandriva.com (Postfix, from userid 501)
	id EEF30274004; Fri, 23 Jan 2009 13:25:11 +0100 (CET)
X-Spam-Virus: No
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on mx1.mandriva.com
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=6.0 tests=AWL,BAYES_00,
	RCVD_IN_DNSWL_LOW autolearn=ham version=3.2.5
Received: from office-abk.mandriva.com (office-abk.mandriva.com [84.55.162.90])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.mandriva.com (Postfix) with ESMTP id 9672B274003
	for <git@vger.kernel.org>; Fri, 23 Jan 2009 13:25:10 +0100 (CET)
Received: from leia.mandriva.com (fw2.mandriva.com [192.168.2.3])
	by office-abk.mandriva.com (Postfix) with ESMTP id AE6F282926
	for <git@vger.kernel.org>; Fri, 23 Jan 2009 13:28:53 +0100 (CET)
Received: by leia.mandriva.com (Postfix, from userid 505)
	id 1AA0B23F80; Fri, 23 Jan 2009 13:25:30 +0100 (CET)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106878>

hi, 

i hit a bug (git 1.6.1): when you transform a binary file into a
symlink in one commit, the binary patch can't be used in "git apply".
Is it a known issue?


reproducer: 

----------
#!/bin/sh -e

# the bug: if you transform a binary file into a symlink in one commit, 
# the binary patch can't be used in "git apply"
#
# nb: if you uncomment the "##" lines, the problem disappears
# since the first patch will empty the binary file then the non-binary file
# will be transformed into a symlink

rm -rf t t2
mkdir t
dd if=/dev/urandom of=t/a count=10
cp -r t t2

cd t
git init
git add .
git commit -m initial

##echo -n > a
##git commit -a -m foo
ln -sf zzz a
git commit -a -m foo2
git format-patch :/initial

cd ../t2
git apply ../t/*.patch

cd ..
rm -rf t t2
----------
