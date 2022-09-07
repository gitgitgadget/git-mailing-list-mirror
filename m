Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D328C6FA82
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 19:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiIGThL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 15:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiIGThK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 15:37:10 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997CDBCC02
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 12:37:09 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 145so15653660pfw.4
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 12:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date;
        bh=4HKKO1TmoFlM1HQIZmrD9b49hW2WJXwaGVkC4VBN884=;
        b=PtdqcVVHLGem6RzZ+LyNI9SP96zGTrLO2wDB2KTkOImJrdQyO50pqOrKMzqDmlU4R7
         T2fgjeQFbhpvGxKAv1xhi6c9iM++yBJDIJpMjA0AFy2cGtq3vnMjJ2G3HlBg0/vWPgIP
         ZXPB9HB79DDlA4TCndlJtSZZ8tAvb/K8tcPxwLc3m5Eo9KsUi5IOi3raOdh42wlkFtNo
         Kc90DLhnl4y1rSkVEmLAqg9K9BikyzRLW3xbzzcWfzMV9KGb2NEcscn8jbDlQh7V5V9y
         kIoXe0x7ZKAsKBU8GirPHIwbJOlUFr7BZ67VSKCrpQu1PiPSGCPxk+6CBJjfH5f+QWTx
         82OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=4HKKO1TmoFlM1HQIZmrD9b49hW2WJXwaGVkC4VBN884=;
        b=tuZDjZyqUt+3qmiAC5dIu+pwpnB3I56ia2z4Qa3cek/KNZhvHL0WXQswOBpCaZr3nD
         47eDsd7HafTCdj4/m+YUbO/96HI6rUhGgmYpSAtpmMTmBD3f81XgtXFFMJ9uIuAJTJWt
         z8wnbEYmzcVkKxKffC64KS7xYHp604qzMnQMssj1SDYuZyZU5lzRy9nvCJYXbrzUZSTY
         31gVvM/yZ/bR4QKW/ogjbhCiu8KHh/tO9mBRFjiJadeoaWKC7D0MExj8iTUTk5L1/j72
         1FCxGCQyJtgQ66rtMEoSSCztX6D/HzYsveigtPK7ki1ZTG/shbR4YjWPd2yWY9VeroXh
         ctbA==
X-Gm-Message-State: ACgBeo1TNOPIxN6bJmrI+ncH+56WIWtWZgLl9VX7MkQgTtzSPtcW8VCc
        zWL7pQpVZ8dT9JoYvH/Hl/A=
X-Google-Smtp-Source: AA6agR7ntOiyhlVwnIBAcjPtP1TkEmcjevregY+CtOHBHfIEEIUgQ4onu4xhTtlut7VtmAL3gQYdVw==
X-Received: by 2002:a63:84c1:0:b0:434:b9db:b9d with SMTP id k184-20020a6384c1000000b00434b9db0b9dmr4748057pgd.397.1662579429051;
        Wed, 07 Sep 2022 12:37:09 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 15-20020a63184f000000b00434abd19eeasm3989421pgy.78.2022.09.07.12.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 12:37:08 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 3/2] diff-no-index: simplify argv index calculation
References: <xmqqilm579hc.fsf@gitster.g> <xmqqilm51gn6.fsf@gitster.g>
        <181c029b-8b36-4b04-30f9-97a3f252bfbc@web.de>
        <xmqq8rmx1saz.fsf@gitster.g>
        <9ea33608-3a6c-c0ef-9bb3-4bb535009aeb@web.de>
Date:   Wed, 07 Sep 2022 12:37:08 -0700
In-Reply-To: <9ea33608-3a6c-c0ef-9bb3-4bb535009aeb@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Wed, 7 Sep 2022 13:45:42 +0200")
Message-ID: <xmqqr10nt1qz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Since 16bb3d714d (diff --no-index: use parse_options() instead of
> diff_opt_parse(), 2019-03-24) argc must be 2 if we reach the loop, i.e.
> argc - 2 == 0.  Remove that inconsequential term.
>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
> Bonus patch "while at it", would have saved me from going "huh?".
> Generated using -U8 for easier review.

All three patches made sense to me.  Thanks.

>
>  diff-no-index.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/diff-no-index.c b/diff-no-index.c
> index a18f6c3c63..18edbdf4b5 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -262,17 +262,17 @@ int diff_no_index(struct rev_info *revs,
>  	if (argc != 2) {
>  		if (implicit_no_index)
>  			warning(_("Not a git repository. Use --no-index to "
>  				  "compare two paths outside a working tree"));
>  		usage_with_options(diff_no_index_usage, options);
>  	}
>  	FREE_AND_NULL(options);
>  	for (i = 0; i < 2; i++) {
> -		const char *p = argv[argc - 2 + i];
> +		const char *p = argv[i];
>  		if (!strcmp(p, "-"))
>  			/*
>  			 * stdin should be spelled as "-"; if you have
>  			 * path that is "-", spell it as "./-".
>  			 */
>  			p = file_from_standard_input;
>  		else if (prefix)
>  			p = to_free[i] = prefix_filename(prefix, p);
> --
> 2.37.2
