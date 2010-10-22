From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: possible bug when pushing with multiple remote repos.
Date: Fri, 22 Oct 2010 11:32:07 +0200
Message-ID: <AANLkTikkBoJ-dHSZ7H3_LGdzEmpQw5A2Q723tmY_kiPZ@mail.gmail.com>
References: <1287738771.13348.34.camel@amolinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 11:32:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9DzI-0005NR-PG
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 11:32:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753538Ab0JVJcb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Oct 2010 05:32:31 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:58493 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753485Ab0JVJca convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Oct 2010 05:32:30 -0400
Received: by ywk9 with SMTP id 9so499334ywk.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 02:32:29 -0700 (PDT)
Received: by 10.42.12.131 with SMTP id y3mr1892419icy.211.1287739949285; Fri,
 22 Oct 2010 02:32:29 -0700 (PDT)
Received: by 10.229.232.4 with HTTP; Fri, 22 Oct 2010 02:32:07 -0700 (PDT)
In-Reply-To: <1287738771.13348.34.camel@amolinux>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159671>

On Fri, Oct 22, 2010 at 11:12 AM, Arnaud Mouiche
<arnaud.mouiche@invoxia.com> wrote:
> Hi,
>
> I found a behavior which is, at least, different from what "git help
> push" seems to declare.
> basically:
> - if I have 2 remotes : 'origin' and 'remote_B'
> - if I checkout with tracking a branch of 'remote_B'
> - if I do "git push remote" or "git push" or "git push -repo=3Dremote=
_B"
> then git try to push all my branches of "origin" to remote_B.
>
> I check with latest git 1.7.3.2, and the issue is still here.
>
> strangely:
> - git checkout master
> - git push =A0=3D> =A0this is OK, and doesn't try to push any remote_=
B
> references to origin.
>
> I found this is particularity error prone as origin/master can be a f=
ast
> forward of remote_B/master, and in this case nobody will complains..
> (that's what happened to me ;-) )

This is because "git push" pushes matching branches by default if you
don't specify the refspec. From the git push manpage:

       <refspec>...
=2E..
           The special refspec : (or +: to allow non-fast-forward updat=
es)
           directs git to push "matching" branches: for every branch th=
at
           exists on the local side, the remote side is updated if a br=
anch of
           the same name already exists on the remote side. This is the
           default operation mode if no explicit refspec is found (that=
 is
           neither on the command line nor in any Push line of the
           corresponding remotes file---see below).

It may be worth pointing this out in the description.

(I hope the scissor patch is well formated, and the mua doesn't mangle =
it)
-----8<-----
Doc: git-push: Specify the default mode in the description

Signed-off-by: Santi B=E9jar <santi@agolina.net>
---
 Documentation/git-push.txt |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index e11660a..9a2a93e 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -23,6 +23,8 @@ You can make interesting things happen to a repositor=
y
 every time you push into it, by setting up 'hooks' there.  See
 documentation for linkgit:git-receive-pack[1].

+The default operation mode if no explicit refspec is found is
+to push "matching" branches, see below.

 OPTIONS[[OPTIONS]]
 ------------------
--=20
1.7.3.rc1.227.gee5c7b
