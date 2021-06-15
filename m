Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABD2C48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 11:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79BCF6143D
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 11:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhFOLZB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 07:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhFOLZA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 07:25:00 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F950C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 04:22:54 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a11so17887564wrt.13
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 04:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VRdyFQkF5+68wzJww8E81c1ZaXbolN8Sj3qXO4bJJWM=;
        b=bFo56/o43lPifDCPvBMTng5zpk0WU94gQj8tPIqzVTw4F/fkcC2YFCmZrxfRoUHY7E
         Rm2i92rkFU4LQUYCKXYsrhmOmhwmiJq7UZmd8UofC5wIWXQ8u5YHvsUNc25z8ZmrlvWN
         I2Pd0AevAe9fzGDQfv7CoAhWz+OhzkcYYgXWokhA3sLR5V+kNXkAjOOQa/QfR8fD02ve
         p66fTzCZwxUjs2VjAAH/CmFcRBAOxp4CdzDvz4+3IVfAjVBrO1wYQ9kf154sdO8gSU8X
         NHHGJRYpRXPZTyInNnvpbCyflXqrNDOkDEukUqQTvsFOzIeEGdxHtHk8jY3jY/uzTuv/
         NRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=VRdyFQkF5+68wzJww8E81c1ZaXbolN8Sj3qXO4bJJWM=;
        b=rhlLYchLJjoLzv/mC5LTpHk1eyuY/vhOIKV51bYl2mkboMISt9agf6wI6Ayb/tTf27
         A512Hfub+NHJUAkA4XchApHy2GmG62AFWPQ+kvaCsQJk8mtK03ckuJsuOQhP1+xI0or1
         VXOrgevXEDKCV28j/GKxdPowS+8YIr8xPuvSXQLjHLdCiihjEp7S85VDQpcmhDhpa0uu
         z7Zr/j3mRGYq63vwF/CakVH3BZLtjfzzaK7znGbT4GObWR/CsFwHIeXFaZzyGmZkYolw
         ha3rCG29Iic3MlNuE+BgcIQmM8ok+H0KkFF1YJQTm2TUDfs/TlLnjuqo/aKYZG0CmxZd
         cYtA==
X-Gm-Message-State: AOAM533M8sbkyBNy0tMM2wOtAdvjqxfjkJSGqLH1G9jZ7+TD/buZ+17+
        t10SDgd8WpFzqigKFUVVLmU=
X-Google-Smtp-Source: ABdhPJxxdzozUMb+bDS/ny5yxpRoxqZhV+BW+Qv4OX4nEuqm6yph/jaT5po0rTkkIraVtgU29RpFaQ==
X-Received: by 2002:a5d:5189:: with SMTP id k9mr23668235wrv.319.1623756173113;
        Tue, 15 Jun 2021 04:22:53 -0700 (PDT)
Received: from [192.168.1.240] (11.22.198.146.dyn.plus.net. [146.198.22.11])
        by smtp.gmail.com with ESMTPSA id u12sm19090716wrr.40.2021.06.15.04.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 04:22:52 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 01/10] diff --color-moved=zerba: fix alternate coloring
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.981.git.1623675888.gitgitgadget@gmail.com>
 <374dbebcbf29b686508e51205b2f7a4e72104950.1623675888.git.gitgitgadget@gmail.com>
 <xmqq4kdzyfm0.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <e74e3750-b43d-1010-17df-6c821bb7b090@gmail.com>
Date:   Tue, 15 Jun 2021 12:22:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <xmqq4kdzyfm0.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/06/2021 04:24, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> Subject: Re: [PATCH 01/10] diff --color-moved=zerba: fix alternate coloring
> 
> Zerba?

They're quite rare in the wild :-/ Thanks for pointing that out I'll fix 
it when I re-roll

Best Wishes

Phillip

