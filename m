Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739A4C7EE29
	for <git@archiver.kernel.org>; Sat,  3 Jun 2023 00:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236911AbjFCARD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 20:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236470AbjFCARB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 20:17:01 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8171B6
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 17:16:59 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64d3bc502ddso3213862b3a.0
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 17:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685751419; x=1688343419;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N62/0+mqcagNlP9MpHooKswYi/fD0nI8GuItAhLyleU=;
        b=IqLzU6cT6e6Zho1LADQ65cgvoWkAbLM82YnMcMrBekXvjbYqaALq+XTZ7Ta0iv+GG8
         6GY3Z78vVqRfHo/bgmwRetIvuELMPynKb97velkQTwJUbmB1gJUE3Lr9fP8MhbDg6sDS
         CJFcVlX03Lz03uBeOnVgxZXBLTkVbFk5HPOuI/EhijLE4Zn5E4sxsqLt97mI+uC6fBWn
         7XSbpYvMWXCRL7QzHjr19K5E2P3YJ1/exYaPWBY9Ptm4IDG6BFXXwLp13pDAmTVpBDbD
         wxmk+jAGDOpA7IzCphzv7YUAuAm/WHAAp+9snZV1LaTPy78yZUTgbPP7zZ1u8vdOgs+G
         p/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685751419; x=1688343419;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N62/0+mqcagNlP9MpHooKswYi/fD0nI8GuItAhLyleU=;
        b=h5eJu5kGEUCeG7cxEwDw4vwNNZ5UXJtcWrWRGotdWrsx54nw4hETLMa3fl5K+zVuhk
         40+594nFC8SVzuZ/I3XJ84sPP5v923eyx6pfG4hfEC2Rb+SpIBJKVOZK3EkdaLuq0/gL
         gu2UBPZs2V/N2QiHUrSsBcDsUzhclVI/CJuhT9z0UKB00F2TE1o5DF586vCVedivA9IN
         /TU85pmBQcTYLwFnU/uOko6sM3F4+nY/0zKdgjQ1vFhcSTRcenGUsXJBbii7573XtV7h
         +2E9z17rUgs7g+9Wsn75RBUgC7vFpo87cdlSHfk333dThm9RTJI+DczBnAsbQstklGBm
         SgDw==
X-Gm-Message-State: AC+VfDz7TsVsovIQ9COCGUSBWbgXMlf/9vp165WGkeccM0529WD/K748
        vGvvzcPI52qiDqmLEDto1ZI=
X-Google-Smtp-Source: ACHHUZ7TjtFmxhRbJds4HteOrTPQC4YWQl3cnOH8/Okpm1Lb/YxFLawHyB7y9eGE+ekwWnvjAHpkiw==
X-Received: by 2002:a05:6a00:15c6:b0:64f:e997:510a with SMTP id o6-20020a056a0015c600b0064fe997510amr17968944pfu.3.1685751418884;
        Fri, 02 Jun 2023 17:16:58 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id 9-20020aa79149000000b00652a72b89d1sm1503054pfi.170.2023.06.02.17.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 17:16:58 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Kousik Sanagavarapu <five231003@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add new "signature" atom
References: <20230529192209.17747-1-five231003@gmail.com>
        <20230602023105.17979-1-five231003@gmail.com>
        <xmqqzg5i8gpt.fsf@gitster.g>
        <CAPig+cRmY3oDJLVKsBgKVZc-bJ7hArzk2eib9Ra5timC=Xz_kA@mail.gmail.com>
Date:   Sat, 03 Jun 2023 09:16:58 +0900
In-Reply-To: <CAPig+cRmY3oDJLVKsBgKVZc-bJ7hArzk2eib9Ra5timC=Xz_kA@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 2 Jun 2023 03:51:01 -0400")
Message-ID: <xmqqilc58kn9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Moreover, I wondered if using `[01]` to avoid the repetition would be
> worthwhile:
>
>     case "$gpg_version" in
>     "gpg (GnuPG) "[01].*)
>
> though, of course, it's subjective whether that is clearer.

Excellent.

I'd say that the value of your version is primarily that it is much
less error prone than repeating the constant string part that can be
misspelt.  The glob limiting "begins with either '0' or '1' followed
by a dot" might be slightly less easier to understand for less trained
eyes, but eyes will not remain untrained forever, so it is OK.
