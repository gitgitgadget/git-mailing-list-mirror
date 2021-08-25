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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D75C432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 02:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ECDD61184
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 02:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237494AbhHYCXW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 22:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237542AbhHYCXU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 22:23:20 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0A9C0617A8
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 19:22:33 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id qe12-20020a17090b4f8c00b00179321cbae7so3698774pjb.2
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 19:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IdJsBBXPrKP6PQNZtIraFQqIN5D48duU1jn8S4lBxJk=;
        b=pEhhM75i+OfOG2Z1zIi6HWgVCu+sNdbUlQi+Bs5bBNV3lHmR7nTiwa5rT5SEHY0TgX
         siCOz8NRaJZLlN0j0fL0AeyragmfRHWzQKk4yZktWS8ci8YyZ4RXASpMcOUyWcX0i0J3
         wIBYkBBODZ1uo61oPBe1gzhPgKyeiWe7YQSjabK/1LGC5uB9UKBa4xMkIZs0na7wxvvR
         esBwJ3rpGFW4BU4nq7TYODX5+ytMVccFfL38JZxM2IDxAf9qA1KCwHOHsj9B5XrDWfIU
         9GMbYhvo19+Y7AhdG1Yky4yA9wA0MOcKSF6HmNbfmOoMnfvV5b6TSrnSJBG7KJP1rY86
         BLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IdJsBBXPrKP6PQNZtIraFQqIN5D48duU1jn8S4lBxJk=;
        b=QzKKw5F8gLhHao9gDSkGEorlS13/9V9lNq4/IK6swtPSz1WW6cY1frLwmvQlfAEg3h
         bqJYSin3eEKosOckYsqVCnzri155cmZv2RFu7sMrdQMUXpAK12qoXqbRzyivuBamOBKi
         BEboKaMV91Zm4FYMiFrEcpKN1S2Pcgjhnc8iAKtuO9l9w5PQVu5M+ewSBrlnd++4fSmP
         yGVUhb2SowQ3pdmEP/R87BGPJUDrCYrmPsFRrBPk/yVEG77j9YuyaCxbDatg5LjfiLZv
         h1Z00dlmEiAlce7z6fnO8GAgZy61+8ZwPWS11xxcjpIa+7zaml8N+oKrJHGH5gpdvBPw
         EGJw==
X-Gm-Message-State: AOAM532BQdxRKl1q0r/szgD9mLmAlxee0tvMUopyJ+IeKbrqFaoxxf4D
        XBb0POoEt7nrfnalTELJ2Kg=
X-Google-Smtp-Source: ABdhPJwmk4YIorLS6RZhQOuu2QYjmGuForKf7+vaWbIWxmKhBruuUNXu1OLSrj0fzWZWozGKV3M9iw==
X-Received: by 2002:a17:902:d2c3:b0:136:3916:c936 with SMTP id n3-20020a170902d2c300b001363916c936mr5889418plc.85.1629858153224;
        Tue, 24 Aug 2021 19:22:33 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.155])
        by smtp.gmail.com with ESMTPSA id e14sm3628683pjg.40.2021.08.24.19.22.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Aug 2021 19:22:32 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     gitster@pobox.com, dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, jonathantanmy@google.com
Subject: [PATCH v5 09/14] commit.h: add wrapped tags in commit struct
Date:   Wed, 25 Aug 2021 10:21:53 +0800
Message-Id: <011e5eaea3f48eeacac1614f769e8fd809e0c093.1629805396.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.456.gec51e24953
In-Reply-To: <cover.1629805395.git.dyroneteng@gmail.com>
References: <cover.1629805395.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 commit.h   | 5 +++++
 revision.c | 8 ++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/commit.h b/commit.h
index df42eb434f..1e99e9ae8a 100644
--- a/commit.h
+++ b/commit.h
@@ -38,6 +38,11 @@ struct commit {
 	 */
 	struct tree *maybe_tree;
 	unsigned int index;
+	/*
+	* wrapped tags or NULL.  If the commit is peeled from tag(s),
+	* then save the wraps, otherwise will be NULL.
+	*/
+	struct object_list *wraps;
 };
 
 extern int save_commit_buffer;
diff --git a/revision.c b/revision.c
index 65e0926d25..aecf493f46 100644
--- a/revision.c
+++ b/revision.c
@@ -416,14 +416,17 @@ static struct commit *handle_commit(struct rev_info *revs,
 	const char *path = entry->path;
 	unsigned int mode = entry->mode;
 	unsigned long flags = object->flags;
-
+	struct object_list *wraps = NULL;
 	/*
 	 * Tag object? Look what it points to..
 	 */
 	while (object->type == OBJ_TAG) {
 		struct tag *tag = (struct tag *) object;
-		if (revs->tag_objects && !(flags & UNINTERESTING))
+		if (revs->tag_objects && !(flags & UNINTERESTING)) {
+			object_list_insert(object, &wraps);
 			add_pending_object(revs, object, tag->tag);
+		}
+
 		object = parse_object(revs->repo, get_tagged_oid(tag));
 		if (!object) {
 			if (revs->ignore_missing_links || (flags & UNINTERESTING))
@@ -449,6 +452,7 @@ static struct commit *handle_commit(struct rev_info *revs,
 	 */
 	if (object->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *)object;
+		commit->wraps = wraps;
 
 		if (repo_parse_commit(revs->repo, commit) < 0)
 			die("unable to parse commit %s", name);
-- 
2.31.1.456.gec51e24953