>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> b0a2ba4776 ("diff --color-moved=zebra: be stricter with color
>> alternation", 2018-11-23) sought to avoid using the alternate colors
>> unless there are two adjacent moved blocks of the same
>> sign. Unfortunately it contains two bugs that prevented it from fixing
>> the problem properly. Firstly `last_symbol` is reset at the start of
>> each iteration of the loop losing the symbol of the last line and
>> secondly when deciding whether to use the alternate color it should be
>> checking if the current line is the same sign of the last line, not a
>> different sign. The combination of the two errors means that we still
>> use the alternate color when we should do but we also use it when we
>> shouldn't. This is most noticable when using
>> --color-moved-ws=allow-indentation-change with hunks like
>>
>> -this line gets indented
>> +    this line gets indented
>>
>> where the post image is colored with newMovedAlternate rather than
>> newMoved. While this does not matter much, the next commit will change
>> the coloring to be correct in this case, so lets fix the bug here to
>> make it clear why the output is changing and add a regression test.
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   diff.c                     |  4 +--
>>   t/t4015-diff-whitespace.sh | 72 ++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 74 insertions(+), 2 deletions(-)
>>
>> diff --git a/diff.c b/diff.c
>> index 52c791574b71..cb068f8258c0 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -1142,6 +1142,7 @@ static void mark_color_as_moved(struct diff_options *o,
>>   	struct moved_block *pmb = NULL; /* potentially moved blocks */
>>   	int pmb_nr = 0, pmb_alloc = 0;
>>   	int n, flipped_block = 0, block_length = 0;
>> +	enum diff_symbol last_symbol = 0;
>>   
>>   
>>   	for (n = 0; n < o->emitted_symbols->nr; n++) {
>> @@ -1149,7 +1150,6 @@ static void mark_color_as_moved(struct diff_options *o,
>>   		struct moved_entry *key;
>>   		struct moved_entry *match = NULL;
>>   		struct emitted_diff_symbol *l = &o->emitted_symbols->buf[n];
>> -		enum diff_symbol last_symbol = 0;
>>   
>>   		switch (l->s) {
>>   		case DIFF_SYMBOL_PLUS:
>> @@ -1214,7 +1214,7 @@ static void mark_color_as_moved(struct diff_options *o,
>>   			}
>>   
>>   			if (adjust_last_block(o, n, block_length) &&
>> -			    pmb_nr && last_symbol != l->s)
>> +			    pmb_nr && last_symbol == l->s)
>>   				flipped_block = (flipped_block + 1) % 2;
>>   			else
>>   				flipped_block = 0;
>> diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
>> index 2c13b62d3c65..920114cd795c 100755
>> --- a/t/t4015-diff-whitespace.sh
>> +++ b/t/t4015-diff-whitespace.sh
>> @@ -1442,6 +1442,78 @@ test_expect_success 'detect permutations inside moved code -- dimmed-zebra' '
>>   	test_cmp expected actual
>>   '
>>   
>> +test_expect_success 'zebra alternate color is only used when necessary' '
>> +	cat >old.txt <<-\EOF &&
>> +	line 1A should be marked as oldMoved newMovedAlternate
>> +	line 1B should be marked as oldMoved newMovedAlternate
>> +	unchanged
>> +	line 2A should be marked as oldMoved newMovedAlternate
>> +	line 2B should be marked as oldMoved newMovedAlternate
>> +	line 3A should be marked as oldMovedAlternate newMoved
>> +	line 3B should be marked as oldMovedAlternate newMoved
>> +	unchanged
>> +	line 4A should be marked as oldMoved newMovedAlternate
>> +	line 4B should be marked as oldMoved newMovedAlternate
>> +	line 5A should be marked as oldMovedAlternate newMoved
>> +	line 5B should be marked as oldMovedAlternate newMoved
>> +	line 6A should be marked as oldMoved newMoved
>> +	line 6B should be marked as oldMoved newMoved
>> +	EOF
>> +	cat >new.txt <<-\EOF &&
>> +	  line 1A should be marked as oldMoved newMovedAlternate
>> +	  line 1B should be marked as oldMoved newMovedAlternate
>> +	unchanged
>> +	  line 3A should be marked as oldMovedAlternate newMoved
>> +	  line 3B should be marked as oldMovedAlternate newMoved
>> +	  line 2A should be marked as oldMoved newMovedAlternate
>> +	  line 2B should be marked as oldMoved newMovedAlternate
>> +	unchanged
>> +	  line 6A should be marked as oldMoved newMoved
>> +	  line 6B should be marked as oldMoved newMoved
>> +	    line 4A should be marked as oldMoved newMovedAlternate
>> +	    line 4B should be marked as oldMoved newMovedAlternate
>> +	  line 5A should be marked as oldMovedAlternate newMoved
>> +	  line 5B should be marked as oldMovedAlternate newMoved
>> +	EOF
>> +	test_expect_code 1 git diff --no-index --color --color-moved=zebra \
>> +		 --color-moved-ws=allow-indentation-change \
>> +		 old.txt new.txt >output &&
>> +	grep -v index output | test_decode_color >actual &&
>> +	cat >expected <<-\EOF &&
>> +	<BOLD>diff --git a/old.txt b/new.txt<RESET>
>> +	<BOLD>--- a/old.txt<RESET>
>> +	<BOLD>+++ b/new.txt<RESET>
>> +	<CYAN>@@ -1,14 +1,14 @@<RESET>
>> +	<BOLD;MAGENTA>-line 1A should be marked as oldMoved newMovedAlternate<RESET>
>> +	<BOLD;MAGENTA>-line 1B should be marked as oldMoved newMovedAlternate<RESET>
>> +	<BOLD;CYAN>+<RESET><BOLD;CYAN>  line 1A should be marked as oldMoved newMovedAlternate<RESET>
>> +	<BOLD;CYAN>+<RESET><BOLD;CYAN>  line 1B should be marked as oldMoved newMovedAlternate<RESET>
>> +	 unchanged<RESET>
>> +	<BOLD;MAGENTA>-line 2A should be marked as oldMoved newMovedAlternate<RESET>
>> +	<BOLD;MAGENTA>-line 2B should be marked as oldMoved newMovedAlternate<RESET>
>> +	<BOLD;BLUE>-line 3A should be marked as oldMovedAlternate newMoved<RESET>
>> +	<BOLD;BLUE>-line 3B should be marked as oldMovedAlternate newMoved<RESET>
>> +	<BOLD;CYAN>+<RESET><BOLD;CYAN>  line 3A should be marked as oldMovedAlternate newMoved<RESET>
>> +	<BOLD;CYAN>+<RESET><BOLD;CYAN>  line 3B should be marked as oldMovedAlternate newMoved<RESET>
>> +	<BOLD;YELLOW>+<RESET><BOLD;YELLOW>  line 2A should be marked as oldMoved newMovedAlternate<RESET>
>> +	<BOLD;YELLOW>+<RESET><BOLD;YELLOW>  line 2B should be marked as oldMoved newMovedAlternate<RESET>
>> +	 unchanged<RESET>
>> +	<BOLD;MAGENTA>-line 4A should be marked as oldMoved newMovedAlternate<RESET>
>> +	<BOLD;MAGENTA>-line 4B should be marked as oldMoved newMovedAlternate<RESET>
>> +	<BOLD;BLUE>-line 5A should be marked as oldMovedAlternate newMoved<RESET>
>> +	<BOLD;BLUE>-line 5B should be marked as oldMovedAlternate newMoved<RESET>
>> +	<BOLD;MAGENTA>-line 6A should be marked as oldMoved newMoved<RESET>
>> +	<BOLD;MAGENTA>-line 6B should be marked as oldMoved newMoved<RESET>
>> +	<BOLD;CYAN>+<RESET><BOLD;CYAN>  line 6A should be marked as oldMoved newMoved<RESET>
>> +	<BOLD;CYAN>+<RESET><BOLD;CYAN>  line 6B should be marked as oldMoved newMoved<RESET>
>> +	<BOLD;YELLOW>+<RESET><BOLD;YELLOW>    line 4A should be marked as oldMoved newMovedAlternate<RESET>
>> +	<BOLD;YELLOW>+<RESET><BOLD;YELLOW>    line 4B should be marked as oldMoved newMovedAlternate<RESET>
>> +	<BOLD;CYAN>+<RESET><BOLD;CYAN>  line 5A should be marked as oldMovedAlternate newMoved<RESET>
>> +	<BOLD;CYAN>+<RESET><BOLD;CYAN>  line 5B should be marked as oldMovedAlternate newMoved<RESET>
>> +	EOF
>> +	test_cmp expected actual
>> +'
>> +
>>   test_expect_success 'cmd option assumes configured colored-moved' '
>>   	test_config color.diff.oldMoved "magenta" &&
>>   	test_config color.diff.newMoved "cyan" &&
