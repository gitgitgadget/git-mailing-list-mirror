Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AA1C2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 16:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6849A611CE
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 16:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhFVQiH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 12:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhFVQiF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 12:38:05 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA185C061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 09:35:47 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id g4so39861687qkl.1
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 09:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5hJ/Uw/UoIH0GxLLbHeKwch5+5uR2sbWU73JQr3AGkk=;
        b=cQxYJf3mK2RZ3xtftI1XsjpLeQTgm44LMkH7Q9109W3tW+F+wPpF6+qb6D6WSjkhnJ
         8aaoj/QZZ5BF7i5dSDX3cG5lHZXItLoiZ2rYhvtnvn7AFLdnnCJymKr/zDKk0g/IuFrt
         bpr5mY+PDCHpxkby9bgAER7CWRTLkOVezKkWzmYuwZbbJ+UwmnlLMyaDEHZs+RBkmt7m
         2cdyo+cnjneHuUWjVeCBo3BTjJ4/suCA9aIhvp1s1mTD3D59PwerkOUevtVO023wTQwl
         42q1UvHv0Db3yK/a3qeO8+4ICKrJ1IhuELcsSNSyJ8pd8njHBz7Aje4TUmAie9uH/G8h
         1CLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5hJ/Uw/UoIH0GxLLbHeKwch5+5uR2sbWU73JQr3AGkk=;
        b=J5skNgtjRAadAkdCP+ruMt6Z7Xs6YCazjo6bwvo6QMSsXIkDQ69yHINahYfhxJfGsC
         xnePyTbmciOmJBwNAIqZAHOhlU9lE76gFNlOeXvF7FZdE5+Gr/XrEMbyCnM6Q2UsdNVX
         QpDTU42kspTOZSHolBrSrZydMAkc3a8s4r3xVJu63G/B6O1Q1d5+iQB6pIOSnWnxRPVT
         dD64v7hKLtsC3r5jWdsBEGhR2vUOS4vul1TcBc/iQhWhCARirA9MoiaGW+DsiF8k3tG7
         dUf+YSQ7o7pVoy9A87R3c1IzG5Fs7viTHH768zjhcnYEu7IS5gPjXSseaZ8MTW/SHJUo
         Ssyw==
X-Gm-Message-State: AOAM533ydmFjDheMO0Uaka7JPJJ/OKmy076x1Xt8hmlw+bjTYmrv4KuS
        EgGIgUUCf2u+ANBXfQ55xPsOOO/medpQvA==
X-Google-Smtp-Source: ABdhPJyNB0NNJCy35YxeCZMLqtCi1CoGJsQU4I0ydlwlGweIo60uI6qvfpijR5pu8mNGMDcYPe1DZQ==
X-Received: by 2002:a37:6495:: with SMTP id y143mr5289175qkb.406.1624379746936;
        Tue, 22 Jun 2021 09:35:46 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:2110:dbed:f0f7:d6e3? ([2600:1700:e72:80a0:2110:dbed:f0f7:d6e3])
        by smtp.gmail.com with ESMTPSA id 85sm12066714qkl.46.2021.06.22.09.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 09:35:46 -0700 (PDT)
Subject: Re: [PATCH 5/5] load_ref_decorations(): avoid parsing non-tag objects
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
References: <YNIJw/8p0F3cPfzd@coredump.intra.peff.net>
 <YNILCDz3LpHX7OX0@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a93690bc-1d33-0fe0-5ca8-0e8baa9c66e6@gmail.com>
Date:   Tue, 22 Jun 2021 12:35:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNILCDz3LpHX7OX0@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/22/2021 12:08 PM, Jeff King wrote:

> -	obj = parse_object(the_repository, oid);
> -	if (!obj)
> +	objtype = oid_object_info(the_repository, oid, NULL);
> +	if (type < 0)
>  		return 0;

Do you mean "if (objtype < 0)" here? There is a 'type' variable,
but it is an enum decoration_type and I can't find a reason why
it would be negative. oid_object_info() _does_ return -1 if there
is a problem loading the object, so that would make sense.

This is the only question I had about the entire series. Everything
else LGTM.

Thanks,
-Stolee
