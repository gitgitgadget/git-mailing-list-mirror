Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64408C433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 12:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44A6361251
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 12:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhKJMWB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 07:22:01 -0500
Received: from mout.gmx.net ([212.227.17.20]:35341 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229653AbhKJMWA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 07:22:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636546738;
        bh=i9iygLjh5YSQw9EuqrchkBc3xq2yu/ZM6SBuJv5hua4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=X/X1vTJSVnKDfUqPeOZMS5WOrzuLuIPvdWTS6ftzSjONMEHTOXpC2thxmkYBUtbt9
         B4gmqYc5+7ynwBXKBqF/xZ/QskctEkFhUZNptk+VbNBba7sfumuKMnCsxEgciRhVd8
         Ogr7Z22W8Xj2HxTRL4fMVX+hJUKbTZf9XYDw+v5w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.166.205] ([89.1.212.10]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQeA2-1n7OBb3xlW-00NfWe; Wed, 10
 Nov 2021 13:18:58 +0100
Date:   Wed, 10 Nov 2021 13:18:55 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Anders Kaseorg <andersk@mit.edu>
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Andreas Heiduk <andreas.heiduk@mathema.de>
Subject: Re: [PATCH v5 1/4] fetch: Protect branches checked out in all
 worktrees
In-Reply-To: <20211109230941.2518143-1-andersk@mit.edu>
Message-ID: <nycvar.QRO.7.76.6.2111101315330.21127@tvgsbejvaqbjf.bet>
References: <2f983e36-532f-ac87-9ade-fba4c6b9d276@mit.edu> <20211109230941.2518143-1-andersk@mit.edu>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-898277111-1636546543=:21127"
Content-ID: <nycvar.QRO.7.76.6.2111101316060.21127@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:VVEX6SwU0O3oHSwgFVOEZOcBGdtwglXynFrLnYKUbZMaMbSFPTE
 ct80jZfEDap9n/Zi7uOrZZzYHeLWIrueJownM3TlTLQpUbYSB5alnemPf/SDDp6IUYaLMwr
 Kcdcc4BYOBqG5FCet0UQ9IXemfPp8xv7OWxLkdiuKWosV61HKu2QQG3yxxEc+W2k+zuuyR3
 5tQVsVRf6kltKdz9GL/mg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yhYvVP5QjP0=:9MMn9dKiqne98mPGXE8Ve1
 1InFmLbIhDwJhkHTSGIoMZlW8cdAsdTqzForHAcblkGlnbCWDe7J7NbjvMeoVJpm/UcYJ22aP
 GXwgNTmyy7k/Iyp6vJxrVowcL8Hy1ku6xr1JM2DIsQT798zgD+cl4oyG0tSkGlhkCFp9iQDol
 I7eHzEYa4BF0CJbKDmDWX07HK0Uan96YCro80f8QoZLzzMOCSvM1QvioGh5Tw++NKHQeWswPL
 JqhC+MpWKwYUHFhxYTI0ZM6HBc9rXJ4mssq4TA6nmRRqDvFGV2ugZxZC38gWn1KN3sarfuEmN
 mrQwSl+Wf8F8YCSih35rUAAhMqsq3XfOEP9NAtscnaBoKRLb4xnCKGMCUWB9Y93cyOmLzuMTG
 EeWOr79W4xLAI55g1GiJAKT7APfOCZjt7kTLecGs9dvydVmJUiXxZoQ91x1F9mnGD/Mph9a1c
 ic1vA5jW5Dp9gIwq5YJnT6S+vu64RJ2Om+yWkqIbZSKSQT9tsnDClVC1v2eqwrEMtUcihed+G
 MF5RcPZeqOP2qLEw74Oo6gGXBW+aUL5P/gmklKgyyk0qMZ9HkuxNP8VZP6UPodFNRU98xXF5G
 VovH6rfQg/mhn7YrwUg/eOgThHocxpUAVFaqDupJ+I+rrJTUCzsypzwFe/p1WSe4uPp7TGdXu
 gL0jSOoXWENOBsuRdd3UTjpSXh5wViK7HqF2ARTROEVABUTDGdIiAAiZAkE7+vGa8pnJXNfOY
 cIpoofF7UAJQ3qIru131iZnkU5bfIGBZMCa/qmy+snTVjWEVXnMqPD+O2E57j3J+JQcmtt77N
 NrBZjMS9eTMHecQdyBm5dgBwbOInYMj88oF8A8+bZQiHcmMuD9s2oeKr50zwH4o00l/xz/DwQ
 chaGaXkK7DoS/wRG1tm/Rav7vLvvmLafsWoBI1BRjMbk2P36F3oa3AtaUHz7EYX80Twfwmu4B
 hx2RgF5EqcrFHBiKPTpu3aD9toWILJd+RZAQqk1ANFpTxxZRNX0dp4Zcfg4B15UzmjpFT96gc
 SIWV6k9VFTZF0/XttnwSYJk0Yt2WCmH6BXdRNnprO7Xvm7m6qHkkP2lw18K8OMU8cKicDJSgv
 JuO/QTq9toWjjg=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-898277111-1636546543=:21127
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.2111101316061.21127@tvgsbejvaqbjf.bet>

Hi Anders,

responding here instead of to the cover letter (because there is none
;-)): great work!

