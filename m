Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5A9C433E0
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE7B222D08
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgLUSN1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgLUSN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 13:13:26 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4635BC061282
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:12:46 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id a12so25876242lfl.6
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0W3us1d0G5MzwFNR/Pz+9/j1tIqVyxQx+lyRwVD3uME=;
        b=vDucMYrBV7S3HpVjxBQOrhxJBxqOq0cj5ZliC3tVc40WhFKnec2NEaTCi5Wfg0LVE/
         nkvH1n6C5nqiACB3AQaiQK60Q60vYqzBUW1XdAqu717MpGwEEFStf0dauVE/yemtoo2I
         SIInEi5AQPW/ScEZqZxMuYjBkmDh5T2O4bz+S4xQKTcwcrfe0NlLdSVrlJ4xOnoC4QG/
         ouSG634AA0z6YG9N9tHDLLyDowWrbOzVJLAOqutkNLasQIRUm6wfVtOgbDNQrdsTQowN
         Y6LedksDmaqPEdv+kU9Rma8n9bhj773v9jpBRxeanDZ4FFQjIGOSrI/IXaAAxInkQh00
         Xiuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0W3us1d0G5MzwFNR/Pz+9/j1tIqVyxQx+lyRwVD3uME=;
        b=Bffj5OQeM1235H5UcYb7jbrhu8ciwui9h0s9NJ49GLOCWIk1rLvu43rBewrKvN1Rx3
         3QlX5may9s8ulwlwduoU4WErLE9oxFvpXe+cnfdvXC6KlJd2Qq/Qnb4iD4KFSED036B8
         ZYP/1QbER/A3z5dFdyWzzO217AG1E73rDwfmVf0jX0tICUJudQgziG1Dvmy1N7lP0tER
         rxGzQxFZTUZFhir4J+MksA7FCTxtLrnvid4Dtemrq3V84pq5pRJfriGI13bU/+N85ab2
         zd2MYCgp6QLUVcBSYTfYlQqwfrVMDyYRF0l/2HsvpZEG5YSyAfKzsVpEwVa9HO8Fklgm
         C9kw==
X-Gm-Message-State: AOAM533AR+MAP4UX688/awT7r3Ueq699P5rr/TANlqEhPOeHJobtVXqR
        VwnzVP7wMeSbCdAdidLquSRIhdFNLMw=
X-Google-Smtp-Source: ABdhPJyrpCtK8cHXoSMMJ/MxhAo719bp5H0QQ0/xkhDbdQ4NN1QgDFSqZth8QyKYsFb0rEHyx4t7mA==
X-Received: by 2002:ac2:4f86:: with SMTP id z6mr6363470lfs.368.1608564055357;
        Mon, 21 Dec 2020 07:20:55 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c5sm2220085ljj.67.2020.12.21.07.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 07:20:54 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 19/32] diff-merges: group diff-merge flags next to each other inside 'rev_info'
Date:   Mon, 21 Dec 2020 18:19:47 +0300
Message-Id: <20201221152000.13134-20-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201221152000.13134-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201221152000.13134-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The relevant flags were somewhat scattered over definition of 'struct
rev_info'. Rearrange them to group them together.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 revision.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/revision.h b/revision.h
index fcc532c873d1..dcfa14454a55 100644
--- a/revision.h
+++ b/revision.h
@@ -191,13 +191,14 @@ struct rev_info {
 			match_missing:1,
 			no_commit_id:1,
 			verbose_header:1,
+			always_show_header:1,
+			/* Diff-merge flags */
 			explicit_diff_merges: 1,
 			separate_merges: 1,
 			combine_merges:1,
 			combined_all_paths:1,
 			dense_combined_merges:1,
-			first_parent_merges:1,
-			always_show_header:1;
+			first_parent_merges:1;
 
 	/* Format info */
 	int		show_notes;
-- 
2.25.1

