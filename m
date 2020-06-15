Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9D1C433DF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 21:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA1402071A
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 21:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEBFbxKt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgFOVu1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 17:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgFOVu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 17:50:26 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F419CC061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 14:50:24 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id dr13so19077637ejc.3
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 14:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ULKVtj7JL4brPBeniTpaYFC+sYBwMqRdg/hmAfAE154=;
        b=ZEBFbxKtWblWKsRjwFoGeOKHM3/QkSzX5oKqfP1kmXX5bjV6bT/LFMk4N2RGUzWwaw
         Kc4EmJzZngAso+nFPF9PtlXT7Kyi8BVGlGXnLonU8vOTa88kaC/TiijxdWBM/v22oAc8
         z9LUp+7RblwZcg3hfZmdHiCgT/Z5II84yRQyBAv6DrXcnFtFmShNw7XJmEgEqbO3N7w3
         c4VFdweVJytSH3k4ns0fcyl4EjYq9Qvi9ou7xPfbU7LCaNLbtDhEHsYknOuFf7SEAdkF
         5+o0JH/tGhIed2wmoeweW4kY2THnvveJyEgsSySJ94naikCyaXz/djO9zc4q4kmOAJfx
         00pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ULKVtj7JL4brPBeniTpaYFC+sYBwMqRdg/hmAfAE154=;
        b=j6rqYSQMxUoLUAHveuAhTasCeQcLjK2aieq9hQaVWIJCwO6n4UzkLDrE6B9KuTc3a7
         nLqXTGNDRejdfFfU8ASEMGDc3o621Cx/QVbN97d0+JP2iXWPSPRVrQiaZoicpJtV6hXH
         t8MSfCV5r7ULjHD38bvoqhCVRCWQ5SaSXKCo9k8otw9S4WhaBy3ETYv/8CnPOMeRBLCD
         x6n47dwqJUjyohE61meg7xmj4pyrCuBy0FlNLvFqs/0UCRdV+Dio+q8RWJNDg/ilSX5b
         ouXSM+mIgM4LLI41M/jEIv1cHT2i7s0UGe47fhRUXBZ4/FGUT76kObL4bajr2oi0myl7
         WxBQ==
X-Gm-Message-State: AOAM530Bb6BxpGIeWZIbwvaFoAaJQ4aTuvxHQRQrlLrhPvx7zSd0d3Ct
        EGIAMYYCHE2/uDD8hUPO47vo1h8H
X-Google-Smtp-Source: ABdhPJxVs8XCGnHgfWpvmDbLlSPYEoYu5TSfl+Dlu0bzuU5kzL0dDMJ0g4E2Co3lp8bkdp0T7+gEYA==
X-Received: by 2002:a17:906:b207:: with SMTP id p7mr14578934ejz.23.1592257823716;
        Mon, 15 Jun 2020 14:50:23 -0700 (PDT)
Received: from szeder.dev (62-165-236-99.pool.digikabel.hu. [62.165.236.99])
        by smtp.gmail.com with ESMTPSA id w3sm9730793ejn.87.2020.06.15.14.50.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2020 14:50:23 -0700 (PDT)
Date:   Mon, 15 Jun 2020 23:50:20 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Son Luong Ngoc <sluongng@gmail.com>
Subject: Re: [RFC PATCH v1 0/6] stash: drop usage of a second index
Message-ID: <20200615215020.GE2898@szeder.dev>
References: <20200505104849.13602-1-alban.gruin@gmail.com>
 <20200615152715.GD2898@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200615152715.GD2898@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 15, 2020 at 05:27:15PM +0200, SZEDER Gábor wrote:
>       - Should we even allow 'splitIndex.sharedIndexExpire=now'?
>     
>         I believe, though haven't confirmed, that it can cause trouble
>         even without using an alternate index.  Consider the following
>         sequence of events:
>     
>           - Git process A reads '.git/index', finds the 'link' extension,
>             and reads the SHA1 recorded there that determines the filename
>             of its shared index.
>     
>           - The scheduler steps in, and puts process A to sleep.
>     
>           - Git process B updates the index, decides that it's time to
>             write a new shared index, does so, and then because of
>             'splitIndex.sharedIndexExpire=now' it removes all other shared
>             index files.
>     
>           - The scheduler wakes process A, which now tries to open the
>             shared index file it just learned about, but fails because
>             that file has just been removed by process B.

Confirmed.

To help reproduce the issue, this diff adds a strategically-placed
controllable delay between reading '.git/index' and reading its
shared/base index:

diff --git a/read-cache.c b/read-cache.c
index b888c5df44..5a66e9bf4b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2319,6 +2319,9 @@ int read_index_from(struct index_state *istate, const char *path,
 	else
 		split_index->base = xcalloc(1, sizeof(*split_index->base));
 
+	if (git_env_bool("GIT_TEST_WAIT", 0))
+		sleep(3);
+
 	base_oid_hex = oid_to_hex(&split_index->base_oid);
 	base_path = xstrfmt("%s/sharedindex.%s", gitdir, base_oid_hex);
 	trace2_region_enter_printf("index", "shared/do_read_index",


Then this test creates the above described sequence of events:

test_expect_failure 'splitIndex.sharedIndexExpire=now can be harmful' '
	>file1 &&
	>file2 &&
	git update-index --split-index --add file1 &&

	{
		sleep 1 &&
		# "process B"
		git -c splitIndex.sharedIndexExpire=now \
		    update-index --split-index --add file2 &
	} &&

	# "process A"
	GIT_TEST_WAIT=1 git diff --cached --name-only
'

... and fails reliably with:

  [...]
  + GIT_TEST_WAIT=1 git diff --cached --name-only
  [ ... trace from background commands removed ...]
  fatal: .git/sharedindex.818f65852e7402f236aeaadd32efdbb62291aa75: index file open failed: No such file or directory


>         This is similar to the issue we have with 'git gc --prune=now',
>         except that 'git gc's documentation explicitly warns about the
>         risks of using '--prune=now', while the description of
>         'splitIndex.sharedIndexExpire' doesn't have any such warning.
>     
>         I think that 'splitIndex.sharedIndexExpire=now' should be allowed,
>         for those who hopefully know what they are doing, just as we allow
>         'git gc --prune=now', but the documentation should clearly warn
>         against its potential pitfalls.
