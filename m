Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB67C1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 21:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbeJLErV (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 00:47:21 -0400
Received: from mail-it1-f201.google.com ([209.85.166.201]:53805 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeJLErV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 00:47:21 -0400
Received: by mail-it1-f201.google.com with SMTP id f79-v6so10751141ita.3
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 14:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fHEBkMvfNkG1LKHhcqjHWe+nIt3HXD1NXOI5mSoxsRY=;
        b=P2EP8yQOIkUuf4H3mnURhqyrUbrwwOqN2E+hKM2/65450RZ6djzEBXIzm56uanXvYC
         u4F/vmstuDq19PesAbnO2b4zuBDmnBTZYe3N3HsI7KWXQVL9ZFQAn4XWFy8PTytcMntE
         rCDSOKR6hHGSbfkhnrxF6rSiFmqhqC48X+7x9EFtKB6U29W+f70eBZihsaF8lAHhJl8f
         Fl0K+SgEQyYrFA9XRoHtWoclsaj2/AQCboFir553N5VxALv42ID7+9ZCidz2pKBthx38
         FMCG72iKfXQtTF2CY18k15T/k66DxOigYbhf8QZmLflvmrMkMCaLeWGyqw/r+/T/1QTJ
         Cl/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fHEBkMvfNkG1LKHhcqjHWe+nIt3HXD1NXOI5mSoxsRY=;
        b=iaJ6V0hIAY6LBur32T9oWhz1FHV+cXD5ukvMKuwOamiRYRrP8AxweZlQlks3lrmBcG
         pDaQozToQU+0l2garzb/tMyDl1Cb/WT/8QkHM37k2T+SnFr7dAiTV/HqBoT8gbEiWwZX
         VjWlOjYskrJD4KsH1NS5ATKxp7MUAJy2eVdtwifceDpcRuGi8hM0w9gsEjxPZ5ccq6Fw
         ZNSgTQBv0fuihzVCzXP7U7JVfvzeBAH09r63AZzkH0XBjOzFyw1SjZlO8yVXwsQWvpBV
         1aw/4Ml1i4rrBoQqSsl9VpwLOES29MFLzG/O6XwDmAHXlVDt/V/WBPhtxLaoRIaVuKV+
         HNfg==
X-Gm-Message-State: ABuFfoiBhWLXKW00wKXWIwtGNVuGgQyywsnh9vLsp6FdvW+a1UmX6DuH
        H9/JHtaFxVugtN6JkWcNon5pxvIdgEBIKc4Gpmpq0X2MKNDMoE5NWymoUfsHK+Joj2NoX0kNdFp
        GF8uIuwzOH67B2D1UC2xuaEnwb0PBl/2WoqYztCltoSw0BRD8SWUuV89atGs2
X-Google-Smtp-Source: ACcGV60BdckSChMTYgTH8jwMrzacQya+dbN2ShF7gpo9khw+Q8TJv2xBiJ3gd4hSLMT1XpYQH0DndSlDOCgT
X-Received: by 2002:a24:2752:: with SMTP id g79-v6mr2820543ita.4.1539292696804;
 Thu, 11 Oct 2018 14:18:16 -0700 (PDT)
Date:   Thu, 11 Oct 2018 14:17:43 -0700
In-Reply-To: <20181011211754.31369-1-sbeller@google.com>
Message-Id: <20181011211754.31369-9-sbeller@google.com>
Mime-Version: 1.0
References: <20181011211754.31369-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 08/19] commit.c: allow merge_bases_many to handle arbitrary repositories
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
 commit.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/commit.c b/commit.c
index f493a82f72..5e8791f0c1 100644
--- a/commit.c
+++ b/commit.c
@@ -934,7 +934,9 @@ static struct commit_list *paint_down_to_common(struct repository *r,
 	return result;
 }
 
-static struct commit_list *merge_bases_many(struct commit *one, int n, struct commit **twos)
+static struct commit_list *merge_bases_many(struct repository *r,
+					    struct commit *one, int n,
+					    struct commit **twos)
 {
 	struct commit_list *list = NULL;
 	struct commit_list *result = NULL;
@@ -949,14 +951,14 @@ static struct commit_list *merge_bases_many(struct commit *one, int n, struct co
 			return commit_list_insert(one, &result);
 	}
 
-	if (parse_commit(one))
+	if (repo_parse_commit(r, one))
 		return NULL;
 	for (i = 0; i < n; i++) {
-		if (parse_commit(twos[i]))
+		if (repo_parse_commit(r, twos[i]))
 			return NULL;
 	}
 
-	list = paint_down_to_common(the_repository, one, n, twos, 0);
+	list = paint_down_to_common(r, one, n, twos, 0);
 
 	while (list) {
 		struct commit *commit = pop_commit(&list);
@@ -1063,7 +1065,7 @@ static struct commit_list *get_merge_bases_many_0(struct commit *one,
 	struct commit_list *result;
 	int cnt, i;
 
-	result = merge_bases_many(one, n, twos);
+	result = merge_bases_many(the_repository, one, n, twos);
 	for (i = 0; i < n; i++) {
 		if (one == twos[i])
 			return result;
-- 
2.19.0

