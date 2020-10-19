Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15366C433E7
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 17:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E76E2225F
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 17:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="SZI3IUzj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgJSRvD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 13:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgJSRvD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 13:51:03 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6743FC0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 10:51:03 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id b8so617785ioh.11
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 10:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zxzv02MSRR+tOCQZ+qMhROml7pu77pRwqndMa/AJStk=;
        b=SZI3IUzjPqUTIbjgkXigYjrXEPsr8eq4sD5fb8q06Ttib/M0+qKdzAo9T7gthaBMGD
         2nTRjt9+HwP7G46r3abrg5UhanZKWs5oue9nDPVP3vigzfQ0qbHPc8VJ18u7BU86C7hZ
         jTo0v044XKQf+6A5r+cQnDthtG+X1Z9kOmCMKYh1P/JCVb1xznS6GoOQrkD1skPp+oF8
         Sp6eGL/GAnt7CwCCWtCyKHNOmF4dr+B49vTOtFB8rlpeRf5wRRuCTDkQYL5ypmRcKV1L
         ZP0+Dw22clN6sqJ0WJRuO6ObJTrlmerJfwZQNa7M/vvpVRaFb12GjlwmagggNba/TG2B
         tfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zxzv02MSRR+tOCQZ+qMhROml7pu77pRwqndMa/AJStk=;
        b=BgVvRZWcPMagzCnn+7Qw+9C6bfFUdd8q5bCRuiO9LLKTEaBgRWWiNKBPeEmnGyO+BC
         dhWH55cditSHX7qAtFqGG0oaaNJF0nrwgW2rUXLQ0VDucKxoC55ZZZ2Rkx5oBU7loiNN
         vLNy1a802eNvawmxiLHCBtY+lADzbK+L969JWIuDdtY6h4XFJHjeFPhERCaAlGZM1xtN
         e+stqntQj/v+fW3uW4/LhoVz8NvKw0Z82TkU4Dln+F7FfuGmHLk9Zob5x9XmmOKwdBnM
         3/t2KOBEn8b8ERYLOqAu9h3E8VhvHbh9NAlJu40y63Anv7ZCEO8YHOC8VewDVsXg07y5
         2Bpw==
X-Gm-Message-State: AOAM531QiiRL2D/sKYkDlzfwftvxev6UTIQ60HuoVBhazJverAnABNlq
        WBfr5+c3okj/RKThwSb4KxrmDw==
X-Google-Smtp-Source: ABdhPJzX2wMxNnimVHFkHHC7ni1X24niT1tLNPKZYcMJEdqRyrRkwPKtRkSU8p/uEGnMpRnxLF0tBg==
X-Received: by 2002:a02:a60f:: with SMTP id c15mr1015802jam.48.1603129862740;
        Mon, 19 Oct 2020 10:51:02 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:c096:f5e9:cd72:773e])
        by smtp.gmail.com with ESMTPSA id m66sm465130ill.69.2020.10.19.10.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 10:51:02 -0700 (PDT)
Date:   Mon, 19 Oct 2020 13:50:59 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Sami Boukortt <sami@boukortt.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: French translation: =?utf-8?Q?incorrec?=
 =?utf-8?Q?t_translation_for_error_message_in_=E2=80=9Cgit_push_=3Cremote?=
 =?utf-8?B?PuKAnQ==?=
Message-ID: <20201019175059.GB42778@nand.local>
References: <CAAb+AL_xObsexRXL_fZdhj2FNQsOLzEz3_mZqd1Yz7F0=-havA@mail.gmail.com>
 <20201019174127.GA42778@nand.local>
 <xmqq5z76umvc.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5z76umvc.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 19, 2020 at 10:49:43AM -0700, Junio C Hamano wrote:
> My understanding is that the l10n effort mostly uses the GitHub pull
> request based workflow than sending patches to this mailing list.

My misunderstanding. I thought that brian's patch to the list a couple
of weeks ago was the typical workflow, but apparently not :). In either
case, the po/README guide is authoritative, so whatever it says is good
to do.

Thanks,
Taylor
