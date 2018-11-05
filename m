Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 315BF1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 01:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbeKELHR (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 06:07:17 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32819 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbeKELHR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 06:07:17 -0500
Received: by mail-wm1-f65.google.com with SMTP id f19-v6so5274460wmb.0
        for <git@vger.kernel.org>; Sun, 04 Nov 2018 17:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=4IpMsF4pEH/q28MPKfCzR9HcYSjJ5hh981jVDCZjJqg=;
        b=IMeGBMCKteiLOwOOV9gsfSeuLRIwKZLNJoITZNRTgfy5D8CCSUzfSP290/dHKGFoVS
         ZAdufDYfyR8OsbE7JEDOHVmvaUo3O5AAekBqcLXi1mjmtjtbWH48Pnq7DqxWd5hmtHD+
         ew8Nkx2it7b23BsZvCkjJlluoAUU9F39HevNOmg7AtLvNsT3hOFTsCgFFPPK9UjyCrfu
         0NOjCfxxkyBhW/LZt5D2zQ5HLV/3zfDd8J211SEn8PZhkoCU5OkS5H440EcfECRcHEBJ
         WAfnQpM6oTdKaBjtuQpm+nc4JzLOyFN4yrqxkIME4TOM7S2sDfC030Fzzll05OQ5QsLo
         L6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=4IpMsF4pEH/q28MPKfCzR9HcYSjJ5hh981jVDCZjJqg=;
        b=QUDG1nqMtwslxUy/vtp9Wqe98gSl4/z9s+K7Yt50TkqQ+WhUhfWWJ2nrcdMiLHc74o
         5Hp/Q6kPUgfrtadF6Aju2hKDJ8t6LUijUmFa/VN6nxKxSVsV4/N5oJvxvRO8jUaepffx
         fy+8O7K4+C3NxiJWXELAgPR+CURk4g5//5VXgtLM88teyFje6eG5S93QEW17LMLsKqlO
         bAlZTV93YTEN9sBY0e41TzR1dzX9NdbtAyQgim7k07PSs4ZHOc7EJCvVmuGYwt+iOzMG
         oYdfl1JtBfG0lGy6E/v5T2aM8tNzQtCrB5esx3SmAdOTohVr7W3ORO32HIeU1OcOc0tF
         SZcQ==
X-Gm-Message-State: AGRZ1gJAhDGn6kyOxtY/CVrSVil9rivc1mRSv/AVchBQicBOptSWzy/e
        1qnMYmkcsmao5UVAP2VGZ1LvP+KDbOk=
X-Google-Smtp-Source: AJdET5cXBLYP2WHE4INGZoeYlirxK134NRiQlJdKR7qNF6pNkR5ZFeSVpx5DVx9ErOP7FKuT9i47sA==
X-Received: by 2002:a1c:b8d:: with SMTP id 135-v6mr4411583wml.128.1541382603504;
        Sun, 04 Nov 2018 17:50:03 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 66-v6sm3437716wmp.28.2018.11.04.17.50.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Nov 2018 17:50:02 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     christophe.bliard@trux.info, git@vger.kernel.org,
        rafa.almas@gmail.com, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] tree-walk.c: fix overoptimistic inclusion in :(exclude) matching
References: <20181103153049.22850-1-pclouds@gmail.com>
        <20181104052851.12584-1-pclouds@gmail.com>
