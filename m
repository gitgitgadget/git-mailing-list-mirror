Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2BCD1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 21:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbeJLErZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 00:47:25 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:51813 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeJLErZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 00:47:25 -0400
Received: by mail-pl1-f202.google.com with SMTP id d63-v6so7728149pld.18
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 14:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Uh53UNCboTiCuOX27IF+eo5LEhSR8CWc2x/1rp7lP7o=;
        b=pEHWNJH3akZbuPo1YY4frDRl6/yWRTzLZkMjULlngmms3j90VKhKI6dfg04kgmEajO
         ABFbW7mwL5vvNwJDGA3wBX0dIip9hGdC1HhcsZfLJ3z4Bth0BBqYxbVrruUjwJ/UndD8
         JMGwVbaxKCUN+dAoq5uZxf16vyVFUApPEsJna895pBYWS3+WbdTfymaAih00pgKTLman
         u1kt+trmWdSDp/ZjpyndHX1lNGUdeB7KeehBHGiUejmgEOB/od27G/askC1VwFwhBJpy
         Pa9mwEiXFruatHnMKxaZD6MoUR8EmC6sDrLThU/X4AkjAFiIxbXWQNWY0PFZNW2n4+NN
         Q6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Uh53UNCboTiCuOX27IF+eo5LEhSR8CWc2x/1rp7lP7o=;
        b=sSb8o4tO5BfwQ7p6KSEEMwYYt2XJkPoosc4IldUHWR/h+s7IL6B0GSOXKyUauCmTOB
         +m06YDuOdmXWcKhAzV6L+oSzzEX/cH6SwNVfe0ocHQrjbzFXNhJu0cp451hPebkm21sC
         CUBWVWwUD/5qtTtVq3yoawJbuRi3SwhmBxKcTsayGYKzDnZAmJjD7ElOiqBZB/4IMTAY
         IsAdytcIFocnHyDG6zsAv3NIt6s81iZnqF/C2x+oJu6170Ip6akL7N9+r5G4CYhlbxEx
         uUTdPIgVO/9uHz4fhTznMv1+yNR19kGrfSodwghcRgBqBD3wQrX/zzVqZw0eFqgSqRju
         8pfg==
X-Gm-Message-State: ABuFfoibUbmc8gsWmHE0N168DemNcLBWx3qSPBYQ2pcmVz8QNOK5y5Op
        QlLj4ioYxlJFhwbqsvVkPmUYR5wQzzY95Wv8lyrsViLUX7W+CeZWvQ5bxMiOJPebe4txK4vlTrz
        giVs99xGVuCVbiTwtEva4FgWV2MOGqBbFsTRdnHXRF/OJZAVB+SvgEWI2AA0f
X-Google-Smtp-Source: ACcGV61sUtK6EKk+3oyZG3HslK/4bdRcNldxDTqp4p7k1F5jkAh6p6H84GwOUorsKnD//7jusBikzuxJAVJ9
X-Received: by 2002:a63:1413:: with SMTP id u19-v6mr1648423pgl.80.1539292700941;
 Thu, 11 Oct 2018 14:18:20 -0700 (PDT)
Date:   Thu, 11 Oct 2018 14:17:45 -0700
In-Reply-To: <20181011211754.31369-1-sbeller@google.com>
Message-Id: <20181011211754.31369-11-sbeller@google.com>
Mime-Version: 1.0
References: <20181011211754.31369-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 10/19] commit: allow get_merge_bases_many_0 to handle
 arbitrary repositories
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
 commit.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/commit.c b/commit.c
index f8a8844a72..b36c2aa0bf 100644
--- a/commit.c
+++ b/commit.c
@@ -1055,7 +1055,8 @@ static int remove_redundant(struct repository *r, struct commit **array, int cnt
 	return filled;
 }
 
-static struct commit_list *get_merge_bases_many_0(struct commit *one,
+static struct commit_list *get_merge_bases_many_0(struct repository *r,
+						  struct commit *one,
 						  int n,
 						  struct commit **twos,
 						  int cleanup)
@@ -1065,7 +1066,7 @@ static struct commit_list *get_merge_bases_many_0(struct commit *one,
 	struct commit_list *result;
 	int cnt, i;
 
-	result = merge_bases_many(the_repository, one, n, twos);
+	result = merge_bases_many(r, one, n, twos);
 	for (i = 0; i < n; i++) {
 		if (one == twos[i])
 			return result;
@@ -1088,7 +1089,7 @@ static struct commit_list *get_merge_bases_many_0(struct commit *one,
 	clear_commit_marks(one, all_flags);
 	clear_commit_marks_many(n, twos, all_flags);
 
-	cnt = remove_redundant(the_repository, rslt, cnt);
+	cnt = remove_redundant(r, rslt, cnt);
 	result = NULL;
 	for (i = 0; i < cnt; i++)
 		commit_list_insert_by_date(rslt[i], &result);
@@ -1100,19 +1101,19 @@ struct commit_list *get_merge_bases_many(struct commit *one,
 					 int n,
 					 struct commit **twos)
 {
-	return get_merge_bases_many_0(one, n, twos, 1);
+	return get_merge_bases_many_0(the_repository, one, n, twos, 1);
 }
 
 struct commit_list *get_merge_bases_many_dirty(struct commit *one,
 					       int n,
 					       struct commit **twos)
 {
-	return get_merge_bases_many_0(one, n, twos, 0);
+	return get_merge_bases_many_0(the_repository, one, n, twos, 0);
 }
 
 struct commit_list *get_merge_bases(struct commit *one, struct commit *two)
 {
-	return get_merge_bases_many_0(one, 1, &two, 1);
+	return get_merge_bases_many_0(the_repository, one, 1, &two, 1);
 }
 
 /*
-- 
2.19.0

