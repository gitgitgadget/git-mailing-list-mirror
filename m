Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9B3C83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 22:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 916A720730
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 22:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M00JSBNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbgD1W7N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 18:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725934AbgD1W7N (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Apr 2020 18:59:13 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158AAC03C1AC
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 15:59:13 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 23so179272qkf.0
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 15:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RXl4FUIMg/2wkxVgvjZfjBQxJA/7fM4NNbpE3YSU1ms=;
        b=M00JSBNpjDcDOjdH1tIb8gprcW198rq+DccI+bFCYqU6G7AMJUHy82Xj1+PlPccUR0
         oQAD+0TnOmyCV2ayemMQD1Gwc/FWpj7d3Zk4shDxTK99q/+AVff3rfHCt5GH/Y5y4T57
         CP1fdJsL3reXlXs5XExNaW5VmZLo8nhXgpSUIdqJxDmkG/3xPp+Og3FH0NsmoggeUgZN
         1PK3XjnG2z8UyctoI+bni+3OW6JKxodfNVE/jHJRy4AIXKUec2HACMtllDy328nTFE9O
         xEU9WjCGYC0uPE1JHS4lyWnFwsZ4hcH9FOQRQrmlb1pSacZ9kwOoAzeg3ac0apGO02KZ
         JZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RXl4FUIMg/2wkxVgvjZfjBQxJA/7fM4NNbpE3YSU1ms=;
        b=WHwTqjxQgB3MCmEBmU+kpDDOdUZTwpFEhAWMEw/DdsyTQYuRUiQzcuUbRbKj1Fqmcg
         GDaH2CZc4+z/oISrrCPQehjssDs1wnO7FhlNXlXh/jcgygrDe7AYatvbiViBYy/0CPsG
         v1icXglhHM6039XXfUzVL3woi75q9fh8AY37Hyh0hyufKv0mPdhdPAwwCof5Zr71MqGO
         bmj7wIdnWtFmRCyYXNdkiF8bSVXFAfMo21GNjbaxKbmTibggqHmWqcnIVcpyVEyYOUhj
         J/CtdvjLFh3ZCMRlhihdlTaf5tWArJZ8JOrEHAz3/QqFDT8y//7jNTZIhc+ZgBzknw6L
         samw==
X-Gm-Message-State: AGi0PuZNHk7VcZzJwQAzCZo8yxW+8LQ7EsA39GUIA2hx9aO4g2lE0hfb
        r5/24r5vhPzbAnL2vZUAcgY=
X-Google-Smtp-Source: APiQypLsgksSTjMb3NTnWsboLQdSnmdWIhQSkPKOpzOXpdFF8XEZ5tHz2FuoPtIeI44h6TQbC8RC6g==
X-Received: by 2002:a37:a116:: with SMTP id k22mr26885477qke.99.1588114752294;
        Tue, 28 Apr 2020 15:59:12 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id b10sm11347205qkl.19.2020.04.28.15.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 15:59:11 -0700 (PDT)
Date:   Tue, 28 Apr 2020 18:59:08 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Andrew White <andrew.white@audinate.com>
Subject: Re: [PATCH] push: unset PARSE_OPT_OPTARG for --recurse-submodules
Message-ID: <20200428225908.GA2570028@generichostname>
References: <346FFB0C-7419-4E2D-B593-9F64F9403D11@audinatedante.onmicrosoft.com>
 <c2b92691ca85029fde3bd6969252cc827ca697b5.1587969824.git.liu.denton@gmail.com>
 <20200427120225.GB1718141@coredump.intra.peff.net>
 <xmqq7dy092tq.fsf@gitster.c.googlers.com>
 <xmqqwo5z33cz.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwo5z33cz.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, Apr 28, 2020 at 10:51:56AM -0700, Junio C Hamano wrote:
> Here is what I am going to queue for this fix; hopefully it can be
> cherry-picked by folks who maintain older versions of Git for
> distros and in-house use.
> 
> The other "huge" patch has also been adjusted by dropping the first
> hunk on builtin/push.c from it, and then resurrecting the part to
> use OPT_CALLBACK_F() for compare-and-swap (which happened to be in
> the same hunk).

Thanks, that approach makes sense to me. I looked at both patches that
you have queued and they look good.

-Denton
