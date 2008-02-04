From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [BUG] (minor) "git status ." reports added files as untracked
Date: Mon, 04 Feb 2008 18:19:09 +0100
Message-ID: <vpqtzko8ws2.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 04 18:21:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM508-0004Bj-1X
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 18:21:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766AbYBDRU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 12:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753877AbYBDRU2
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 12:20:28 -0500
Received: from imag.imag.fr ([129.88.30.1]:57287 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753230AbYBDRU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 12:20:27 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m14HJFiG023398
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 4 Feb 2008 18:19:15 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1JM4yL-0001at-KE; Mon, 04 Feb 2008 18:19:09 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1JM4yL-0003xY-HY; Mon, 04 Feb 2008 18:19:09 +0100
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 04 Feb 2008 18:19:15 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72527>

Hi,

I have a minor bug with git (head of master today): Briefly, added
files in a toplevel directory show up as "untracked" for 
"git status ." in a subdirectory. See below to reproduce.

Indeed, I've always considered the fact that "git status ." reports
untracked files outside the current directory as a bug, but I'm not
sure whether this is intended or not. If not, then not looking for
untracked files oustide the directory when doing a limited "status"
would be a fix.

No time for a patch, appologize :-(.

/tmp/test$ git init
Initialized empty Git repository in .git/
/tmp/test$ mkdir subdir
/tmp/test$ touch file1
/tmp/test$ git add file1
/tmp/test$ touch subdir/file2
/tmp/test$ cd subdir/
/tmp/test/subdir$ git add file2
/tmp/test/subdir$ git status .
# On branch master
#
# Initial commit
#
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       new file: file2
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       ../file1                     <------------------- this one 
                                                          shouldn't be here
/tmp/test/subdir$ git status
# On branch master
#
# Initial commit
#
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       new file: ../file1
#       new file: file2
#

Regards,

--
Matthieu