Others pointed out the really tiny nit that some phrases should start with
lower-case, which would be nice to see addressed. I did not find any major
issue anymore (apart from the slightly iffy assumption that `buf->ref`
starts with `refs/heads/` and therefore `buf->ref + strlen("refs/heads/")`
would not overrun, but I _think_ the current code enforces that prefix
somewhere along the lines), so:

	Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Thank you for this contribution!
Dscho

On Tue, 9 Nov 2021, Anders Kaseorg wrote:

> Refuse to fetch into the currently checked out branch of any working
> tree, not just the current one.
>
> Fixes this previously reported bug:
>
> https://public-inbox.org/git/cb957174-5e9a-5603-ea9e-ac9b58a2eaad@mathem=
a.de
>
> As a side effect of using find_shared_symref, we=E2=80=99ll also refuse =
the
> fetch when we=E2=80=99re on a detached HEAD because we=E2=80=99re rebasi=
ng or bisecting
> on the branch in question. This seems like a sensible change.
>
> Signed-off-by: Anders Kaseorg <andersk@mit.edu>
> ---
>  builtin/fetch.c       | 29 +++++++++++++++--------------
>  t/t5516-fetch-push.sh | 18 ++++++++++++++++++
>  2 files changed, 33 insertions(+), 14 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index f7abbc31ff..ed8a906717 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -28,6 +28,7 @@
>  #include "promisor-remote.h"
>  #include "commit-graph.h"
>  #include "shallow.h"
> +#include "worktree.h"
>
>  #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
>
> @@ -854,7 +855,7 @@ static int update_local_ref(struct ref *ref,
>  			    int summary_width)
>  {
>  	struct commit *current =3D NULL, *updated;
> -	struct branch *current_branch =3D branch_get(NULL);
> +	const struct worktree *wt;
>  	const char *pretty_ref =3D prettify_refname(ref->name);
>  	int fast_forward =3D 0;
>
> @@ -868,16 +869,18 @@ static int update_local_ref(struct ref *ref,
>  		return 0;
>  	}
>
> -	if (current_branch &&
> -	    !strcmp(ref->name, current_branch->name) &&
> -	    !(update_head_ok || is_bare_repository()) &&
> +	if (!update_head_ok &&
> +	    (wt =3D find_shared_symref("HEAD", ref->name)) &&
> +	    !wt->is_bare &&
>  	    !is_null_oid(&ref->old_oid)) {
>  		/*
>  		 * If this is the head, and it's not okay to update
>  		 * the head, and the old value of the head isn't empty...
>  		 */
>  		format_display(display, '!', _("[rejected]"),
> -			       _("can't fetch in current branch"),
> +			       wt->is_current ?
> +			       _("can't fetch in current branch") :
> +			       _("checked out in another worktree"),
>  			       remote, pretty_ref, summary_width);
>  		return 1;
>  	}
> @@ -1387,16 +1390,14 @@ static int prune_refs(struct refspec *rs, struct=
 ref *ref_map,
>
>  static void check_not_current_branch(struct ref *ref_map)
>  {
> -	struct branch *current_branch =3D branch_get(NULL);
> -
> -	if (is_bare_repository() || !current_branch)
> -		return;
> -
> +	const struct worktree *wt;
>  	for (; ref_map; ref_map =3D ref_map->next)
> -		if (ref_map->peer_ref && !strcmp(current_branch->refname,
> -					ref_map->peer_ref->name))
> -			die(_("Refusing to fetch into current branch %s "
> -			    "of non-bare repository"), current_branch->refname);
> +		if (ref_map->peer_ref &&
> +		    (wt =3D find_shared_symref("HEAD", ref_map->peer_ref->name)) &&
> +		    !wt->is_bare)
> +			die(_("Refusing to fetch into branch '%s' "
> +			      "checked out at '%s'"),
> +			    ref_map->peer_ref->name, wt->path);
>  }
>
>  static int truncate_fetch_head(void)
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 8212ca56dc..f07e32126f 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1771,4 +1771,22 @@ test_expect_success 'denyCurrentBranch and worktr=
ees' '
>  	git -C cloned push origin HEAD:new-wt &&
>  	test_must_fail git -C cloned push --delete origin new-wt
>  '
> +
> +test_expect_success 'refuse fetch to current branch of worktree' '
> +	test_when_finished "git worktree remove --force wt && git branch -D wt=
" &&
> +	git worktree add wt &&
> +	test_commit apple &&
> +	test_must_fail git fetch . HEAD:wt &&
> +	git fetch -u . HEAD:wt
> +'
> +
> +test_expect_success 'refuse fetch to current branch of bare repository =
worktree' '
> +	test_when_finished "rm -fr bare.git" &&
> +	git clone --bare . bare.git &&
> +	git -C bare.git worktree add wt &&
> +	test_commit banana &&
> +	test_must_fail git -C bare.git fetch .. HEAD:wt &&
> +	git -C bare.git fetch -u .. HEAD:wt
> +'
> +
>  test_done
> --
> 2.33.1
>
>

--8323328-898277111-1636546543=:21127--
