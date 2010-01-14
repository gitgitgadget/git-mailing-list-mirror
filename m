From: Marko Poutiainen <regs@sofistes.net>
Subject: Gitignore matching "git add" wildcard prevents operation
Date: Thu, 14 Jan 2010 20:18:40 +0200
Message-ID: <4B4F6000.4070005@sofistes.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 19:28:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVUQa-0005mx-CV
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 19:28:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754421Ab0ANS2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 13:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754267Ab0ANS2J
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 13:28:09 -0500
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:55697 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754129Ab0ANS2I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 13:28:08 -0500
X-Greylist: delayed 563 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Jan 2010 13:28:08 EST
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh04-2.mail.saunalahti.fi (Postfix) with SMTP id 32CF413B634
	for <git@vger.kernel.org>; Thu, 14 Jan 2010 20:18:42 +0200 (EET)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A05A2E341E2; Thu, 14 Jan 2010 20:18:42 +0200
Received: from [192.168.0.24] (a91-155-40-90.elisa-laajakaista.fi [91.155.40.90])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 1E9FD1C6391
	for <git@vger.kernel.org>; Thu, 14 Jan 2010 20:18:40 +0200 (EET)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
X-Enigmail-Version: 0.96.0
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137008>

It seems that that there is a bug related to how Git handles the add
command with wildcards if the wildcard also matches a file that is ignored.

E.g (I activate the *.[ao] rule when editing .git/info/exclude):

mep@Blackbird:~$ cd /tmp
mep@Blackbird:/tmp$ mkdir git
mep@Blackbird:/tmp$ cd git
mep@Blackbird:/tmp/git$ git init
Initialized empty Git repository in /tmp/git/.git/
mep@Blackbird:/tmp/git$ nano -w .git/info/exclude
mep@Blackbird:/tmp/git$ touch a.o a.c a.h
mep@Blackbird:/tmp/git$ git add a.*
The following paths are ignored by one of your .gitignore files:
a.o
Use -f if you really want to add them.
fatal: no files added
mep@Blackbird:/tmp/git$ git status
# On branch master
#
# Initial commit
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       a.c
#       a.h
#       a.o
nothing added to commit but untracked files present (use "git add" to track)

Furthermore:

mep@Blackbird:/tmp/git$ git add .
mep@Blackbird:/tmp/git$ git commit -m "foo"
[master (root-commit) 43da825] foo
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 a.c
 create mode 100644 a.h
mep@Blackbird:/tmp/git$ nano a.c
mep@Blackbird:/tmp/git$ nano a.h
mep@Blackbird:/tmp/git$ git add a.*
The following paths are ignored by one of your .gitignore files:
a.o
Use -f if you really want to add them.
fatal: no files added
mep@Blackbird:/tmp/git$ git status
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working
directory)
#
#       modified:   a.c
#       modified:   a.h
#
no changes added to commit (use "git add" and/or "git commit -a")
