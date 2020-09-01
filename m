Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C03C433E6
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 13:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B9E7207EA
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 13:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mV/e//0F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgIANHm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 09:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbgIANFF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 09:05:05 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4784EC061245
        for <git@vger.kernel.org>; Tue,  1 Sep 2020 06:04:39 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id f2so805202qkh.3
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 06:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=d24TDz5zL5cLZTJq1t7Ks1/3+oLFvU+KeenJy9vY2JI=;
        b=mV/e//0F9Wt5LTYPBchKKBl+pt1gSvQMkNTptCq/s18b1q2SOcPgJG9V3/yhXb9bSb
         zqiEvsC5BLDhLHarpH47NtWG33XzZSkpiBWJWekiQ9K774rX3C2tydj14ZLwpyTD/hFJ
         UzXfxLwmHRdaH2iHGA1XJjbIKFTND0kSSqTbjvDysSQPx67ISfekpUb46njpbKVHhqeJ
         W5p5fRunAhL4nLbwpEyn3Ty0k3sewR6wHUoBYd6/VP86LZtzNbUnAT7EJP2c4ORdCuR9
         NasTn7ITCD/I6qAxNeNQfWKSpdmiwyA+aLeoc31LaruOKjNuHCsApjR6xjQWy3YIQ0Fk
         cSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d24TDz5zL5cLZTJq1t7Ks1/3+oLFvU+KeenJy9vY2JI=;
        b=FVrXJu2dVD7lA+mWT5uA8QR8cbeeCIz/vx6JJY8WnE10+AWqAYyhD91P4BkKLv4mUy
         PTCjgWTBj6KikxcExXwTIT8LQWtc0BXk8AuYktUkMFS8FBhixPjhNl5s4oNHwfrv5TMg
         5gh4r3j6saxZ2kyxPWxeqJ+ekssvJya/f6BmCseyP4ALt7h+U2ir1wUINvo9GpEB9yb5
         iJ1UO66eYG+aCZru7rsJwWMxmu/tSho+S+3F20f3XTgHb9QLF+i95JStmPdGP51K2MVH
         Np+YkVM0M+QlBR72WC7htpBqq8O0J81v4f/MJmFNMcdB1yEyHN6SCpLPf+ufE28BM/Pd
         vmtw==
X-Gm-Message-State: AOAM533TKtP+ezt8pLqQsY+z5dSI99XtAMogR4mxjJYhIW9ptJQO8a4e
        cniMSY323Kk2Ysr7H5AqaWgSRPeIdm8lEQ==
X-Google-Smtp-Source: ABdhPJx66NJFZCzZffpNWQkoQg0BhlGuUuIBbODbxU4WzGuZhGDPtXoMVzKvOhuG9r2z+PQTrdUMkg==
X-Received: by 2002:ae9:ebcf:: with SMTP id b198mr1751195qkg.488.1598965478116;
        Tue, 01 Sep 2020 06:04:38 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:5166:a025:6686:ff84? ([2600:1700:e72:80a0:5166:a025:6686:ff84])
        by smtp.gmail.com with ESMTPSA id e90sm1186116qtd.4.2020.09.01.06.04.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 06:04:36 -0700 (PDT)
Subject: Re: [PATCH] xrealloc: do not reuse pointer freed by zero-length
 realloc()
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20200901111800.GA3115584@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c81b7225-a663-1598-62b3-bd80457d5648@gmail.com>
Date:   Tue, 1 Sep 2020 09:04:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200901111800.GA3115584@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/1/2020 7:18 AM, Jeff King wrote:
> This patch fixes a bug where xrealloc(ptr, 0) can double-free and
> corrupt the heap on some platforms (including at least glibc).

!!! Good find !!!

> The simplest fix here is to just pass "ret" (which we know to be NULL)
> to the follow-up realloc(). That does mean that a system which _doesn't_
> free the original pointer would leak it. But that interpretation of the
> standard seems unlikely (if a system didn't deallocate in this case, I'd
> expect it to simply return the original pointer). If it turns out to be
> an issue, we can handle the "!size" case up front instead, before we
> call realloc() at all.

Adding an `if (!size) {free(ptr); return NULL;}` block was what I
expected. Was that chosen just so we can rely more on the system
realloc(), or is there a performance implication that I'm not
seeing?

> @@ -120,7 +120,7 @@ void *xrealloc(void *ptr, size_t size)
>  	memory_limit_check(size, 0);
>  	ret = realloc(ptr, size);
>  	if (!ret && !size)
> -		ret = realloc(ptr, 1);
> +		ret = realloc(ret, 1);

I appreciate all the additional context for such a small change.

LGTM.
-Stolee
