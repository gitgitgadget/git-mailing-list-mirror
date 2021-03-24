Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE1DC433E5
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 20:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D69C61A24
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 20:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238052AbhCXUfB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 16:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238108AbhCXUea (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 16:34:30 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0531DC06174A
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 13:34:28 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id m7so15522741pgj.8
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 13:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vHcp5o0R8P02H1qMMWCszJ6+ww773e97VUtNUQ4YStk=;
        b=NXAPkD7xolyOwepAt4CLhSXGCPrr7BG+Lf7nctOWLpKOu8KG7RzZDUV4iJlk1CF7G3
         5RmBdtNanxlE1chWXPua6gfUKyfFmrHa4/GvBbC6wFy47yQN5ZGqmQ+yxDKdeHjZB+Rq
         REcdcHCNkfKkq3gD24ybU3jNHOH8NvCor3GkoUVD2Xfkkd27ZgfchwXgBlfwspoP570E
         oM7I/KDezD7U51kb6IsdhNw6jVq8xgu9Bwa/rYH08KFWKxaWaprYDOCHeotRDDkeAPep
         FBlR/oOrc9qdgvJ8gWSd5F4M+JzF9yS4vWUKz/iOt1Fh2wolxza+pV9aO1SPD8lBx27A
         IIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vHcp5o0R8P02H1qMMWCszJ6+ww773e97VUtNUQ4YStk=;
        b=XncXAZN0vjCRxqEKKoMJsmzi/S5/CU/SaDnSie2kWRISp7kSvyPDfXy381ogr0IKHS
         5QHyjSTVks8ByN23YSwzANh+crWgF4ACTkmPUog5Fihvu6KDknZO2ZxO0ju2NnZHhvv0
         2rjXddUX5cvyiBw1SCule8pw6v2AuVYhKFw1fDCSpKS+7CKxsbUX1S/rKOUa7M6riItx
         U1GWv7ialoNYEWp8wKOig8iEJtLOjYCBpfHPpmPyRikI7KTCBjY0uLR6jZzZErF3932G
         hnUqVjLKc3SFmirGUwXsWeAuB0UNprhF4FnUc7ziN9UTYMO1ZJYGy83ck0+NIown4wyz
         dWhA==
X-Gm-Message-State: AOAM533HbpLeNFsHE2/hNJVgjMMctFamVgTaAWyxuEuHT1qc7PvhDoml
        ee68ZcjZXFlG11lqT5wixGgL5g==
X-Google-Smtp-Source: ABdhPJz0dPaEH92wz5AwssRMV4OSSndNyjqP/KNxrHteVH4L3NnfVkJ6PnaatOTP1iLn30RCkOsxQg==
X-Received: by 2002:a17:902:b94c:b029:e6:98b9:c15b with SMTP id h12-20020a170902b94cb02900e698b9c15bmr5578036pls.60.1616618067450;
        Wed, 24 Mar 2021 13:34:27 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:d027:9201:1f66:e720])
        by smtp.gmail.com with ESMTPSA id i20sm3034997pgg.65.2021.03.24.13.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 13:34:26 -0700 (PDT)
Date:   Wed, 24 Mar 2021 13:34:21 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 07/37] parse-options: parse into strvec
Message-ID: <YFuiTQx1sHPvntC8@google.com>
References: <20210311021037.3001235-1-emilyshaffer@google.com>
 <20210311021037.3001235-8-emilyshaffer@google.com>
 <87czw4hi19.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87czw4hi19.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 12, 2021 at 09:50:58AM +0100, Ævar Arnfjörð Bjarmason wrote:
[snip]
> Nice, seems very useful.
> 
> But let's add a test in test-parse-options.c like we have for
> string_list?

Sure, done. Thanks.
