Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44E831F516
	for <e@80x24.org>; Fri, 29 Jun 2018 01:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936474AbeF2BXF (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 21:23:05 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:53602 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936468AbeF2BW7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 21:22:59 -0400
Received: by mail-qt0-f202.google.com with SMTP id x16-v6so7667660qto.20
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 18:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=CZQaLsfnYyY+cyjVI7IgHBQdsrsSrQeJzstVK9zAMWk=;
        b=vYr1ncoxbpxXHWAAVBAYxiBst3xZb1S3ri6JZ0zL+dT3WWPz1x/Rptsx1kuChYmr44
         nUH0RsRVVfKunl/i2tGnS3SD4mfv768yZcPkU4ydde3NIoKhmHauFQZczxltRHYOSCtq
         uKmTLiXL5WFm321pzc5EHeAQl/UNh3iy6uqOYBCOE1zBItDyslZJJg1fzvwZeCU0/68c
         Wy4E/dfy5s5d3Zp4i7jEH9O1dm/GKxMhbvxKVZZWUW7M15SmTu7sEbuvwu/IJszcFk8n
         e9OOcDG+RvIhLFypff9gj3FACKiX9OT4JDD9YHstJr7p/JOwhtW0VhrTTtVQ5Oyh4m+U
         +P/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=CZQaLsfnYyY+cyjVI7IgHBQdsrsSrQeJzstVK9zAMWk=;
        b=toc1lNjE7vByaI0ebo9EoyHT2uFZLFEvBhcC8MhiXIZ0ek0++S54/z3R9vfCSIq3XW
         FMhEaJcpxWbiNxp6VWN760O9cdws4uJnaVHlAXmzYEPm8ydiN+i40tE1Z4Pe4nkkXP+7
         l/3DOJQwtQSmxe9uAn+CAvr0lUMkbrl9NSSTKEbrVtPkW14SwawgrUGaNnL3VBX2sNRy
         S2yiqg/DfpGEVLlQHAOBkV8vTcd5to0xlxfbe+h8yb53A/Bs8Drj04BajtoX4knZE8vA
         6dneTPZbYHE/UpFWadXeQ8lXq3aGR+SMGrl53WDeEbZUJQ1KjGwEeL8YF4ZsTM36a0+O
         Pjrw==
X-Gm-Message-State: APt69E1zOqv2wJjH06pfHSimQy4uOP0TnnfUMocJZOC53ksq1PYHk401
        ZfZ2gGGd1D8BpOzdXh8yLgklCKVbKzIMtAJscNz/G+foQ/oPtL2KNEu9vsvztAvsRp4Bgf15/Kr
        x+UJhhuyCN5rdvjILyN9mStW3UcZG+kOD1Maa5QC8gjjYSeZBafTySix87nPE
X-Google-Smtp-Source: AAOMgpebfqHBYf2V8siyb9m6k2Epmct31eAjJ4XfKfTxBe6IoKjdm36SsiLby0hzbszbjdICtyjSjWePJK7l
MIME-Version: 1.0
X-Received: by 2002:a0c:a101:: with SMTP id d1-v6mr6432688qva.5.1530235378145;
 Thu, 28 Jun 2018 18:22:58 -0700 (PDT)
Date:   Thu, 28 Jun 2018 18:22:01 -0700
In-Reply-To: <20180629012222.167426-1-sbeller@google.com>
Message-Id: <20180629012222.167426-12-sbeller@google.com>
References: <20180629012222.167426-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v3 11/32] commit: add repository argument to set_commit_buffer
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow callers of set_commit_buffer to
be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 blame.c  | 2 +-
 commit.c | 4 ++--
 commit.h | 3 ++-
 object.c | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/blame.c b/blame.c
index 8a0655a5997..cf102276bea 100644
--- a/blame.c
+++ b/blame.c
@@ -158,7 +158,7 @@ static void set_commit_buffer_from_strbuf(struct commit *c, struct strbuf *sb)
 {
 	size_t len;
 	void *buf = strbuf_detach(sb, &len);
-	set_commit_buffer(c, buf, len);
+	set_commit_buffer(the_repository, c, buf, len);
 }
 
 /*
diff --git a/commit.c b/commit.c
index 75d0bdede84..cdfb1a025b6 100644
--- a/commit.c
+++ b/commit.c
@@ -262,7 +262,7 @@ struct commit_buffer {
 define_commit_slab(buffer_slab, struct commit_buffer);
 static struct buffer_slab buffer_slab = COMMIT_SLAB_INIT(1, buffer_slab);
 
-void set_commit_buffer(struct commit *commit, void *buffer, unsigned long size)
+void set_commit_buffer_the_repository(struct commit *commit, void *buffer, unsigned long size)
 {
 	struct commit_buffer *v = buffer_slab_at(&buffer_slab, commit);
 	v->buffer = buffer;
@@ -450,7 +450,7 @@ int parse_commit_gently(struct commit *item, int quiet_on_missing)
 	}
 	ret = parse_commit_buffer(the_repository, item, buffer, size, 0);
 	if (save_commit_buffer && !ret) {
-		set_commit_buffer(item, buffer, size);
+		set_commit_buffer(the_repository, item, buffer, size);
 		return 0;
 	}
 	free(buffer);
diff --git a/commit.h b/commit.h
index f326c13622b..7c14dfdc54b 100644
--- a/commit.h
+++ b/commit.h
@@ -95,7 +95,8 @@ void parse_commit_or_die(struct commit *item);
  * Associate an object buffer with the commit. The ownership of the
  * memory is handed over to the commit, and must be free()-able.
  */
-void set_commit_buffer(struct commit *, void *buffer, unsigned long size);
+#define set_commit_buffer(r, c, b, s) set_commit_buffer_##r(c, b, s)
+void set_commit_buffer_the_repository(struct commit *, void *buffer, unsigned long size);
 
 /*
  * Get any cached object buffer associated with the commit. Returns NULL
diff --git a/object.c b/object.c
index 5494c0cbaa1..d1f77565af6 100644
--- a/object.c
+++ b/object.c
@@ -217,7 +217,7 @@ struct object *parse_object_buffer_the_repository(const struct object_id *oid, e
 			if (parse_commit_buffer(the_repository, commit, buffer, size, 1))
 				return NULL;
 			if (!get_cached_commit_buffer(commit, NULL)) {
-				set_commit_buffer(commit, buffer, size);
+				set_commit_buffer(the_repository, commit, buffer, size);
 				*eaten_p = 1;
 			}
 			obj = &commit->object;
-- 
2.18.0.399.gad0ab374a1-goog

