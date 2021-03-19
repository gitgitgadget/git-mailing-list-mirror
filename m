Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD76BC433DB
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 19:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E99B61962
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 19:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhCSTZH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 15:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbhCSTY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 15:24:56 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB22C06174A
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 12:24:56 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v4so10193564wrp.13
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 12:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nxqW+bAe0sgH0CNATN/sM2s9BLKLB8VsjANXLaWazsU=;
        b=CjTwNnWkrDvql7c53QST6RHWXvLGKwZYAiMzTNiMEs9+BdUFA7Yx/vdzP0F5mXLw2w
         ZM1tKiZN11jsp5Z3AhfflZhu63ImpYXJhD8nZ1TWbgyY9YGYjUaGxUtUcq8DMxQBLHti
         aZGHWZI1KTJVgQSMr34YZggMVzWG8VNLzY8CbldWlKNwFtCfJgxpVr9Y0zTXXaqJk9TB
         uOwB1ZCtrYT6FB3GqGX2CgGeOucujWggMSoxEokgln6P92rVHpU5B3/KWM30gN3Hbh8y
         Dt99AvQnCZae+qe3I8dJMCuI8Ahu14FFljnvBeyfhIqN+T2ZqYjFjSqjoGaQMZg2hP16
         wqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nxqW+bAe0sgH0CNATN/sM2s9BLKLB8VsjANXLaWazsU=;
        b=DKmOLDFZEi88tb89hval0h6ThavJlb3zrkMQJsZngvDlzc4HVltSdKr0T/P1hxivMv
         gq8LfwlbhfSdkcOgkgnNWlrdTJKtz/xMD+5whJysb4wg14jIZto44InYUl02oHbbA6LQ
         EKPwHv++UJn/WUl4ZJUHyTbp7qVzFCqiFMQva9fpn+E2z8Aq5vRClXqDRAABoyOiz0aM
         0CDmTs9jiQw83Rrn6dw/tCKRREc0wbeJ152H+M1TYYfnKDqWkr3+ov31wY1CVsibD32f
         3InZ9gFmCxzDCl5MCtcgt41Gqg7goyGb9d8xnRs88iU5USWqImzkA9FYSXx38+4BTKCT
         Oriw==
X-Gm-Message-State: AOAM532fWxaRZqdmL320IZgSW9DOLf6e1QKfzeh9YTHL8FXsQDhFQWke
        1tVDEYTvaD4Gx0ObiAn5GIxf5d06MDc=
X-Google-Smtp-Source: ABdhPJyeABI0eGy3CAp7V873ea+/Zif3IXM93a4mQi87iwWA200KEvVC2gO6t9emyfI/Dw3Y3GOSnQ==
X-Received: by 2002:a5d:4743:: with SMTP id o3mr6188588wrs.108.1616181894960;
        Fri, 19 Mar 2021 12:24:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j123sm7571645wmb.1.2021.03.19.12.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 12:24:54 -0700 (PDT)
Message-Id: <pull.982.v2.git.git.1616181893.gitgitgadget@gmail.com>
In-Reply-To: <pull.982.git.git.1616147527082.gitgitgadget@gmail.com>
References: <pull.982.git.git.1616147527082.gitgitgadget@gmail.com>
From:   "Krushnal Patel via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Mar 2021 19:24:51 +0000
Subject: [PATCH v2 0/2] replace test -f with test_path_is_file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Krushnal Patel <krushnalpatel11@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Although has the same functionality as test_path_is_file(), in the case
where test_path_is_file() fails, we get much better debugging information.

Replace with test_path_is_file so that future developers will have a better
experience debugging these test cases.

krush11 (2):
  replace test -f with test_path_is_file
  replaced test -f and test ! -f

 t/t7300-clean.sh | 376 +++++++++++++++++++++++------------------------
 1 file changed, 188 insertions(+), 188 deletions(-)


base-commit: 576ba9dcdaf1007243f5a5cb4bf1a1e7b8fcf850
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-982%2Fkrush11%2Fnext-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-982/krush11/next-v2
Pull-Request: https://github.com/git/git/pull/982

Range-diff vs v1:

 1:  e5f92e3882cd = 1:  e5f92e3882cd replace test -f with test_path_is_file
 -:  ------------ > 2:  a31a147a34f8 replaced test -f and test ! -f

-- 
gitgitgadget
