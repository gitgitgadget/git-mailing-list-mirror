Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAC0C33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 22:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25EEA20748
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 22:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zt3XGekw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387676AbgAPWRE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 17:17:04 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63169 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730287AbgAPWRE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 17:17:04 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 044E538A9A;
        Thu, 16 Jan 2020 17:16:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9wB4WltzZfeSKiL0zrHG02kx3is=; b=Zt3XGe
        kwasqcz/4l+18RtfkmHHuJEAGDv9VQLZUh8AQuLRL0y6T9OivgdqldKlDLurycF7
        xbOwTj5wRwjPy/yNZwBR1RHJP+feb0/zMwNt8lq++J2Ownr8p2bSG5vVpQQ5xxWk
        Pa19tEc3u0md7jK3TV9t891Vrh+E15I9oa45Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tsFvKmNLOJNuXjMk96EqZxNrCge1nUco
        W04cBvM9q8jctQ/RVMvcEzpQ3S+A6HDcNRH6DorY8kpk52EUXUQ88+Fe+4Hufpdk
        aT99EJhaPJKYDcb2UnPe1sw3Dt7BWADCokPRTVdICFLgaqMv0HDCZkU4v3RbZxPh
        HFc0peepZMs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EF29D38A99;
        Thu, 16 Jan 2020 17:16:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 607A638A98;
        Thu, 16 Jan 2020 17:16:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] built-in add -i: accept open-ended ranges again
References: <pull.528.git.1579163587.gitgitgadget@gmail.com>
        <7e4bf4bbbcd8c81a19d690aee379042e47246947.1579163587.git.gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 14:16:57 -0800
In-Reply-To: <7e4bf4bbbcd8c81a19d690aee379042e47246947.1579163587.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 16 Jan 2020
        08:33:07 +0000")
Message-ID: <xmqqv9pbf3mu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E95FFBE8-38AD-11EA-917D-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The interactive `add` command allows selecting multiple files for some
> of its sub-commands, via unique prefixes, indices or index ranges.
>
> When re-implementing `git add -i` in C, we even added a code comment
> talking about ranges with a missing end index, such as `2-`, but the
> code did not actually accept those, as pointed out in
> https://github.com/git-for-windows/git/issues/2466#issuecomment-574142760.
>
> Let's fix this, and add a test case to verify that this stays fixed
> forever.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  add-interactive.c          | 5 ++++-
>  t/t3701-add-interactive.sh | 9 +++++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/add-interactive.c b/add-interactive.c
> index 14d4688c26..396066e724 100644
> --- a/add-interactive.c
> +++ b/add-interactive.c
> @@ -328,7 +328,10 @@ static ssize_t list_and_choose(struct add_i_state *s,
>  				if (endp == p + sep)
>  					to = from + 1;
>  				else if (*endp == '-') {
> -					to = strtoul(++endp, &endp, 10);
> +					if (isdigit(*(++endp)))
> +						to = strtoul(endp, &endp, 10);
> +					else
> +						to = items->items.nr;

Good.  We do not allow "everything up to N" with "-N", so covering
"N and everything after" with "N-" is sufficient.

> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index d4f9386621..b02fe73631 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -57,6 +57,15 @@ test_expect_success 'revert works (initial)' '
>  	! grep . output
>  '
>  
> +test_expect_success 'add untracked (multiple)' '
> +	test_when_finished "git reset && rm [1-9]" &&
> +	touch $(test_seq 9) &&
> +	test_write_lines a "2-5 8-" | git add -i -- [1-9] &&
> +	test_write_lines 2 3 4 5 8 9 >expected &&
> +	git ls-files [1-9] >output &&
> +	test_cmp expected output
> +'
> +
>  test_expect_success 'setup (commit)' '
>  	echo baseline >file &&
>  	git add file &&
