From: Yves Orton <yves.orton@booking.com>
Subject: git-rev-parse --show-cdup returns a relative path instead of
	absolute (problem with git pull --rebase not finding the git dir)
Date: Tue, 15 Jul 2008 16:13:28 +0200
Message-ID: <1216131208.19334.171.camel@gemini>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 15 16:14:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIlIW-0006l1-I6
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 16:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753747AbYGOONd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 10:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753260AbYGOONc
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 10:13:32 -0400
Received: from msx1.activehotels.net ([62.190.24.9]:36444 "EHLO
	mx1.activehotels.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752155AbYGOONc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 10:13:32 -0400
Received: from p5098d9db.dip0.t-ipconnect.de ([80.152.217.219] helo=[192.168.250.20])
	by mx1.activehotels.net with esmtpsa (SSLv3:AES256-SHA:256)
	(Exim 4.50)
	id 1KIlHV-00071x-KI
	for git@vger.kernel.org; Tue, 15 Jul 2008 15:13:29 +0100
X-Mailer: Evolution 2.22.3.1 
X-AH-Spam-Helo: [192.168.250.20]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88557>

Hi,

Im reporting this based on a conversation I had in the #git channel on
freenode.

I have a setup where various subdirectories of a number of git repos are
symlinked into a common directory tree. Something like what the
following would create but with more repositories involved:

cd ~; mkdir foo; chdir foo; git init; mkdir bar; git add bar ; git
commit -m'add bar' ; cd ~; ln -s foo/bar bar ; cd bar; 

[try various git commands, not all will work]

Most git command seem perfectly happy to work on the correct repos from
this symlinked tree. However at least one doesnt, git pull --rebase, in
particular.

Doing a 

	git-rev-parse --git-dir 

seems to behave correctly (always finding the correct location) and 

	git-rev-parse --is-inside-work-dir

reports true. However git-pull --rebase responds with lots of "fatal:
Not a git repository" messages. Example is below.

During discussion about this on #git it was suggested this was because 

	git-rev-parse --show-cdup 

returns a relative path. (../).

Im not on list so id appreciate it if anyone replying to this could cc
me on the mail.

Oh, i am aware of submodules but i have to work with what i have now. 

Cheers,
yves


Example of git pull --rebase failing yet git commit working:

[dmq@somewhere apps]$ echo test > test.txt
[dmq@somewhere apps]$ git add test.txt
[dmq@somewhere apps]$ git commit -m'add a test file -- will remove next
commit'
Created commit 45ab725: add a test file -- will remove next commit
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 apps/test.txt
[dmq@somewhere apps]$ git rm test.txt
rm 'apps/test.txt'
[dmq@somewhere apps]$ git commit -m'removed test file'
Created commit 2768e6d: removed test file
 1 files changed, 0 insertions(+), 1 deletions(-)
 delete mode 100644 apps/test.txt
[dmq@somewhere apps]$ git pull --rebase
fatal: Not a git repository
fatal: Not a git repository
fatal: Not a git repository
fatal: Not a git repository
