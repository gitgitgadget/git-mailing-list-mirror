Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EABC4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 21:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 534972224C
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 21:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503159AbgLNVAV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 16:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503664AbgLNVAH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 16:00:07 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87201C0613D6
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 12:59:27 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id j21so1688239oou.11
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 12:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=xpmK3zPr7WgYEs4yBXlpe91hVQ0VPRBFzaewDu6l6jI=;
        b=Oa5HZrL7nprnqa7RrXkF8mIODNcCGc15E/AEkItQknqvG+dVswfwcisgpA0ZBeiKZl
         fFUy5aRhG3FPQcg+deVWf2GL9b2Xe9VzxPnOtwpr0GpQ4ijueOdBB0PqdDsmkXYpIF8Y
         FPQfm2YuPgLOreJXayJgnGSCOcrgl9t2n0QJqJWcAdaEzO3K7YYc5wO2DTI/ezn54mT8
         p+JDBlSQ4/zwZ0ZOeoFWjEwgzKWXwkr6xjuTsJdacwGUJn10F1K4KTmcuuvWBV38RAMC
         xcOw2wKyTIgP9VS8DKWRa7xUqwXUkMu/cVhMd+399HxZxQhXyTd7c6OcbIqVy3VHsher
         fnsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=xpmK3zPr7WgYEs4yBXlpe91hVQ0VPRBFzaewDu6l6jI=;
        b=Y1SBQ66KYpBrnXm01LVfLDizHaQ+4QENP842GmVKjdYBScGYE/y82SX3uFPJS6Juza
         xqjc2KyswACsqRQLJ9KQYkYsDSrpbuwJM2/0FLkLMCdFNReXgOM6z9yVhm6jt6nWecyW
         KAxBiGpvEfF8nJbwqFFMSQ40RUkoCGDqxTkyYQR7qgvL3UxS5tXOLjc5fQYJWwveuTuB
         Imw3T7fiSH3k9IEAorTar/oWLivpheBjzJaxuxncbyehneJ8QqPDmaQ7COb1YDqSeJSY
         GHHi8b/+F3i2b9QXyzevP4+uLKF86ZyaLYSPLKXDMHJrJgWQ/GsKwT77VaHS5H3EMMUq
         flVw==
X-Gm-Message-State: AOAM530tg1W+XyZlyMphA05Le+SbjABcUHMLh+qqr4VQaK1du9c3qiLW
        vrNgETI/Li1PRpuLMkX9ZPPfdmRVgKqRnA==
X-Google-Smtp-Source: ABdhPJxkw53zpckvYr/QXpEB/cvdQgLmLit1QrLfSEyFE+C8V+54bkmhxW0T4o2eaC4tunt1X5uMxw==
X-Received: by 2002:a4a:9c5:: with SMTP id 188mr11450022ooa.77.1607979566935;
        Mon, 14 Dec 2020 12:59:26 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id 65sm665324otp.35.2020.12.14.12.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 12:59:26 -0800 (PST)
Date:   Mon, 14 Dec 2020 14:59:24 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <5fd7d22ceec2b_d4113208c1@natae.notmuch>
In-Reply-To: <20201214202647.3340193-4-gitster@pobox.com>
References: <20201214202647.3340193-1-gitster@pobox.com>
 <20201214202647.3340193-4-gitster@pobox.com>
Subject: RE: [PATCH v7 3/5] pull: get rid of unnecessary global variable
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> It is easy enough to do,

Yes.

> gives a more descriptive name to the variable,

I disagree.

> and there is no reason to make the code deliberately worse by ignoring
> improvement offered on the list.

I doubt any person contributing to the mailing is making the code
deliberately worse.

And I certainly did not ignore any improvement on the list. I responded
to the suggestion, I just disagreed it's actually an improvement.

In my opinion differences of opinion must be tolerated.

And I don't think any of that belongs in the commit message. "Gives a
more descriptive name to the variable" (in your opinion) should be
enough.

Anyway, I like the fact that your opinion and my opinion are clearly
demarcated in two different commits.

Cheers.

-- 
Felipe Contreras
