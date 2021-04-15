Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C14C433B4
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 08:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E683361074
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 08:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbhDOI4S (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 04:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbhDOI4S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 04:56:18 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F3CC061574
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 01:55:55 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id m11so15619997pfc.11
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 01:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=epHYG4RZJW39odMNlimCDyELivpW/+8QmfwrYYWmMls=;
        b=EPEVGw9onXWIfgq2WtozrBn3lTY4/m7ApasBseAOrlozzu1hAA2aipEbYrc75KOkZf
         VEqDjbrGspc5KYevh7NAh8QqderJSAoPjYiTECbSP2ZwnpjFcGuGyFCGVNlcL8Mg1GUD
         N9HeLoZviJqx3BU4huT+GRUrSDh+BFYdyVtRoxpm6NFFkLPh+YV2MbOwLged3Wa9Oc9R
         u+nIdQIZkyyELzynvzk37Qg5NOTPMAEmNfu+6ZqnvhcuOrV6b2ZdG7sh1VoSCdOTfysR
         oLY9yQPDYyqtsH0KxpkcWYu08BWXuzIFFQ5BsBhKX3HIh5EeYEGljvEZ5vMTbBdg2Wt9
         L7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=epHYG4RZJW39odMNlimCDyELivpW/+8QmfwrYYWmMls=;
        b=uCMO/v5HQ4RbBG0OkuaxmmBzoF1AKoGum1gSQrXw1e5+BBO+q3SQrRgYTwfVeIwkcY
         ZbseYkHYff3jNmu14ztzYEKOS/at7AwvfkTucrRhk89IPso+sI1TaXfk/Xim0arMOYQ0
         YUFrHdEZGfgQkRbyRm9ltMEPiH7i9yvaFfBPe5YYisl0FTc6HZMSxvmQCgwcDMHTNDXi
         fuvAlUHmWP3AqWLLr9NZQgB9688v7xl8VbJLXQZVN/fOiWLMv0xxRo2lz1Zn6xIbu45l
         t3iJm/og138+YFkeQ1L/AwRMCrxpv2A5eUlpvD7kVgZ1ZoHU4UgZ692Z0AzMMgX7ZfuX
         r6ug==
X-Gm-Message-State: AOAM531hSmqmi4cx7IIaSg3M+zZirmprzy/Kym1gqvUThExmjthhOIW9
        y/tpWUZJRZD6FZPXCsWOnTs=
X-Google-Smtp-Source: ABdhPJyarzhwY0lZk/n3tE8iFkxGb5hPYwoEqSRRcUA9q605x6V1ov0F/Xm+ByLGXkAqjbVjNSH3tg==
X-Received: by 2002:a65:4281:: with SMTP id j1mr2538658pgp.348.1618476955371;
        Thu, 15 Apr 2021 01:55:55 -0700 (PDT)
Received: from generichostname ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id ch21sm1722205pjb.8.2021.04.15.01.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 01:55:54 -0700 (PDT)
Date:   Thu, 15 Apr 2021 01:55:52 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 01/15] sha1-file: allow hashing objects literally with
 any algorithm
Message-ID: <YHf/mPIyHr+S2Fpy@generichostname>
References: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
 <20210410152140.3525040-2-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210410152140.3525040-2-sandals@crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

> Subject: [PATCH 01/15] sha1-file: allow hashing objects literally with any algorithm

s/sha1-file/object-file/

I can see that you've waited a while to send this series ;)

On Sat, Apr 10, 2021 at 03:21:26PM +0000, brian m. carlson wrote:
> In order to perform suitable testing with multiple algorithms and
> interoperability, we'll need the ability to hash an object with a given
> algorithm. Introduce this capability for now only for objects which are
> hashed literally by adding a function which does this and changing a
> static function to accept an algorithm pointer.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  object-file.c  | 16 ++++++++++++++--
>  object-store.h |  3 +++
>  2 files changed, 17 insertions(+), 2 deletions(-)
