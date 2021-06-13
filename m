Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB98CC48BCF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 07:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 964896023F
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 07:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhFMHlc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 03:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhFMHlc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 03:41:32 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EC9C061574
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 00:39:18 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id h16so8003932pjv.2
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 00:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FUt+XDuLx7/Chy6lM/vpYBBzKCX4TxdVXL5pY6c0FgE=;
        b=LWX7xXW2hwiTOBO12Iwhy5+pt27FSO9EWnJEc6nzXGItKxFYAkhtkeyn1LT6/x5aHJ
         +JMTviLfLRkxiSwStwJwpF7Fz8B1lhfN7Rp8wpDYw301hE5j6mOYKjMPaG3FpZGzOyHS
         t+bs3HyjgCUjqB0+6tKy/p6yUNA9RHWGz60utxZTq3fp+WWqUngvkKxdbW9sQl+/5hrY
         K0OhmrXd0htnaGUx3G86qKVhq7FRqnnLycXjzMljK5nfGRW/WP5+PBSqPJmfgB+uq29F
         Rb/kUjnPLsEigju3e1Xmo9hW3dNm+c6tcnO2kDMnv7CllYwGmjCvcMfZyJ3lGUF8Kn3Q
         FwlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FUt+XDuLx7/Chy6lM/vpYBBzKCX4TxdVXL5pY6c0FgE=;
        b=ZyBBx635PK/Eg6v7Z6dg6FIhzEYpJFJ2SQOUn3/QDZVFKSBz905Oaogh6PGZ/olTkx
         JWQ40XZHk3aRXlLn63PBlHGplUPlyeyv6XFL7D4DTc+LpoSmU79LFGMttawhAPTEqAad
         BIEGF8mW7LTbkxYgtdKqPShNrZX0dLhCIUzhrAcuWwSyzte8jJfOd9jZOyKVYxM8osk4
         NQ8Vjq2bnujiKH9+kKJCXK3Iu5ZD1LOx9JQP5pKLQgoqINglSV4m/tkBUzwgNdBsfPcc
         u8tMyRaZvhOkry3k2Ezp8iH01cr2hE0deAqjzStogH5GzyVvrZOkcftvUET2dE0oJuDW
         fywQ==
X-Gm-Message-State: AOAM531YYur1HkkbsaDYUjhIRuEX1l+V9QMR42Zo9qSlXD019kf4zoV+
        ewvpBcncHOJOCJ/5OcfWNSw=
X-Google-Smtp-Source: ABdhPJzsWMT1+wcFpwcu0o3aTXTN/23UVgSYopSvV3onCtWaKT2VYDUB6miawICDctRviTyopmWcNA==
X-Received: by 2002:a17:903:3052:b029:119:25dd:8645 with SMTP id u18-20020a1709033052b029011925dd8645mr7617748pla.59.1623569953937;
        Sun, 13 Jun 2021 00:39:13 -0700 (PDT)
Received: from localhost ([2402:800:63b8:a3d1:fb64:d06b:ab01:2de4])
        by smtp.gmail.com with ESMTPSA id b123sm1265851pfg.62.2021.06.13.00.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 00:39:13 -0700 (PDT)
Date:   Sun, 13 Jun 2021 14:39:11 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] t6400: use test_line_count_cmd to count # of lines
 in stdout
Message-ID: <YMW2H3duLOgEObBP@danh.dev>
References: <20210612042755.28342-1-congdanhqx@gmail.com>
 <20210612042755.28342-4-congdanhqx@gmail.com>
 <68b41d84-e9ac-6cf1-184b-5ce9bbfbb18e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68b41d84-e9ac-6cf1-184b-5ce9bbfbb18e@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-06-12 11:33:49+0700, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> Hi Đoàn,

It's better to call me Danh. Thanks. Don't worry, I was called Dan all
the time, too ;)

> 
> > -	test 5 -eq $(git ls-files -s | wc -l) &&
> > -	test 4 -eq $(git ls-files -u | wc -l) &&
> > +	test_line_count_cmd --out = 5 git ls-files -s &&
> > +	test_line_count_cmd --out = 4 git ls-files -u  &&
> 
> I read lines above as "Formerly I tested that 5/4 should be equal to output
> of git ls-files -s/-u piped to wc -l, now I do the same with
> test_line_count_cmd".
> 
> Am I right?

Yes, you read that right. This series is mostly a cleanup for
linting "test .* -o" (But that regex wouldn't be put to be used
anytime soon).

-- 
Danh
