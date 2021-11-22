Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A25FC433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 14:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbhKVOVt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 09:21:49 -0500
Received: from mout.gmx.net ([212.227.17.22]:55661 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232494AbhKVOVt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 09:21:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637590717;
        bh=LbCvqvfW6VkwGsjVblz2yVUZJQ/J3dIqYdycemP3SYA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=c1l1GPXH6IG+32nIbF7Qj/fT99D31xd5rWOG09K8mqnvCobiMmmi+1FkFO+Wf1wQz
         mYtK/k9l0+8zJGjRwvSbyXGEW7rbTgK3L0hk3+kFdDSD8yx2d5suZyE4nx9x4B3yf9
         Hqg4yyue2PLJxdfolcBFfTwmHGv4Jm0Oap5UR+w8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.219]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1wll-1mdnKE3lgP-012F4l; Mon, 22
 Nov 2021 15:18:36 +0100
Date:   Mon, 22 Nov 2021 15:18:34 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 06/15] diff --color-moved: avoid false short line
 matches and bad zerba coloring
In-Reply-To: <10b11526206d3b515ba08ac80ccf09ecb7a03420.1637056178.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111221435140.63@tvgsbejvaqbjf.bet>
References: <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>        <pull.981.v4.git.1637056178.gitgitgadget@gmail.com> <10b11526206d3b515ba08ac80ccf09ecb7a03420.1637056178.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:W0UWVz5DmdtxoGo0/7laKQd5gJcGbKZ+wBgcQyTzzfgPscCN31D
 KPTNnSGlsEvJbkBExmDfjhkNVwljzUX8tFq4DW/XzfvV89LV+ikTy872OVmEX7RC9gdjRP4
 65Sr0QdUq5EQgOqWxlU7ShlxlZNaDynuMLovr2AbXsfNpPS8JDZmPpDO/dTjrlLl7GqFO2s
 EyYJ4y+WdT5u0OGzKb9yQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9x+TASDqhE4=:ou9Fs4TrZ+WqYu0TS6YWO3
 ot7dR53oEe3tq0k4z2B9juYAv9MKiyZfU4L0fGOpcUvViKnkQUtug6KhtLMGJchjYXH+KS0v6
 SLnoTL8wfcyATveWTrVpLCK7gPXUwMyPCMYET2cYb/VgQLYeHQGQbeWmRrEMV04jOJJKLNUyv
 0kJvHcQhcaZAvifyuuwAtKdkU9Ya+Vs/D7dqw/XWnnl95vzPGpPlBRZKuUQ19DHHY+9p0oMoa
 mZxTwDgEpP+/ngIzKsxVOKuDcKjS8zP54EW/hHroqDvr6J8XN+pnt54R8mS66sZoHLDV2G42D
 HJQPgbB1dvs2ySaHafSxXXSz1BtVvCQPuDWgYnIUqdajOreUU4kM7PPEEMhoangYaSb7c70g9
 Il6nqc7Alau096P0isvJyIjv1kH2e0LaByRe752hmGPkwi3U7HAwrbjTeksS2SjblTIbGWGNs
 Si+ZFItUxkGtCLXz37wqPEKjrQiRM7MBJXFsCsnwDnazWfYXR3x900oVIfAbzWQMuq0DE1zLR
 pzuQR6e1swHfgz6gS8OW3WUR8XRpTqeEWDvYUVoFtpDUYsj6WS2gobvkMIpOAAgNM1J6WwQKR
 0c7aZNhJ1UndOkxzlllEfXi0SjLp1L3u2ZZMsrPhVoeA/SCXBVRqrhbw9aBWrDnqpSsqRIO03
 b9WBGgG2LKc1KGYzamCU4UqRJMXXPcMR35WkM2b/PCcb0jXQXUk/vYbMOEzPgA6ayksTbSJr+
 sP5s7uHy9JfciOHhU7nYy3JnWkgvwTx3qvKQUNDW6j+2mySLrQghQF364I7yex+gPqgs5SEys
 Of3NZmv8V/Eg04yLlfoD6nMURKEKrvLaK4lSc1f52Jf/ZnSWKfR0iS+Ldu0iuWOVAn2Anzein
 Oasuh5QM/nx6/5R9lKdb8EuyQ9g5F+r3jVytq6KVCBQCltBbV6gfZ9pOQO+D1ecQ8PlpatbWa
 E4B2Au1ZX5NniWupuP90EUNAKM5WbWxojknZmayNCbqDbKNQNIwXCVK9R6e/NNOlzMTsADPb0
 rTaNrDjqGE9gflZdBvWhmcZIdnNExNj+OWozpNCRJ4j6nA79ymSrG0vfaRi8sMfb+Zgl8OROl
 DFyNz0JADwCtlCqgkcD/xBbAo5F0CZWOTqTJDzFH/L9VLMtICZzqjppJKiER5QW85tpBCU6Go
 loDEA=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

The commit's oneline has a typo: zerba instead of zebra.

