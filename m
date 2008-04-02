From: "Marco Maggi" <marco.maggi-ipsu@poste.it>
Subject: bug in make install
Date: Wed,  2 Apr 2008 21:43:36 +0200
Message-ID: <JYPQSO$FF146173479D39756CA6CA952130001D@poste.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: "git" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 02 22:05:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jh9Ce-0003MM-UV
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 22:05:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753990AbYDBUEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2008 16:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753827AbYDBUEQ
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 16:04:16 -0400
Received: from relay-pt1.poste.it ([62.241.4.164]:44504 "EHLO
	relay-pt1.poste.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439AbYDBUEP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Apr 2008 16:04:15 -0400
X-Greylist: delayed 1238 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Apr 2008 16:04:15 EDT
Received: from poste.it (192.168.144.253) by relay-pt1.poste.it (7.3.122) (authenticated as marco.maggi-ipsu@poste.it)
        id 47F2CD0100010387 for git@vger.kernel.org; Wed, 2 Apr 2008 21:43:36 +0200
X-Sensitivity: 3
X-XaM3-API-Version: 4.3 (R1) (B3pl19)
X-SenderIP: 90.131.178.70
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78710>

Ciao,

upon installing GIT I  was bitten by the following behaviour
of  GNU   Bash  3.1  (from  the  Info   node  "Bourne  Shell
Builtins"):

| If a non-empty directory name from `CDPATH' is used, or if
| `-'  is the first  argument, and  the directory  change is
| successful,  the  absolute  pathname  of the  new  working
| directory is written to the standard output.

this is  triggered by setting "CDPATH=.",  that is including
"." in the list, when "templates/Makefile" does:

| (cd blt && $(TAR) cf - .) \
| (cd '$(DESTDIR_SQ)$(template_dir_SQ)' && umask 022 &&
$(TAR) xf -)

the absolute file name goes into the pipe and the "tar xf -"
fails  with  a "this  does  not  look  like a  tar  archive"
error. The problem is fixed by:

| (cd ./blt && $(TAR) cf - .)
|     ^^

Do not bother me asking why I put "." in CDPATH.

By the  way: the use of  tar annoys me a  little because the
installed files  are 0640, rather  than 0644, and I  have to
fix it while building my custom Slackware package. :/

-- 
Marco Maggi

"Now feel the funk blast!"
Rage Against the Machine - "Calm like a bomb"
