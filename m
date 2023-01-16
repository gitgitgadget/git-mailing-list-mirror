Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7E8C54EBE
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 16:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbjAPQiH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 11:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbjAPQhZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 11:37:25 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632DE23DAD
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 08:26:22 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id d10so19978719pgm.13
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 08:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rX1OjQU8PqjZh2c3445VSBK/5H9VYKT6NHFoONaYTVE=;
        b=DliUa7bKBYo3Wx9b1uG6irEAqL+uEE7c+KHDjOvK0N5WFTR+4EnK+VG7X+fA7CBIxW
         b3nEM5b+DibrIf0nKlujkp4WE6ZlzE2J0EzV4xwbRGNPij+6LdVViEVg0KIN3OVvVpA1
         KbeRtS1wPw2fJJt4XsUFK9glx5Y2UsSdejjfMWSoR9JkeqS4rOV1F+BVikIkO64KqUr/
         6gW27A7cyrgubIHcfuwF1hvOvb6o/bdgwnXjekZqzic+kupWV+E87IJ9r8n92MqqsfuP
         tIKUqAUCdYMjM6KVGaBczsEX/ko09tw2Pfkhw32bPgjW2Wh/Sx6gXkA/6mhX8YCspbpe
         awlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rX1OjQU8PqjZh2c3445VSBK/5H9VYKT6NHFoONaYTVE=;
        b=q5a5iab2WthDYTzuGdawa7xce9EoXDgjasLEjugzWJqcJumk+ahjKBDINRKN02R5ke
         jrwof6PWleIOYtekaUZSkzX3hfNwuhWgo8WDr5FAmzsW2NmF+8wYl7GM4tZTrrc8jSdO
         JnG4P9AhFv7ciwPx9TEzzzgpHbdgKuCHbv1uO08Y8UnPNxpkpCbsbK1V3lUW4bD2Z060
         YzxCqjsNb/oyv0F8Ehi6fD3xATZRRx7tMmknvh1Ye7CUzBaCmoSawOxrMrbLejcocTi8
         TSj1RHW5YqVsQUI83ofYSzMfg33NLHP6JTPuXur95mgArcMdPeQwgvLjnSoKzDVQN4XD
         JGlw==
X-Gm-Message-State: AFqh2kptOs7MHxV3lmTIzYxJkg/uR+B6gDAWzCMh0wPQMlGqptcRxMbS
        KR/+xEYbUS36WAvXShyTaew=
X-Google-Smtp-Source: AMrXdXvXLeh6A5fzSWjsXBHoF/yIh8Gizrhx5RKZNyttrZGKy1GFAZlRtFrxonU9cHtV0t7P5p9+BQ==
X-Received: by 2002:a05:6a00:15d6:b0:588:22ad:2928 with SMTP id o22-20020a056a0015d600b0058822ad2928mr309898pfu.3.1673886382295;
        Mon, 16 Jan 2023 08:26:22 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id e6-20020a621e06000000b00582e4fda343sm4768728pfe.200.2023.01.16.08.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 08:26:21 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 3/3] http: support CURLOPT_PROTOCOLS_STR
References: <Y8RddcM9Vr71ljp4@coredump.intra.peff.net>
        <Y8ReHbGWetJHQcI1@coredump.intra.peff.net>
        <230116.86edruzk5m.gmgdl@evledraar.gmail.com>
        <xmqqzgaicvmj.fsf@gitster.g>
Date:   Mon, 16 Jan 2023 08:26:21 -0800
In-Reply-To: <xmqqzgaicvmj.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        16 Jan 2023 08:05:56 -0800")
Message-ID: <xmqqv8l6cuoi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +#if GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR
>> +#define GIT_CURLOPT_REDIR_PROTOCOLS_STR CURLOPT_REDIR_PROTOCOLS_STR 
>> +#define GIT_CURLOPT_PROTOCOLS_STR CURLOPT_PROTOCOLS_STR
>> +#else
>> +#define GIT_CURLOPT_REDIR_PROTOCOLS_STR 0
>> +#define GIT_CURLOPT_PROTOCOLS_STR 0
>>  #endif
>
> I find it a bit ugly that CURLOPT_* being used are all non-zero, but
> it may be true in practice.

Sorry for making the first half of the sentence unintelligible.  I
meant to say that it is ugly that the correctness of the solution
depends on the real value for these macros being non-zero.

