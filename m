Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CD341F462
	for <e@80x24.org>; Thu, 13 Jun 2019 18:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfFMSGD (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 14:06:03 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:32817 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfFMSGD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 14:06:03 -0400
Received: by mail-qk1-f194.google.com with SMTP id r6so13379121qkc.0
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 11:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YCjQPDTUpOgLwrnTGHZF6Xw4AYytqCGWE2BzQ2GGhUo=;
        b=WfGkZ90ZP7b5/27T/H8fiyyzuj2RiCL+OSp0Pf6+2s7ci01d/lrXRRuMWCXgA9yNdB
         dDqCdw6W4zjitcIZPQQ6eDlr+ivIHEiwew1dzFc8IV6AKrjB0RkmgbXyodjr5lNwZWox
         l6xoF/5AOy5IPXCxHzYtN9sJrQCMq4NFRliI/hsvm3ZMUGhMbSiIcdubBDVi9t/EvebG
         uiydte0cSOZwh/1ZXi0LVq0QRzccJsn2BAxjhNcSz97dopPj22r6AXxFXymRp9NkSFd0
         m6qYm9cWcZUlfLOJcDu3kgkUuSFN9DIezAvJQCHAxLy9gb8v2hff2WznWNSBxZA4lAj3
         5RQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YCjQPDTUpOgLwrnTGHZF6Xw4AYytqCGWE2BzQ2GGhUo=;
        b=TqvlPi7FUAsFZGD4j9bi8TGf47599GbyodZn8LRE56b9mKAQHQefkLvW0hmBAkC8zT
         XAtbwVvJ2miSKoTxVlpdgxbWY2qaHGRp8tiSJ0khHTVyETrxX3FMelsnteNgVrqTxx8t
         apxEZUbRRA6hOjfWmySVjb2Zmhbwz9wmGaqEZIjE+GvDDTu+THK89ehNU3GyXQAIumz/
         vI5HQKX0ePKYpoN91134fdF4g+xyvOLuV/p58gM+LkAo7bK/wqla7GaG9UxmNQd82cO+
         iMkfWHEnGaxeQ51yuZcB/iCakKuyzBEQ+Xfgge3IoDIZ2MpH4f6QaqjZzncM9hD3kjaO
         sGIw==
X-Gm-Message-State: APjAAAXoW1pfJCQOBIhypvD8E8VXvOloMg4iLRhNBd0mD/ynELFG1Ezu
        ePLoTikDSbXOOLXmxTCewfYglbZl
X-Google-Smtp-Source: APXvYqxWVGyLYBQwwvLMVAFYD88O3scCFRO3dMolP2W+2fGwdG8qC95TBaL2LmBJRkoFpgrd4cKWoQ==
X-Received: by 2002:a37:a094:: with SMTP id j142mr72870067qke.2.1560449161789;
        Thu, 13 Jun 2019 11:06:01 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:e597:8bd7:63ae:9827? ([2001:4898:a800:1012:96cb:8bd7:63ae:9827])
        by smtp.gmail.com with ESMTPSA id v72sm197283qkb.0.2019.06.13.11.06.01
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 11:06:01 -0700 (PDT)
Subject: Re: [PATCH] cleanup: fix possible overflow errors in binary search,
 part 2
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <f0059613-d3e4-a1e2-2c01-727579e069d2@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ac09e504-369d-d6d5-a356-07a75386d3fb@gmail.com>
Date:   Thu, 13 Jun 2019 14:06:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <f0059613-d3e4-a1e2-2c01-727579e069d2@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/13/2019 1:51 PM, René Scharfe wrote:
> Calculating the sum of two array indexes to find the midpoint between
> them can overflow, i.e. code like this is unsafe for big arrays:
> 
> 	mid = (first + last) >> 1;
> 
> Make sure the intermediate value stays within the boundaries instead,
> like this:
> 
> 	mid = first + ((last - first) >> 1);
> 
> The loop condition of the binary search makes sure that 'last' is
> always greater than 'first', so this is safe as long as 'first' is
> not negative.  And that can be verified easily using the pre-context
> of each change, except for name-hash.c, so add an assertion to that
> effect there.
> 
> The unsafe calculations were found with:
> 
> 	git grep '(.*+.*) *>> *1'
> 
> This is a continuation of 19716b21a4 (cleanup: fix possible overflow
> errors in binary search, 2017-10-08).

Thank you for finding these additional examples!

LGTM. Pretty easy to see this is correct.

-Stolee

