Return-Path: <SRS0=Fs4s=6X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE081C28CBC
	for <git@archiver.kernel.org>; Sat,  9 May 2020 16:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B355A2192A
	for <git@archiver.kernel.org>; Sat,  9 May 2020 16:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvChvHxK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgEIQMD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 May 2020 12:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727863AbgEIQMD (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 May 2020 12:12:03 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E32CC061A0C
        for <git@vger.kernel.org>; Sat,  9 May 2020 09:12:02 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id hi11so5647429pjb.3
        for <git@vger.kernel.org>; Sat, 09 May 2020 09:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BT7IbqD/STa7nTkv1GqSdGVmyuw3U4yziJOujIr02DY=;
        b=RvChvHxKdH3IENjxSjNf73/03mRQuBmzmcqr/hvrOGqz6xSdV86zXt78QrX2bXlk7b
         DmBaYD5pkS7lYMZT6+JAZcSuf6ClPuYDlJZl8QN4hzyyLolVe2xQSPotbUnONwx1+p2N
         h/n0lNz/ZoWxhvd3TJWXp4htggS13DxyJG2RoIJrAZIK8eAKN3bfSCYKCnjzkNoxmF+y
         XTbLdJm6+my3CpzB1UiGh9MjfYFbOX+TEueybEDF7nqPZS1F+h6S+fV8erWqfknp4Za9
         cGf11I/Pl8PP8Mtrga4UzBye1tWWJ13ytu6JR3AxFjcy7EVT89rpYGrOlFuqyPyPoLDH
         TPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BT7IbqD/STa7nTkv1GqSdGVmyuw3U4yziJOujIr02DY=;
        b=C/7q5lKDJG91jkacPpfLO+sV3T8rCLdvH10s5rfT3gb0O716Rs12AESIkcojMzQy8s
         H1t2DsCTU+9QirRTUA5SGYMc/glAi6y6CrHPGFFfxLXNzV8fEGlNPTzz31W+lS2TKztk
         dF6mgHYyatT5fI1Zu3lPHvf78+rwswqdCYir3TcosEB8jIEpbml4cC5RaxS0W5Ahztfi
         U8wMJixX57WV1Wn63WWyU7bnjgGWio+l3gnc68vZ+9+dmWmidHjYnfBePPKtBmlYRx32
         OjeEMXuks4ZIizLP9S7HF7S++fT5wa7/jHzNy7C0798oRH3L64/hp2I/FfbEbmIVwjET
         /Iuw==
X-Gm-Message-State: AGi0PuaxEwm3Gl6Eh6dQNWAG3EeiGRpbN3eb7lObqWK0zzkeS0k0wmyM
        2yXURaw90W4OlFEUNbbfweEJyWI9
X-Google-Smtp-Source: APiQypKj+8Xa2fOuSh/5oPtwe0eJnjUw+Jgq6prMnWAXalcrqxAXngz+lM7PwYq1qEpCorulPEeweQ==
X-Received: by 2002:a17:902:7048:: with SMTP id h8mr7525021plt.300.1589040721564;
        Sat, 09 May 2020 09:12:01 -0700 (PDT)
Received: from localhost ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id d124sm4786415pfa.98.2020.05.09.09.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 09:12:01 -0700 (PDT)
Date:   Sat, 9 May 2020 23:11:59 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Son Luong Ngoc <sluongng@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 2/3] multi-pack-index: respect
 repack.packKeptObjects=false
Message-ID: <20200509161159.GA15146@danh.dev>
References: <pull.626.v2.git.1588758194.gitgitgadget@gmail.com>
 <pull.626.v3.git.1589034270.gitgitgadget@gmail.com>
 <988697dd5121430cd3ddfa60b1ebcf26027566ef.1589034270.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <988697dd5121430cd3ddfa60b1ebcf26027566ef.1589034270.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-09 14:24:29+0000, Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com> wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> +test_expect_success 'repack respects repack.packKeptObjects=false' '
> +	test_when_finished rm -f dup/.git/objects/pack/*keep &&
> +	(
> +		cd dup &&
> +		ls .git/objects/pack/*idx >idx-list &&

I think ls(1) is an overkill.
I think:

	echo .git/objects/pack/*idx

is more efficient.

> +		test_line_count = 5 idx-list &&
> +		ls .git/objects/pack/*.pack | sed "s/\.pack/.keep/" >keep-list &&

Likewise.

> +		for keep in $(cat keep-list)
> +		do
> +			touch $keep || return 1

Is this intended?
Since touch(1) accepts multiple files as argument.

> +		done &&
> +		git multi-pack-index repack --batch-size=0 &&
> +		ls .git/objects/pack/*idx >idx-list &&
> +		test_line_count = 5 idx-list &&
> +		test-tool read-midx .git/objects | grep idx >midx-list &&
> +		test_line_count = 5 midx-list &&
> +		THIRD_SMALLEST_SIZE=$(test-tool path-utils file-size .git/objects/pack/*pack | sort -n | head -n 3 | tail -n 1) &&

This line is overly long.
Should we write test-tool's output to temp file and process it?

And I think either

	sed -n '3{p;q}'

or:

	sed -n 3p

is cleaner than

	head -n 3 | tail -n 1

> +		BATCH_SIZE=$(($THIRD_SMALLEST_SIZE + 1)) &&

I think we're better to make this correct in this patch instead of
spend a dollar here, than take it back in the next patch.

> +		git multi-pack-index repack --batch-size=$BATCH_SIZE &&
> +		ls .git/objects/pack/*idx >idx-list &&

-- 
Danh
