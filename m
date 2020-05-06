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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EB2C28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 17:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8199020936
	for <git@archiver.kernel.org>; Wed,  6 May 2020 17:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/ASG/Px"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbgEFRLt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 13:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730058AbgEFRLs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 13:11:48 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8499C061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 10:11:48 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id f8so764980plt.2
        for <git@vger.kernel.org>; Wed, 06 May 2020 10:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eNlZHvW1cgA6bCjxfw3juRdvEUSWfAvm7+3h/d3dAX0=;
        b=o/ASG/PxiFCM5WpswmLkOb61VokVBRvGofoITsuHCJI/HY41uaCsEsg9osuf70e+G+
         /+EYw+J2LaLds0QHqo9KVjqtB/QTJ7Hk+3gj65DoHdInYrQeLgAdIWfVHnLXBKbKoe6W
         W2I7rcbOm/7SxmObWz8jjBOhDc6hNgeG2paXFXAoqJdcnHcAMafw78gU4OC+hz+WpGv0
         pjC4+yO7NzJqLsZXIwGHcgB0VM7u0REcT4pyBXMxYgnTvXKhNhKsVFH/4/UHDWA6UxxL
         jKJCsX82ANTRHMuKyymZfPIzjYTgamP9jjvQDTonz58oBJwcP4lfbF72EPmCmsvCB14t
         AFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eNlZHvW1cgA6bCjxfw3juRdvEUSWfAvm7+3h/d3dAX0=;
        b=uO4+RjF1RmusXo66ijmohSCwTzHSCAp/cpKLPk7R149xNppRe2iR/YT/UEvDgxm0iC
         VcS0O+ap6wJ1u6pdC0EUwmn+rHJKAVRPjBcEQQZMla4NOYMerz2CXhdWyaAKXqRh00nH
         WTkjB1thGLOPE0K7r0VIqt280DVDNdK3v+cYriL7JX8G5j7LhHVRUgBsBlugfSBWZZGX
         itayknRLJ30c4IM+Kyj86bcvQFoVavu4QeP4TdzkQp9cUSFkOQjKqIiDfoR1ubffzJxA
         alnJCRC0xeV206XPoZJjQET/TA+bBsikXGdMHXUdlQhiVq+u2ccrE6OsI+4YI7L6l6lF
         s22Q==
X-Gm-Message-State: AGi0PubNW3Hip2CiiWhxNrupZePBw0DOtVu2UlxTQr2EtZcNDhcZrfXc
        7bCZpefRAo0M4F/N8J5rfjXlzXZgH5sPqItr
X-Google-Smtp-Source: APiQypJdEN8cJNgwUarSeHDKVCfZWd+G7X3aIITh0863MHP1sNStXykjqZ5VlTaSWTNko6lZqK7wKg==
X-Received: by 2002:a17:90a:c7c8:: with SMTP id gf8mr8268604pjb.226.1588785107690;
        Wed, 06 May 2020 10:11:47 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.172])
        by smtp.gmail.com with ESMTPSA id 6sm1961273pgw.47.2020.05.06.10.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 10:11:46 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, sandals@crustytoothpaste.net,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH v7 2/4] gitfaq: changing the remote of a repository
Date:   Wed,  6 May 2020 22:41:08 +0530
Message-Id: <20200506171110.23124-2-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200506171110.23124-1-shouryashukla.oo@gmail.com>
References: <20200506171110.23124-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add issue in 'Common Issues' section which addresses the problem of
changing the remote of a repository.

Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 Documentation/gitfaq.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index 11d9bac859..875cfa0acd 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -233,6 +233,17 @@ I asked Git to ignore various files, yet they are still tracked::
 	and add a pattern to `.gitignore` that matches the <file>.
 	See linkgit:gitignore[5] for details.
 
+[[changing-remote-of-the-repository]]
+I want to change the remote of my repository. How do I do that?::
+	A remote is an identifier for a location to which Git pushes your
+	changes as well as fetches any new changes from (if any).  There
+	might be different circumstances in which one might need to change
+	the remote URL (see linkgit:git-remote[1]).  To change the remote URL
+	one may use: git remote set-url <name> <newurl>
++
+One can list the remotes of a repository using `git remote -v` command.
+The default name of a remote is 'origin'.
+
 Hooks
 -----
 
-- 
2.26.2

