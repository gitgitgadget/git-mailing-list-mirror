Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D1EC433C1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 10:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88D3461924
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 10:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbhC2K5H (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 06:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbhC2K4i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 06:56:38 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61500C061756
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 03:56:37 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id q5so9605897pfh.10
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 03:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=nMRNDqlzedD1rGqgM6dDv8+vFzGpxR8ZmC31sk51NYE=;
        b=gkjMjhLOJaqzKazor2+EKV2Eqk7aQpDuvaSpoDb/iNDAbJ3Zs4rkzx2YHNCIIwObl6
         vCDfOJP0ZaKhGlB9gwKNN+MiHh8NqXzYbyCoVxXXj33usjHMNHuxyvjcmmtQwZM2UZh3
         wmPWiPXhfwNnV3sgvz9mETbbW4uLDkS5RlsQtvVvaYPuA3V42PXbxVeiLAYoLxIr+9r4
         bFtZwjOmc56Qtrv9n2pJIURW+pOnAz19EVqafmRmp/MkTzPtI+KH2gKjyMCd3DuKakDY
         rcBg03LSLCa8X78lWJEwK8TUsT7k+kMHlDEsimQnEnY6E3+dqYj4paJYxc8/LB2FCk5P
         vS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=nMRNDqlzedD1rGqgM6dDv8+vFzGpxR8ZmC31sk51NYE=;
        b=SCB9QGayve475y6YMAVT8rbslfQVAj26ce2aIauKLnrWV5LgJq5nUey+DUEBSPV9Zf
         zs4JSfQ0OEv8eJZL2+VzDLNiJLhoyNS9xyqm8lHIQGbD6FQ90YBoikyg6pYrt8F0lXy6
         VAwulT6yZ2EIwaN/ToWGuqps9xiSOzlpMqXHuw7a/AewIBb21AFpc5IZKZjKuEYnmRiB
         37V8l+UpbMWBELArpP6focrjVVDJFWTZ+ejvYxq4Pw+Cj4smoWRGarn9UX4jm9QmN2No
         r4Um5FoALVbiOmmUEa2dlf6y/tRCvalHFcviZcEW1pjMzjGKnTzj07DsiN5BHgSVawcP
         edOw==
X-Gm-Message-State: AOAM530/X4VxFMtwXyuurPpm0wO9OOp5cVA1KeMUWGLVikiTuJnmKtjq
        v9wG9v3kq/+YualGdE/XbaIlz6eaRQO7bg==
X-Google-Smtp-Source: ABdhPJwXeHbzJwhBIXpEjnN6kKgMWujnt7iqfKpD6/y8CPUdqofJ6Oz9tG0v/dU2CP3p/4l9Gq0y/g==
X-Received: by 2002:a65:40c7:: with SMTP id u7mr7531572pgp.29.1617015396714;
        Mon, 29 Mar 2021 03:56:36 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-74.three.co.id. [180.214.232.74])
        by smtp.gmail.com with ESMTPSA id y23sm16701179pfo.50.2021.03.29.03.56.35
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 03:56:36 -0700 (PDT)
To:     git@vger.kernel.org
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Upstreaming Reviewed-by to git.git
Message-ID: <0e32b0af-cd05-39a9-51a9-4d983e7085cc@gmail.com>
Date:   Mon, 29 Mar 2021 17:56:33 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I had reviewing patches here, but how can my reviews be credited with
Reviewed-by tags to the applicable patches on git.git (Git SCM)
repo (upstream)?

-- 
An old man doll... just what I always wanted! - Clara
