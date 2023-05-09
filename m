Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E35EC7EE22
	for <git@archiver.kernel.org>; Tue,  9 May 2023 20:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbjEIUjm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 16:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjEIUjl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 16:39:41 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9C51BDB
        for <git@vger.kernel.org>; Tue,  9 May 2023 13:39:39 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so32686122276.0
        for <git@vger.kernel.org>; Tue, 09 May 2023 13:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683664778; x=1686256778;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IYxvAALE43WoKDC3WeoDMWxqJnueTmEhSLDCz4nRyug=;
        b=zgiYrg/B6Qt7pYB2ckTfExs0lqcIRUJPhI6FEFyyY2jJosqi74J2ZS7kGhB38cvXn7
         4awkoWN14ABrhWSoRbQN9xmExzlFgZrKbl2SUCsJPR6ro7PbmekauINeKr/apXlO2ofo
         h/f6Hi1BWN9qCu2r+0Wsi5Zv63jDG9wybYwms3/kHMiIly2Te0wmOUKEdLE7kseIgnDY
         7/GbCgbePXvK33H8p4dXwaragNm3UAjiDMvqNgtNRkooS64Fm54WZnf7mlAfndik/P1/
         1C8x7GNMMKl1Zip8T8KzNrv3GxxwfReK/ztcYGHgxGgHfdXOmP52sYkh8G4f7B+RvniE
         2ZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683664778; x=1686256778;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IYxvAALE43WoKDC3WeoDMWxqJnueTmEhSLDCz4nRyug=;
        b=VrxQkM1j6xzXVHCqIiZQcP4mnES0XGt/iwrIMN9Ei26MANnOuySx7HGPqx6luW60fY
         QQu/tGFlLxpXNsSLEKHh0DQgrIf98KZlWfxIz7ZfN06LkePLh43xeQqsoDKq5MCWXhiu
         kE4ppo8RnpSKd+3Dw3JQpxyZbBESHUH/4mLqMYiASkaAaLCAC+b2VAPAcOC1ygbnMFbo
         s+lzZWyxUqk7GTek3nswv3bdKNWODn+lZgjIr1gR1IjAcsBiAYeJ98XW+gI/osY6Wego
         BnezbGRxxMAinaEooGazjMJSSjLnms+HWjDkmYuvjGAOzX4ogt6v6HGycJGOAVvhTkSX
         08Hg==
X-Gm-Message-State: AC+VfDzNz34YTnGNzf30dr/ZvFVK5D7PSz8odDVU3X9dg+LL3UGUn0Rc
        +hPtcP89EnCwR9KTdY+7TuoXvQ==
X-Google-Smtp-Source: ACHHUZ4vb4teLaW0FKpQBkviPwpKyBinpaUqe9/ctm460V/79rU5lml08xyr/woAiyzSC5JlrA9Cmg==
X-Received: by 2002:a25:20c1:0:b0:b9d:db54:3076 with SMTP id g184-20020a2520c1000000b00b9ddb543076mr15020057ybg.6.1683664778623;
        Tue, 09 May 2023 13:39:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a13-20020a25f50d000000b00b9da0df3beasm3187842ybe.35.2023.05.09.13.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 13:39:38 -0700 (PDT)
Date:   Tue, 9 May 2023 16:39:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Chris Torek <chris.torek@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/15] refs/packed-backend.c: implement skip lists to
 avoid excluded pattern(s)
Message-ID: <ZFqviJG0mnD+zaFt@nand.local>
References: <cover.1683581621.git.me@ttaylorr.com>
 <a39d1107c1f3e9fbd859a23aed72e63bbd394fa2.1683581621.git.me@ttaylorr.com>
 <CAPx1Gvft0pXehRHpRXrinsTTSaQQkgOL8YaBgt54SHnfsFo2NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPx1Gvft0pXehRHpRXrinsTTSaQQkgOL8YaBgt54SHnfsFo2NQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 08, 2023 at 05:10:52PM -0700, Chris Torek wrote:
> On Mon, May 8, 2023 at 3:06 PM Taylor Blau <me@ttaylorr.com> wrote:
> >   - Construct a skip list of regions by combining adjacent and
> >     overlapping regions from the previous step.
>
> You might want to add a note to the code that there is no
> relationship here to the skip list data structure (see
> https://en.wikipedia.org/wiki/Skip_list).

Good suggestion, thanks. I picked the name skip list for this concept
since we're skipping over excluded regions of the packed-refs file, but
you're right it has no relation to the skip list data structure.

Will note in the patch message.

Thanks,
Taylor
