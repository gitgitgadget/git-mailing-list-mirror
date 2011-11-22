From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH 4/3] revert: write REVERT_HEAD pseudoref during conflicted revert
Date: Tue, 22 Nov 2011 19:40:06 -0200
Message-ID: <CACnwZYd3ocb2dx9-2iHH4xmP6_O0M9gRdr3RvDpaAyZq5wPZ0w@mail.gmail.com>
References: <20111120073059.GA2278@elie.hsd1.il.comcast.net>
	<CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com>
	<20111120094650.GB2278@elie.hsd1.il.comcast.net>
	<20111122111207.GA7399@elie.hsd1.il.comcast.net>
	<20111122111736.GE7399@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Phil Hord <phil.hord@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 22 22:40:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSy4b-0005r1-FA
	for gcvg-git-2@lo.gmane.org; Tue, 22 Nov 2011 22:40:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757231Ab1KVVkI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Nov 2011 16:40:08 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:49252 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753278Ab1KVVkI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Nov 2011 16:40:08 -0500
Received: by qyk2 with SMTP id 2so537770qyk.19
        for <git@vger.kernel.org>; Tue, 22 Nov 2011 13:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ILx80LbOi3olQh2VcTh1pVQjYTOTiKBtP7d5UsV/vBU=;
        b=BpOzTmSyPrtTln8Ua7QE287y28/bjnJF/q2ZF2xp/U8TzzgOQbYZG2UXc3IXFg0t7o
         e/KPBlucV6fgo9hYfx8ywbmiemwUS7gzpFErExuVBOFYtSb/pHA4iKnfAGk0xCI0aOcy
         zbDXmISvtUT63JmSGKkyvuJqYq7uJIb80PeOU=
Received: by 10.182.77.231 with SMTP id v7mr7942916obw.4.1321998006363; Tue,
 22 Nov 2011 13:40:06 -0800 (PST)
Received: by 10.182.37.3 with HTTP; Tue, 22 Nov 2011 13:40:06 -0800 (PST)
In-Reply-To: <20111122111736.GE7399@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185811>

There seems to be something wrong with the subject. I says [4/3],
instead of [4/6]?

On Tue, Nov 22, 2011 at 9:17 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> When conflicts are encountered while reverting a commit, it can be
> handy to have the name of that commit easily available. =C2=A0For exa=
mple,
> to produce a copy of the patch to refer to while resolving conflicts:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git revert 2eceb2a8
> =C2=A0 =C2=A0 =C2=A0 =C2=A0error: could not revert 2eceb2a8... awesom=
e, buggy feature
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git show -R REVERT_HEAD >the-patch
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ edit $(git diff --name-only)
>
> Set a REVERT_HEAD pseudoref when "git revert" does not make a commit,
> for cases like this. =C2=A0This also makes it possible for scripts to
> distinguish between a revert that encountered conflicts and other
> sources of an unmerged index.
>
> After successfully committing, resetting with "git reset", or moving
> to another commit with "git checkout" or "git reset", the pseudoref i=
s
> no longer useful, so remove it.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> =C2=A0branch.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A01 +
> =C2=A0builtin/commit.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| =C2=A0 =C2=A01 +
> =C2=A0builtin/revert.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| =C2=A0 =C2=A08 +++--
> =C2=A0t/t3507-cherry-pick-conflict.sh | =C2=A0 54 +++++++++++++++++++=
++++++++++++++++++++
> =C2=A04 files changed, 61 insertions(+), 3 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index d8098762..025a97be 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -241,6 +241,7 @@ void create_branch(const char *head,
> =C2=A0void remove_branch_state(void)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unlink(git_path("CHERRY_PICK_HEAD"));
> + =C2=A0 =C2=A0 =C2=A0 unlink(git_path("REVERT_HEAD"));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unlink(git_path("MERGE_HEAD"));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unlink(git_path("MERGE_RR"));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unlink(git_path("MERGE_MSG"));
> diff --git a/builtin/commit.c b/builtin/commit.c
> index c46f2d18..8f2bebec 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1514,6 +1514,7 @@ int cmd_commit(int argc, const char **argv, con=
st char *prefix)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unlink(git_path("CHERRY_PICK_HEAD"));
> + =C2=A0 =C2=A0 =C2=A0 unlink(git_path("REVERT_HEAD"));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unlink(git_path("MERGE_HEAD"));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unlink(git_path("MERGE_MSG"));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unlink(git_path("MERGE_MODE"));
> diff --git a/builtin/revert.c b/builtin/revert.c
> index 1d112e4c..f5ba67a5 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -289,7 +289,7 @@ static char *get_encoding(const char *message)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;
> =C2=A0}
>
> -static void write_cherry_pick_head(struct commit *commit)
> +static void write_cherry_pick_head(struct commit *commit, const char=
 *pseudoref)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *filename;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int fd;
