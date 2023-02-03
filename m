Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B5FC61DA4
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 01:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjBCBWN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 20:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjBCBWM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 20:22:12 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8655974A54
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 17:22:11 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id cl23-20020a17090af69700b0022c745bfdc3so3545026pjb.3
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 17:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkPiryErL3uib3f9ZOpcWDVw/ys3oAFMbdOpSm8hB/U=;
        b=P3oa1xahQoM7O8fC3TquKiY8J7Zso5IfBov/f4uR8xtGbDZ217+qo6I7euQYQULoCA
         MekU93SckIvjkpAXbsyHFnGQz16JSFSVFBWYOFSD6/knQZY2hlVmE6P0u+Q0ut6LTO7c
         MIJNZ8GFSijkmiMDUTVpVZCQ0Q3E2IzdtPawWis7yzeDoqeVhMW0QReaghgkCzFywmUi
         uuq308bfQnc4aILVnr6bMCH4ALaHuwcKjTsry+S/HLqHCRJ0sa6zTR9JZHrraAMARbXP
         mcjNmjxoRW7jYIul2thRdwykAaIZD2yPiYpWCRnEOSu2XfQI72hG2s/FKqZS9ViREGEv
         8PUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkPiryErL3uib3f9ZOpcWDVw/ys3oAFMbdOpSm8hB/U=;
        b=4+HZIhr7l7aoZQkd8dOiyRAa0wH+uttJGbGhgC+Axm5vnsPaLt58rQ9PUkN6tajv4k
         OaLVAgnYZ4+sbfTY+0yGvW99U3BgXAIPhvzzlc1JKhnhPrZiwXZ8h2H0u2W9qM3tljHg
         JuyeHRlgy3+OQ2ysX9dwov5Vbz5ueCu2OkdYiTfJOJW2nj7zEz3Kuk4Ct9cbQp0ZW25d
         xGbpuuIIzv2OA1G9zfRn9YsCQWjgW4qUU5El3WNsJdzuMnJVbVlRjwkLMoSBbyLPUt4g
         3y/6T22WRB/YXoHYWCmA1ShVAWDOADGtGe6FxD6RhfUIycp7Op03N+WYCEh2k/ySdaxU
         lX2Q==
X-Gm-Message-State: AO0yUKU/B3N9zVmjsz3vorDKt4r56P1GQ5NK9bik6PknQOVlGVSIODB1
        pSQk0yeWkPQcS0QzKtHJWCE=
X-Google-Smtp-Source: AK7set//rLr6VDe/hZP4KVatTPeOkhX8cHDHbs+R7lvYQbqfJEMG8ZnE3txT/skJ3CW0c6J3zGw01g==
X-Received: by 2002:a17:902:dac9:b0:198:adc4:2285 with SMTP id q9-20020a170902dac900b00198adc42285mr4153044plx.0.1675387330864;
        Thu, 02 Feb 2023 17:22:10 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id m21-20020a170902bb9500b001947222676csm287011pls.249.2023.02.02.17.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 17:22:10 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, raymond@heliax.dev,
        zweiss@equinix.com
Subject: Re: [PATCH v4 1/9] config tests: cover blind spots in
 git_die_config() tests
References: <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com>
        <cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com>
        <patch-v4-1.9-4ae56cab7c7-20230202T131155Z-avarab@gmail.com>
Date:   Thu, 02 Feb 2023 17:22:10 -0800
Message-ID: <xmqqwn4zo859.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> There were no tests checking for the output of the git_die_config()
> function in the config API, added in 5a80e97c827 (config: add
> `git_die_config()` to the config-set API, 2014-08-07). We only tested
> "test_must_fail", but didn't assert the output.

It sort of is expected as git_die_config() is useful only for code
that uses new style config parsing (i.e. instead of using the
git_config() callback interface to parse what we encounter in the
config file, actively call git_config_get_foo() interface to ask for
keys the caller cares about), and dying unconditionally is not
useful for the old style ones.

A better coverage is good.
