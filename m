Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0460C48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 03:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B45FD6054E
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 03:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhFOD0s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 23:26:48 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57162 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhFOD0r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 23:26:47 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 316AE1254CB;
        Mon, 14 Jun 2021 23:24:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nhfhe0tsP7m4SjOaCTrIr9boWgGso2r7Jy2sUt
        howyg=; b=rBiuAF1EBGNYBozcQxh++Ns2dzEjypLE9wLuthDz+puS2TzYWqVmEv
        O8Jtqmae0Gfl/blj6LW5Lc77wY2oBYW9H/PabwKF/EldGwO41ZhWhXFvPPo5pCLD
        FW4pp5uo3P0EHMCPJ4/+9n1Ai3eN8IijEqsA0wS1F/xC2Nu6xF4Ek=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 29D2A1254CA;
        Mon, 14 Jun 2021 23:24:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 71D571254C9;
        Mon, 14 Jun 2021 23:24:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 01/10] diff --color-moved=zerba: fix alternate coloring
References: <pull.981.git.1623675888.gitgitgadget@gmail.com>
        <374dbebcbf29b686508e51205b2f7a4e72104950.1623675888.git.gitgitgadget@gmail.com>
Date:   Tue, 15 Jun 2021 12:24:39 +0900
In-Reply-To: <374dbebcbf29b686508e51205b2f7a4e72104950.1623675888.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Mon, 14 Jun 2021 13:04:39
        +0000")
Message-ID: <xmqq4kdzyfm0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 38F6843A-CD89-11EB-B07B-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Subject: Re: [PATCH 01/10] diff --color-moved=zerba: fix alternate coloring