> @@ -297,7 +297,7 @@ static void write_cherry_pick_head(struct commit =
*commit)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0strbuf_addf(&buf, "%s\n", sha1_to_hex(comm=
it->object.sha1));
>
> - =C2=A0 =C2=A0 =C2=A0 filename =3D git_path("CHERRY_PICK_HEAD");
> + =C2=A0 =C2=A0 =C2=A0 filename =3D git_path(pseudoref);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(filename, O_WRONLY | O_CREAT, =
0666);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fd < 0)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0die_errno(_("C=
ould not open '%s' for writing"), filename);
> @@ -597,7 +597,9 @@ static int do_pick_commit(struct commit *commit, =
struct replay_opts *opts)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * write it at all.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (opts->action =3D=3D CHERRY_PICK && !op=
ts->no_commit && (res =3D=3D 0 || res =3D=3D 1))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 write_cherry_pick_=
head(commit);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 write_cherry_pick_=
head(commit, "CHERRY_PICK_HEAD");
> + =C2=A0 =C2=A0 =C2=A0 if (opts->action =3D=3D REVERT && ((opts->no_c=
ommit && res =3D=3D 0) || res =3D=3D 1))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 write_cherry_pick_=
head(commit, "REVERT_HEAD");
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (res) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error(opts->ac=
tion =3D=3D REVERT
> diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-co=
nflict.sh
> index cb45574a..ee1659c1 100755
> --- a/t/t3507-cherry-pick-conflict.sh
> +++ b/t/t3507-cherry-pick-conflict.sh
> @@ -253,6 +253,60 @@ test_expect_success 'revert also handles conflic=
ts sanely' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_cmp expected actual
> =C2=A0'
>
> +test_expect_success 'failed revert sets REVERT_HEAD' '
> + =C2=A0 =C2=A0 =C2=A0 pristine_detach initial &&
> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git revert picked &&
> + =C2=A0 =C2=A0 =C2=A0 test_cmp_rev picked REVERT_HEAD
> +'
> +
> +test_expect_success 'successful revert does not set REVERT_HEAD' '
> + =C2=A0 =C2=A0 =C2=A0 pristine_detach base &&
> + =C2=A0 =C2=A0 =C2=A0 git revert base &&
> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git rev-parse --verify CHERRY_P=
ICK_HEAD &&
> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git rev-parse --verify REVERT_H=
EAD
> +'
> +
> +test_expect_success 'revert --no-commit sets REVERT_HEAD' '
> + =C2=A0 =C2=A0 =C2=A0 pristine_detach base &&
> + =C2=A0 =C2=A0 =C2=A0 git revert --no-commit base &&
> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git rev-parse --verify CHERRY_P=
ICK_HEAD &&
> + =C2=A0 =C2=A0 =C2=A0 test_cmp_rev base REVERT_HEAD
> +'
> +
> +test_expect_success 'revert w/dirty tree does not set REVERT_HEAD' '
> + =C2=A0 =C2=A0 =C2=A0 pristine_detach base &&
> + =C2=A0 =C2=A0 =C2=A0 echo foo > foo &&
> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git revert base &&
> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git rev-parse --verify CHERRY_P=
ICK_HEAD &&
> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git rev-parse --verify REVERT_H=
EAD
> +'
> +
> +test_expect_success 'GIT_CHERRY_PICK_HELP does not suppress REVERT_H=
EAD' '
> + =C2=A0 =C2=A0 =C2=A0 pristine_detach initial &&
> + =C2=A0 =C2=A0 =C2=A0 (
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GIT_CHERRY_PICK_HE=
LP=3D"and then do something else" &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GIT_REVERT_HELP=3D=
"and then do something else, again" &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 export GIT_CHERRY_=
PICK_HELP GIT_REVERT_HELP &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_must_fail git=
 revert picked
> + =C2=A0 =C2=A0 =C2=A0 ) &&
> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git rev-parse --verify CHERRY_P=
ICK_HEAD &&
> + =C2=A0 =C2=A0 =C2=A0 test_cmp_rev picked REVERT_HEAD
> +'
> +
> +test_expect_success 'git reset clears REVERT_HEAD' '
> + =C2=A0 =C2=A0 =C2=A0 pristine_detach initial &&
> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git revert picked &&
> + =C2=A0 =C2=A0 =C2=A0 git reset &&
> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git rev-parse --verify REVERT_H=
EAD
> +'
> +
> +test_expect_success 'failed commit does not clear REVERT_HEAD' '
> + =C2=A0 =C2=A0 =C2=A0 pristine_detach initial &&
> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git revert picked &&
> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git commit &&
> + =C2=A0 =C2=A0 =C2=A0 test_cmp_rev picked REVERT_HEAD
> +'
> +
> =C2=A0test_expect_success 'revert conflict, diff3 -m style' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pristine_detach initial &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git config merge.conflictstyle diff3 &&
> --
> 1.7.8.rc3
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
