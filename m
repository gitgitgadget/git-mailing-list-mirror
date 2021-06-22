Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06833C2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 18:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D89AC6128C
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 18:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbhFVSRY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 14:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhFVSRX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 14:17:23 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A4FC061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 11:15:06 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id b3so3212700plg.2
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 11:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+sLFxC5vnxdpm6dZJB4Hr4LcqSH5mP3xGzhqYgdLkp8=;
        b=DHylE2K+m5w8T+rv78EAcE5yAcbrKcXVTGBi+iXe0Itj33aGctwIrhj0OSVKo3mtLY
         MgzAXfyEfHZo/JMzCioqhxDRKAPa1YahuROFwXJQFpVopgWJ0kL5ztXMM2ZdgmYzIluC
         HtkpBVvxxRCY4sPcJWHNioSAbQ8JUMj3gs4M5ksta/xN79MMAMW5uJGmN/iSM8EOZ4QJ
         DFje29trCEw6seQvjso74hFaIY0qgukT+cT2GzNgnuIYituF0eUQpVVsXpA3rTjhs+mK
         zQOWYHqrRWziNwxW0TMGQP8NMlmUns+Cq1kxv046qy6oRehi+RJyWpmAF2Inf73vSMeW
         0K5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+sLFxC5vnxdpm6dZJB4Hr4LcqSH5mP3xGzhqYgdLkp8=;
        b=lHOxKq3MDsS0UrXRqCDD332KLLEZxUSwVB0VfvNmvO6NsuzZ+B2LSTJx6t3u1VhRnl
         dWs0UDtAK6uTVtLt+VxFfQMu2JGQzHErcPrX32GAe/Pf1Qy1j7TUGH4quTZg/6JZoUvk
         lIRxBw6S2Ad/EslRTfsdPCSBv+iGHWcDzByoROSaITfQxpgXP7VAl89Gq2gi+aO9aSsO
         HvPq69saWCVGmpIyNfucUvcmXsU5oEi+oOMwQ5NmSmE6t+QustUor5h2YPNq8Wg4chUb
         n90w0RGf6D71liEa+135Y29MwnPpdiF4UifMbWsXDSjJu7VzwgoefBWStfzVThZs6pAt
         t0lQ==
X-Gm-Message-State: AOAM531/Duxx60CfkCK4yOAgSfDeTLZH2/PmAo7u7fYpNBrA7TzLpCKD
        eJHZozpPmWW4Qu+75ITfZ2DBIuP8U5qdKw==
X-Google-Smtp-Source: ABdhPJwpAwggkJcQhr8FqtUa+oTmE1/8QMOD+tZgFgeKbJku+sEze5TwwQDkXWBbqkWJlDIrkP6AVw==
X-Received: by 2002:a17:90a:cc05:: with SMTP id b5mr5169770pju.146.1624385705876;
        Tue, 22 Jun 2021 11:15:05 -0700 (PDT)
Received: from localhost.localdomain ([183.82.190.58])
        by smtp.gmail.com with ESMTPSA id co18sm2828679pjb.37.2021.06.22.11.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 11:15:05 -0700 (PDT)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: [PATCH v2 0/1] Some submodule related code cleanup
Date:   Tue, 22 Jun 2021 23:44:51 +0530
Message-Id: <20210622181452.2974-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.32.0.9.g81a5432dce.dirty
In-Reply-To: <20210621190837.9487-1-kaartic.sivaraam@gmail.com>
References: <20210621190837.9487-1-kaartic.sivaraam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is v2 of the series on submodule related code cleanup.

Changes since v1:

Based on review feedback from Eric, I dropped the first patch as it
was an incorrect change.

The second patch is included as-is.

Thanks,
Sivaraam


Kaartic Sivaraam (1):
  submodule: remove unnecessary `prefix` based option logic

 git-submodule.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

-- 
2.32.0.9.g81a5432dce.dirty

