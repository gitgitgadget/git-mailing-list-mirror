Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C21761F403
	for <e@80x24.org>; Wed, 13 Jun 2018 23:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935937AbeFMXGH (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 19:06:07 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:37932 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935933AbeFMXGG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 19:06:06 -0400
Received: by mail-ua0-f202.google.com with SMTP id f18-v6so1352135ual.5
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 16:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=q53eTCT8kk21S4KqxfjB8eSi2rQYbvD7kFBIR3vKwkA=;
        b=QQe20ZxeRroSlbFtEt7aKjLwhXm2C6P4yxMOI5kKFF4GqC6d2h32f67FojCN68+HV+
         KchanYV82BughXVF1J62xq5DUotkjKhEPTdAMyvqgBmLHd7MJtsXNb3fXeTzTSbvmaeb
         FI9UMI4Te9vlDaxJoBq5uXt+TIAzZFQEwgMIyORct9qq5vbxPT6FsmRK+qSq7zo4yJzC
         phHo8aMBqeH1rlgWwTbFpewX7s5l7B4mIEF4O00Bc7Hv7zPVzKEIipguZrW3o265SFVZ
         P3VLf+bGOPvg/nwvDkJ+GmQrVAqwSuFUftqO+jQSfYTu3ZuD6L+Q6t33gLWWsEBLaYrL
         vM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=q53eTCT8kk21S4KqxfjB8eSi2rQYbvD7kFBIR3vKwkA=;
        b=HAQAHKS+I29YrRBbYGy0VLoRtumaUI4Es8TiQ4Rd0sHnlXUgBGuGV6+KtufoI+fzhl
         SSUjYfVFcy/QT74F53jUHQicqG6o53SoII4hrDbl0e9BjPkgbo0s17z3ls8Ra5J62h7U
         gYY1Wa6bFv/iX5XeBips2WdnPpqESPSJrUpS6r4hdu/R0XBl78jxlRB0UiY0eT3+/lSO
         hVQ2sE+oYLnmkCAUraT/XG3FH3jsd0xfJw3MUpt/k8fj1T47j9eVsQO34olX6qXAWwde
         cheH4HARWlztOEJ/uhiR4qnrzdNTorc66Jx1LDAaX4WgNy/O5flxiDXBIExQUk0B0WzE
         F0Lg==
X-Gm-Message-State: APt69E044Ji4rDZ1RAE0zNaW4x8DvfztzStWx5+3wshdizac+l52PsYc
        gCVD6mLuX14rkVUDidJs6ExZiWyTmDypDejsSW3Xkbvf9QKk2wtJvWga3nd7apmAVCfu+hvGHCL
        xX2vGXYQRWwaKOhofxAqQGgQoE1TH8tDW9407ZT/9C+y3xmQ7MWLjyMDa3iky
X-Google-Smtp-Source: ADUXVKIdBmOYexNCV/ryIYtQMpLlTKys4zp7Kl3Jorc+wTdAuWcuw8b9PNOd+6D+QEtacxUjGxVse2OOPu+c
MIME-Version: 1.0
X-Received: by 2002:ab0:1b2b:: with SMTP id d43-v6mr81337uai.56.1528931165172;
 Wed, 13 Jun 2018 16:06:05 -0700 (PDT)
Date:   Wed, 13 Jun 2018 16:05:04 -0700
In-Reply-To: <20180613230522.55335-1-sbeller@google.com>
Message-Id: <20180613230522.55335-14-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com> <20180613230522.55335-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v2 13/31] tag: add repository argument to parse_tag_buffer
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the callers of parse_tag_buffer
to be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/replace.c | 2 +-
 log-tree.c        | 2 +-
 object.c          | 2 +-
 sha1-file.c       | 2 +-
 tag.c             | 4 ++--
 tag.h             | 3 ++-
 6 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 8c8cec4aae6..bff1c3df964 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -362,7 +362,7 @@ static void check_one_mergetag(struct commit *commit,
 	tag = lookup_tag(the_repository, &tag_oid);
 	if (!tag)
 		die(_("bad mergetag in commit '%s'"), ref);
-	if (parse_tag_buffer(tag, extra->value, extra->len))
+	if (parse_tag_buffer(the_repository, tag, extra->value, extra->len))
 		die(_("malformed mergetag in commit '%s'"), ref);
 
 	/* iterate over new parents */
diff --git a/log-tree.c b/log-tree.c
index 727758eb442..ac42ad42acc 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -511,7 +511,7 @@ static void show_one_mergetag(struct commit *commit,
 		return; /* error message already given */
 
 	strbuf_init(&verify_message, 256);
-	if (parse_tag_buffer(tag, extra->value, extra->len))
+	if (parse_tag_buffer(the_repository, tag, extra->value, extra->len))
 		strbuf_addstr(&verify_message, "malformed mergetag\n");
 	else if (is_common_merge(commit) &&
 		 !oidcmp(&tag->tagged->oid,
diff --git a/object.c b/object.c
index 080e9b36eaf..c6779ee596f 100644
--- a/object.c
+++ b/object.c
@@ -225,7 +225,7 @@ struct object *parse_object_buffer_the_repository(const struct object_id *oid, e
 	} else if (type == OBJ_TAG) {
 		struct tag *tag = lookup_tag(the_repository, oid);
 		if (tag) {
-			if (parse_tag_buffer(tag, buffer, size))
+			if (parse_tag_buffer(the_repository, tag, buffer, size))
 			       return NULL;
 			obj = &tag->object;
 		}
diff --git a/sha1-file.c b/sha1-file.c
index 00b1b2b8660..3440b67639e 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1788,7 +1788,7 @@ static void check_tag(const void *buf, size_t size)
 {
 	struct tag t;
 	memset(&t, 0, sizeof(t));
-	if (parse_tag_buffer(&t, buf, size))
+	if (parse_tag_buffer(the_repository, &t, buf, size))
 		die("corrupt tag");
 }
 
diff --git a/tag.c b/tag.c
index 5b41fc71fad..4971fd4dfc9 100644
--- a/tag.c
+++ b/tag.c
@@ -126,7 +126,7 @@ void release_tag_memory(struct tag *t)
 	t->date = 0;
 }
 
-int parse_tag_buffer(struct tag *item, const void *data, unsigned long size)
+int parse_tag_buffer_the_repository(struct tag *item, const void *data, unsigned long size)
 {
 	struct object_id oid;
 	char type[20];
@@ -203,7 +203,7 @@ int parse_tag(struct tag *item)
 		return error("Object %s not a tag",
 			     oid_to_hex(&item->object.oid));
 	}
-	ret = parse_tag_buffer(item, data, size);
+	ret = parse_tag_buffer(the_repository, item, data, size);
 	free(data);
 	return ret;
 }
diff --git a/tag.h b/tag.h
index 276c448cd55..149959c81ba 100644
--- a/tag.h
+++ b/tag.h
@@ -13,7 +13,8 @@ struct tag {
 };
 #define lookup_tag(r, o) lookup_tag_##r(o)
 extern struct tag *lookup_tag_the_repository(const struct object_id *oid);
-extern int parse_tag_buffer(struct tag *item, const void *data, unsigned long size);
+#define parse_tag_buffer(r, i, d, s) parse_tag_buffer_##r(i, d, s)
+extern int parse_tag_buffer_the_repository(struct tag *item, const void *data, unsigned long size);
 extern int parse_tag(struct tag *item);
 extern void release_tag_memory(struct tag *t);
 extern struct object *deref_tag(struct object *, const char *, int);
-- 
2.18.0.rc1.244.gcf134e6275-goog

