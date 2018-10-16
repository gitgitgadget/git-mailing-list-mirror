Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC9F51F453
	for <e@80x24.org>; Tue, 16 Oct 2018 23:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbeJQHCS (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 03:02:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34513 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbeJQHCS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 03:02:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id l6-v6so27042926wrt.1
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 16:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=b4WCzEcfDljX1F9VnSweqwav9nd2br4bwGPp0boEOwk=;
        b=by8zJyalw4bu2O5M3U6dGTbHLVr3ophD1oO9cwWUVATR4KoocZILTpozU7oTXvSMu6
         3fs7vnCoc/UNeeMYTvQvOcCrTqTgj1G+qX2v+YbXxscobN1LH1aNOEPrhFHYeGAVJolG
         gA2MnR9f4ql2Lwo6k8CF2XzWoWDJvs4m3EiT5IPcTv8arEeyPZZcDKiA3vX1CUJ7pxjC
         PPtQIOFdpMiCwaVGkc9nWWBLbAKnH1psqMqBXQ2RO4qpjMW+h3mNnNNSkwXn4wUBoJYW
         bilKDXPligIGuwYnbNDROBcMlCZkoBc0Mlq3K+hM0aomoweuCc1iGrZMUZRbM+QfUIE1
         AbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=b4WCzEcfDljX1F9VnSweqwav9nd2br4bwGPp0boEOwk=;
        b=VHOdktlLvenxHfar6UKU/jS58sRgxl1gk9CoG6lHSOa5gaOKj5fXb0fG/KQG7vBjE3
         4+5NgqPXRDXBPNEZQPncOVnedOPy70N1hTeN1ThIk1w7QpWYJ/vxOEjaVFOKKBUUdpja
         JrS6LraZS12qzLI0cL1WylC+Xp1AIrRzL3sLRT82U3ZC8MQnvATMlEDI55NFAWSo5tOh
         f4YmE+9VKouK5gM0NwEAbFi0A1pIznepjCRA+JjdL4eZ2CXMtYJxQpKg2B0qOvAyPqqM
         zigIk9LHFidre3F+oiWoTRW1/M8JTfzVehnwiCbNz5Ee2t5F0lxXYUUGu46elLlBzEcx
         zhiQ==
X-Gm-Message-State: ABuFfogVpU7bVehus79ixk8qDQ44emLqj1Y3ZRYwDhbNxUCy6CaAwzNt
        wlFCSB2rHiiyv5PswoOwIgE=
X-Google-Smtp-Source: ACcGV63iszG8tg9sa2/YOkH1CPC1wv/Lco5egnlUikKrog67b1PaD20avrZKWOb6QFlB28Ntvfp9AA==
X-Received: by 2002:a05:6000:50:: with SMTP id k16mr13132357wrx.103.1539731376929;
        Tue, 16 Oct 2018 16:09:36 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h78-v6sm118337wmd.4.2018.10.16.16.09.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 16:09:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 15/16] commit-reach: make can_all_from_reach... linear
References: <pull.10.git.gitgitgadget@gmail.com>
        <816821eec9ba476ccdfbfdf6e3cdd3619743ea2e.1531746012.git.gitgitgadget@gmail.com>
        <d1b58614-989f-5998-6c53-c19eee409a2f@web.de>
        <dd798e76-922f-a113-4408-e3892bee3b44@gmail.com>
        <223b14f7-213f-4d22-4776-22dcfd1806c2@web.de>
        <7b95417a-c8fb-4f1e-cb09-c36804a3a4d0@web.de>
        <20181005165157.GC11254@sigill.intra.peff.net>
        <dca35e44-a763-bcf0-f457-b8dab53815cf@web.de>
        <20181005190847.GC17482@sigill.intra.peff.net>
        <c05f192b-4e89-48b0-1c23-b43ec6fdb74b@web.de>
        <20181005194223.GA19428@sigill.intra.peff.net>
        <c141fb44-904f-e8b6-119f-7d2d6bcfd81a@web.de>
Date:   Wed, 17 Oct 2018 08:09:34 +0900
Message-ID: <xmqqr2gpxzdd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Apart from that the macro is simple and doesn't use any tricks or
> added checks.  It just sets up boilerplate functions to offer type-safe
> sorting.
> ...
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 5f2e90932f..491230fc57 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -1066,6 +1066,21 @@ static inline void sane_qsort(void *base, size_t nmemb, size_t size,
>  		qsort(base, nmemb, size, compar);
>  }
>  
> +#define DECLARE_SORT(scope, name, elemtype) \
> +scope void name(elemtype, size_t)
> +
> +#define DEFINE_SORT(scope, name, elemtype, one, two)			\
> +static int name##_compare(const elemtype, const elemtype);		\
> +static int name##_compare_void(const void *a, const void *b)		\
> +{									\
> +	return name##_compare(a, b);					\
> +}									\
> +scope void name(elemtype base, size_t nmemb)				\
> +{									\
> +	QSORT(base, nmemb, name##_compare_void);			\
> +}									\
> +static int name##_compare(const elemtype one, const elemtype two)

... and here comes the body of the comparison function that takes
two "things" we are about, i.e. elements of the array being sorted.

Quite cleanly done and the result looks pleasant, at least to me.
