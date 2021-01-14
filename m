Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E76DC4332B
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 15:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6672923A9F
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 15:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbhANPvM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 10:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbhANPvE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 10:51:04 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAA0C0613C1
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 07:50:24 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id v184so898441wma.1
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 07:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xHbwXW/8RfrlSlx7gwtliKsz6xdZmBFRYSWjYkyo7HM=;
        b=WbmbJvElzx6Fz8flF8QNgZ6Sf/inFE0eYgjZvpXQNbl5K3IPL8Gg6X/POH8Lx4ug3n
         f+LGMIoAZdtwGbYoKVe4Y2zCqifEPozudL38/+bxbJ8m0I2nR1YCpe+fpZbjLa4Nn3gZ
         D5ieeoeAbQaxZpV+yaPhOUfZ27h+Ie3IvTEsK6acKXRvHWGWN7g+pjqRQWDhSAm528MC
         sa1IrGNvKyfARheaMJEFDlCpq3UH13dDfGYayYC3ZtwS7mo0B10S31LO9mSqbuqqIxZK
         VDDmmYavrn6+9w4O8SVj6dDyXDQEHAqZJpfjtElzonMHG7p2MZFuXFsaTMr6DwzztArC
         nnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xHbwXW/8RfrlSlx7gwtliKsz6xdZmBFRYSWjYkyo7HM=;
        b=DSSA1UU8DUdnOlm6FqsglKL8NPe1J0XEq1z3SLmy87LCFDY5nMfeHk9laH6BplXcbO
         NjVx0iBMH6Gk6gnRm/WELZJKWMoT0TAXTyiWJ/oFmaFbjoU5oYx/EStmaHUQ3qt1OvPq
         cSmvbaN7yJLg76u+gbzLFEtNiH2cRIhKNkdwM/W/UvhMsSwKYptR8LcTZQhkCH/zkrhG
         /OqxfJiRZVYKMpjagUiwZhqP7wh1dnm/bPBv3uLgfe6QPJDeuhjvjCq3+bEmua4U1pAl
         mhgQmgeIwil+moABUEPIZllqq+v2Xj+M0gTDXgftSDgKw5lnDDZPrUnwvDff2Z4aHR+Y
         6CAQ==
X-Gm-Message-State: AOAM532tKJZkiNhnuG0QiANioPyy0gFKc2ZNVNFq3SllvBEFO6922Z2d
        pkub3TDw+0zT6Ug5IwKjmZPkDM54SubB/Q==
X-Google-Smtp-Source: ABdhPJwesvZSo8RifLxn+CHI7IxRXzPK/gq0LPxBqw7w4nGNDfKkNPdEZAQGrU11yzG3LM7orwWhXA==
X-Received: by 2002:a05:600c:2281:: with SMTP id 1mr4707723wmf.150.1610639422492;
        Thu, 14 Jan 2021 07:50:22 -0800 (PST)
Received: from localhost.localdomain ([185.228.231.221])
        by smtp.gmail.com with ESMTPSA id q7sm10170489wrx.62.2021.01.14.07.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 07:50:21 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 0/3] Refactor writing promisor file 
Date:   Thu, 14 Jan 2021 16:50:13 +0100
Message-Id: <20210114155016.3005932-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.30.0.83.g36fd80b35a.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a small patch series to refactor the code that actually writes
a promisor file (<pack-name>.promisor) into a write_promisor_file()
function, and then to improve it a bit.

Compared to version 1 of this patch series, the only difference is
that patch 3/3 has been added to die() in case of error, instead of
ignoring it, when actually writing the content of the file or closing
it. Thanks to Peff and Taylor for their suggestions.

Discussion about V1:
  https://lore.kernel.org/git/20210112082159.2277214-1-chriscool@tuxfamily.org/

Christian Couder (3):
  fetch-pack: rename helper to create_promisor_file()
  fetch-pack: refactor writing promisor file
  pack-write: die on error in write_promisor_file()

 builtin/repack.c |  8 +++-----
 fetch-pack.c     | 16 +++++-----------
 pack-write.c     | 16 ++++++++++++++++
 pack.h           |  4 ++++
 4 files changed, 28 insertions(+), 16 deletions(-)

-- 
2.30.0.83.g36fd80b35a.dirty

