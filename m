From: Yann Droneaud <ydroneaud@opteya.com>
Subject: Another core.safecrlf behavor with git diff/git status
Date: Mon, 24 Jun 2013 18:37:04 +0200
Organization: OPTEYA
Message-ID: <866f886ef5e48ba22eec0f67203666bb@meuh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 24 18:37:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur9lR-0006O2-Hu
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 18:37:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069Ab3FXQhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 12:37:07 -0400
Received: from mx-out.ocsa-data.net ([194.36.166.37]:49182 "EHLO
	mx-out.ocsa-data.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569Ab3FXQhG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 12:37:06 -0400
Received: from [192.168.111.12] (helo=rc.ouvaton.coop)
	by mx-out.ocsa-data.net with esmtpa (Exim - FreeBSD Rulez)
	id 1Ur9lJ-000JOY-6f
	for <git@vger.kernel.org>; Mon, 24 Jun 2013 18:37:05 +0200
X-Sender: ydroneaud@opteya.com
User-Agent: Roundcube Webmail/0.9.2
X-abuse-contact: abuse@ocsa-data.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228849>

Hi,

I'm still trying to use .gitattributes "text" flag with CRLF line ending 
files
under Linux.

I'm surprised about the interaction between the index and the working 
directory,
more specificaly about the interaction between git diff and git status:

   $ git init
   Initialized empty Git repository in /home/ydroneaud/tmp/.git/
   $ echo "test text" > .gitattributes
   $ git add .gitattributes
   $ git commit -m ".gitattributes"
   [master (root-commit) 67c2a06] attrib
    1 file changed, 1 insertion(+)
    create mode 100644 .gitattributes
   $ printf "One\r\nLine\r\n" > test
   $ git add test
   warning: CRLF will be replaced by LF in test.
   The file will have its original line endings in your working 
directory.
   $ git commit -m "test"
   [master 8b06aed] test
   warning: CRLF will be replaced by LF in test.
   The file will have its original line endings in your working 
directory.
    1 file changed, 2 insertions(+)
    create mode 100644 test
   $ git diff
   # <git diff report nothing>
   $ touch test
   $ git diff
   warning: CRLF will be replaced by LF in test.
   The file will have its original line endings in your working 
directory.
   $ git diff                                    # <= twice
   warning: CRLF will be replaced by LF in test.
   The file will have its original line endings in your working 
directory.
   $ git status
   # On branch master
   nothing to commit, working directory clean
   $ git diff
   # <git diff report nothing>


- Why git diff does not always report the CRLF/LF mismatch ?

- Why git status does not report about the CRLF/LF mismatch before 
updating the index:
   it silently hide the CRLF/LF warning.
   git add, git commit report the warning. git status should probably do 
the same.

Regards.

-- 
Yann Droneaud
OPTEYA
