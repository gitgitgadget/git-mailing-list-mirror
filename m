Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9B2C83008
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 10:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BB4F2082E
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 10:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHOko5Pk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgD2K0u (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 06:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbgD2K0t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 06:26:49 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEA6C03C1AE
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 03:26:49 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id r26so1434514wmh.0
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 03:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=az57/uM1PU975XWC3FO+tA9BaGt2XAF1gnETXtB0YvM=;
        b=CHOko5PkJ7KnL9v7/xgNU0OPYzdIr1y2Ss3552FWmPZI/mUtBCzFtM9mkiAsUqqlBd
         tdDGgFXJ25L//u4An5Kc0VDnkDJnjhwfreHGgiF0/XthNmMEK6w4c5FpKjaWT/nlG7VD
         zKUuxK7+Boksuz1sxqGWO3CrAaSk9w1KNPvbreOj9XBlAS0n3OWed25dDhKrM3xP6t7Z
         4+tzpMEfkRBTcnsBNeTvaAxlHE15rXMcNpugQX3KDIkHtHDadhHFFkQdz+LLzHHUvd26
         v6qaWAb0gqhdsWeqM1SJ74uyNszp36BiQRvGNg5wJMJ25RQNtZNhkmMjH4UfL9hAbq9e
         qjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=az57/uM1PU975XWC3FO+tA9BaGt2XAF1gnETXtB0YvM=;
        b=polNwPtH7q1TU3gAvUCrsydrA/0pE+zlxHtKf8CJ+kRx9zExDrSWcnYZSDuPiHhLzL
         S3j67fCyJiOWXNJpjXmGMMPH+GOr0ugMmPqP91ZvVqR+vgeZe9MrGVen7cBwXSjL/nnB
         ZdcJMhw+5tUx5SCh3G9d/pVoUbtxpAR9N6hENE385nMcE1rvVMgvPgNzWOWmSKl94H4y
         QU6Fe5IwEwuvBVIeKarqsv9g8GXLGumhzO60qUH2W2tDBw3bBDNg6yS9qlnS0OFut7wj
         uOV/1+BS/vlhd85q3kIh4sopScUHwpxIfnw0knb/PDQ6ZrNfVcNnjQY8sn2QMhV6sZUa
         RMwQ==
X-Gm-Message-State: AGi0PuYGlw43xC57TXDFjkWDuSFkNVTOaBw+CntskcfDPS2xiaELiuR2
        7L/wStD84j+C0grwOfKQuTvHSMrj
X-Google-Smtp-Source: APiQypJJolu+CMZ4phP5MRgMrtOO5+U/4bubKmPAVBMmuGImG+OSa01MdPcWHvLcJ5INjVASvg4NcQ==
X-Received: by 2002:a1c:9c0a:: with SMTP id f10mr2460067wme.139.1588156007897;
        Wed, 29 Apr 2020 03:26:47 -0700 (PDT)
Received: from localhost.localdomain (155.20.198.146.dyn.plus.net. [146.198.20.155])
        by smtp.gmail.com with ESMTPSA id c1sm30718196wrc.4.2020.04.29.03.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 03:26:47 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH v2 3/5] sequencer: rename amend_author to author_to_free
Date:   Wed, 29 Apr 2020 11:25:19 +0100
Message-Id: <20200429102521.47995-4-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429102521.47995-1-phillip.wood123@gmail.com>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200429102521.47995-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Rohit Ashiwal <rohit.ashiwal265@gmail.com>

The purpose of amend_author was to free() the malloc()'d string
obtained from get_author() when amending a commit. But we can
also use the variable to free() the author at our convenience.
Rename it to convey this meaning.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 sequencer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 3bb80d7414..8dff8b9b95 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1335,7 +1335,7 @@ static int try_to_commit(struct repository *r,
 	struct commit_extra_header *extra = NULL;
 	struct strbuf err = STRBUF_INIT;
 	struct strbuf commit_msg = STRBUF_INIT;
-	char *amend_author = NULL;
+	char *author_to_free = NULL;
 	const char *hook_commit = NULL;
 	enum commit_msg_cleanup_mode cleanup;
 	int res = 0;
@@ -1356,7 +1356,7 @@ static int try_to_commit(struct repository *r,
 			strbuf_addstr(msg, orig_message);
 			hook_commit = "HEAD";
 		}
-		author = amend_author = get_author(message);
+		author = author_to_free = get_author(message);
 		unuse_commit_buffer(current_head, message);
 		if (!author) {
 			res = error(_("unable to parse commit author"));
@@ -1472,7 +1472,7 @@ static int try_to_commit(struct repository *r,
 	free_commit_extra_headers(extra);
 	strbuf_release(&err);
 	strbuf_release(&commit_msg);
-	free(amend_author);
+	free(author_to_free);
 
 	return res;
 }
-- 
2.26.2