On Tue, 16 Nov 2021, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> When marking moved lines it is possible for a block of potential
> matched lines to extend past a change in sign when there is a sequence
> of added lines whose text matches the text of a sequence of deleted
> and added lines. Most of the time either `match` will be NULL or
> `pmb_advance_or_null()` will fail when the loop encounters a change of
> sign but there are corner cases where `match` is non-NULL and
> `pmb_advance_or_null()` successfully advances the moved block despite
> the change in sign.
>
> One consequence of this is highlighting a short line as moved when it
> should not be. For example
>
> -moved line  # Correctly highlighted as moved
> +short line  # Wrongly highlighted as moved
>  context
> +moved line  # Correctly highlighted as moved
> +short line
>  context
> -short line
>
> The other consequence is coloring a moved addition following a moved
> deletion in the wrong color. In the example below the first "+moved
> line 3" should be highlighted as newMoved not newMovedAlternate.
>
> -moved line 1 # Correctly highlighted as oldMoved
> -moved line 2 # Correctly highlighted as oldMovedAlternate
> +moved line 3 # Wrongly highlighted as newMovedAlternate
>  context      # Everything else is highlighted correctly
> +moved line 2
> +moved line 3
>  context
> +moved line 1
> -moved line 3
>
> These false matches are more likely when using --color-moved-ws with
> the exception of --color-moved-ws=3Dallow-indentation-change which ties
> the sign of the current whitespace delta to the sign of the line to
> avoid this problem. The fix is to check that the sign of the new line
> being matched is the same as the sign of the line that started the
> block of potential matches.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  diff.c                     | 17 ++++++----
>  t/t4015-diff-whitespace.sh | 65 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 76 insertions(+), 6 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 53f0df75329..efba2789354 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1176,7 +1176,7 @@ static void mark_color_as_moved(struct diff_option=
s *o,
>  	struct moved_block *pmb =3D NULL; /* potentially moved blocks */
>  	int pmb_nr =3D 0, pmb_alloc =3D 0;
>  	int n, flipped_block =3D 0, block_length =3D 0;
> -	enum diff_symbol last_symbol =3D 0;
> +	enum diff_symbol moved_symbol =3D DIFF_SYMBOL_BINARY_DIFF_HEADER;

The exact value does not matter, as long as it is different from whatever
the next line will have, of course.

>
>
>  	for (n =3D 0; n < o->emitted_symbols->nr; n++) {
> @@ -1202,7 +1202,7 @@ static void mark_color_as_moved(struct diff_option=
s *o,
>  			flipped_block =3D 0;
>  		}
>
> -		if (!match) {
> +		if (pmb_nr && (!match || l->s !=3D moved_symbol)) {
>  			int i;
>
>  			if (!adjust_last_block(o, n, block_length) &&
> @@ -1219,12 +1219,13 @@ static void mark_color_as_moved(struct diff_opti=
ons *o,
>  			pmb_nr =3D 0;
>  			block_length =3D 0;
>  			flipped_block =3D 0;
> -			last_symbol =3D l->s;
> +		}

This is one of those instances where I dislike having the patch in a
static mail. I so want to have a _convenient_ way to expand the diff
context, to have a look around.

So I went over to
https://github.com/gitgitgadget/git/pull/981/commits/10b11526206d3b515ba08=
ac80ccf09ecb7a03420
to get the convenience I need for a pleasant reviewing experience.

In this instance, the `continue` that dropped out of that conditional
block gave me pause.

My understanding is that the diff makes it essentially a lot harder to
understand what is done here: this conditional block did two things, it
re-set the possibly-moved-block, and it skipped to the next loop
iteration. With this patch, we now re-set the possibly-moved-block in more
cases, but still skip to the next loop iteration under the same condition
as before:

> +		if (!match) {
> +			moved_symbol =3D DIFF_SYMBOL_BINARY_DIFF_HEADER;
>  			continue;
>  		}

However, after reading the commit message, I would have expected the
condition above to read `if (!match || l->s !=3D moved_symbol)` instead of
`if (!match)`. Could you help me understand what I am missing?

>
>  		if (o->color_moved =3D=3D COLOR_MOVED_PLAIN) {
> -			last_symbol =3D l->s;
>  			l->flags |=3D DIFF_SYMBOL_MOVED_LINE;
>  			continue;
>  		}

I want to make sure that I understand why the `last_symbol` assignment
could be removed without any `moved_symbol` assignment in its place. But I
don't, I still do not see why we do not need a `moved_symbol =3D l->s;`
assignment here.

Unless, that is, we extended the `!match` condition above to also cover
the case where `l->s !=3D moved_symbol`.

> @@ -1251,11 +1252,16 @@ static void mark_color_as_moved(struct diff_opti=
ons *o,
>  							    &pmb, &pmb_alloc,
>  							    &pmb_nr);
>
> -			if (contiguous && pmb_nr && last_symbol =3D=3D l->s)
> +			if (contiguous && pmb_nr && moved_symbol =3D=3D l->s)
>  				flipped_block =3D (flipped_block + 1) % 2;

This is totally not your fault, but I really wish we could have the much
simpler and much easier to understand `flipped_block =3D !flipped_block`
here.

>  			else
>  				flipped_block =3D 0;
>
> +			if (pmb_nr)
> +				moved_symbol =3D l->s;
> +			else
> +				moved_symbol =3D DIFF_SYMBOL_BINARY_DIFF_HEADER;
> +
>  			block_length =3D 0;
>  		}
>
> @@ -1265,7 +1271,6 @@ static void mark_color_as_moved(struct diff_option=
s *o,
>  			if (flipped_block && o->color_moved !=3D COLOR_MOVED_BLOCKS)
>  				l->flags |=3D DIFF_SYMBOL_MOVED_LINE_ALT;
>  		}
> -		last_symbol =3D l->s;

That makes sense: we only set `moved_symbol` when `pmb_nr` had been 0 now,
and don't want it to be overridden.

As I said, I do not quite understand this patch yet, and am looking for
your guidance to wrap my head around it.

Thank you for working on this!
Dscho

>  	}
>  	adjust_last_block(o, n, block_length);
>
> diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
> index 4e0fd76c6c5..15782c879d2 100755
> --- a/t/t4015-diff-whitespace.sh
> +++ b/t/t4015-diff-whitespace.sh
> @@ -1514,6 +1514,71 @@ test_expect_success 'zebra alternate color is onl=
y used when necessary' '
>  	test_cmp expected actual
>  '
>
> +test_expect_success 'short lines of opposite sign do not get marked as =
moved' '
> +	cat >old.txt <<-\EOF &&
> +	this line should be marked as moved
> +	unchanged
> +	unchanged
> +	unchanged
> +	unchanged
> +	too short
> +	this line should be marked as oldMoved newMoved
> +	this line should be marked as oldMovedAlternate newMoved
> +	unchanged 1
> +	unchanged 2
> +	unchanged 3
> +	unchanged 4
> +	this line should be marked as oldMoved newMoved/newMovedAlternate
> +	EOF
> +	cat >new.txt <<-\EOF &&
> +	too short
> +	unchanged
> +	unchanged
> +	this line should be marked as moved
> +	too short
> +	unchanged
> +	unchanged
> +	this line should be marked as oldMoved newMoved/newMovedAlternate
> +	unchanged 1
> +	unchanged 2
> +	this line should be marked as oldMovedAlternate newMoved
> +	this line should be marked as oldMoved newMoved/newMovedAlternate
> +	unchanged 3
> +	this line should be marked as oldMoved newMoved
> +	unchanged 4
> +	EOF
> +	test_expect_code 1 git diff --no-index --color --color-moved=3Dzebra \
> +		old.txt new.txt >output && cat output &&
> +	grep -v index output | test_decode_color >actual &&
> +	cat >expect <<-\EOF &&
> +	<BOLD>diff --git a/old.txt b/new.txt<RESET>
> +	<BOLD>--- a/old.txt<RESET>
> +	<BOLD>+++ b/new.txt<RESET>
> +	<CYAN>@@ -1,13 +1,15 @@<RESET>
> +	<BOLD;MAGENTA>-this line should be marked as moved<RESET>
> +	<GREEN>+<RESET><GREEN>too short<RESET>
> +	 unchanged<RESET>
> +	 unchanged<RESET>
> +	<BOLD;CYAN>+<RESET><BOLD;CYAN>this line should be marked as moved<RESE=
T>
> +	<GREEN>+<RESET><GREEN>too short<RESET>
> +	 unchanged<RESET>
> +	 unchanged<RESET>
> +	<RED>-too short<RESET>
> +	<BOLD;MAGENTA>-this line should be marked as oldMoved newMoved<RESET>
> +	<BOLD;BLUE>-this line should be marked as oldMovedAlternate newMoved<R=
ESET>
> +	<BOLD;CYAN>+<RESET><BOLD;CYAN>this line should be marked as oldMoved n=
ewMoved/newMovedAlternate<RESET>
> +	 unchanged 1<RESET>
> +	 unchanged 2<RESET>
> +	<BOLD;CYAN>+<RESET><BOLD;CYAN>this line should be marked as oldMovedAl=
ternate newMoved<RESET>
> +	<BOLD;YELLOW>+<RESET><BOLD;YELLOW>this line should be marked as oldMov=
ed newMoved/newMovedAlternate<RESET>
> +	 unchanged 3<RESET>
> +	<BOLD;CYAN>+<RESET><BOLD;CYAN>this line should be marked as oldMoved n=
ewMoved<RESET>
> +	 unchanged 4<RESET>
> +	<BOLD;MAGENTA>-this line should be marked as oldMoved newMoved/newMove=
dAlternate<RESET>
> +	EOF
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'cmd option assumes configured colored-moved' '
>  	test_config color.diff.oldMoved "magenta" &&
>  	test_config color.diff.newMoved "cyan" &&
> --
> gitgitgadget
>
>
