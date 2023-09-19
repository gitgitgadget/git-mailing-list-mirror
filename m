Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE43CD54AB
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 09:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjISJMr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 05:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjISJMq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 05:12:46 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF48DA
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 02:12:40 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 684245C0250;
        Tue, 19 Sep 2023 05:12:37 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Tue, 19 Sep 2023 05:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1695114757; x=
        1695201157; bh=fm6VamaFiayE9wx5bl//wU+8tiyatCH5jsv+HeG19eE=; b=g
        af+/NWgZT7eyEfo872Tdm7UsEYx1+wPl/VEHcmD7wdnQhqoGU7wxYGXdvs8wMbo2
        iLd0/rw/SlWiXRObexM8icGGrMrxREVR41yTQqBOAyopLIpqXq+UqcFqn/r2l76L
        qfjZa10xz4790iSqM/DgkHxD4aLXbR1dPd2GpUIeJfcNRV2nPlSgPWE++NsKDVlj
        CphJCBwr6cdbWYNO7ASdfzwrodIPZC4cFUzfJUTLyzqDfb2hsebQvvYX70ZTO3F0
        mjzM6X/oq7QS1CN7kU60LQzBaui92OX7OEc4zoJuhJ27jso3icXmmvdNuvIy8cZw
        7Si/9j0p8jaBXbHlx0hWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695114757; x=1695201157; bh=fm6VamaFiayE9
        wx5bl//wU+8tiyatCH5jsv+HeG19eE=; b=IF3nvgN6+wTypL/JMDp8PcdksLz+W
        JgmxTDvoRHXlneSsgtdoR0oLdnKC4+CR3xiC5KftjIMT6grwv3oT6i73G/vSm8Qo
        smwpWTPNhX4CLS8//J5JopbBQsc8J+YWDkX2tJwjYlCx/GyByBF73Bq2/Qs8evO5
        NZGU4GOoGzq6X1Tta1RogiUFuYeAa0JQEG7ULD2B0W7lwYxyyePDgaGb5SvEp7bl
        5icvbaUGxR9DbKIY8YQVZDeCshN0+sUaG5+ejp6BDZF1xE5TZtWAJ5658YFEb33p
        IlfZAX3B2FElRbN/zhLG/00gz8fzsmVltIB0UtdH5BYkx1FHiHhCYsF2w==
X-ME-Sender: <xms:BWYJZTiMRzgr41mpVe79kcfZmCvsVInFQ4hmBqrSdDHOdNziPaERXgU>
    <xme:BWYJZQAgB1pTcH5ABJewk2bbm75vK9HCthjUnDJMbWtQwKCL1pNPHXzGhX8K9jDDg
    dtY5xIFJDql9t-fxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudektddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnheptdektdejieffleetffehieehueffgfeh
    leeufedtjeekueffgfeihfegkeffffeunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:BWYJZTH4KDNz_PgBANQie4VddVpM4ZpLEuBIRbl9ad8gmH5CN2m1VA>
    <xmx:BWYJZQQffSc8WJVzuhun1IDQBM97niU5xbHzVNDlxTO5ZrnhF8XsoQ>
    <xmx:BWYJZQyRF4amFsP-8yTfgUtOQl0FLkHNyi25FVESaQSLuhZwa2n0Ig>
    <xmx:BWYJZb8zpxM0tIMp1NZVIJrkYTmc1nDsjeZj3H4vEQbgc4LtI9gwUg>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1B36D15A0091; Tue, 19 Sep 2023 05:12:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-761-gece9e40c48-fm-20230913.001-gece9e40c
MIME-Version: 1.0
Message-Id: <69e8d116-05eb-4b16-aa5d-62da1ff818cc@app.fastmail.com>
In-Reply-To: <xmqqled3hsip.fsf@gitster.g>
References: <cover.1693584310.git.code@khaugsbakk.name>
 <cover.1694383247.git.code@khaugsbakk.name>
 <a37dfb3748e23b4f5081bc9a3c80a5c546101f1d.1694383248.git.code@khaugsbakk.name>
 <xmqqzg1strgx.fsf@gitster.g> <dd2958c5-58bf-86dd-b666-9033259a8e1a@gmx.de>
 <c7d1e196-9521-45a7-b41c-80499f19f546@app.fastmail.com>
 <xmqqled3hsip.fsf@gitster.g>
Date:   Tue, 19 Sep 2023 11:12:16 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, "Denton Liu" <liu.denton@gmail.com>,
        "Jeff King" <peff@peff.net>
Subject: Re: [PATCH v3 1/1] range-diff: treat notes like `log`
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 19, 2023, at 03:16, Junio C Hamano wrote:
> Will one of you tie the loose ends?
>
> Thanks.

I will this afternoon (CEST).

Cheers

-- 
Kristoffer Haugsbakk
