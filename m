Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B67C4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 03:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbiLBDlS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 22:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbiLBDlP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 22:41:15 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BE817E15
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 19:41:14 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id l127so3126884pfl.2
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 19:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wt/ZCPLtDiHSLCNnlVLHM6eIF3MPMQwnCxQhQRyhfkU=;
        b=Eoqh62ycNYL9tMSif9Gz0+FquWCDCxTuqnaGJAuLl93dsVpVXGo27aZgI0HGr5FH40
         UJ4BMV5eaeMN/dXW2F9ZcxFBaA1y5x7iPY5k+rzHeROAV4zpz/DsnZLQzzvU48Hecuzq
         5BSnLyC1o8L0SMxmlLqN/Ayk7AICQkoS2fkPCzTQQo5Gf6XvcX4S5PT/2RjmE8TEjgD/
         YutafXEEVYPjo7VkxfHF8pdF3+758uda8qZDZs40EMehqe8bIsd97r8mljKSpqf8fClg
         aMR37Ail2MfhNOvyZW4aoX/Sl2uOG73E7UweugVbfzS0q2mi8e1CjHVx4SkjTaB3QLWC
         n2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wt/ZCPLtDiHSLCNnlVLHM6eIF3MPMQwnCxQhQRyhfkU=;
        b=lTqwNLDTCGgwEWUVYIXdKhp5150243Z6OHvsltlzgyqQZTrHWjpzGMdxiz9HLQfLfm
         tbER0JfyEpUOa2u68Uzz9Xjb13aJK48kWvDwPasT2dqMGf5cinOSTm1mOuHlhlsjgbyz
         wX0J0xdauaeoWEkcwISRxwRnKtrEHE5v1npY167EA/XZGjQoi9NfNo2IKwLu9L6ggB4N
         vEBFOnpdY6Jqe6AvwH95HG1VaSBFClbhIX7V1yPC1OwNThyC67LjeBmVjGSunKu4eiuN
         Zp3stwAXtOgDKqy1PwBv/gMQk+9Y142Xe9utf8XB+8gFTZxso08oMSGC78e8tLfmzAnI
         +1JQ==
X-Gm-Message-State: ANoB5pkkhdmGX/LIRMriqn/8q9saeqfJiCMZPmKSsIHEiY6J3da7EV3X
        AS9P5vwxWR+WPEBEZeajiXw=
X-Google-Smtp-Source: AA0mqf4YxNF8xWXNO1OnxYXA/4Dt5dKP9gDROk2zCVNm6SzOQ4uwXc2bgCv3mCf/hLxM7ITtU7ezPw==
X-Received: by 2002:aa7:9293:0:b0:56b:9bf4:c1c4 with SMTP id j19-20020aa79293000000b0056b9bf4c1c4mr61883337pfa.67.1669952474006;
        Thu, 01 Dec 2022 19:41:14 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id b12-20020a1709027e0c00b001886ff822ffsm4327564plm.186.2022.12.01.19.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 19:41:13 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 4/8] test-lib-functions: add and use test_cmp_cmd
References: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com>
        <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
        <patch-v2-4.8-c36060934a6-20221202T000227Z-avarab@gmail.com>
        <CAPig+cTfx4QYBdtSomPRM+BpW+3ELqaQxD7okKhXzykVkyH9NA@mail.gmail.com>
        <CAPig+cSgnhzFCUVTQCcTKJK+2qVOpdB2R-Vq1DjqspDJudom4w@mail.gmail.com>
Date:   Fri, 02 Dec 2022 12:41:12 +0900
In-Reply-To: <CAPig+cSgnhzFCUVTQCcTKJK+2qVOpdB2R-Vq1DjqspDJudom4w@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 1 Dec 2022 20:45:42 -0500")
Message-ID: <xmqq5yeupj53.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Another reason I'm "meh" about this function is that it seems too
> narrowly focussed, insisting that the "expect" argument is expressed
> as a one-liner. (Yes, I know that that is not a hard limitation; a
> caller can pass in a multiline string, but still...) Maybe I'd be less
> jaded if it accepted "expect" on its stdin. But, even that doesn't
> seem to buy much. The vast majority of cases where you've converted:
>
>     test "$dir" = "$(test-tool path-utils real_path $dir2)" &&
>
> to:
>
>     test_cmp_cmd "$dir" test-tool path-utils real_path $dir2 &&
>
> could just have easily become:
>
>     echo "$dir" >expect &&
>     test-tool path-utils real_path $dir2 >actual &&
>     test_cmp expect actual
>
> which isn't bad at all, even if it is one line longer, and it is
> idiomatic in this test suite.

[jc: updated the rewritten example]

And it is crystal clear that "expect" and "actual" are clobbered
if written that way.
