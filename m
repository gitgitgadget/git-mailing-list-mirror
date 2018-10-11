Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 071731F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 21:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbeJLErY (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 00:47:24 -0400
Received: from mail-it1-f201.google.com ([209.85.166.201]:54939 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeJLErX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 00:47:23 -0400
Received: by mail-it1-f201.google.com with SMTP id v13-v6so10754786itc.4
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 14:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=t479P2RXlsIOLR/pHltHu7p4oqKg24wEF8UxWF3OPSQ=;
        b=dw1LCw7X5j3I2TuscMeIDF4wgiDZ16TV0gajr7+nGFnhvwJjGLfugq8UNRyOJJbE2y
         lUgUR/2lkXWHycp8zrPY8RHJv1JeibjmRoEXHqt+iMRd2CT4fqqSGhie4C8+e0IiA+8f
         YpNGdZTTIJ40rmAh0llKcXXKpQ4zfaVCeiWYrsd9ZufZd7EU7s8Adon+kkG8W/SGhAHd
         GDNi9nXoCHfd4bGHjMt28izMEc/CKDr4fhny992wr8+rEsw5fS7OP674geOHW1k/hnza
         JoMXWxhnHFw8zbyxwZj7fs/F4EgQG5iMCp7UN9APsqqXz9y3nByHeqHCNwGGgPPaqtZR
         YGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=t479P2RXlsIOLR/pHltHu7p4oqKg24wEF8UxWF3OPSQ=;
        b=WAGWHecMF/KDMxXpmSt8/ZYFzrmoEU4idpktconDANIf2RiNHlKYo6qfZdk9ZQzqpU
         VtBSNI+jfilmDgLkbKqxRvEOeRhhYa6P6PaZxKCzGMnWdkdEGR3xzyWijy7q3HoH6s5f
         oaMdtfmf/Y8hdHkZe5k+zXk/i3MglQRoZr4W0jIFcmo22iny8o4QSdygRcwTHk2I45Ak
         8cGpvSrq9bCETfqqWs0anhUqa7DatlRn5qc2WlYO4v/SeqyhQmVXXRLjW0pxHCb/Z0Ha
         F4xS8X/AjuHrtszqGIw9uf6qvcV1EnNghVdvjn4bAHqD9Cb7rifYFK8pBIdWgLzKJhGC
         EhCg==
X-Gm-Message-State: ABuFfogv9X2vqdGAIy0jUGSTyOQfVVyGsmL7MIxDP0Mix+hENZphRqaK
        6KCJk/prVV61LwXcOlu/L+0gk+gFydutbcQcQk/u62K9hNNVCYTo4BNsS4zLXanlFNDPbJeiX5J
        TvuIWReQo8WVds9GbnrmeCoJA1EyRhBjOJWAm2ME3UG9nJBSHWITOdP4pcCno
X-Google-Smtp-Source: ACcGV61t0jgV58cjQTH6yX23fL+l6s0EeVAxNLn9TRMZbH7nBTZYZiVEsQ/qzvdlrwang5xHQDwVpfijKb2n
X-Received: by 2002:a24:be05:: with SMTP id i5-v6mr2998848itf.17.1539292699100;
 Thu, 11 Oct 2018 14:18:19 -0700 (PDT)
Date:   Thu, 11 Oct 2018 14:17:44 -0700
In-Reply-To: <20181011211754.31369-1-sbeller@google.com>
Message-Id: <20181011211754.31369-10-sbeller@google.com>
Mime-Version: 1.0
References: <20181011211754.31369-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 09/19] commit.c: allow remove_redundant to handle arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/commit.c b/commit.c
index 5e8791f0c1..f8a8844a72 100644
--- a/commit.c
+++ b/commit.c
@@ -995,7 +995,7 @@ struct commit_list *get_octopus_merge_bases(struct commit_list *in)
 	return ret;
 }
 
-static int remove_redundant(struct commit **array, int cnt)
+static int remove_redundant(struct repository *r, struct commit **array, int cnt)
 {
 	/*
 	 * Some commit in the array may be an ancestor of
@@ -1013,7 +1013,7 @@ static int remove_redundant(struct commit **array, int cnt)
 	ALLOC_ARRAY(filled_index, cnt - 1);
 
 	for (i = 0; i < cnt; i++)
-		parse_commit(array[i]);
+		repo_parse_commit(r, array[i]);
 	for (i = 0; i < cnt; i++) {
 		struct commit_list *common;
 		uint32_t min_generation = array[i]->generation;
@@ -1029,7 +1029,7 @@ static int remove_redundant(struct commit **array, int cnt)
 			if (array[j]->generation < min_generation)
 				min_generation = array[j]->generation;
 		}
-		common = paint_down_to_common(the_repository, array[i], filled,
+		common = paint_down_to_common(r, array[i], filled,
 					      work, min_generation);
 		if (array[i]->object.flags & PARENT2)
 			redundant[i] = 1;
@@ -1088,7 +1088,7 @@ static struct commit_list *get_merge_bases_many_0(struct commit *one,
 	clear_commit_marks(one, all_flags);
 	clear_commit_marks_many(n, twos, all_flags);
 
-	cnt = remove_redundant(rslt, cnt);
+	cnt = remove_redundant(the_repository, rslt, cnt);
 	result = NULL;
 	for (i = 0; i < cnt; i++)
 		commit_list_insert_by_date(rslt[i], &result);
@@ -1199,7 +1199,7 @@ struct commit_list *reduce_heads(struct commit_list *heads)
 			p->item->object.flags &= ~STALE;
 		}
 	}
-	num_head = remove_redundant(array, num_head);
+	num_head = remove_redundant(the_repository, array, num_head);
 	for (i = 0; i < num_head; i++)
 		tail = &commit_list_insert(array[i], tail)->next;
 	free(array);
-- 
2.19.0

