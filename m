From: "Jonas Bang" <email@jonasbang.dk>
Subject: Git feature request: Option to force Git to abort a checkout if working directory is dirty (i.e. disregarding the check for conflicts)
Date: Thu, 27 Mar 2014 17:15:33 +0100
Message-ID: <004d01cf49d7$c8b9cd90$5a2d68b0$@jonasbang.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 27 17:25:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTD7O-0004UU-Bu
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 17:25:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756955AbaC0QZT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Mar 2014 12:25:19 -0400
Received: from mail6.surf-town.net ([212.97.132.46]:51681 "EHLO
	mailgw13.surf-town.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756953AbaC0QZQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2014 12:25:16 -0400
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Mar 2014 12:25:15 EDT
Received: by mailgw13.surf-town.net (Postfix, from userid 65534)
	id ECBFA40293; Thu, 27 Mar 2014 17:15:40 +0100 (CET)
Received: from localhost (unknown [127.0.0.1])
	by mailgw13.surf-town.net (Postfix) with ESMTP id D66E24025D
	for <git@vger.kernel.org>; Thu, 27 Mar 2014 17:15:40 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mailgw13.surf-town.net
X-Spam-Flag: NO
X-Spam-Score: -1.44
X-Spam-Level: 
X-Spam-Status: No, score=-1.44 tagged_above=-999 required=7
	tests=[ALL_TRUSTED=-1.44] autolearn=disabled
Received: from mailgw13.surf-town.net ([127.0.0.1])
	by localhost (mailgw13.surf-town.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 4GMZTXDEr7y1 for <git@vger.kernel.org>;
	Thu, 27 Mar 2014 17:15:34 +0100 (CET)
Received: from Mainframe (unknown [5.103.38.58])
	(Authenticated sender: email@jonasbang.dk)
	by mailgw13.surf-town.net (Postfix) with ESMTPA id E8D0740299
	for <git@vger.kernel.org>; Thu, 27 Mar 2014 17:15:32 +0100 (CET)
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac9J17qOWDGONsycSNCfLslGDF24Pg==
Content-Language: da
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245289>

Hi Git developers,=20

This is my first Git feature request, I hope it won=92t get me hanged o=
n the
gallows ;o)=20

*Git feature request:*
Add an option to Git config to configure the criteria for when a "git
checkout" should abort.=20

*Name proposal and options:*
checkout.clean false <default>=20
checkout.clean true=20

*False behavior:*
As is:=20
When doing a checkout then Git will check if your working directory is
dirty, and if so check if the checkout will result in any conflicts, an=
d if
so abort the checkout with a message:=20

$ git checkout some_branch
error: Your local changes to the following files would be overwritten b=
y
checkout:
=A0 =A0 =A0 =A0some_file
Please, commit your changes or stash them before you can switch branche=
s.
Aborting=20

If no conflicts then:=20

$ git checkout some_branch
M =A0 =A0 =A0 some_file
M =A0 =A0 =A0 some_other_file
Switched to branch 'some_branch'=20

I.e. it will only abort if there are conflicts.=20

*True behavior:*
When doing a checkout then Git will check if your working directory is =
dirty
(checking for both modified and added untracked files), and if so abort=
 the
checkout with a message:=20

$ git checkout some_branch
error: Your working directory is not clean.
Please, commit your changes or stash them before you can switch branche=
s.
Aborting=20

I.e. it will abort if working directory is dirty (checking for both mod=
ified
and added untracked files).=20
I.e. you can only do checkout if you get "nothing to commit, working
directory clean" when running "git status" (ignoring ignored files thou=
gh).=20

*Usecase in short:*
If you use an IDE (like e.g. Eclipse) and do a checkout
of=A0'some_branch'=A0with a dirty working directory which will not resu=
lt in any
conflicts, then you will not be nicely notified (as you would in Git Ba=
sh)
that the changes you were working on in=A0'previous_branch'=A0are still=
 present
in your working directory after changing to=A0'some_branch'. I.e. when =
you
compile your code your uncommitted changes from=A0'previous_branch'=A0a=
re still
present in your working directory on=A0'some_branch'.=20

As I see it Git is extremely strong in context switching (i.e. working =
on
multiple issues on multiple branches), and I could see a use for a sett=
ing
which setup a strict check for if working directory is not clean
(disregarding the check for conflicts). This would mean that your chang=
es
created while on branch #1 will not be carried over when changing to br=
anch
#2, i.e. you will work strictly context based always.=20

*Usecase also described here:*
http://stackoverflow.com/questions/22609566/how-to-force-git-to-abort-a=
-chec
kout-if-working-directory-is-not-clean-i-e-dis=20

Br,=20
Jonas Bang Christensen