Zerba?

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> b0a2ba4776 ("diff --color-moved=zebra: be stricter with color
> alternation", 2018-11-23) sought to avoid using the alternate colors
> unless there are two adjacent moved blocks of the same
> sign. Unfortunately it contains two bugs that prevented it from fixing
> the problem properly. Firstly `last_symbol` is reset at the start of
> each iteration of the loop losing the symbol of the last line and
> secondly when deciding whether to use the alternate color it should be
> checking if the current line is the same sign of the last line, not a
> different sign. The combination of the two errors means that we still
> use the alternate color when we should do but we also use it when we
> shouldn't. This is most noticable when using
> --color-moved-ws=allow-indentation-change with hunks like
>
> -this line gets indented
> +    this line gets indented
>
> where the post image is colored with newMovedAlternate rather than
> newMoved. While this does not matter much, the next commit will change
> the coloring to be correct in this case, so lets fix the bug here to
> make it clear why the output is changing and add a regression test.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  diff.c                     |  4 +--
>  t/t4015-diff-whitespace.sh | 72 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 74 insertions(+), 2 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 52c791574b71..cb068f8258c0 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1142,6 +1142,7 @@ static void mark_color_as_moved(struct diff_options *o,
>  	struct moved_block *pmb = NULL; /* potentially moved blocks */
>  	int pmb_nr = 0, pmb_alloc = 0;
>  	int n, flipped_block = 0, block_length = 0;
> +	enum diff_symbol last_symbol = 0;
>  
>  
>  	for (n = 0; n < o->emitted_symbols->nr; n++) {
> @@ -1149,7 +1150,6 @@ static void mark_color_as_moved(struct diff_options *o,
>  		struct moved_entry *key;
>  		struct moved_entry *match = NULL;
>  		struct emitted_diff_symbol *l = &o->emitted_symbols->buf[n];
> -		enum diff_symbol last_symbol = 0;
>  
>  		switch (l->s) {
>  		case DIFF_SYMBOL_PLUS:
> @@ -1214,7 +1214,7 @@ static void mark_color_as_moved(struct diff_options *o,
>  			}
>  
>  			if (adjust_last_block(o, n, block_length) &&
> -			    pmb_nr && last_symbol != l->s)
> +			    pmb_nr && last_symbol == l->s)
>  				flipped_block = (flipped_block + 1) % 2;
>  			else
>  				flipped_block = 0;
> diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
> index 2c13b62d3c65..920114cd795c 100755
> --- a/t/t4015-diff-whitespace.sh
> +++ b/t/t4015-diff-whitespace.sh
> @@ -1442,6 +1442,78 @@ test_expect_success 'detect permutations inside moved code -- dimmed-zebra' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'zebra alternate color is only used when necessary' '
> +	cat >old.txt <<-\EOF &&
> +	line 1A should be marked as oldMoved newMovedAlternate
> +	line 1B should be marked as oldMoved newMovedAlternate
> +	unchanged
> +	line 2A should be marked as oldMoved newMovedAlternate
> +	line 2B should be marked as oldMoved newMovedAlternate
> +	line 3A should be marked as oldMovedAlternate newMoved
> +	line 3B should be marked as oldMovedAlternate newMoved
> +	unchanged
> +	line 4A should be marked as oldMoved newMovedAlternate
> +	line 4B should be marked as oldMoved newMovedAlternate
> +	line 5A should be marked as oldMovedAlternate newMoved
> +	line 5B should be marked as oldMovedAlternate newMoved
> +	line 6A should be marked as oldMoved newMoved
> +	line 6B should be marked as oldMoved newMoved
> +	EOF
> +	cat >new.txt <<-\EOF &&
> +	  line 1A should be marked as oldMoved newMovedAlternate
> +	  line 1B should be marked as oldMoved newMovedAlternate
> +	unchanged
> +	  line 3A should be marked as oldMovedAlternate newMoved
> +	  line 3B should be marked as oldMovedAlternate newMoved
> +	  line 2A should be marked as oldMoved newMovedAlternate
> +	  line 2B should be marked as oldMoved newMovedAlternate
> +	unchanged
> +	  line 6A should be marked as oldMoved newMoved
> +	  line 6B should be marked as oldMoved newMoved
> +	    line 4A should be marked as oldMoved newMovedAlternate
> +	    line 4B should be marked as oldMoved newMovedAlternate
> +	  line 5A should be marked as oldMovedAlternate newMoved
> +	  line 5B should be marked as oldMovedAlternate newMoved
> +	EOF
> +	test_expect_code 1 git diff --no-index --color --color-moved=zebra \
> +		 --color-moved-ws=allow-indentation-change \
> +		 old.txt new.txt >output &&
> +	grep -v index output | test_decode_color >actual &&
> +	cat >expected <<-\EOF &&
> +	<BOLD>diff --git a/old.txt b/new.txt<RESET>
> +	<BOLD>--- a/old.txt<RESET>
> +	<BOLD>+++ b/new.txt<RESET>
> +	<CYAN>@@ -1,14 +1,14 @@<RESET>
> +	<BOLD;MAGENTA>-line 1A should be marked as oldMoved newMovedAlternate<RESET>
> +	<BOLD;MAGENTA>-line 1B should be marked as oldMoved newMovedAlternate<RESET>
> +	<BOLD;CYAN>+<RESET><BOLD;CYAN>  line 1A should be marked as oldMoved newMovedAlternate<RESET>
> +	<BOLD;CYAN>+<RESET><BOLD;CYAN>  line 1B should be marked as oldMoved newMovedAlternate<RESET>
> +	 unchanged<RESET>
> +	<BOLD;MAGENTA>-line 2A should be marked as oldMoved newMovedAlternate<RESET>
> +	<BOLD;MAGENTA>-line 2B should be marked as oldMoved newMovedAlternate<RESET>
> +	<BOLD;BLUE>-line 3A should be marked as oldMovedAlternate newMoved<RESET>
> +	<BOLD;BLUE>-line 3B should be marked as oldMovedAlternate newMoved<RESET>
> +	<BOLD;CYAN>+<RESET><BOLD;CYAN>  line 3A should be marked as oldMovedAlternate newMoved<RESET>
> +	<BOLD;CYAN>+<RESET><BOLD;CYAN>  line 3B should be marked as oldMovedAlternate newMoved<RESET>
> +	<BOLD;YELLOW>+<RESET><BOLD;YELLOW>  line 2A should be marked as oldMoved newMovedAlternate<RESET>
> +	<BOLD;YELLOW>+<RESET><BOLD;YELLOW>  line 2B should be marked as oldMoved newMovedAlternate<RESET>
> +	 unchanged<RESET>
> +	<BOLD;MAGENTA>-line 4A should be marked as oldMoved newMovedAlternate<RESET>
> +	<BOLD;MAGENTA>-line 4B should be marked as oldMoved newMovedAlternate<RESET>
> +	<BOLD;BLUE>-line 5A should be marked as oldMovedAlternate newMoved<RESET>
> +	<BOLD;BLUE>-line 5B should be marked as oldMovedAlternate newMoved<RESET>
> +	<BOLD;MAGENTA>-line 6A should be marked as oldMoved newMoved<RESET>
> +	<BOLD;MAGENTA>-line 6B should be marked as oldMoved newMoved<RESET>
> +	<BOLD;CYAN>+<RESET><BOLD;CYAN>  line 6A should be marked as oldMoved newMoved<RESET>
> +	<BOLD;CYAN>+<RESET><BOLD;CYAN>  line 6B should be marked as oldMoved newMoved<RESET>
> +	<BOLD;YELLOW>+<RESET><BOLD;YELLOW>    line 4A should be marked as oldMoved newMovedAlternate<RESET>
> +	<BOLD;YELLOW>+<RESET><BOLD;YELLOW>    line 4B should be marked as oldMoved newMovedAlternate<RESET>
> +	<BOLD;CYAN>+<RESET><BOLD;CYAN>  line 5A should be marked as oldMovedAlternate newMoved<RESET>
> +	<BOLD;CYAN>+<RESET><BOLD;CYAN>  line 5B should be marked as oldMovedAlternate newMoved<RESET>
> +	EOF
> +	test_cmp expected actual
> +'
> +
>  test_expect_success 'cmd option assumes configured colored-moved' '
>  	test_config color.diff.oldMoved "magenta" &&
>  	test_config color.diff.newMoved "cyan" &&
