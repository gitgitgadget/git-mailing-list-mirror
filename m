Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0E4C47080
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 00:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 144A0611BE
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 00:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbhFAA2m (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 20:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbhFAA2l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 20:28:41 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07649C061574
        for <git@vger.kernel.org>; Mon, 31 May 2021 17:26:59 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id x10so5031580plg.3
        for <git@vger.kernel.org>; Mon, 31 May 2021 17:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=c0JlXp/GaO48NPNxDN+qrQpi1xM8WWUUO6KOsuxX6sc=;
        b=Hbl/KCCuDev2pbRfdZXUMk/nYXkgznnFeLupFPZxGkcGAwSghg9xO0lgLPLXbzQB/p
         2CuPsK+kEEmzNcZUKE0+hdOblOyZg+OpHPRqzTs+EixCp5YTVI9KnhS+iLneFMo4MyMv
         pPJaTFQUwYEeAv0wEt6Yew+j9OBR66w0h54SuOovrVcM//kHunQsXPfhEuOupfMlUGjW
         34dOVh5cYDlZabFRw93yGIaLFp7gNZF82ilKlrBLLYNgxLt7Lgn6FbgnVvzJI9d7JydI
         xf9SK3agrKLW5HGYNvZuYUg7yBCwiJYjwiY506Pr1hpDTsN641pRkybPCJ6NJwReE16r
         V3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=c0JlXp/GaO48NPNxDN+qrQpi1xM8WWUUO6KOsuxX6sc=;
        b=h6yaPcdKq/buVr0LWu781yiuyfxksjQWJIfXB57puCSvqBusBaQEeHX9J/XTjpCVul
         kNGvxsXizGS2gebrdH4V1uJbaocGIWNZFUwE5TQhtSPhC+ZYTzs4PQ2tjeaIzvIy4mLF
         wgo0h2oAkQbK6X3vJ0UGDPMJOA6fB+SC7KnpXGFqMwuNtxfMIS+VSKSf8MADevEFx1zy
         wpnNpIhAiHuhT6iQ+s8VkVB4oUehGR59X2cmqCRaUXOk03VBOUpr51wa1IVrFW1P0yXe
         3V2flXmjYC+LJM0BUH8nxu8SreDHspVm5u6ANyo+nSlvQOJEAiMnRKEZkw5jfVYIPiOG
         lG9A==
X-Gm-Message-State: AOAM530iOgBytVAxCpRIfeOVzHCyJyiMMOgR5yz4IWDEOQglBO2uEyWl
        +DusmdObPiltm6kJQBKD+pteqttEBCeFYYYdMhU=
X-Google-Smtp-Source: ABdhPJyq/EnkAXbysxygE/EjLkSOijL7TgNmSFbv1SUUaDa34oTki13MGToAkm2aLdygy/cXC763/A==
X-Received: by 2002:a17:902:ed82:b029:ef:48c8:128e with SMTP id e2-20020a170902ed82b02900ef48c8128emr22989096plj.72.1622507219192;
        Mon, 31 May 2021 17:26:59 -0700 (PDT)
Received: from [192.168.2.150] (ec2-18-163-188-250.ap-east-1.compute.amazonaws.com. [18.163.188.250])
        by smtp.gmail.com with ESMTPSA id bv3sm667795pjb.1.2021.05.31.17.26.57
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 17:26:58 -0700 (PDT)
From:   AndyAo <zen96285@gmail.com>
X-Google-Original-From: AndyAo <Zen96285@gmail.com>
To:     git@vger.kernel.org
Subject: How to disable Git from automatically identifying and managing
 embedded git repositories?
Message-ID: <c4d32a7b-94c5-b613-ae5e-9c18b1ffa627@gmail.com>
Date:   Tue, 1 Jun 2021 08:26:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When I upgraded Git from 2.24.1.windows.2 to 2.29.2.windows.2, I noticed 
that the embedded git repository is recognized in `git status`, and if I 
use `git add .` will manage the embedded git repository directly as a 
submodule, instead of just ignoring them, which is the behavior I want.

How do I turn this off?

Thanks.

