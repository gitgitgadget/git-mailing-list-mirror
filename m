Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362ADC433E1
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 15:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B48B20838
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 15:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtP4tGdR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgFLPTx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 11:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbgFLPTw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 11:19:52 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1A2C03E96F
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 08:19:51 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id q2so5514276vsr.1
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 08:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=n8q953i9+qlFrHeVuBr1Hu3TNOHYcCNenUQ8XmQGhSM=;
        b=NtP4tGdRO1GOcKIBOo++mKTu6ewaj2jqZ8yFF2dW2xhytj3KN44oLfsJNFUmLbmGcs
         Mb4veA9IdWgda70hNOuXuwiAjQW202jZtJykusm1dPwKLK1UJ9fKiPwz1pqkhwsUylBn
         oTLH6WB3VBFSt6B5cTA7NLvhwOnGHVDalhk8cy0vrhk0959EpszbkA7NkEkHzm1bmalo
         Dy2PgPLflM2pVyHF8zGsotvOJ/QhCp5XWfv1KQue6Q1xpcm8GPsrKs3Kd+6PIN3TxAWL
         TGfzcoyBsocU7ospaC4emTizyv6hkQkEH2tFv89w3NuhD16BdnUmyHwTTPh7lSZ+Yh9s
         DxYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=n8q953i9+qlFrHeVuBr1Hu3TNOHYcCNenUQ8XmQGhSM=;
        b=lHHFkxbxvWx0aSsTa82hm1/ybUy/+/Pa6jkI0HSVk/0YVKiQUits3bQmvR68nn6fUH
         ti/0t81wOqRFJiiYZRzbnbBgygeRhElbdRpu35AyM/7YsZ2imVJXHMi/45flJp2ogmUj
         5d2OZzGmPuAG0A2eMipY0kSQjw9XTn9qmHd/Trdyj+1FdtMgi/1OaL/WcFBhTyttlCPe
         7NmxIu11eCJOhbZ39i+jv6xjMeFej0+FODHwOtJ1/65eKHFfAYBdQ/KhXoKezvIu8ZmB
         v0VNUaXZgX3ZNhBCUlHMR7+PUrFrl3A1JukRb2zTYNT3DxE6mkFoOqMe22/IH6xIZvRA
         sUdQ==
X-Gm-Message-State: AOAM530sqs7ImDfMNuOmEnZDb1x0dee3JtA6ezJ43b4hxAcSYJsDIkPh
        Nc7ry7qgT4pOoLQpaBOEDC0=
X-Google-Smtp-Source: ABdhPJxPlZ16R2FyZFv/YjGrSh8z1fTzAUzCXVoGuk2A0nBy8OFeu6vWyv8l4yxoK8DRqtpg7Qt04A==
X-Received: by 2002:a67:8881:: with SMTP id k123mr10927771vsd.198.1591975190856;
        Fri, 12 Jun 2020 08:19:50 -0700 (PDT)
Received: from localhost (25.173.196.35.bc.googleusercontent.com. [35.196.173.25])
        by smtp.gmail.com with ESMTPSA id h14sm864492vsl.12.2020.06.12.08.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 08:19:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Matt Rogers <mattr94@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        don@goodman-wilson.com, stolee@gmail.com, Jeff King <peff@peff.net>
Subject: Re: Re* [PATCH 8/9] fast-export: respect the possibly-overridden default branch name
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
        <1efe848f2b029e572cea61cadcfe36b9d3797836.1591823971.git.gitgitgadget@gmail.com>
        <CAOjrSZvm9QNUttUNVBEUMPJ8zgYEoAnSPN5_6N5uwpiM1sVrcQ@mail.gmail.com>
        <20200610233912.GU6569@camp.crustytoothpaste.net>
        <CAOjrSZvV6+ApfmOBa7rdXDPQJbExRsOfodO16i_1N5QjjhCB1w@mail.gmail.com>
        <xmqq3672cgw8.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2006111559300.56@tvgsbejvaqbjf.bet>
        <xmqqpna5bq2l.fsf_-_@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2006121451100.56@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.2006121518160.56@tvgsbejvaqbjf.bet>
Date:   Fri, 12 Jun 2020 08:19:49 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2006121518160.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 12 Jun 2020 15:18:57 +0200 (CEST)")
Message-ID: <xmqqtuzg2twq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Also, t9351 obviously needs to be adjusted. This one works for me:
>
> -- snipsnap --
> From: Junio C Hamano <gitster@pobox.com>
> Date: Thu, 11 Jun 2020 08:05:38 -0700
> Subject: [PATCH] fast-export: do anonymize the primary branch name
>
> In a fast-export stream with --anonymize option, all the end-user
> data including refnames are munged to prevent exposure, but the
> 'master' branch is left intact.
> ...
> This is in preparation for introducing a mechanism to affect the
> name of the primary branch used in the repository.  Once the
> mechanism is in use, the name of the primary branch won't be
> 'master', and may not be allowed to be exposed.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/fast-export.c            | 7 +++----
>  t/t9351-fast-export-anonymize.sh | 9 +++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
> ...
>  	if (!strcmp(refname, "refs/heads/master"))
> -		return refname;
> +		return "refs/heads/ref0";

As I said already, I personally do not think that this needs to be a
preparatory patch to anonymize 'master' that cannot be configured to
something else into 'ref0'.  This will become necessary when we make
the primary branch configurable, so I think it is easier to replace
the counterpart to your [PATCH 8/9] in the original series with it
in the v2 series.

Regarding the update to the comment before this "special case", I
would suggest to explain "why" not just "what".

Thanks.

