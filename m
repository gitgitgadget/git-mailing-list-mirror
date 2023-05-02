Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75930C77B7E
	for <git@archiver.kernel.org>; Tue,  2 May 2023 09:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbjEBJrx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 05:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjEBJrw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 05:47:52 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385354C29
        for <git@vger.kernel.org>; Tue,  2 May 2023 02:47:51 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63b781c9787so1065122b3a.1
        for <git@vger.kernel.org>; Tue, 02 May 2023 02:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683020870; x=1685612870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=roiKtdcrYB77vTVolVXggwJpyK8B3mJg6Kud7H3yUT0=;
        b=YjDnozY54yj9ssxmBrk7e7d8JMGBNf9DoTX+IEII+YMo9VA2aHle2A794Ifoay3yl6
         +9ZPrXhCH1z88LvUs0T37P4aXnRs1JYUFJhDX4LFz1lKxMr+sGiP3xTUQYEq8wBc4Pw1
         XQDP46t2Wx1M87bybMNysl/0z6u+qflzmFoOqXaPEDaK6oaJDbeQS1f/xLifEYkreVe/
         F2FcdXsTL9vJtjz8XMQ0B1+iIB68aQxUavUcAROEQR2IAZZXnMZVbu+LcHUud40iMiPa
         DrpF2W1ydlF0rF67gXUcSMVIMCFMSIBoFN/wLUoq2NucDbuXd/MO2E+yveUx0ElqHlLN
         tJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683020870; x=1685612870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=roiKtdcrYB77vTVolVXggwJpyK8B3mJg6Kud7H3yUT0=;
        b=MOy9NYm2kQImh6xb67VuSAYqiNVgUPDAKzA0bKCI72VQl0op71GYD0bwheJEhEJdft
         je7+SZQR6RdvXEwPwPw7EMo79lVewihCJhlx90MNuapeOiSHIqNEkdRYzjKUwZ3/49VM
         8fma/2DPmsCBAHI2l3hhnEbvouB8uastOA8qvjR767wCzsih71r0L+d+HQMqal62O5oc
         Dhro8wCVKxGkR5RuFiQmz5TXton4m1PjYFKOSBYEwKA5mObda15J98ZtMHrKaMTx5gOR
         3GbSjNRyuQdlmdGUvxeEB0XvrEFzueT+75w12EbbGoJAjuyvjznqTuX0jXvPzpJ3L/UI
         k4WQ==
X-Gm-Message-State: AC+VfDyxc3o4hCj91Xkyx9sna25UmJw39TzFkL5oMXUCLZPZw8oxsVH0
        Z+1QmEegzpJKEcjuI6Lrlw8=
X-Google-Smtp-Source: ACHHUZ5tEuI0L6hqdk63VhnmCnLyszzundRXAa/sXhL8XhhtJmDvx4RkDMcZqSq3Q4z9+N3GjUZ9Dg==
X-Received: by 2002:a05:6a20:7f8d:b0:e8:dcca:d9cb with SMTP id d13-20020a056a207f8d00b000e8dccad9cbmr2665327pzj.5.1683020870483;
        Tue, 02 May 2023 02:47:50 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6c01:39e1:cd79:39bc:8518:eed0])
        by smtp.gmail.com with ESMTPSA id m9-20020a629409000000b00639eae8816asm21324210pfe.130.2023.05.02.02.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 02:47:49 -0700 (PDT)
From:   Raghul Nanth A <nanth.raghul@gmail.com>
To:     cheskaqiqi@gmail.com
Cc:     derrickstolee@github.com, git@vger.kernel.org, gitster@pobox.com,
        vdye@github.com, Raghul Nanth A <nanth.raghul@gmail.com>
Subject: [GSOC] diff-index: enable sparse index
Date:   Tue,  2 May 2023 15:16:58 +0530
Message-Id: <20230502094658.608646-1-nanth.raghul@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230422212500.476955-1-cheskaqiqi@gmail.com>
References: <20230422212500.476955-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey,
  Thanks for the info. Your explanations make sense and I will make the appropriate changes. I had two questions I had two questions regarding this: 
  I have been trying to base my changes off the 'sl/diff-files-sparse' branch, but I am not sure how I would go about doing that. I thought I would be just pulling changes from some remote repo but I couldn't find one. So, could you let me know how I could do that?
  Also, I don't seem to have been CC'd on this email. Just wanted to point that out, so that I don't accidentally miss conversations.

Thanks,
Raghul
