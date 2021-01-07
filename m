Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54541C4332E
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 21:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21E9C235FF
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 21:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbhAGVhj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 16:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727694AbhAGVhh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 16:37:37 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BD1C061282
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 13:36:17 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id q18so7062625wrn.1
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 13:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HFooLETrm6cM084s80tGP8huAtkbI3KV88B3jfO86ys=;
        b=na4tZmFV8e3MRtUxI90KO/1Yh9gsKD93iSFniOYPuKXOG/qmT0CcbjCg5hxe/Ai26e
         NrlgyE67Q0ZY+2UPEz7qHCVutDWFLYJuSeiZ1A5n8jVUqhiMuQZU77wHjTTT6y2AeHzP
         NvQ2h2a2IQ64D0cteAhnd/e9M4lReQAZwkbHLA271GvGvOkOB01Ba4qvtGqNyDsS/KYp
         KkWNrfl9lfy2H4yjmfl0MyVC7MnPjvJRCTiyjyoGFS2c0E1VSyjKjqIspR4v3jnhb3wm
         3x8Kb2SJRVEEE7EBx0xQiOwV7mceaPkO4bojpMn52ka/4exsnhR9BbiVFaWL10wWZFEC
         2gRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HFooLETrm6cM084s80tGP8huAtkbI3KV88B3jfO86ys=;
        b=HSugy8P53neWeYBS88EDu8EMjLPw8Ht7B+mKCf6qhaoFlVR5N7M3Zoz/px6C4N2aIr
         IbnIlboXnJN28P1H8qqR/YHgNdbNpiJgMt3MW9Gog5CQvbLoZRihTpsCaU6Igkbzoi+6
         W0EZVrzLi9/DiHNWREvOJXSaCKpbBAMO3+cwPLG2+skyYog+Yx7qX5yVOq2nfvO8rVGo
         +nbDZvYooUVu0ZQuSufXYgXyergD2+EplJM9JSq7Lq+7cYAxnfb0+Nqu8cCH4Xgpo/uY
         hggRREyfM0cuWHbwbV0hEHPV1P4lD/lsw4phTDNv9PqRlHO1rUFp+25yOTovycNbVeBB
         SdPg==
X-Gm-Message-State: AOAM530TgSHk8r+Xzm0iRasaAvfXWjdvzUA3KOTd2Uc0zRvKMZEgtW5R
        TGQdd3S3izVQQOPtRD48+iM7yYCd1ig=
X-Google-Smtp-Source: ABdhPJz//97CkrsUacyC32hrxUK8Q88bAcpbda+B56tGihuLgwL8+WVY1vlABh2x7XN0V2iAwhLxog==
X-Received: by 2002:a5d:4ece:: with SMTP id s14mr499293wrv.427.1610055376215;
        Thu, 07 Jan 2021 13:36:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j10sm10208267wmj.7.2021.01.07.13.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 13:36:15 -0800 (PST)
Message-Id: <f6efa4350d621cd955965e13329f15f4d1b91bb4.1610055365.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
References: <pull.835.git.1610049687.gitgitgadget@gmail.com>
        <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 21:35:56 +0000
Subject: [PATCH v2 08/17] merge-ort: implement
 handle_directory_level_conflicts()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This is modelled on the version of handle_directory_level_conflicts()
from merge-recursive.c, but is massively simplified due to the following
factors:
  * strmap API provides simplifications over using direct hashamp
  * we have a dirs_removed field in struct rename_info that we have an
    easy way to populate from collect_merge_info(); this was already
    used in compute_rename_counts() and thus we do not need to check
    for condition #2.
  * The removal of condition #2 by handling it earlier in the code also
    obviates the need to check for condition #3 -- if both sides renamed
    a directory, meaning that the directory no longer exists on either
    side, then neither side could have added any new files to that
    directory, and thus there are no files whose locations we need to
    move due to such a directory rename.

In fact, the same logic that makes condition #3 irrelevant means
condition #1 is also irrelevant so we could drop this function.
However, it is cheap to check if both sides rename the same directory,
and doing so can save future computation.  So, simply remove any
directories that both sides renamed from the list of directory renames.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index a8fcc026031..feeb838231a 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -941,7 +941,23 @@ static void get_provisional_directory_renames(struct merge_options *opt,
 
 static void handle_directory_level_conflicts(struct merge_options *opt)
 {
-	die("Not yet implemented!");
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+	struct string_list duplicated = STRING_LIST_INIT_NODUP;
+	struct strmap *side1_dir_renames = &opt->priv->renames.dir_renames[1];
+	struct strmap *side2_dir_renames = &opt->priv->renames.dir_renames[2];
+	int i;
+
+	strmap_for_each_entry(side1_dir_renames, &iter, entry) {
+		if (strmap_contains(side2_dir_renames, entry->key))
+			string_list_append(&duplicated, entry->key);
+	}
+
+	for (i=0; i<duplicated.nr; ++i) {
+		strmap_remove(side1_dir_renames, duplicated.items[i].string, 0);
+		strmap_remove(side2_dir_renames, duplicated.items[i].string, 0);
+	}
+	string_list_clear(&duplicated, 0);
 }
 
 /*** Function Grouping: functions related to regular rename detection ***/
-- 
gitgitgadget

