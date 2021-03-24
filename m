Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DE0C433DB
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 12:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3291B61A09
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 12:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhCXMas (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 08:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbhCXMap (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 08:30:45 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67ECDC061763
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 05:30:45 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so1130038pjb.0
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 05:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D9QnO6zyqTXFfqa3fZvXwxrBEiacCC+DcIZOTRyYKcM=;
        b=jsj6k1sPHnPPwvTi6VbnSy8Qz/p6f7S2Dpg3lgcJFaeIHykS90DScWqiBrJhFPop9J
         /MLqNQh3ojNjkyunMdARplwib2Utbe1q1foZNW2ScVaRQZtb/m91IKVafGQhHGLjRa80
         zZ0k+WURnfGnD/tG2noOq4IFetKCx1gxy19F5HF3Kk4bN035JOKZuTZemIcAQxO5Jp6V
         rsHdRj+SM04/RzGRqEpJM6kEZ7Dft+hBlcI0tthymN7ripgf5RWiH6dOV5eyhFP5Lub4
         2PRNdOsTHfiCtlg4WAtC2ht/NqaTW1jSkMFRBFC0UZ4SejnhbsnibBGs+5nfp5PsYtYc
         lOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D9QnO6zyqTXFfqa3fZvXwxrBEiacCC+DcIZOTRyYKcM=;
        b=ts9dLiN4cTVNQr0tWyYo/+iWZFoCQqbt4tvLyxGTxNZd++By7K5+BorYaQjBTD7EL+
         vXCbpqKMEogFTUKUf8P0DKK/NYp5Q5qI9u6WhJQx+dx9lqIQIcD/WeE8pxwL9SFudy6j
         A4c2B90Z3LjaLnS4pZrsGPSNMgeAJz/KpqNOotvmfwbSuLN+eC40Y8FG+MWyL92Coyh0
         c2DQkTmKVkyWRAepXLxrdsoB6TBwSlBQw5V9PXlJuON3wIFiY9DEpEeiqaOWu7QmiEy3
         33SK+pRiZX9Ziy5H2PStgSXxJrrnh0JluZ6CKgVpvDimsCSV5ccYHUsXg4eltlCzjAu4
         BqUA==
X-Gm-Message-State: AOAM531ahIfzbYCnbKQ1btlH0ZzVKRRIkyPUqqRKG1fAyyb0seThVbRH
        nnFefFknAxmHItYHuG5tyBz5Ksv7W4RimQ==
X-Google-Smtp-Source: ABdhPJwvNiWXeShiPhY7iKR5pyoKf/W2b0Su2xdiuh329P9Olnq2FYoCZb9gd8xuT82oAD6P4W5lkg==
X-Received: by 2002:a17:902:a412:b029:e5:d7dd:9e41 with SMTP id p18-20020a170902a412b02900e5d7dd9e41mr3433545plq.78.1616589044808;
        Wed, 24 Mar 2021 05:30:44 -0700 (PDT)
Received: from ubuntu.mate (subs03-180-214-233-84.three.co.id. [180.214.233.84])
        by smtp.gmail.com with ESMTPSA id c24sm2443299pjv.18.2021.03.24.05.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 05:30:44 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 0/2] Diff format documentation for git-format-patch
Date:   Wed, 24 Mar 2021 19:30:25 +0700
Message-Id: <20210324123027.29460-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-format-patch generates diff, but the documentation for its
format is missing, so add it.

Bagas Sanjaya (2):
  git-format-patch: Include diff-generate-patch documentation
  git-format-patch: Document format for binary patch

 Documentation/git-format-patch.txt | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

-- 
2.25.1

