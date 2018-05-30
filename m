Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BB281F42D
	for <e@80x24.org>; Wed, 30 May 2018 00:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968604AbeE3AuJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 20:50:09 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:45811 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968527AbeE3Asr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 20:48:47 -0400
Received: by mail-pg0-f54.google.com with SMTP id z1-v6so400048pgv.12
        for <git@vger.kernel.org>; Tue, 29 May 2018 17:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p9xI9SYapnTcdfJG5kd8njBtHjFytpZXssn/sU8PBjk=;
        b=QlV+zt6kqD1Xdn8hIE2h3YtL5sAvmQ2Hbf0u4hpUlqGSHOtlYwyP/1wDfqcB7udeLh
         UYZPtHh0EZ3omRTwqgwUOKhCn2grzoYVpr1fzR74BpbpYOQ4LDZXigTx8Y0YhlIX5w5c
         hsZe+Wcicr6OCEt/M0Gmo3odQa0UPzMU+l4AugxO8b8js88qq5Ki9SHrB27HVoufa2qQ
         2L//S/eRUQIghm+6xBDO3VaS2V5kjOXJ3xHEwrIh2uIE53DiiQPp1BSd7TVrcsHqpc9h
         ioDnLO9i0ZUiw8yV4PgjZ/qrjMFzTYiEQGd2g52Q+AIuOsH+1a6CrNSi+X9/eHezwFbj
         aBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p9xI9SYapnTcdfJG5kd8njBtHjFytpZXssn/sU8PBjk=;
        b=qxzmIJ/SA/dPY6gq3Yl053iSdeQjMwbwt8GtICHir8Ocm4wYQ2ZjWegf9FkoUIkb5/
         JgKtKrmnIK8Wh5jzF7QjbBoF3Kn2LkolyoY4zKs0QFqMK9WVRbIUKzDYLk2LbDmvSyvN
         DIbdCXW7DDCzDTdar13VpxgIrT3aZe8W5dAEP82h+vL4smZovSPx3/EJcM2exVyyvZo0
         fje9cu2kWhLJYmUjvULEEhy40xW3Ljus/n7mdOJTkvgRGw00hyMGyb4+tkFuymHBBRIq
         XsWf/0uxRX4sGnng0oI4in2JOlnI2tg4Qqtxib03sNpP6Ey9D414L2MLzOSym0TEPew2
         EeHw==
X-Gm-Message-State: ALKqPwdwxmtmAdXDMQCiYaWDSGfuXZmZj0pyOvq7zNCwqS05GtuJVEdh
        AiWZ4OmPXx01YycwFf4CtBEWDSkEz2I=
X-Google-Smtp-Source: ADUXVKLCKi6wgxzp9TLp95MueoM0YMoUnoyBeJjhS7GBOa7abIW+OB4LtYnqOiuYoY6M/Oakc/XFBQ==
X-Received: by 2002:a62:fd12:: with SMTP id p18-v6mr611264pfh.152.1527641326564;
        Tue, 29 May 2018 17:48:46 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id c27-v6sm17319091pfl.63.2018.05.29.17.48.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 17:48:45 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 17/35] object: add repository argument to parse_commit_gently
Date:   Tue, 29 May 2018 17:47:52 -0700
Message-Id: <20180530004810.30076-18-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180530004810.30076-1-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow callers of parse_commit_gently to
be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

The included coccinelle semantic patch will adapt any new callers in
the diff produced by `make coccicheck`.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c   | 2 +-
 commit.h   | 5 +++--
 revision.c | 4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/commit.c b/commit.c
index ede31c46931..dcb32561275 100644
--- a/commit.c
+++ b/commit.c
@@ -394,7 +394,7 @@ int parse_commit_buffer_the_repository(struct commit *item, const void *buffer,
 	return 0;
 }
 
-int parse_commit_gently(struct commit *item, int quiet_on_missing)
+int parse_commit_gently_the_repository(struct commit *item, int quiet_on_missing)
 {
 	enum object_type type;
 	void *buffer;
diff --git a/commit.h b/commit.h
index 66eb576897f..b1198ec2b77 100644
--- a/commit.h
+++ b/commit.h
@@ -74,10 +74,11 @@ struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref
 
 #define parse_commit_buffer(r, i, b, s) parse_commit_buffer_##r(i, b, s)
 int parse_commit_buffer_the_repository(struct commit *item, const void *buffer, unsigned long size);
-int parse_commit_gently(struct commit *item, int quiet_on_missing);
+#define parse_commit_gently(r, i, q) parse_commit_gently_##r(i, q)
+int parse_commit_gently_the_repository(struct commit *item, int quiet_on_missing);
 static inline int parse_commit(struct commit *item)
 {
-	return parse_commit_gently(item, 0);
+	return parse_commit_gently(the_repository, item, 0);
 }
 void parse_commit_or_die(struct commit *item);
 
diff --git a/revision.c b/revision.c
index 25df00cc16c..33506faabda 100644
--- a/revision.c
+++ b/revision.c
@@ -785,7 +785,7 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit,
 			parent = parent->next;
 			if (p)
 				p->object.flags |= UNINTERESTING;
-			if (parse_commit_gently(p, 1) < 0)
+			if (parse_commit_gently(the_repository, p, 1) < 0)
 				continue;
 			if (p->parents)
 				mark_parents_uninteresting(p);
@@ -813,7 +813,7 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit,
 		struct commit *p = parent->item;
 		int gently = revs->ignore_missing_links ||
 			     revs->exclude_promisor_objects;
-		if (parse_commit_gently(p, gently) < 0) {
+		if (parse_commit_gently(the_repository, p, gently) < 0) {
 			if (revs->exclude_promisor_objects &&
 			    is_promisor_object(&p->object.oid)) {
 				if (revs->first_parent_only)
-- 
2.17.0.582.gccdcbd54c44.dirty

