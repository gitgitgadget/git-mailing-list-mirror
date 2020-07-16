Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF23C433EC
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 17:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E64DE2067D
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 17:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAwuMl5p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgGPRcf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 13:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729172AbgGPRce (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 13:32:34 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68876C061755
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 10:32:34 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f139so12362556wmf.5
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 10:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=3PTj4VRENxzwWcqR4TZlHeHBhBiWUf/is80xJx6e5CY=;
        b=EAwuMl5po91fg4+a9V7gBTJE3yEk1kjszFq2Kv7B1WYQXrSz9p37LFBoE9aqOO4xW2
         68H/j7pG1J0vzuvyyUF7Vi7V6F007FA6RnK9Lo2zEcKs6XLlmhBuUGaaVIokTudVYFYN
         p3qc1i8MaobbUwFJhWC2FxhwcM2xmU0v6pEyDpb8NDsuKtFkSLNINH3ew0fftd/egybM
         /a9p5Qzd3X7OSEAXgKyTCTGCXJNux/YntSqpIVzW3g5av4x8O8l47IzLLX6vIg1Zhm3V
         ZthJeoZ3wWQZfzVlWFpdE7Lj9bttVtbgg3+OX1GMGi71QcZCM6PBrlTSW8NZ4nsoOXps
         QI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=3PTj4VRENxzwWcqR4TZlHeHBhBiWUf/is80xJx6e5CY=;
        b=XQREptKj2iyTlHqt8ujabmJhds6WWdiCnjmXPVeNOIqgNsOCW6Ms+Z2kBLcIse8Cv0
         ECcMR1GHyl7mSoQtDxTkNgHoUnFFRZGI7AaqgAZFgDnUqY103nk3exLXVAVj/9CtXG3e
         0g15CyJLsvICW5HIwJKkI2zGi0qCmRZzjLprPtM7MLJMpKT5YpvvOHFkwrS88dbfmMAV
         74bxvBXR1xMH4dILI1YAzkOGwgl0EaGPDrZFtkx8DBLftI/MLGL4QgB4k7WUiro49tHn
         PNE2GmlquAkpp0G9JUHukuqZC+F6EUP2KK7T0quRqWFWhnAU8Kep7dM4ROkvHqvwhbit
         g3ZA==
X-Gm-Message-State: AOAM532um4DXbxjXbxOsCiz2DysGO6pW16VjnpCfrAsSI5WHBytybt1J
        qDTlmVmpKFwoxidDU6xuGaE=
X-Google-Smtp-Source: ABdhPJyxawhaFMJmU1o5Ncoy6zypqnNBFQxBCI0Y5FhPLim89W67v4N8DEkLOhe1a6aKOjDa8PF4cQ==
X-Received: by 2002:a1c:4183:: with SMTP id o125mr5216328wma.101.1594920753154;
        Thu, 16 Jul 2020 10:32:33 -0700 (PDT)
Received: from localhost.localdomain (130.20.198.146.dyn.plus.net. [146.198.20.130])
        by smtp.gmail.com with ESMTPSA id q1sm9890020wro.82.2020.07.16.10.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 10:32:32 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH v7 3/5] sequencer: rename amend_author to author_to_free
Date:   Thu, 16 Jul 2020 18:32:19 +0100
Message-Id: <20200716173221.103295-4-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200716173221.103295-1-phillip.wood123@gmail.com>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200716173221.103295-1-phillip.wood123@gmail.com>
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
index 368d397970..29f6d1bc39 100644
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
@@ -1357,7 +1357,7 @@ static int try_to_commit(struct repository *r,
 			strbuf_addstr(msg, orig_message);
 			hook_commit = "HEAD";
 		}
-		author = amend_author = get_author(message);
+		author = author_to_free = get_author(message);
 		unuse_commit_buffer(current_head, message);
 		if (!author) {
 			res = error(_("unable to parse commit author"));
@@ -1474,7 +1474,7 @@ static int try_to_commit(struct repository *r,
 	free_commit_extra_headers(extra);
 	strbuf_release(&err);
 	strbuf_release(&commit_msg);
-	free(amend_author);
+	free(author_to_free);
 
 	return res;
 }
-- 
2.27.0

