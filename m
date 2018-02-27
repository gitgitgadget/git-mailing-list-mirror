Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2DBD1F404
	for <e@80x24.org>; Tue, 27 Feb 2018 21:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751851AbeB0Vaz (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 16:30:55 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43864 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751839AbeB0Vaw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 16:30:52 -0500
Received: by mail-wr0-f193.google.com with SMTP id u49so258182wrc.10
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 13:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sf/0JRipMIvQtGg+TlUaVLiKDUPNiuju8T5nMs/Q+vs=;
        b=YCFt5Rw5RdlPq4J1q+hGTn6Bx6hr8Z1vau7TsSWkRsxmXmQeM8usHCIaHV7Y060KUE
         y/IKp2Xu/K1RPHApeqP36P3IHp9VRDrxLoGUuESlv8sc2a1PKZMFH3MKus03GK/3LWQs
         CLoG2eC0G6GEdadujBBoQW3VHrfbjTnML8yKNL6NYlZEHkjxAn0oP6ZBQL+TeeWgT1aK
         kvblwSt1/lVexmCrREO5tTukmy3fHFN4kubWmwEkt2/OkYCn++0TGfCGzBzamcbii+bM
         sIE/8XZIpiGfgxXhrmOx+DgT92kkpf1o9YZnE14G720BnEjS5Dz/uzek+03a5+yo63Q2
         R12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sf/0JRipMIvQtGg+TlUaVLiKDUPNiuju8T5nMs/Q+vs=;
        b=P4fMnJj/nXV6AQuv24F6viz7GQLDDSEnAa/tp+hODlY54v/JbgKn6FVa48IeZxNEY6
         LNJzsi7kt6eLxDyIzY4hQMBoyE1oWIWrJMz01ZvsNX9lVvu7m2wB055XvOGi+O7cACCB
         UEjmTrKsBfzPByq+KV8wo4EK6VHTW4eCp0T8uTo/2mY7USeCBGxxMt2OUYVEmqsYZtKx
         vFdrT0Np0Pc+UNfl8LlCeFl0u2/BY2+f3estRTetdYdCOhFlcvk0Y9hO84eLf/UESC3f
         QBWlEolxlKBiPblc5ZKShzCH+3/lmpQfBoWxHRyOXX3ZJ7fjXKRlguXGiZZmV7LFuX1g
         6h9A==
X-Gm-Message-State: APf1xPDZ3onsfdLRK7OBC5SuN/B/QfRKqbfQ+1jslLdkzLO9Ta5W8xSC
        28ereRhelHjZ9XeMPV7w9sEpPofq
X-Google-Smtp-Source: AH8x2271VBfaq4p6DoJroopl2lwQO3AD8b8h74Vl0muwwDqURem4pCqI9siMxZTE0FC9XzAffBM/1Q==
X-Received: by 10.223.192.76 with SMTP id c12mr13359370wrf.177.1519767051305;
        Tue, 27 Feb 2018 13:30:51 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id t91sm126888wrc.21.2018.02.27.13.30.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Feb 2018 13:30:50 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 4/5] merge: always roll back lock in `checkout_fast_forward()`
Date:   Tue, 27 Feb 2018 22:30:12 +0100
Message-Id: <8d2a1da0ad699c885b6ef335633c038ab7e354c4.1519763396.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.16.2.246.ga4ee44448f
In-Reply-To: <cover.1519763396.git.martin.agren@gmail.com>
References: <cover.1519763396.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function originated in builtin/merge.c. It was moved to merge.c in
commit db699a8a1f (Move try_merge_command and checkout_fast_forward to
libgit.a, 2012-10-26), but was used from sequencer.c even before that.

If a problem occurs, the function returns without rolling back the
lockfile. Teach it to do so.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 merge.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/merge.c b/merge.c
index 195b578700..f06a4773d4 100644
--- a/merge.c
+++ b/merge.c
@@ -113,17 +113,23 @@ int checkout_fast_forward(const struct object_id *head,
 	setup_unpack_trees_porcelain(&opts, "merge");
 
 	trees[nr_trees] = parse_tree_indirect(head);
-	if (!trees[nr_trees++])
+	if (!trees[nr_trees++]) {
+		rollback_lock_file(&lock_file);
 		return -1;
+	}
 	trees[nr_trees] = parse_tree_indirect(remote);
-	if (!trees[nr_trees++])
+	if (!trees[nr_trees++]) {
+		rollback_lock_file(&lock_file);
 		return -1;
+	}
 	for (i = 0; i < nr_trees; i++) {
 		parse_tree(trees[i]);
 		init_tree_desc(t+i, trees[i]->buffer, trees[i]->size);
 	}
-	if (unpack_trees(nr_trees, t, &opts))
+	if (unpack_trees(nr_trees, t, &opts)) {
+		rollback_lock_file(&lock_file);
 		return -1;
+	}
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		return error(_("unable to write new index file"));
 	return 0;
-- 
2.16.2.246.ga4ee44448f

