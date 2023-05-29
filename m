Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F62C77B7A
	for <git@archiver.kernel.org>; Mon, 29 May 2023 13:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjE2N2G (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 May 2023 09:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjE2N2E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2023 09:28:04 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CFD8E
        for <git@vger.kernel.org>; Mon, 29 May 2023 06:28:03 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64d2a87b9daso2433744b3a.0
        for <git@vger.kernel.org>; Mon, 29 May 2023 06:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685366882; x=1687958882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fVmfSmgfeHdqQGMav7XwCywpCBuxrkyB/qtBLklHiR8=;
        b=nzinysxceVvwnX5Lq2hMqukwPJnGe9KlDrkX0xuI3+s4khaKV/k42jVyZ91hR6bYMa
         /5ZEkOUgtV+iy6S3A1iZ22miF46lMi6vG5whqJSNRWFqscYnMg3BEBwhBw0HRCOQAL2p
         BK52AopJwPfRBD+0Boh32CDHOxuTG9k1q7orNVygROJnhb7ElugufOX3N8WqTbUJEZG+
         7YHnVcxeiAkB+ek5cPr6Xb00pzeSdmf7UpRX0jhD6bCBe0VHSMX/MBp8gBsFYrkxpKL+
         aYNUBNg5qf83tQvDHDf58atj0ihXdo9q55HVBYgi6Toe0x7Kn0rzKbAl3EjGhSMs71NG
         JflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685366882; x=1687958882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fVmfSmgfeHdqQGMav7XwCywpCBuxrkyB/qtBLklHiR8=;
        b=azi2hknxovLPPklQU2zADanp4QqRlfMe/uvdXjpe72F0MnClp4NkkPOJwaqKxisnLI
         XguQ+Cy1WBGrTDzGCeuTgAxje/5F+VwDvIyIl6qQqthEoMbXpn7k6jMr8Si2PIGY9X8m
         CcdXtH6hYyTIlnWSnw4N7ie2mle9xEF6PJSLmlB0BB7VRj+hEf0ro1zBza64uuPz1ckK
         CDsm09jfXs9SsmwPMr0BXpE4cbAI1/b/nnB4+gU+Ljjv0lFa4WiX469opbFwyoNeKJqG
         4ywOoNuusq7RgcWRo+1Bywcj9oruljWB0oBlE7W94gJHMdbaadXRCgV5Nu1IIHuTom9N
         xBeg==
X-Gm-Message-State: AC+VfDzP+QI3lS3XJv0Qj8bvfuvdJmAnvQU+fcNIF95wD2fnQUawuLO+
        BnjruIqZ157nidAJQ1hpLM1NWJ4iV30LgFQT
X-Google-Smtp-Source: ACHHUZ6Par5Cb/P3Sms71/Fd9OEQ5JCMC6bHM4b1Jy+9nPmbRPRk6cKZeHS6qpv51w7ZYq76gdz35A==
X-Received: by 2002:a17:902:f551:b0:1af:b47e:7887 with SMTP id h17-20020a170902f55100b001afb47e7887mr13359402plf.65.1685366882343;
        Mon, 29 May 2023 06:28:02 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.48])
        by smtp.gmail.com with ESMTPSA id p23-20020a170902a41700b001aaecc0b6ffsm8214628plq.160.2023.05.29.06.28.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 May 2023 06:28:02 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     tenglong.tl@alibaba-inc.com, Teng Long <dyroneteng@gmail.com>
Subject: [PATCH v1 0/1] surround %s with quotes when failed to lookup commit
Date:   Mon, 29 May 2023 21:27:55 +0800
Message-ID: <cover.1685366301.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.41.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

When lookup commit fails, wrap quotes around %s format specifier.

Do we have to put a "<topic>": or "<filename>:" before the commit
title, such as this patch, which modifies two different features,
how should we name it appropriately.

Thanks.

Teng Long (1):
  surround %s with quotes when failed to lookup commit

 builtin/commit.c     | 6 +++---
 builtin/merge-tree.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.41.0.rc2

