Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93721C5519F
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 17:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42F802075A
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 17:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYhhvIb4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgKVRQf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Nov 2020 12:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbgKVRQe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Nov 2020 12:16:34 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AF9C0613CF
        for <git@vger.kernel.org>; Sun, 22 Nov 2020 09:16:34 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id r17so16228021wrw.1
        for <git@vger.kernel.org>; Sun, 22 Nov 2020 09:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=qNL6fdPjJdnKrz+r9xSWDltZB3AgL4pEUz/3Is68KiA=;
        b=TYhhvIb48WlW6QrSLOvacNDMMX6x7+aoRTosPlUL9D/QUMGJ6uDIJmtxT10jWKJ2Ha
         SeTESAtqVoB5gB9pW8mKGuQyphqIcagiv4zLPe3z+3K/uDqGP6SkG9z7j/6jJY5IOVEj
         Qq7f04HcmdV3ivhZLhdvwsq86UTZIG1z6lGKcQ1pjhF8lLlN7jyxP6W6zwvpGi3A1OEX
         acZMzihYPS5j0dHlTT07rWhxokgrXRlDM2P65lZ0b9FaqkC+8I3mYTL/v50QjHbB7l2z
         dW8mdKKVh6d+hlkSt5n1o4smbG//NvPacQXX3NeYG1IN74A/b7e5XcY8oB769VPp3iT2
         eZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=qNL6fdPjJdnKrz+r9xSWDltZB3AgL4pEUz/3Is68KiA=;
        b=k3AYymv/F+9e5OmEzS3idA8w9ohJfCoR+njO3dPoHoctyNzKN+WL1WD6vYPs/+3M9d
         DGzJyuzo/7noqtYAzrESUeaGYc/ivvdL9bVCaSLAOEmzcHgN8PDy1DMLkDGzuC9gvXcc
         9+stbsOWRvglAqtQpGmqzb5EcDCHKZgb2N2CfJhf5lKFyLLcnDNdA0qeBVDrie2VsA4C
         +INNzIR/cTnu9a+014slEi+NZgc/Jf4127OKEfKQ8UOotprQtOv+KUTUNVO0mX7HBTlD
         Xic9O73S/mHX5tIW+2AKDqFqpfVz+m6jSGuVQHwwNqS7kPbw1laFene7cmYU+Vkk/aVn
         FE4w==
X-Gm-Message-State: AOAM532GsJro9CBRC8DQtDBQV9YqbjjT9GBJcCaHqrH5Atu28AHjTq0L
        MLzq7i3Hyt6Z+wKANp3rk1C0GGIbJD+BNA==
X-Google-Smtp-Source: ABdhPJzkrHT5/dKHOWMDXXPLi4re21scFw9X1OvMJj3MotvzsmjmylpSy8VXw/P20BQAj47mfK8b1A==
X-Received: by 2002:a5d:6050:: with SMTP id j16mr28899322wrt.158.1606065392709;
        Sun, 22 Nov 2020 09:16:32 -0800 (PST)
Received: from [192.168.1.66] ([46.98.123.94])
        by smtp.gmail.com with ESMTPSA id l23sm8376155wmh.40.2020.11.22.09.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 09:16:32 -0800 (PST)
Date:   Sun, 22 Nov 2020 19:16:25 +0200
From:   serg.partizan@gmail.com
Subject: Re: [PATCH] git-gui: Fix selected text colors
To:     Stefan Haller <stefan@haller-berlin.de>
Cc:     git@vger.kernel.org, me@yadavpratyush.com
Message-Id: <DZJ7KQ.UXACXR9SWDQI3@gmail.com>
In-Reply-To: <2436cd2e-26b9-a7cc-722a-7f27212f58f4@haller-berlin.de>
References: <7553c99f-1dea-0c1d-e5b0-2103333a76b7@haller-berlin.de>
        <20201122133233.7077-1-serg.partizan@gmail.com>
        <2436cd2e-26b9-a7cc-722a-7f27212f58f4@haller-berlin.de>
X-Mailer: geary/3.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 22, 2020 at 16:41, Stefan Haller <stefan@haller-berlin.de> 
wrote:
> Preserving the previous behavior is probably a good idea when fixing a
> regression.
> 
> However, it would actually be nice to have different colors for active
> and inactive selection (could be a follow-up patch). In native Mac and
> Windows applications the active selection background is usually light
> blue, and the inactive one is light grey. This would not just be a
> cosmetic improvement that looks prettier (that wouldn't be worth it),
> but it would be a real usability improvement because it would make it
> much easier to tell which of the four main views has the keyboard 
> focus.
> 
> I couldn't find a way to query the inactive selection colors, though. 
> Do
> you know if there's a way to do that? If not, I guess one way to do 
> this
> is to numerically calculate a grey color with a similar brightness 
> from
> the active selection background. I could work on a patch if you think
> this is an approach that makes sense.

I'm using this code in `wish` to query widget for available options:

 > text .t
 > .t configure

And it shows this widget has `-inactiveselectbackground` option. 
However, it doesn't have `-inactiveselectforeground` as I was thinking 
in previous patch.

 > .t configure -inactiveselectbackground
-inactiveselectbackground inactiveSelectBackground Foreground #c3c3c3 
#c3c3c3

But I have no idea how to get this colors from ttk::style. Looking at 
awdark theme, it set's inactiveselectbackground in function 
setTextColors, which is used on text widget directly. And we cannot use 
it here.

I think calculating that gray color from current selection bg is too 
much work for just one color.

We can just set inactiveSelectBackground to some neutral gray color 
like #707070 or #909090 which will work fine with both dark and light 
themes.

And, because we're using "widgetDefault" priority - themes can override 
this, when they want to explicitly set this color.


