From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] completion: add completer for status
Date: Fri, 28 Jun 2013 13:26:31 +0200
Message-ID: <20130628112631.GC16562@goldbirke>
References: <1372094575-20799-1-git-send-email-artagnon@gmail.com>
 <20130628102936.GA16562@goldbirke>
 <20130628105601.GB16562@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 28 13:26:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsWp6-0006tK-6N
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 13:26:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755587Ab3F1L0g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Jun 2013 07:26:36 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:55882 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755423Ab3F1L0f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 07:26:35 -0400
Received: from localhost6.localdomain6 (g226130042.adsl.alicedsl.de [92.226.130.42])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0MVHys-1UlGje1xZW-00Z2cX; Fri, 28 Jun 2013 13:26:32 +0200
Content-Disposition: inline
In-Reply-To: <20130628105601.GB16562@goldbirke>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:QleJfk/CJqv1LoI8odEvy0I8N6GvJQO/SIWvQLdT9Jp
 J3YLbL0qd3LUG7Ger6Yvad/XqrWJeI2GVBwG0daMj3/LKsw1lJ
 /ZWnsWPUjIbrErv2a0T5jGDsOhH1p0B+0HJXy3s7KCtkn0ojog
 a7/p92KGWlxkLqNf7Tfb6N5P7v0sGXl8W0I1emDDuxpNb97Ms4
 /HLt8JEmhcV8MezZ/f7tDtsiN98CFUeQNnB4pbCbWTQvW35ObN
 GsHCyicX0g9SUEtmoghORQDhT9V3YKe25mVZEWScvEhxfYTBH9
 XI2anYhH0RMPpGlSwlCWK6F/h3FPmolcxBonow8jdECV6wudll
 2j8l/ZfWSghb2VmZvjlgPak3cD0pnLk3WFRtA9Qz9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229188>

On Fri, Jun 28, 2013 at 12:56:01PM +0200, SZEDER G=E1bor wrote:
> On Fri, Jun 28, 2013 at 12:29:36PM +0200, SZEDER G=E1bor wrote:
> > On Mon, Jun 24, 2013 at 10:52:55PM +0530, Ramkumar Ramachandra wrot=
e:
> > > Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> > > +	__git_complete_index_file
> >=20
> > With or without this change we can't ask for the status of a certai=
n
> > deleted file:
> >=20
> > $ git rm version.h
> > rm 'version.h'
> > $ git status=20
> > # On branch master
> > # Changes to be committed:
> > #   (use "git reset HEAD <file>..." to unstage)
> > #
> > #       deleted:    version.h
> > #
> > $ git status v<TAB>
> > varint.c   varint.h   vcs-svn/   version.c =20
>=20
> Well, at least the deleted is there if I only remove it from the work
> tree (i.e. use 'rm' instead of 'git rm'):
>=20
> $ rm version.h
> $ git status
> # On branch master
> # Changes not staged for commit:
> #   (use "git add/rm <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working
> #   directory)
> #
> #       deleted:    version.h
> #
> no changes added to commit (use "git add" and/or "git commit -a")
> $ git status v<TAB>
> varint.c   varint.h   vcs-svn/   version.c  version.h =20

Ok, how about this on top?


diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 912fb988..b68024c6 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1697,6 +1697,8 @@ _git_stage ()
=20
 _git_status ()
 {
+	__git_has_doubledash && return
+
 	case "$cur" in
 	--untracked-files=3D*)
 		__gitcomp "no normal all" "" "${cur##--untracked-files=3D}"
@@ -1718,7 +1720,7 @@ _git_status ()
 		return
 		;;
 	esac
-	__git_complete_index_file
+	__git_complete_index_file "--with-tree=3DHEAD --cached --deleted"
 }
=20
 __git_config_get_set_variables ()


In my cursory testing it seemed to do the right thing for deleted and
tracked files:

$ rm version.h
$ git rm version.c
rm 'version.c'
$ echo >varint.h
$ echo >v-added
$ git add v-added=20
$ echo >v-untracked
$ git status=20
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       new file:   v-added
#       deleted:    version.c
#
# Changes not staged for commit:
#   (use "git add/rm <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working
#   directory)
#
#       modified:   varint.h
#       deleted:    version.h
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       v-untracked
$ git status v
v-added    varint.c   varint.h   vcs-svn/   version.c  version.h

Note, however, that this doesn't offer untracked files (Ram's original
didn't do that either), but in case somebody really needs that he can
have it by using '--':

$ git status -- v
v-added      varint.c     varint.h     vcs-svn/     v-untracked


Best,
G=E1bor
