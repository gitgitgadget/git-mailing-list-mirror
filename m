Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1517EC4332F
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 22:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235685AbiL3W7G (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Dec 2022 17:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235680AbiL3W7F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Dec 2022 17:59:05 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9001CFC9
        for <git@vger.kernel.org>; Fri, 30 Dec 2022 14:59:04 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so16077179wms.2
        for <git@vger.kernel.org>; Fri, 30 Dec 2022 14:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQ/Eowj2TOgQWaoCos1pFf1YBlHkTjHNucBhvnaexfU=;
        b=Z6g1mJLSetNSaDL7cdYWKBKfWVFrk83DLD77s8/esfpidI3te863TWI/+mtVaUrXm7
         tcaE/ePG0hODp7JH6xLPEDDPLyimLErsTTDt/XuMYDxFCOoukHL4JKXnefFGTOZ8KI0F
         tUT4H15bV+ydDCJUedL4BSZqHT9tvEJoI9SOZpsjul7z/doG0PKkOGFLYwCW1cFjUQRu
         NY7NN8LFLN/WdXsZfhT2Am3QLUzlVL+cpN3JDfiJEC9DutAjBi1iXsyjQ2f2EpFkshW7
         GIRuCbywm2/7g65G63EBP5v9LGkTOKNajkI0P35q+qkNhG/TKrFHUhNORS0MYSWEnSQu
         MZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQ/Eowj2TOgQWaoCos1pFf1YBlHkTjHNucBhvnaexfU=;
        b=doKBE4B9psgduccEIW/sqGcfiLI0U5a/vWSZJXz0RlI2bCveUuFH2k8/xLKdEJ64ED
         z9eKAby6EQFJrSC5lz9t9nW1GbWjC36BVX9x12FAGcWT/AF1jVXtsGht+g/6CiwxhKuE
         PLsmYK5fs2PfiQh2+sGz8cbV/NyMHeB58Tc85rdJ9aDSZLvv5SbT8plbjtxLLXI6g4RP
         1b2hohp023mwMRO6NqSpJ0RQRFO0JXMps5FMg4/C/sxeR9424yiHEmV5cwrfSHgx6i0P
         YvvSCZQEbYJ3OsXtoGgycUg53wUDnbTmuCV3rsKt/zohgYE5yzu2oEuPHNpJGddpdhcY
         2Wcg==
X-Gm-Message-State: AFqh2kqoW2M2/m2JpITLZPlCXfev/OmumsFXwHuMRqSitJBaLYZyXySB
        l9dxfq/s/FrjLwm6Wl6p6YY6ImSwIe8=
X-Google-Smtp-Source: AMrXdXuuxRfbLiWTEMZFxmKCWih7z1IaKm18FkdLCWuuL3a4z94SiAq8d8qI6KqHNBkLlFsu6WuoMQ==
X-Received: by 2002:a05:600c:1503:b0:3d0:8722:a145 with SMTP id b3-20020a05600c150300b003d08722a145mr23129863wmg.40.1672441144053;
        Fri, 30 Dec 2022 14:59:04 -0800 (PST)
Received: from [192.168.2.52] (94.red-88-14-213.dynamicip.rima-tde.net. [88.14.213.94])
        by smtp.gmail.com with ESMTPSA id l7-20020a05600c4f0700b003d96c811d6dsm30099717wmq.30.2022.12.30.14.59.03
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Dec 2022 14:59:03 -0800 (PST)
To:     Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Subject: [PATCH 0/2] branch: operations on orphan branches
Message-ID: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
Date:   Fri, 30 Dec 2022 23:59:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid some confusing errors operating on orphan branches when
working with worktrees


Rubén Justo (2):
  branch: description for orphan branch errors
  branch: rename orphan branches in any worktree

 builtin/branch.c       | 10 +++++-----
 t/t3200-branch.sh      | 12 ++++++++++++
 t/t3202-show-branch.sh | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 5 deletions(-)

-- 
2.39.0

