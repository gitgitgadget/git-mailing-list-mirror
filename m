Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C063C4332F
	for <git@archiver.kernel.org>; Sun,  1 Jan 2023 12:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjAAMMD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Jan 2023 07:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjAAMMC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jan 2023 07:12:02 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48C8B65
        for <git@vger.kernel.org>; Sun,  1 Jan 2023 04:12:00 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 79so16834339pgf.11
        for <git@vger.kernel.org>; Sun, 01 Jan 2023 04:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjnwgcF4r5rYl7YWQIni+MSRuGHHAfwDvBtHdWyYOLE=;
        b=jnGwQK3NG52kPKzD/LQFOOfLZ64FSmLWqo8Pg0c6b7BymMF9CUKdM1ha9iCS0mCQpm
         xvd3jR0B3GiBxI/RfBuAvgJFMHthc69T3YmhnU5Vuyrs2X6xaSPxjBhzNQ2jfl84er58
         Ku+YTneve5WMSbc6AEhysJeO/7tEwyqb20nrrUWKwI2OckW4xXSXbUOyhXULKnK7a+Pj
         CrzeA64dZBwjkzCo5a5PUxNcxNCqnmPaP3qPk7CuT2fAA4bMW57X+PcABaGtUqAlCVOz
         Oz0aLelOQrjm4QXgxs9PoJFY712BJv1cpQdE8WdAnnzUNrhNLPjpjUdV2vcRsSUzMCmX
         hDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PjnwgcF4r5rYl7YWQIni+MSRuGHHAfwDvBtHdWyYOLE=;
        b=CEGIaz0Im980t2YVXfAA0XUmeFO5IBCOCUJ7kpQLgWFS+eaJddL4BTS0Gga3IjdXeB
         dWu0jWVsl552sQ7DcAm7g8Jh7eoyINVonILF99zDaM9dnbP3axaE0gXpir9R+Y0L1jAd
         C1o7JS9n/xpet3uyTHQtuSA6s52Zy9Itp7oIfCVns0L9MKo7NWxxgKmQOTlGBU0U3nmg
         YlgNDU1soOxA3xP5AuGx6PMCSSgMWZzlaclA4bqL3GlSOlpzy/MD/YLP5zmu4pmebsK6
         rHytBl/yqQ7WHtkwfeT72S/9o0P9kHXj/0GbNl1rlovbqhEDZelybDXGTXPuEnd+cRPj
         /lLw==
X-Gm-Message-State: AFqh2koQKjIRvz83vw8eGHnHyTG108zxLVsSo0sBWOmVL1qR9JHhMRLq
        JDJjKnlbler3mkHQv9Uc9zo=
X-Google-Smtp-Source: AMrXdXtsIIOL1JtAUB0/gJx+VIHv2z4LsgbYHImPKZbhibiC90dJ0X5DtjrdPGDfyYBqD9b8SW0HPg==
X-Received: by 2002:a05:6a00:1a45:b0:582:294d:f465 with SMTP id h5-20020a056a001a4500b00582294df465mr5765999pfv.13.1672575119975;
        Sun, 01 Jan 2023 04:11:59 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id f6-20020aa79686000000b005769ccca18csm9647393pfk.85.2023.01.01.04.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 04:11:59 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] do full type check in COPY_ARRAY and MOVE_ARRAY
References: <efe7ec20-201e-a1c1-8e16-2f714a0aee8e@web.de>
        <f3b9e9be-06ef-3773-a496-da5e479f9d49@web.de>
        <xmqq8rinhs7t.fsf@gitster.g> <xmqqsfguhplc.fsf@gitster.g>
        <220515b3-3924-c8d2-ff20-7017caa7dead@web.de>
        <bf4e6798-c687-270d-1344-37bacb403e13@web.de>
Date:   Sun, 01 Jan 2023 21:11:59 +0900
In-Reply-To: <bf4e6798-c687-270d-1344-37bacb403e13@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 1 Jan 2023 11:45:41 +0100")
Message-ID: <xmqqzgb2fo8g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> On second thought, what do we gain by using __builtin_types_compatible_p
> here?  Does it catch cases that the assignment check plus the element
> size check wouldn't?

I was reacting to this part of an earlier message in the thread:

Presumably we cannot catch
	
	int *ip;
	unsigned *up;

	(0 ? (*(ip) = *(up), 0) : 0);
	(0 ? (*(up) = *(ip), 0) : 0);

with the approach?

i.e. *ip and *up are of the same size.  Would the assignment check
trigger?

> We actually need to compare the types of the elements here, because
> otherwise we'd disallow copies between arrays (int arr[7]) and pointers
> (int *p), which would be unnecessarily strict.

Yup.  Thanks for inferring what I meant to give, despite the two
typoes (the other one is ", 0").