Date:   Mon, 05 Nov 2018 10:50:01 +0900
In-Reply-To: <20181104052851.12584-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sun, 4 Nov 2018 06:28:51 +0100")
Message-ID: <xmqq36sgl2d2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> tree_entry_interesting() is used for matching pathspec on a tree. The
> interesting thing about this function is that, because the tree
> entries are known to be sorted, this function can return more than
> just "yes, matched" and "no, not matched". It can also say "yes, this
> entry is matched and so is the remaining entries in the tree".
>
> This is where I made a mistake when matching exclude pathspec. For
> exclude pathspec, we do matching twice, one with positive patterns and
> one with negative ones, then a rule table is applied to determine the
> final "include or exclude" result. Note that "matched" does not
> necessarily mean include. For negative patterns, "matched" means
> exclude.
>
> This particular rule is too eager to include everything. Rule 8 says
> that "if all entries are positively matched" and the current entry is
> not negatively matched (i.e. not excluded), then all entries are
> positively matched and therefore included. But this is not true. If
> the _current_ entry is not negatively matched, it does not mean the
> next one will not be and we cannot conclude right away that all
> remaining entries are positively matched and can be included.
>
> Rules 8 and 18 are now updated to be less eager. We conclude that the
> current entry is positively matched and included. But we say nothing
> about remaining entries. tree_entry_interesting() will be called again
> for those entries where we will determine entries individually.

Thanks.  Will queue.

> Reported-by: Christophe Bliard <christophe.bliard@trux.info>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  v2 fixes the too broad "git add ." in the test
>
>  t/t6132-pathspec-exclude.sh | 17 +++++++++++++++++
>  tree-walk.c                 | 11 ++++++++---
>  2 files changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/t/t6132-pathspec-exclude.sh b/t/t6132-pathspec-exclude.sh
> index eb829fce97..2462b19ddd 100755
> --- a/t/t6132-pathspec-exclude.sh
> +++ b/t/t6132-pathspec-exclude.sh
> @@ -194,4 +194,21 @@ test_expect_success 'multiple exclusions' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 't_e_i() exclude case #8' '
> +	git init case8 &&
> +	(
> +		cd case8 &&
> +		echo file >file1 &&
> +		echo file >file2 &&
> +		git add file1 file2 &&
> +		git commit -m twofiles &&
> +		git grep -l file HEAD :^file2 >actual &&
> +		echo HEAD:file1 >expected &&
> +		test_cmp expected actual &&
> +		git grep -l file HEAD :^file1 >actual &&
> +		echo HEAD:file2 >expected &&
> +		test_cmp expected actual
> +	)
> +'
> +
>  test_done
> diff --git a/tree-walk.c b/tree-walk.c
> index 77b37f36fa..79bafbd1a2 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -1107,7 +1107,7 @@ enum interesting tree_entry_interesting(const struct name_entry *entry,
>  	 *   5  |  file |    1     |    1     |   0
>  	 *   6  |  file |    1     |    2     |   0
>  	 *   7  |  file |    2     |   -1     |   2
> -	 *   8  |  file |    2     |    0     |   2
> +	 *   8  |  file |    2     |    0     |   1
>  	 *   9  |  file |    2     |    1     |   0
>  	 *  10  |  file |    2     |    2     |  -1
>  	 * -----+-------+----------+----------+-------
> @@ -1118,7 +1118,7 @@ enum interesting tree_entry_interesting(const struct name_entry *entry,
>  	 *  15  |  dir  |    1     |    1     |   1 (*)
>  	 *  16  |  dir  |    1     |    2     |   0
>  	 *  17  |  dir  |    2     |   -1     |   2
> -	 *  18  |  dir  |    2     |    0     |   2
> +	 *  18  |  dir  |    2     |    0     |   1
>  	 *  19  |  dir  |    2     |    1     |   1 (*)
>  	 *  20  |  dir  |    2     |    2     |  -1
>  	 *
> @@ -1134,7 +1134,12 @@ enum interesting tree_entry_interesting(const struct name_entry *entry,
>  
>  	negative = do_match(entry, base, base_offset, ps, 1);
>  
> -	/* #3, #4, #7, #8, #13, #14, #17, #18 */
> +	/* #8, #18 */
> +	if (positive == all_entries_interesting &&
> +	    negative == entry_not_interesting)
> +		return entry_interesting;
> +
> +	/* #3, #4, #7, #13, #14, #17 */
>  	if (negative <= entry_not_interesting)
>  		return positive;
