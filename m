Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C0CC07E95
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 07:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E094613ED
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 07:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbhGJHvD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 03:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbhGJHvC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 03:51:02 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34172C0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 00:48:18 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id b8-20020a17090a4888b02901725eedd346so7365144pjh.4
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 00:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FaeNmXwpIOtshkpJAUM4ElwX++E8UhuTnZbTAqzIK08=;
        b=H+AokP/6HnSOKTF6fGJ8t3Dw4p9+xq7zVWe0xXqVqlkRn7uupSFtU62hnMFPTl6gRQ
         +6X1bKWeSbHz2XigWxaEMKu0/XEzrocYfKYuy823501L56vR6Gl8SikpyMFFzWMMd+k1
         3J+JgxBHF2f2hQLW+FwN98pZXGX/wfPhjcPh5TONteHi/kpmYeAdKtxBG+LMlLynLp2m
         /hcpFUVhcFATi7BZ2e5DK1AtE6jQLDX7ZzkINfYbG79ni0mQ5UINlPKxvLEtYjJKWx0N
         FPhHVuYlzSsXSNm2B+hGrFZ0aXqq3XrYheXmvkGWFCJygXAE3J5Ik7k3cTcyjMlDOOFC
         t0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FaeNmXwpIOtshkpJAUM4ElwX++E8UhuTnZbTAqzIK08=;
        b=DOmqjX2out4qgjELa/apwOG1tcbtv7v8jb0G3WsB1hm2pWEtqnh2f02qDusr/5cEnS
         woB/Cyn75HeccOzORoDBAyXTP26Ik+j1zjS7DVhVERG6lrDW1KSsls4r/4KI0MEKSduk
         9DaAMxjI+y5ePv7vD5RcvbtSP8JHcmd77OCHyKZy0jTxG2teotCSrPA4shtKrtFJ438V
         P3btaBh6UH5BVPRAqOErTip7qaxt4q4TDIcJNJpl55S6+zizjUPwiNIlMwzRD6NKzF1E
         PZr3LRfHsOE6gM4oVuirHk9HnIGsgaQMNqlqEfT2kr5OmCFSoSmQvDLq/DQtV3j/81Wt
         i3Zw==
X-Gm-Message-State: AOAM530riwnItcJJOCuhIjDr7s0tCylEEMK7FJLGMfBGw/pf9UBtBG8P
        M0N+HxQrJDM/bwo5Pojz1diuJlKnDu4kAiyP
X-Google-Smtp-Source: ABdhPJzu+3gz5s5JzOf453t4m1D0ICviqUsH5PnFOb6fT8Btd2U3716qI3njJcqVlCKdOwvxXHCn3w==
X-Received: by 2002:a17:90a:8c87:: with SMTP id b7mr3300903pjo.230.1625903297490;
        Sat, 10 Jul 2021 00:48:17 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id 125sm8811327pfg.52.2021.07.10.00.48.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Jul 2021 00:48:17 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [GSoC] [PATCH v3 0/4] submodule add: partial conversion to C
Date:   Sat, 10 Jul 2021 13:17:57 +0530
Message-Id: <20210710074801.19917-1-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210708095533.26226-1-raykar.ath@gmail.com>
References: <20210708095533.26226-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v2:
 * In 2/4, the prefix 'fatal' is left out of the gettext functions so that it
   will not create new translatable items for the translators.

Atharva Raykar (4):
  t7400: test failure to add submodule in tracked path
  submodule: prefix die messages with 'fatal'
  submodule--helper: refactor module_clone()
  submodule--helper: introduce add-clone subcommand

 builtin/submodule--helper.c | 418 ++++++++++++++++++++++++++----------
 git-submodule.sh            |  76 ++-----
 t/t7400-submodule-basic.sh  |  13 +-
 t/t7406-submodule-update.sh |  10 +-
 4 files changed, 342 insertions(+), 175 deletions(-)

-- 
2.32.0

