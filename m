Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5935F1F731
	for <e@80x24.org>; Thu,  8 Aug 2019 16:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404079AbfHHQup (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 12:50:45 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:52654 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbfHHQup (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 12:50:45 -0400
Received: by mail-wm1-f46.google.com with SMTP id s3so3074197wms.2
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 09:50:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D+KakboRidIfSeaexQwcDOxU0P4xiz5vIpocAL4mCj8=;
        b=DtTV81OsExUgxnwChrTMeSTdhqKxg080JWjT0HAd6uU8iGfO/IlaYSQaPraoGwlP8D
         S0C1UZIFKGyYtvmpguvCs61j4h5Cyqiqj3xGFs33c8VPrDLan55jXLweGid1l/Ma47rq
         AhFTiUp0s5SLZ7fD5vQhDZMjg9wwxQ4q3WaHzx1fPsnETQvhnmg8OEn7UP8WNUw5lmN9
         K2+0HXIKyBW/GHkO20CcH5tPQbSdKNP8tufvam9pTkxO9D1bG8JQzgisQHjlkr5rVwsA
         ahXQUR0PS59r7MAIVFvCO+CPaQiTrVALhOYgOJHdSb9AulrOQ5Sbqo1/LzF8rgSf7CCr
         ASXw==
X-Gm-Message-State: APjAAAXGR/IYeKokJ7mWmvbog4LkokwJA7/dWXSHUKaLwEDuq2YQ46Lg
        DFIE0/pIN95RoCKAX/ZtAuoogInZRW/vaDe8ndA=
X-Google-Smtp-Source: APXvYqwzhQqr0PvOlBAc4k1oZwpqPqvIdSMo9+OZxmGrsQgefEcyc4AostjgKBkWpCqQX1gNCq2Q7c6m8X4AcMcqC2o=
X-Received: by 2002:a1c:f511:: with SMTP id t17mr5444141wmh.53.1565283043460;
 Thu, 08 Aug 2019 09:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <DB7PR83MB0268816EF2F435EF791272C197D70@DB7PR83MB0268.EURPRD83.prod.outlook.com>
In-Reply-To: <DB7PR83MB0268816EF2F435EF791272C197D70@DB7PR83MB0268.EURPRD83.prod.outlook.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 8 Aug 2019 12:50:32 -0400
Message-ID: <CAPig+cSuj6xWjYuQtuiuNQwroqO8sEh4iAGgLqQVOLQr8CMpDQ@mail.gmail.com>
Subject: Re: Windows absolute drive path detection incomplete
To:     Christopher Ertl <Christopher.Ertl@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 8, 2019 at 12:45 PM Christopher Ertl
<Christopher.Ertl@microsoft.com> wrote:
> So I'm proposing to remove the check for the drive letter being alpha in `has_dos_drive_prefix` macro:
>
> #define has_dos_drive_prefix(path) \
>         ( (path)[1] == ':' ? 2 : 0)

Nit: This isn't safe and will access memory beyond end-of-string if
path is zero-length. Perhaps something like this would be better:

    #define has_dos_drive_prefix(path) \
        (*(path) && (path)[1] == ':' ? 2 : 0)
