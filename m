Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3B0FA3744
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 18:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbiJ0S2j (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 14:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236002AbiJ0S2F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 14:28:05 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DBE75FEF
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 11:28:02 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so2239420pjd.4
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 11:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9HmR3UthTTzCVJY/sD50FPZjQlmkIkIaR0X/edD27I=;
        b=qsRVbXFMlUQiJO+NFfin4XZICklI6BXxDKLmyTX/jXS2B8a0ecuGDzSzKXiViJtbtp
         htqazQd0GAmDqjnC7kPqo7iUMFKgn83EkKu1GQ5OfVBrgDfPQQTw1qUQLVayM3m7KHRf
         mlGTr0s1EWKXAbbDES52fkEZl4beCllmf/R2t8su1/IGTT+udz4ZKWJHTtXsCPtTtmID
         6fF8/kwsyDquGnemYjhuOHvFYK+cSIafr2lpxa2WZK98sVCjzXeTBuZS//+3KhmnfHtg
         3TUUS793pO2I2XlHAShcNZL6ruWwdPkjfDJliVWlaUrGhJQgSDyhYy1wFORoSH6yceF2
         uqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f9HmR3UthTTzCVJY/sD50FPZjQlmkIkIaR0X/edD27I=;
        b=JtsA3Rw/quP8MSbqV9G4p4131e7q0G4MBR+BuKNu+kCvDUcoC14cUXuhPXuzs2jCGM
         PeXDmDdSAzm/UxXfRYOyGe5n2cJJZbSYTuA4gNpKb7eOiqAXvhOPY/uV5L1kCZtMlKOB
         VLykBMy8xU/OYHKXexGX4mago9FcuwUtqdLVduqJ5LOOydIlKU21EwjsJGxwD40ONbPU
         fQ5++IucK/wkdvgysRLcEoLZbB61LE36db/szntRYtyfF1rdO4YwL7sRiUxVPCwt+LTo
         AgsFxOzcVEF01cDkJQ4ez1v2FoMxE79CuqQy+F7yiuxQWYdMf73lAcA/AHDBw8xjvDgq
         Z/Sw==
X-Gm-Message-State: ACrzQf3GCTH7mUpEv9+Mg3m7OBzZQ5DLH2jGmyhcBOKdBTVZAYVMxXZK
        S+n7RIiFQVJbagosFMBkqzk=
X-Google-Smtp-Source: AMsMyM70kNMoJzOGfsC4n3ZrKpU2hRst6T57F8x/4/tKw48GBVdtGBLVDP4Lc6oIRytjhXv/6Q756w==
X-Received: by 2002:a17:90a:6405:b0:203:6eaa:4999 with SMTP id g5-20020a17090a640500b002036eaa4999mr11784380pjj.8.1666895282082;
        Thu, 27 Oct 2022 11:28:02 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 83-20020a621656000000b0056b9c2699cesm1466017pfw.46.2022.10.27.11.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 11:28:01 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 3/8] use child_process members "args" and "env" directly
References: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
        <672e4176-81b4-bb9c-5a14-e558d24b0c0d@web.de>
Date:   Thu, 27 Oct 2022 11:28:00 -0700
In-Reply-To: <672e4176-81b4-bb9c-5a14-e558d24b0c0d@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 27 Oct 2022 18:36:45 +0200")
Message-ID: <xmqq8rl1m89b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Build argument list and environment of child processes by using
> struct child_process and populating its members "args" and "env"
> directly instead of maintaining separate strvecs and letting
> run_command_v_opt() and friends populate these members.  This is
> simpler, shorter and slightly more efficient.

Nice.
