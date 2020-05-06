Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CED7C28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 17:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B29D208E4
	for <git@archiver.kernel.org>; Wed,  6 May 2020 17:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yq1xLTcp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbgEFRLq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 13:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbgEFRLq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 13:11:46 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCACC061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 10:11:45 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f8so764933plt.2
        for <git@vger.kernel.org>; Wed, 06 May 2020 10:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kOUXWnKVVNY07x46K9+05zWijgWjrRUXm0vAdRPb8HA=;
        b=Yq1xLTcp5gM0SuXARiS1xal5ioRlOcj12nfx4I/sMvpc/8UR9anqOqOSnDi65JfEtg
         V6wDZOzsgGYZlOA15//8lXl0rlfUbUwBCqbHGA7DI68lltqbn4OFOnNlzMcM9NxvMYDT
         HGGQ4Ss0TSIPfo9StN7mKnI5cP8rO8DS4DuAFf7wFsOp7D9t/JiRfZDqGNoO+bw38LR0
         3lebs9oAEfW1ZLO9RTu47i/YNkrOtgjw9qp07TxrdJbO1uDJN5o6fumE2XBaR+qZay0j
         urGYcJjQWa5JyFQ6zwnWM34oi/9ILh6zi1dp+43BQi6fE1DpiccWZoVydl2VSLlfATGW
         rEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kOUXWnKVVNY07x46K9+05zWijgWjrRUXm0vAdRPb8HA=;
        b=T3pi7BuXjiFNqZ32kXtE1gnA7/kYCcysCcmkd4zdbAGWikwFw//vw2gwXJQ+K3BGaF
         JzA0oiQk63MNCOiiVgaomIW97Z6oZDw7qCvMWS4VQiKNU20a8rGdWAXQVSYwZe+FqiBW
         eGO6oSI5hEuhvohWVNKecEQZVjxuSf2GGKTKuMEeeRChbOIIgvSJpyb2qggEzs6f1pom
         I9Vk5QqYLZxsfUhfO3y0Zg7W0qqW7NQfPDjaY8eVQSGdJA+Z+FwUn/EzyvgmFDv7x3fa
         7XysfXmQiuQ+FBsSl7I8dHGogvQNi4Zt7+0YqeksNmLvJluuLIt6sMiwYo+eqhNDV3L4
         NKiQ==
X-Gm-Message-State: AGi0PuYncTGZsw1DKVybT3ZHa/hRsCOYbW3WVjPZdGBBa+AJ3z2Em5/+
        wCtOWsMAPr2TL6K+gTSP0kC00WZfUn8nnoq/
X-Google-Smtp-Source: APiQypJGKHXh0M3Y/Jlk9FqYe11OTr2QixKWPxYj5IVPVZn9DHVP89gEZKAWn6+qwpg3bWH0njf7BQ==
X-Received: by 2002:a17:90b:93:: with SMTP id bb19mr10376609pjb.134.1588785104665;
        Wed, 06 May 2020 10:11:44 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.172])
        by smtp.gmail.com with ESMTPSA id 6sm1961273pgw.47.2020.05.06.10.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 10:11:43 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, sandals@crustytoothpaste.net,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH v7 1/4] gitfaq: files in .gitignore are tracked
Date:   Wed,  6 May 2020 22:41:07 +0530
Message-Id: <20200506171110.23124-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add issue in 'Common Issues' section which addresses the problem of
Git tracking files/paths mentioned in '.gitignore'.

Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 Documentation/gitfaq.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index 1cf83df118..11d9bac859 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -223,6 +223,16 @@ a file checked into the repository which is a template or set of defaults which
 can then be copied alongside and modified as appropriate.  This second, modified
 file is usually ignored to prevent accidentally committing it.
 
+[[files-in-.gitignore-are-tracked]]
+I asked Git to ignore various files, yet they are still tracked::
+	A `gitignore` file ensures that certain file(s) which are not
+	tracked by Git remain untracked.  However, sometimes particular
+	file(s) may have been tracked before adding them into the
+	`.gitignore`, hence they still remain tracked.  To untrack and
+	ignore files/patterns, use `git rm --cached <file/pattern>`
+	and add a pattern to `.gitignore` that matches the <file>.
+	See linkgit:gitignore[5] for details.
+
 Hooks
 -----
 
-- 
2.26.2

