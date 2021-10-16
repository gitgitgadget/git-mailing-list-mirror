Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089DAC433EF
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 05:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCB9760D42
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 05:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhJPFQl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Oct 2021 01:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbhJPFQh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Oct 2021 01:16:37 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2A0C061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 22:14:29 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id y12so47898000eda.4
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 22:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=0Gwd6aZ/trE2s1wY77/tye5iKKDgG+hfN9A0aRvuWlQ=;
        b=L1HDlYCuYaZmObGcNbXBd2xEuAFpjLYxmzxGWcYvR75PoNH/1Gz5nnpaMLwJE0oH+P
         rvNFNBchDMKUmVKa1uy/cRI7HxXsxDvyDO1hfXyIfMbyGngB16FLxU4mKzEP80lLXUyC
         5A86r7SHr6DVCQjEP/A7c4mRbk/TA+bAifHoFcQBXDKsxmhN7VjCKvFEBKepw4rMAtWJ
         lD4WNx705wW85Ynx1l34pMiD7GRdU9hOWUduruyY/binU0VKLiXikIVzymhpTf5gliKo
         aUqYltcz8rCqiRt8CGnZTpDK4GCppokEV8oKvqu8TLTec3/WtZZoRkGrS3N9t4KCRpmY
         4Ksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=0Gwd6aZ/trE2s1wY77/tye5iKKDgG+hfN9A0aRvuWlQ=;
        b=b62dJ84lesqYzOAHL6rHK1H1FeIoAjeClhRhfA81lB3XQL4tmCZ9InFMyNKfNNH12w
         RJpsb8T3Z9AXYcAxcQtwR6DNLqJHQN/QxqnSa5mu/xsEmj/It+dY/+thy2+NVk0r1B+M
         Zj2H/jha38ii5Po7Ht3BYWX8F6XCl9OLsvGrtLXFz6tQVe/2mt9dzGskeru0X6HNjC9u
         rsItj6jD2PegUgbKgwUk6+x2hc2PhHAjQePr/dx8Ho/z/FwjdUS+Z/XUTre5jRBeJttB
         iuz6Msc5kA/WTpqe2k2G9jJ8VtORFnDf50JOtRTmvgseuAHWv4WRegRew9iXIyRrlGJA
         mtfQ==
X-Gm-Message-State: AOAM530aU+fC0epnqXpHrQ2GT6AB6eVjeZzBp/8P0QaEhMv2O677Cr5k
        EVG0CWryMblsFN26NTy6PU8=
X-Google-Smtp-Source: ABdhPJyFAcOjYYl7rinTHVtrIaV5NJc7o29Dq0m5KwtnN145Pdtut7ANw6SqSqtQ/nZiWUXCk/p86Q==
X-Received: by 2002:a17:906:f8d0:: with SMTP id lh16mr11491090ejb.367.1634361268435;
        Fri, 15 Oct 2021 22:14:28 -0700 (PDT)
Received: from evledraar (2a02-a45a-de66-1-2cbc-c868-da6a-49d1.fixed6.kpn.net. [2a02:a45a:de66:1:2cbc:c868:da6a:49d1])
        by smtp.gmail.com with ESMTPSA id i6sm5495422ejd.57.2021.10.15.22.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 22:14:27 -0700 (PDT)
Received: from avar by evledraar with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mbc1a-0005d7-Lv;
        Sat, 16 Oct 2021 07:14:26 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] doc lint: make "lint-docs" non-.PHONY
Date:   Sat, 16 Oct 2021 07:13:28 +0200
References: <cover-0.4-00000000000-20211015T123619Z-avarab@gmail.com>
 <patch-4.4-800d7d81d42-20211015T123619Z-avarab@gmail.com>
 <438804d8-eedc-cca5-acbd-5534df601b24@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <438804d8-eedc-cca5-acbd-5534df601b24@gmail.com>
Message-ID: <878ryteekt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Oct 16 2021, Bagas Sanjaya wrote:

> On 15/10/21 19.39, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> @@ -343,6 +348,7 @@ GIT-ASCIIDOCFLAGS: FORCE
>>               fi
>>     clean:
>> +	$(RM) -rf .build/
>>   	$(RM) *.xml *.xml+ *.html *.html+ *.1 *.5 *.7
>>   	$(RM) *.texi *.texi+ *.texi++ git.info gitman.info
>>   	$(RM) *.pdf
>
> Why did you clean the build directory?

The Documentation/.build directory is added by this patch, for the lint
scratch files, but the structure is such that it can be used by other
things in the future.
