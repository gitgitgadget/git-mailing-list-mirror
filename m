Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66FFC433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 14:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99A7B61074
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 14:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbhDHOZl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 10:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbhDHOZk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 10:25:40 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27026C061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 07:25:29 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id g8so4312703lfv.12
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 07:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=5Zw6CHFb+eFhrXi+fFv7UOpVwGgGacCTMfmSQ/+id3k=;
        b=uZWHpNfywMWKW1mphCv4WGvSJqULRRLcwVJR3beTzXZjhiB8maslyA9yi2nStLx/6+
         xpwiewWPWAemUf4wD+SEH+xVMGMwgGtBZn6xy3pRlNTbiS3ZZflGO+//zFH270/6+vCf
         F7H2WBfsNmvAdEZ5LsNVD1tUpIB5GbEUe1I140ctp0wLCBJzLzjVlTjgcb40FAT+2taV
         ls83aQOi7zbjGMmoUshT73Lhzqhx0iz4jKorI7YBE+gHNZvOShpf69A249kLU4Ppfn/P
         PVp7swLygHXoFi6SV66mwJ+ROefQdKAN22wqIVWAkGvyDlhYCsGPSQn+ZPDJV2NHWW9I
         dOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=5Zw6CHFb+eFhrXi+fFv7UOpVwGgGacCTMfmSQ/+id3k=;
        b=FOxAuDnzzKO+QWeiYJC04gJ8WJ3EB2Q530xuoezVlKlpAGHUvD8w8cKFdp5MaYrEdm
         DCxM70YlgxPlTLzs3HGEDegGdS1/05If6785BYCxzG00TuHK9XmYUZ25KFO3G/o8w/xe
         0CeUKfsAaMmAtaw72mCzq/MRvPCt2rOMiktS62ifws21QiUEJPMFXvZOXA8/GrM006+m
         gmJzTBL/M/aqVs/X6vB3IOOu4DkobzkSZgdfpk/mdZ7fqao1uambeVirvyaTmZOCoQTe
         p+Cbzb3K+U+48fV9Bm4mqZyWEXxzF4c2pJVNAg2DaK3u3J0jVeyEhI7Y1jljOGsCadEp
         f2oA==
X-Gm-Message-State: AOAM530rvj8IOZKciN96jRRvghIl61BobfiPbTuD0jr+WCyLscXmaY+J
        6XKdh6Qr174ftyivtBgxP2JgL85/Pq8=
X-Google-Smtp-Source: ABdhPJzaHzwo4Ga8GnECp4ZIYN12FT/MKdIt6ChV+jxZnrGXWoeqB8K03pNqDhzj0j+zp7sZq91zBg==
X-Received: by 2002:a05:6512:b97:: with SMTP id b23mr6682798lfv.101.1617891925862;
        Thu, 08 Apr 2021 07:25:25 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id x27sm1288562lfu.231.2021.04.08.07.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 07:25:25 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 6/9] t4013: add tests for log.diffMerges config
References: <20210407225608.14611-1-sorganov@gmail.com>
        <20210407225608.14611-7-sorganov@gmail.com>
        <87v98xitjh.fsf@evledraar.gmail.com>
Date:   Thu, 08 Apr 2021 17:25:24 +0300
In-Reply-To: <87v98xitjh.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 08 Apr 2021 01:06:26 +0200")
Message-ID: <87a6q8dfaj.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Thu, Apr 08 2021, Sergey Organov wrote:

[...]

>> +test_expect_success 'deny wrong log.diffMerges config' '
>> +	git config log.diffMerges wrong-value &&
>> +	test_expect_code 128 git log &&
>> +	git config --unset log.diffMerges
>
> Don't use "git config", but "test_config" at the start, then you don't
> need the --unset at the end, it'll happen automatically. Ditto for the
> following tests.

[...]

Junio C Hamano <gitster@pobox.com> writes:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>>> +test_expect_success 'deny wrong log.diffMerges config' '
>>> +	git config log.diffMerges wrong-value &&
>>> +	test_expect_code 128 git log &&
>>> +	git config --unset log.diffMerges
>>
>> Don't use "git config", but "test_config" at the start, then you don't
>> need the --unset at the end, it'll happen automatically. Ditto for the
>> following tests.
>
> More importantly, test_config arranges the unset to happen even if
> a step in the middle (e.g. test_expect_code in the above example)
> fails.  In the posted version, the control would not reach the
> "git config --unset" and leaves the configuration behind.
>
> And that is the biggest reason why the above should use test_config.

Yeah, thanks for pointing, – will fix for the next re-roll.

-- Sergey Organov
