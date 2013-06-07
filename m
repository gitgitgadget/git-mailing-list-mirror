From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: What's cooking in git.git (Jun 2013, #03; Thu, 6)
Date: Fri, 7 Jun 2013 21:34:44 +0200
Message-ID: <20130607193444.GB31625@goldbirke>
References: <7vzjv2x3p7.fsf@alter.siamese.dyndns.org>
 <20130607000006.GA25731@goldbirke>
 <7vli6mwx07.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 21:34:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul2R1-0003fM-Uu
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 21:34:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754148Ab3FGTer convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 15:34:47 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:63633 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920Ab3FGTer (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 15:34:47 -0400
Received: from localhost6.localdomain6 (g228010151.adsl.alicedsl.de [92.228.10.151])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0MFi3J-1UZ9nt0mMX-00EcXY; Fri, 07 Jun 2013 21:34:44 +0200
Content-Disposition: inline
In-Reply-To: <7vli6mwx07.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:1mNLb+StaRmkcS2bs4uhuIaC5A9XVnC+li6Yvnzw8IK
 wz5Q1r8zGXUBG9zwaTquqHZnauiuD4qozn68GKFUgcXMcBTKI4
 vnTAU3IKyrsOLWuY09/blvq7kx/HBCiui3rmcmC4mOLQk1bmNq
 jB872zlvSI78xpXwg84Ds/5kq/Zl/bf5nbokDbRnqSVygy0V1s
 pJ9YRwSLsaFsqCgbrxaqE313fDUDkTS87PxMzEqhZwYfxv+dHJ
 kRk0FXgWjS1aQ7KOGdy/ibBA1H4NuZuHS+hCMfFO0tPG7MExfk
 cowntYvOpF5iaCIjzsrcsl5dpz9o18qmfHZWhuGt/QJ0YrPgR1
 F8yAljhJxpuLuvGeSahm8V4dOElfR0GI7wJ0X8LdV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226685>

On Thu, Jun 06, 2013 at 06:05:44PM -0700, Junio C Hamano wrote:
> SZEDER G=E1bor <szeder@ira.uka.de> writes:
>=20
> > On Thu, Jun 06, 2013 at 03:41:08PM -0700, Junio C Hamano wrote:
> >> * rr/complete-difftool (2013-06-03) 2 commits
> >>   (merged to 'next' on 2013-06-04 at 01c7611)
> >>  + completion: clarify ls-tree, archive, show completion
> >>  + completion: difftool takes both revs and files
> >>=20
> >>  Update command line completion (in contrib/) to use a better name=
d
> >>  completion helper function for commands that take revisions and
> >>  paths.
> >>=20
> >>  Will merge to 'master'.
> >
> > This should not be merged to master as is; the one at the top becau=
se
> > of the reasons given in $gmane/226272, the one at the bottom becaus=
e
> > of the misleading commit message (__git_complete_file() always
> > completed refs first as part of the ref:file notation, so it worked
> > just fine except for the ref1...ref2 notation; the real reason for
> > calling __git_complete_revlist_file() for difftool is to make clear
> > that difftool takes ref1...ref2:file, too).
>=20
> Oops.
>=20
> It is too late to amend the log messages now, but at least a follow-u=
p
> patch can fix the breakage by adding __git_complete_file() back.  Wou=
ld
> you mind doing that?

Is it in master already?  Am I missing something?

Wouldn't it be cleaner to revert those two patches from next and apply
this instead?


 -- >8 --

=46rom: SZEDER G=E1bor <szeder@ira.uka.de>
Subject: [PATCH] completion: be explicit about revlist completion for d=
ifftool
 and show

The completion functions for 'git difftool' and 'git show' call
__git_complete_file() to support completion of the 'ref:path' notation.
However, these two commands also understand the 'ref1..ref2:path'
notation, the completion of which we happen to support accidentaly,
because nowadays __git_complete_file() is a wrapper around
__git_complete_revlist_file().

Let's be explicit about it and call __git_complete_revlist_file()
directly.

Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 56c52c66..fd9a1d5f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1211,7 +1211,7 @@ _git_difftool ()
 		return
 		;;
 	esac
-	__git_complete_file
+	__git_complete_revlist_file
 }
=20
 __git_fetch_options=3D"
@@ -2277,7 +2277,7 @@ _git_show ()
 		return
 		;;
 	esac
-	__git_complete_file
+	__git_complete_revlist_file
 }
=20
 _git_show_branch ()
--=20
1.8.0.220.g4d14ece
