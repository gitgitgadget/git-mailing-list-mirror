Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAF3C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 14:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEADF613E9
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 14:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhFJO0R (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 10:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhFJO0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 10:26:16 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8219EC061574
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 07:24:06 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id q5-20020a9d66450000b02903f18d65089fso11448420otm.11
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 07:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=xuwsWaV0NDVeu4cFrbTTw3NyZzn9jsPW2UbkO3BJNj4=;
        b=QcguvgWb3jWRh9elJa71Di83bwRo2V04QXGV83d4S1HA84cCaBXKyVZjqZZiVCTQb9
         pAa/2NI8bQ0Gs4P5geKQ5FErAunMu8TxsVHYImpX+Tk9Evtu4UlLeJdubfJvEBBVs8x1
         4HQyKnFfSzUKk9xjm9iZ/N62BPZAyvXT+BsKgNDwW23wgmJJW1rMufenPWtp1HzURB8Y
         28ZoAhMJVkVgrepr0MQ+MZI8zudauLGRhahO7+SelQBQhd01OYd+BuEf4gCxOWwkTsDx
         JLpIy4aCArnwbSIGxHuK6bSv+v9d6rdkecpdvclUhFYRnyQ+Sc4jZj81Bi2mfXTC+dM7
         6WKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=xuwsWaV0NDVeu4cFrbTTw3NyZzn9jsPW2UbkO3BJNj4=;
        b=kV2jBrwV2KZcwg800vZUPvVdHB51ECOlRTnODUlgHVSg0tFn8fZF0G9CbRaD7m44V8
         R7aEtllgVMZLbL+Zga3N7FdpdaG9gzCx4kVp7miWj22zdbEuI0zWoIOP2nAFdmvMtY9T
         Ycp8fujLTA0P7lE6p9GEsRNidR16Y9YzeI08Ee+Wjbu7IyKOqtjmEgp2bhZrg9/kuY07
         5RtZNtruW7QVInLii7gjyfJ19C3GKXADUMQUi/gORwX2FSEDNheKCQ83sG9ewaVkHxtB
         JB/rjxBr+u8JtNOm+d4Ua7/Mj+sal0D/FM3nvgnpsA/XL8vEX+NDikjT+QAFjqbqZpkT
         Yikg==
X-Gm-Message-State: AOAM530k9Rn8DN+dNq9TVAqTLUxnoxWT7Qv6X3EnTXE93ROwtq9PlMxr
        kQgkYrWkvO+yCca6PUUr8WQ=
X-Google-Smtp-Source: ABdhPJwnOCDPhUk20MjC2RmbJgJ2Oki0Yy4iz0DnugOvpd57Uq8TzovuUf4VKaPs3GhyODo4fFF32w==
X-Received: by 2002:a9d:1e4:: with SMTP id e91mr2621616ote.211.1623335045749;
        Thu, 10 Jun 2021 07:24:05 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id z4sm651078otq.48.2021.06.10.07.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 07:24:05 -0700 (PDT)
Date:   Thu, 10 Jun 2021 09:24:03 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Nikhil Gupta <nikhilgupta2102@gmail.com>
Cc:     git-packagers@googlegroups.com, Git List <git@vger.kernel.org>
Message-ID: <60c22083b4131_b25b1208f6@natae.notmuch>
In-Reply-To: <87sg1p24zc.fsf@evledraar.gmail.com>
References: <f5487adb-b7dc-4f97-bca1-749701337759n@googlegroups.com>
 <87sg1p24zc.fsf@evledraar.gmail.com>
Subject: Re: Build errors when building git on MacOS 11 (x86-64) and for M1
 macs
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> This is arguably a bug in git's Makefile in that we should have that
> "-I." in an ESSENTIAL_CFLAGS variable or something, I can't think of a
> scenario where git would compile without it.

If they are so essential we probably don't even need a variable, just
put it directly into the $(CC) command.

-- =

Felipe Contreras=
