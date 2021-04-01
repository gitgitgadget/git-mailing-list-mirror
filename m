Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2485C433B4
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 18:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEFEE6044F
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 18:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238001AbhDASJM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 14:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236571AbhDASCl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 14:02:41 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC5BC0613A9
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 04:38:48 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so880812pjv.1
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 04:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=XcTqAb3l595YLtXL+/rfCr4q5Ln1oPOJr5vT0c3Ibwo=;
        b=EbAnPV7NK4xc7+OMLAjB5VjhClD8RiOwdkueIADTupensows8vZOoabz0c7snrRlO5
         SE9s8TfWWC+6NrKt5gRGFkci6suvOR4mz0yDptnX607CJamKIkUz78VwKcu6QWs9HFM6
         Eb7LhKwWkjPxMvQ2hwh3UG+l3f3eUyIS0hx2vGl66TGr9eHd7qYCMJpw0J55VRrL1x+0
         wjDLYEVIuiVjV43wDFqTTXGKo9WM9IYEQPN+EEsdS3r9nt9qU29Qpr8343BN4eSw8ikE
         AHkD6p89PBk5OY91a2Hzh8uZ3/LvH6tTbMig9+yPMNrWAWKlo0aVgYWZHko2/4Z5M5/l
         dbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=XcTqAb3l595YLtXL+/rfCr4q5Ln1oPOJr5vT0c3Ibwo=;
        b=tAtDB2XGwQtmbF5U7a3kMirGDrmcREblm3Rv3kLx91PNq4MqtRhiUC2aHp7ficCQzv
         99ZC82UZrTU2DkzmNwBSi2AzMrBisxHBaU9YwsuXd65FAFPrwa5dskbIWIdi43zurCBO
         tzQKoF9YMeMRZG1p3HTtvMxHUTyqKPI9fzfeKM78SAmmu8FWLiyC4O7U43ogPoPEDygV
         ojDjNJ2Q1R+ipbjxZ1GTwxBIFjKErQkhZxcAyJwBVhONQ+daDnePN0XjeADzigIJ233f
         KD92cSrNR4uSxNuTa+93DzmxUceoUHhOuffkQub1dl8+k7Gknd2pYGryJdBf76EuL1X6
         piww==
X-Gm-Message-State: AOAM532OUFrWNLVFyZ9sWjczei30R4trVKLN0Eyj8IWGjiN6BjQxWJUv
        NsGA3vKKWazY/DM69he8Y0fsHLYsH8Ck+A==
X-Google-Smtp-Source: ABdhPJyPEDomn8rpJppDHyelvldWdvmb0VrGm89Oz91KZquMh9ztojZr5vmGwPKv+AKIScLBcg8FLA==
X-Received: by 2002:a17:902:c94c:b029:e6:cd16:24ec with SMTP id i12-20020a170902c94cb02900e6cd1624ecmr7560914pla.27.1617277127445;
        Thu, 01 Apr 2021 04:38:47 -0700 (PDT)
Received: from [10.42.0.98] ([125.21.249.98])
        by smtp.gmail.com with ESMTPSA id gf20sm5654766pjb.39.2021.04.01.04.38.45
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 04:38:46 -0700 (PDT)
To:     git@vger.kernel.org
From:   Chinmoy Chakraborty <chinmoy12c@gmail.com>
Subject: [GSoC] Draft Proposal (Convert submodule to builtin)
Message-ID: <195bf718-6226-43c9-8c58-167388d3d99b@gmail.com>
Date:   Thu, 1 Apr 2021 17:10:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings mentors,

This is my draft proposal for the GSoC project, Convert submodule to 
builtin.

It would be really helpful if you could review the draft and present your

views on it :).


Regards,

Chinmoy Chakraborty.


Link: https://github.com/chinmoy12c/GSoC/blob/master/GSoC_Git_proposal.pdf

