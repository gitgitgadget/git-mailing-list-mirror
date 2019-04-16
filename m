Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2E3520248
	for <e@80x24.org>; Tue, 16 Apr 2019 09:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbfDPJhL (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 05:37:11 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33053 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbfDPJhL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 05:37:11 -0400
Received: by mail-pg1-f196.google.com with SMTP id k19so10073829pgh.0
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 02:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UxZ+mfDQii/CnF+OrsFhfKo8Z0vssVnPPitcIe3MPKU=;
        b=u4i0TCiSAJr8AKX62lXwjNq+1jtn8ClCPqEabhVr/IbJRozrC8nHyma97CMsrP5aEr
         5PWGIKoMQMkAbkM/D2X9orzQfGt5/0yg2j257UOzTiRy9hjon6weiu67QNl9FNnLOtuh
         wQ5yV9eg1jwPg5jblo4wlmzRnD6ZWDg8PzPiO9SnWP/ySF6vhpZmWbNl/ZncGDrDG29/
         ymnKLdKRqNCPUiTqKSd2P0NayoUF8rwqRqVBOqZcxrTyz1tcqIIjsmqjpo05dycAdEWj
         MNNhPaChi3j5yrspCDCuJ18YC8UA5852ZiCSLwjHZvS9NJv/yARqjhbUIxFwBb0V9jJF
         hUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UxZ+mfDQii/CnF+OrsFhfKo8Z0vssVnPPitcIe3MPKU=;
        b=RTiR6mGGZVrAol8aYzf9D8EzygoAJp5p3Bpn8MOK9T01wfmkWZl8rpf/8wVwSB0UHE
         eqhm7r/nFbamf4oPyvhUnV3/M++dDXeQddKDle3HccVEG6Inf87Uts5bOd89bv0e2wp5
         nFbbznqZy/WyAPkPzXCg4k1ka2N7iIAIb1I1r1ZKy181EPI4igm0tY3HRblaK8prYOA3
         Svdl3YrFlkTp2hUToaM2uydq3PcHjWVZ912dapoCA3ktLNBycu0yewDNVy6mJ9HYfayn
         NlWLjFmkx7Z3ktqHM21MPEctwMiXkEw4SicH5BRu3k5pzUnuBmBhshuOyTH5DSJS9kSV
         XE9w==
X-Gm-Message-State: APjAAAU3AIrpZ4sR3p9IpTMr+Hyfv9ZIkxMPN5vdo7VaJ8CjzQUMavUy
        Z3+ShyYG4/kMnSek7+4gyNw=
X-Google-Smtp-Source: APXvYqxvW55eDwMdwA2bopCk8IbXsRPFTHvIA3io68zALtCcaop+Yfgos9IIeinUccRy9o56BXRvYw==
X-Received: by 2002:a62:1194:: with SMTP id 20mr679024pfr.224.1555407430716;
        Tue, 16 Apr 2019 02:37:10 -0700 (PDT)
Received: from ash ([116.106.33.3])
        by smtp.gmail.com with ESMTPSA id l74sm91374855pfi.174.2019.04.16.02.37.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 02:37:09 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 16 Apr 2019 16:37:05 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        stefanbeller@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v4 26/34] sha1-name.c: remove the_repo from handle_one_ref()
Date:   Tue, 16 Apr 2019 16:33:33 +0700
Message-Id: <20190416093341.17079-27-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <20190416093341.17079-1-pclouds@gmail.com>
References: <20190406113453.5149-1-pclouds@gmail.com>
 <20190416093341.17079-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1-name.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 5741a9f821..d9050776dd 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1189,15 +1189,21 @@ static enum get_oid_result get_oid_1(struct repository *r,
 /* Remember to update object flag allocation in object.h */
 #define ONELINE_SEEN (1u<<20)
 
+struct handle_one_ref_cb {
+	struct repository *repo;
+	struct commit_list **list;
+};
+
 static int handle_one_ref(const char *path, const struct object_id *oid,
 			  int flag, void *cb_data)
 {
-	struct commit_list **list = cb_data;
-	struct object *object = parse_object(the_repository, oid);
+	struct handle_one_ref_cb *cb = cb_data;
+	struct commit_list **list = cb->list;
+	struct object *object = parse_object(cb->repo, oid);
 	if (!object)
 		return 0;
 	if (object->type == OBJ_TAG) {
-		object = deref_tag(the_repository, object, path,
+		object = deref_tag(cb->repo, object, path,
 				   strlen(path));
 		if (!object)
 			return 0;
@@ -1760,10 +1766,13 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 		char *new_path = NULL;
 		int pos;
 		if (!only_to_die && namelen > 2 && name[1] == '/') {
+			struct handle_one_ref_cb cb;
 			struct commit_list *list = NULL;
 
-			for_each_ref(handle_one_ref, &list);
-			head_ref(handle_one_ref, &list);
+			cb.repo = repo;
+			cb.list = &list;
+			refs_for_each_ref(repo->refs, handle_one_ref, &cb);
+			refs_head_ref(repo->refs, handle_one_ref, &cb);
 			commit_list_sort_by_date(&list);
 			return get_oid_oneline(repo, name + 2, oid, list);
 		}
-- 
2.21.0.682.g30d2204636

