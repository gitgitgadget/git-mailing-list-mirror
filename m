Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08781C2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 04:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA55861177
	for <git@archiver.kernel.org>; Sat, 22 May 2021 04:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhEVEHm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 00:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhEVEHl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 00:07:41 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B276DC061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 21:06:16 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id t21so11999762plo.2
        for <git@vger.kernel.org>; Fri, 21 May 2021 21:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2dLHO7SL8bbSGXXRcZ4ZbeCTuq8wPusPb/GPdhci/Os=;
        b=jUxvH0/hY3URAxxL4LWwUVWie0WieQi5iuCVW9AINbWrYDj4CU2GPebnfOmH3QsY5i
         JQiphdJ30e53fcl2nv6N3eWK+GLlujYw/0MSse+bjOh2TCodzagFacgfW5hJmtihlyqh
         Xd3qjVZkHCEAKXqUwUwQsrObyVyDo8RENh9uYA1jeRI6i7ZnYGZpakCmTcfTJ1bV76R+
         YJXmDXQZd+vmBlKxY8Ab0ZgIN+Ue7m+HcfofCWBaGnYMpJDzwPki71KOQoCqidpOs31O
         KXTndCNmOP5xZ3hjEUl/r45c8k97NSCcqN4ziJ2Y8h5D4XHc44Lo+q7QQWKnopFH4uQP
         zVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2dLHO7SL8bbSGXXRcZ4ZbeCTuq8wPusPb/GPdhci/Os=;
        b=p6FIGpgx28rwJ/tW3U3ZUsxMGDZEywrneP42XDUUQVvwjyufc44miymDiVcNuHlsiZ
         IMZVwgaHEASL9IdHGbrvMB1DKvmGuUYamC/h5Ck/1WVx+Uwl7KXoPEYzPkyKTs6Il9b7
         UYoVwijPztj8qF4NHZghYSQt7fro1HJx/xfo1TSy/q1U1KHi9P+hvfXoq79B1ndWOzic
         3knrf4vQJpUg9vpZnsmosu4h+bYoC3FNyzvJkZAcZLF0+mRI+JZxJPdTG1cqUH0MNF2I
         V5tLn0Ipo8bLRw1oED54kxs128dcs1BGEM2PZgp8WbD2pUa/Bz/G5AynvuAGHD4IxO1G
         3JtA==
X-Gm-Message-State: AOAM530KYJ2TddMCuSVJ0tk7C+PPT6gryQhiJU4fb2Uguye01PRWs5vs
        s/rLxKxfKmL9lpR/ayeb3MA=
X-Google-Smtp-Source: ABdhPJwfaL7elnsIk/rJ+XD6xrPr97sLtJ4fk/wy4PyyZlxBUvxEMsEDsvDPmHXbuRdh5Ha41JnUtg==
X-Received: by 2002:a17:902:f203:b029:f0:d225:c6e4 with SMTP id m3-20020a170902f203b02900f0d225c6e4mr15459766plc.0.1621656375460;
        Fri, 21 May 2021 21:06:15 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-19.three.co.id. [116.206.28.19])
        by smtp.gmail.com with ESMTPSA id bb18sm9863636pjb.44.2021.05.21.21.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 21:06:15 -0700 (PDT)
Subject: Re: RFC: error codes on exit
To:     "H. Peter Anvin" <hpa@zytor.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Josh Steadmon <steadmon@google.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <YKWggLGDhTOY+lcy@google.com>
 <60a5afeeb13b4_1d8f2208a5@natae.notmuch>
 <CAMMLpeScunGg5WM4N90vG+yN3tOATqhsL2iRLsJ43ksNyTx_wQ@mail.gmail.com>
 <dc14c50d-c626-19f8-e615-52ca3c9051dc@zytor.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <657d3d24-2f08-f076-5c84-9ae434149530@gmail.com>
Date:   Sat, 22 May 2021 11:06:11 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <dc14c50d-c626-19f8-e615-52ca3c9051dc@zytor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/05/21 06.20, H. Peter Anvin wrote:
> 
> <sysexits.h>
> 
>      -hpa
> 
Looking that header file you mention, I saw:

> #define EX_OK		0	/* successful termination */
> 
> #define EX__BASE	64	/* base value for error messages */
> 
> #define EX_USAGE	64	/* command line usage error */
> #define EX_DATAERR	65	/* data format error */
> #define EX_NOINPUT	66	/* cannot open input */
> #define EX_NOUSER	67	/* addressee unknown */
> #define EX_NOHOST	68	/* host name unknown */
> #define EX_UNAVAILABLE	69	/* service unavailable */
> #define EX_SOFTWARE	70	/* internal software error */
> #define EX_OSERR	71	/* system error (e.g., can't fork) */
> #define EX_OSFILE	72	/* critical OS file missing */
> #define EX_CANTCREAT	73	/* can't create (user) output file */
> #define EX_IOERR	74	/* input/output error */
> #define EX_TEMPFAIL	75	/* temp failure; user is invited to retry */
> #define EX_PROTOCOL	76	/* remote error in protocol */
> #define EX_NOPERM	77	/* permission denied */
> #define EX_CONFIG	78	/* configuration error */

For EX_USAGE case, we may sometimes display correct usage syntax so that
users can fix their typing.

We may use EX_CONFIG when we encounter any errors when parsing .gitconfig.

EX_OSFILE isn't necessary for Git, though.

-- 
An old man doll... just what I always wanted! - Clara
