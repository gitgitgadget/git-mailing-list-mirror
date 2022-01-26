Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C9AC433EF
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 22:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiAZWzM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 17:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbiAZWzL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 17:55:11 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A73C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 14:55:11 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id o10so1049563ilh.0
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 14:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tvJGg9xOHrvhxyW1NtMn3I8mW3MQ/Z2k9Gzd0A3eKBI=;
        b=klFUlecYA60LYlMamScr818f4GICFOlAh/AfZ2xGFJ1e/nF30L5inCJF7sX3SsH9K4
         cC7DqBwiXGlX7TQvk/biXxUUh4j+5FNUimS0jKzdyA69cu+yxtocC9E0prrJQZN/8DtZ
         iGmBWqie1aZFgT8iZiVK5Li4Wi4IYQE2l+G9JacQT5EzyQjJl8kzLcCSlh1LCedfA2Ia
         RjuBLkpQ+3HN/Bw9vCjgY6scVscuh216g3y8wMvCQvpD7tVjE0FCTRCRn28zsCDpwVDW
         0bOZTGeGVJMKOm2v09+3WJn4tSm4olkulw3qhwS3+lpmcWOITX6pD6LJSMf4ubD3Z23U
         gMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tvJGg9xOHrvhxyW1NtMn3I8mW3MQ/Z2k9Gzd0A3eKBI=;
        b=S9i4TDQf+7QxnUeSjenTHWjtMSasyFEv4jpjlXWWeWbOIj2tKkT0eFIgoHp+Akz+Zl
         e7OJkSzF9XtIQvq9YkK87c3k58u5tFPE/ZPcusgiflCxEcX+vZDc2eo22JhEL6RLZKS4
         dlTQi0DrlniI3TYbC4pAXY+hYyUvISkQ3x9ybXo/pTt2JohRu2icgH1wU1ecGq/dC9+2
         OuJRRCPMASF0tDYyczVnta7tGhWRt1nhZvFqaB8uQcK9kjDSi2eGpfkLje5a+HMu6W2C
         1VLZ7TWL1pOdwV6sAutURWshllU1X6iXM1KoDIt4gFCeugJ9QRbrzrSpIg7o9TLza4o3
         XkuA==
X-Gm-Message-State: AOAM5313RY3wZVuvXaS39BhQeIQ+T4vZyhXIQ18TD/skLjIn/Cjzit1J
        A6VRXKDMhaEM5kzU4M3rkjdUlQ==
X-Google-Smtp-Source: ABdhPJxXCOxBet4vmyLsa3o+w/v1hF1hlv1cD6QYodJlN+FRaqMGHsQMP8HNHMve/nsFzNFkMP/tbA==
X-Received: by 2002:a92:d350:: with SMTP id a16mr897487ilh.187.1643237711058;
        Wed, 26 Jan 2022 14:55:11 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g14sm278678ilr.12.2022.01.26.14.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 14:55:10 -0800 (PST)
Date:   Wed, 26 Jan 2022 17:55:10 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] diff-filter: be more careful when looking for
 negative bits
Message-ID: <YfHRTrdwZVwxcPBK@nand.local>
References: <pull.1127.git.1643149759.gitgitgadget@gmail.com>
 <e8006493a9ed4da9b9125865e004ba7ace20e7a4.1643149759.git.gitgitgadget@gmail.com>
 <xmqq1r0vt0y7.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1r0vt0y7.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 25, 2022 at 11:23:28PM -0800, Junio C Hamano wrote:
>  diff.c         | 31 ++++++++++++++++++++++++++++---
>  t/t4202-log.sh |  4 +++-
>  2 files changed, 31 insertions(+), 4 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index fc1151b9c7..a57e458f63 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4821,13 +4821,38 @@ static int diff_opt_diff_filter(const struct option *option,
>  	prepare_filter_bits();
>
>  	/*
> -	 * If the input starts with a negation e.g. 'd', and we haven't
> +	 * If there is a negation e.g. 'd' in the input, and we haven't
>  	 * initialized the filter field with another --diff-filter, start
>  	 * from full set of bits, except for AON.
> +	 * However, the user can try to limit to selected positive bits,
> +	 * in which case we do not have to.
> +	 *
> +	 * NEEDSWORK: the "we haven't initialied" above is meant to
> +	 * address cases where multiple options, e.g. --diff-filter=d
> +	 * --diff-filter=a are given.  But this implementation is
> +	 * insufficient when we refrain from starting from full set
> +	 * when any positive bit is given.  Consider "--diff-filter=D
> +	 * --diff-filter=r", which ought to behave the same way as
> +	 * "--diff-filter=Dr" and "--diff-filter=rD".  The right fix
> +	 * would probably involve two "opt->filter[NP]" fields,
> +	 * records positive and negative bits separately in them while
> +	 * parsing, and then after processing all options, compute
> +	 * opt->filter by subtracting opt->filterN from opt->filterP
> +	 * (and when we do so, fill opt->filterP to full bits if it is
> +	 * absolutely empty).
>  	 */
>  	if (!opt->filter) {
> -		optch = optarg[0];
> -		if (optch >= 'a' && 'z' >= optch) {
> +		int has_positive = 0;
> +		int has_negative = 0;
> +
> +		for (i = 0; (optch = optarg[i]) != '\0'; i++) {
> +			if (optch < 'a' || 'z' < optch)
> +				has_positive++;
> +			else
> +				has_negative++;
> +		}
> +
> +		if (!has_positive && has_negative) {
>  			opt->filter = (1 << (ARRAY_SIZE(diff_status_letters) - 1)) - 1;
>  			opt->filter &= ~filter_bit[DIFF_STATUS_FILTER_AON];
>  		}

Ahh. I feel much better about this implementation. Something was nagging
me about treating optarg[0] specially, and you put very succinctly what
it was that was bothering me.

(One small nit that I absolutely do not care about is using a variable
that starts with 'has_'--which I would expect to be a boolean--to count
the number of positive/negative filters. Perhaps calling these
positive_nr, and negative_nr, respectively, would be clearer.)

> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 28f727937d..128183e66f 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -142,10 +142,12 @@ test_expect_success 'diff-filter=R' '
>
>  '
>
> -test_expect_success 'diff-filter=Ra' '
> +test_expect_success 'diff-filter=Ra and aR' '
>
>  	git log -M --pretty="format:%s" --diff-filter=R HEAD >expect &&
>  	git log -M --pretty="format:%s" --diff-filter=Ra HEAD >actual &&
> +	test_cmp expect actual &&
> +	git log -M --pretty="format:%s" --diff-filter=aR HEAD >actual &&
>  	test_cmp expect actual

Perfect.

Thanks,
Taylor
