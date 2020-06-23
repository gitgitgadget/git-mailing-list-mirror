Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C86C433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 08:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A444E20716
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 08:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSzvrh2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731581AbgFWIR0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 04:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731158AbgFWIRZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 04:17:25 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69082C061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 01:17:25 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d66so9741636pfd.6
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 01:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YkMUPlh/6QyTnR4ERv0edwQgNw9INwJ36d9Hdafun2E=;
        b=kSzvrh2HLGTV2kNoioE8zTFSDLXyHSLdRTIeQTfQ0ZNZu/sWG35ffBr9Q6/sEHob9b
         2rHQjwidHL1beQRfxbcQB/+FiUrdQD6jJGGxDmmjFF+0VVhTsrHQULpuzie14HK5IXjx
         DMW/yX/xeIUk9xNHtYNPfCVSI5U6/y5o2xXpmjghjl6H7URMU2iDWRvZUJ3lFLXYEV+L
         c04Ysc7iCouzrhJQlY2tbNDFsDRQajWzGt+MZCDppg097YLThNVHxwRp0oLnIA4Tty4p
         OmYvIdybzBpltSx83QQrcQL6MIgysochRJqo3BCY+LrlMyGq4jGBo0356Xa7jejJ66ly
         Pr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YkMUPlh/6QyTnR4ERv0edwQgNw9INwJ36d9Hdafun2E=;
        b=RwA+E4Lj/kpjb4+N6I+2KsKXVs4xCOgE1KAFBa0FwhjBkWx0ubLN09+kPdpbIJdqY1
         BqE7/3jP4uTE3qV6yTidBxw+j7MOiEiYrtIWO0CO8ahieDlhJ3nRvaIT9Hs9ZyRYKsny
         XNKJ6yiQuDnmNRaYUQVeQ7ZCiyCf8TOg6OGe9xrWW5JLsTdCFoAZ5/ubLfmNX6HOgMbz
         g8aWocM8GAdYZZm+ckUkamFsHKXDWUummLnfJm3GyZKWHNN0FhAZObT1SXq0lBq8jm2h
         iKAeF5blL8A76SmANNBqTe1vdeb+p81NAPJG72soLABVojFnwuHiLCRPV2Od74UPO65l
         5dsA==
X-Gm-Message-State: AOAM532FuTfq+HykO5rXqCWMyoUHZtwh/GSy8tDsDyqm51reXy+31TAV
        +2rsEBQ3y8zKMcQy2VQhj8MAvEKf
X-Google-Smtp-Source: ABdhPJwIdf7sq9ZNQryIFelg98x4Bbi+EeUVLjdo7lZKmWFAQpgoAb7n58qSO5ti4YQWKYiPd82PKQ==
X-Received: by 2002:a63:1617:: with SMTP id w23mr16570651pgl.248.1592900244384;
        Tue, 23 Jun 2020 01:17:24 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id f18sm252768pgv.84.2020.06.23.01.17.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jun 2020 01:17:23 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] commit-reach: avoid is_dependant_of() shim
Date:   Tue, 23 Jun 2020 01:17:01 -0700
Message-Id: <20200623081701.52607-1-carenas@gmail.com>
X-Mailer: git-send-email 2.27.0.288.g4b34aa94c7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

d91d6fbf26 (commit-reach: create repo_is_descendant_of(), 2020-06-17)
adds a repository aware version of is_dependant_of() and a backward
compatibility shim that is barelly used.

Update all callers to directly use the new repo_is_dependant_of()
function instead.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 builtin/pull.c        |  3 ++-
 commit-reach.c        | 16 ++++++----------
 commit-reach.h        |  4 +++-
 t/helper/test-reach.c |  2 +-
 4 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 8e6572d305..babc6a4e36 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1025,7 +1025,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			commit_list_insert(head, &list);
 			merge_head = lookup_commit_reference(the_repository,
 							     &merge_heads.oid[0]);
-			if (is_descendant_of(merge_head, list)) {
+			if (repo_is_descendant_of(the_repository,
+							merge_head, list)) {
 				/* we can fast-forward this without invoking rebase */
 				opt_ff = "--ff-only";
 				ran_ff = 1;
diff --git a/commit-reach.c b/commit-reach.c
index 1761217663..82c73171dd 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -283,9 +283,9 @@ struct commit_list *repo_get_merge_bases(struct repository *r,
 /*
  * Is "commit" a descendant of one of the elements on the "with_commit" list?
  */
-static int repo_is_descendant_of(struct repository *r,
-				 struct commit *commit,
-				 struct commit_list *with_commit)
+int repo_is_descendant_of(struct repository *r,
+			  struct commit *commit,
+			  struct commit_list *with_commit)
 {
 	if (!with_commit)
 		return 1;
@@ -310,11 +310,6 @@ static int repo_is_descendant_of(struct repository *r,
 	}
 }
 
-int is_descendant_of(struct commit *commit, struct commit_list *with_commit)
-{
-	return repo_is_descendant_of(the_repository, commit, with_commit);
-}
-
 /*
  * Is "commit" an ancestor of one of the "references"?
  */
@@ -433,7 +428,8 @@ int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid)
 		return 0;
 
 	commit_list_insert(old_commit, &old_commit_list);
-	ret = is_descendant_of(new_commit, old_commit_list);
+	ret = repo_is_descendant_of(the_repository,
+					new_commit, old_commit_list);
 	free_commit_list(old_commit_list);
 	return ret;
 }
@@ -554,7 +550,7 @@ int commit_contains(struct ref_filter *filter, struct commit *commit,
 {
 	if (filter->with_commit_tag_algo)
 		return contains_tag_algo(commit, list, cache) == CONTAINS_YES;
-	return is_descendant_of(commit, list);
+	return repo_is_descendant_of(the_repository, commit, list);
 }
 
 static int compare_commits_by_gen(const void *_a, const void *_b)
diff --git a/commit-reach.h b/commit-reach.h
index 99a43e8b64..b49ad71a31 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -27,7 +27,9 @@ struct commit_list *repo_get_merge_bases_many_dirty(struct repository *r,
 
 struct commit_list *get_octopus_merge_bases(struct commit_list *in);
 
-int is_descendant_of(struct commit *commit, struct commit_list *with_commit);
+int repo_is_descendant_of(struct repository *r,
+			  struct commit *commit,
+			  struct commit_list *with_commit);
 int repo_in_merge_bases(struct repository *r,
 			struct commit *commit,
 			struct commit *reference);
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index a0272178b7..1d640f4757 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -108,7 +108,7 @@ int cmd__reach(int ac, const char **av)
 	else if (!strcmp(av[1], "in_merge_bases"))
 		printf("%s(A,B):%d\n", av[1], in_merge_bases(A, B));
 	else if (!strcmp(av[1], "is_descendant_of"))
-		printf("%s(A,X):%d\n", av[1], is_descendant_of(A, X));
+		printf("%s(A,X):%d\n", av[1], repo_is_descendant_of(r, A, X));
 	else if (!strcmp(av[1], "get_merge_bases_many")) {
 		struct commit_list *list = get_merge_bases_many(A, X_nr, X_array);
 		printf("%s(A,X):\n", av[1]);

base-commit: 4b34aa94c75220f6f4cd334b08a3fb053128a32d
-- 
2.27.0.288.g4b34aa94c7

