Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB3CC433E6
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 11:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA29C207DF
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 11:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6aiZhAz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgH1LGk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 07:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729174AbgH1LFl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 07:05:41 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56E7C061264
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 04:05:40 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id q8so492597lfb.6
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 04:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QD85GmriyZCs0bH892Tlu+/NlI3V6eb3et2gjzaSTDw=;
        b=f6aiZhAzNuWCZXHi1vHRTvKzgpltKG68E4B4aspy/t6zAqAX+/SUZuhPAyCytLVwLY
         nnruzpJ8a9s7xRIML70KxyQuXppDhSZbtRVngXd6Ws60K3LJJ0e0Qmb5BzdmdodQgI/K
         VNccWkxLVQelZE/OAuWZ4n7kpK28fLoIfne3YCTHmr24Z/Cz7c1maoF/zrCeobfgR2Vd
         U72S+e4QJ5SaI+IRlbCkfoATiWGhT7u5eMGQ4idfer0tKpFQOVeyHyG5IckHPFPCzKjQ
         RqjshgV3WE7ZCUF6SejQRoMIVqxrsq9t3QJVjHUpuV8k2J/UkcoUCu8qpRJFHEc1JJjX
         2KLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QD85GmriyZCs0bH892Tlu+/NlI3V6eb3et2gjzaSTDw=;
        b=oz1mXuX87D6DBTTQNqAbJ+k01fHXANJ8SJ1xpGn7rCYd+CMsf9E7m3nyadqi6XpiA+
         eLb+xLy8VBuIDgFj9hgGK6bt3oSgGGmA41ZNQdAdqydFHE9Pj4OL/jGHFtgArca5zim+
         772mL5nQSMwKuhNk7mVLnhEIoip3Yw3ub0b4YxGK3BXz+Gjgd/AWdBb2sqNDFhGh7OpL
         GPQLst4nRASwrnKQOwDB27fzz2HID1FD48aY9yzQ956bj0BKjJNrJZ/yONNsH+8WYRgu
         HFtPmuF1gzYM3qPuBZW333Vuw8RmWVGnyOdjQ/wQojmEM99hoUOjN40oNKWOHk7+9k16
         7lOA==
X-Gm-Message-State: AOAM533qbYYqTclshN30vYVMXLB0WgpbAW7c9uueEtg+EI+xEj0JCJNU
        W9/QoTXPgv+iPiOY6tYm7Jo=
X-Google-Smtp-Source: ABdhPJy161XLpzRM4XVFH1AvyzdS7XRrLzejN0ZAPfWzCLFjwWlrAJ/PzYtCudVhiIIUAe8U67r0CQ==
X-Received: by 2002:a19:915b:: with SMTP id y27mr552933lfj.134.1598612738390;
        Fri, 28 Aug 2020 04:05:38 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id e21sm218707lfc.97.2020.08.28.04.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 04:05:37 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 0/2] log_tree_diff: simplify
Date:   Fri, 28 Aug 2020 14:05:24 +0300
Message-Id: <20200828110526.21145-1-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches are pure code quality improvements, -- they should introduce no
changes in behavior.

Sergey Organov (2):
  log_tree_diff: get rid of code duplication for first_parent_only
  log_tree_diff: get rid of extra check for NULL

 log-tree.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

-- 
2.25.1

