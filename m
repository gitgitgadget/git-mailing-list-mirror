Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A76C433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 16:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0CF561075
	for <git@archiver.kernel.org>; Thu,  6 May 2021 16:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235817AbhEFQWD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 12:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235246AbhEFQWC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 12:22:02 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED70DC061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 09:21:03 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id s22so5063645pgk.6
        for <git@vger.kernel.org>; Thu, 06 May 2021 09:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ueqISx5FbI1D+l9b7G3N0CURgIT5tLoh9eDWF4dKm4Q=;
        b=UWgxoc2MGsU2DA7QOPZdO9/vdd3mBS2Az8zExudYeox/zcIHOEdqgziUTJPuM8VkZR
         KdVsRicEbct6yE7kHqxY/bc2JX78OHUnQXEl+Tu/2MWCvZaNyAPcIZ4F/OXG2VDiyG6y
         JXzkM9vSX168o9OPm1Z7eAQO511O7mHmlrCpOKR6IOaKjOXpyi7p8zztQB1M+5GChMdD
         78zTIdBx7cbWGJKWqt9bDffh/6Ib7HkdGWwf5PmMO0QL5Je1VCDrs8CJ+9Xjium4tc58
         RcN9gcmR7pNg/4KE0aLWVVU4nRMwRwy6H9MPVbM+ZaaNHSYQZBIZogM+m1BAv3Svl2mx
         wFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ueqISx5FbI1D+l9b7G3N0CURgIT5tLoh9eDWF4dKm4Q=;
        b=Jt+OhZK6J8qaIQSvfbmGl2VSj/0aecB1yT06PtpE35mi2fSKZl4fdB7GNpLZgI2ysk
         5KEZ2uyRr9RKZw16KWd8gcprakoTfjuloeW1lH7JiSj2bkAKze0hEQeEXAwpt/TWKiqp
         m9VY0i1bIz1FPshXbSgCde/RwEus2v9GfQSyUF7PPB1CKMBaNAvO6d/1f6kOcbkuXrsB
         S84OTcKEq0a2QnWvgJBilueydNvb1nqmlCE/ow7czG82csxSt0+WMnotUJADovDNNNWc
         2urLDnrJaHh+lYSBQhKzibQKj9SyIA5P5xtLk6k5NptK5Fwcs1XnUzMdxf40WqYZ/Vkw
         c6PQ==
X-Gm-Message-State: AOAM532cVlMlET74Rk/iwxrk/f+ltWalbqDOs8UAXCifAbXiUIa4e2sW
        +aCjn0lRAPr+uuxQn1jhMAY=
X-Google-Smtp-Source: ABdhPJxbq+SrgePurSiw1mfbCjqb+zT8Re9Dmi5D5xWMBRxJXT3H95xzBK3bMm+dSV84QZ12OsidsQ==
X-Received: by 2002:a62:cfc2:0:b029:28e:82bf:a174 with SMTP id b185-20020a62cfc20000b029028e82bfa174mr5811556pfg.9.1620318063402;
        Thu, 06 May 2021 09:21:03 -0700 (PDT)
Received: from localhost ([2402:800:63b8:d379:85bd:c83a:4b40:cd9b])
        by smtp.gmail.com with ESMTPSA id m4sm1099314pjo.53.2021.05.06.09.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 09:21:03 -0700 (PDT)
Date:   Thu, 6 May 2021 23:21:01 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v5 00/11] test-lib.sh: new test_commit args,
 simplification & fixes
Message-ID: <YJQXbVYOYPHb5Kd7@danh.dev>
References: <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com>
 <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com>
 <87eeejvpuy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87eeejvpuy.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-05-06 17:32:01+0200, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> 
> On Fri, Apr 23 2021, Ævar Arnfjörð Bjarmason wrote:
> 
> > Changes since v4: Only a commit message change/re-wording per
> > <87v98e1oj7.fsf@evledraar.gmail.com>.
> 
> SZEDER, Eric, Đoàn et al: does this v5 look good to you? Junio's
> suggested in [1] that this needs some final review feedback before
> advancing to 'next'. If you could take a look that would be great!

I have some minor nit-picks here and there, I didn't look into 11/11.
Otherwise, I think the series is fine, now.

-- 
Danh
