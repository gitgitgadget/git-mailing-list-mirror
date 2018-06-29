Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0967E1F516
	for <e@80x24.org>; Fri, 29 Jun 2018 01:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936469AbeF2BW6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 21:22:58 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:46723 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936441AbeF2BW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 21:22:56 -0400
Received: by mail-qk0-f201.google.com with SMTP id u19-v6so8009765qkl.13
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 18:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=XnL6tr2Mk+ecPbw+NDyOfRT5wdPDRrpzI5q3ZyNnCDY=;
        b=k9LotJuEn8PfJDre5Yg1qFwQc11n5Gh8Qb5WcWY/Xy7Axqs9hD2gpLYiiSqeDWT59J
         Qj6CJY2WnI+V/d4/1rICgoV953KYADFmmG0zfbUqa6a8VzjQbV/v5YxUIbZEwdcMWdl9
         Xy043jJcR9AEFQeY3SIisvSDuIRReY5czxG+KxGPusksaOpS7p91Pb8tAjwK7ePy0Txz
         Cak0++BtMkOeHlq+cJDS/DxrHatGJpZFwkwq/5ZKpYQ4KaRyl3uDcNz/hB69ZWEvm9FE
         VGadeaekhJK39Qt+KtyQaNbyBWEzS2ojJPLybNdwiiOWu3Od1DZU36UIbeuHaRnc7W4/
         /3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=XnL6tr2Mk+ecPbw+NDyOfRT5wdPDRrpzI5q3ZyNnCDY=;
        b=KDXR5a+J9nv5TsflFp9LJfWlyEeMGaQgMVKy9EGQrKwVTln0XSupyUanZlv90bzng0
         OKCluQWh9ceDPF+BQ2ME+rSPBoOfUREUQpf5AvW3U/q4ubZWzt7WQICGedzSyhxeQzJZ
         OPmy6VxIm5pvOdPKV+mB36kMNKEse8sN3PkCPhdj4vQRHkri7Et9Zd++tDuqS4bdux8g
         km2dKu6y8ZsxcHz7HxDGOfEG4vef3dxRQwVMp1zuyaWzMZnVNqjOyC0HsI3CcbwVvan/
         XNkWzofrI2ZqSKspV0tBsrx6jf7VwZmELrDngTAfekwLq9NHHiTsqv+/YOz5jAwvd5x/
         8yPw==
X-Gm-Message-State: APt69E0EUF7/6opivMJ4CbL37li5TZ92iCyKu6XgwN+JLR9VAIwMtxZW
        9T/JKUM091vSZsegPh/lWmLXMqX4k39sOlJLxAfJQiCz1ZyJcX2VLWDx+qckATUt1p6/2s2Fs46
        8qpmJ/i28ll7itikVR2Gg6e67gUoRpNeFMEhzs1Jz96kUZVwJSV+zGeOJExGZ
X-Google-Smtp-Source: AAOMgpeE5SY7FbGKSYz2+pkF/kZjCeE3dqQGpv/uw+Kz6JGuZi3QlSK2DPh8JwDLEvEM8ifTlRpG/x0FvjvG
MIME-Version: 1.0
X-Received: by 2002:a0c:c348:: with SMTP id j8-v6mr6666974qvi.55.1530235375752;
 Thu, 28 Jun 2018 18:22:55 -0700 (PDT)
Date:   Thu, 28 Jun 2018 18:22:00 -0700
In-Reply-To: <20180629012222.167426-1-sbeller@google.com>
Message-Id: <20180629012222.167426-11-sbeller@google.com>
References: <20180629012222.167426-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v3 10/32] commit: add repository argument to parse_commit_buffer
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the callers of parse_commit_buffer
to be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c    | 4 ++--
 commit.h    | 3 ++-
 object.c    | 2 +-
 sha1-file.c | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/commit.c b/commit.c
index 4803c8be1df..75d0bdede84 100644
--- a/commit.c
+++ b/commit.c
@@ -363,7 +363,7 @@ const void *detach_commit_buffer(struct commit *commit, unsigned long *sizep)
 	return ret;
 }
 
-int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long size, int check_graph)
+int parse_commit_buffer_the_repository(struct commit *item, const void *buffer, unsigned long size, int check_graph)
 {
 	const char *tail = buffer;
 	const char *bufptr = buffer;
@@ -448,7 +448,7 @@ int parse_commit_gently(struct commit *item, int quiet_on_missing)
 		return error("Object %s not a commit",
 			     oid_to_hex(&item->object.oid));
 	}
-	ret = parse_commit_buffer(item, buffer, size, 0);
+	ret = parse_commit_buffer(the_repository, item, buffer, size, 0);
 	if (save_commit_buffer && !ret) {
 		set_commit_buffer(item, buffer, size);
 		return 0;
diff --git a/commit.h b/commit.h
index cd80dab59c1..f326c13622b 100644
--- a/commit.h
+++ b/commit.h
@@ -82,7 +82,8 @@ struct commit *lookup_commit_reference_by_name(const char *name);
  */
 struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref_name);
 
-int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long size, int check_graph);
+#define parse_commit_buffer(r, i, b, s, g) parse_commit_buffer_##r(i, b, s, g)
+int parse_commit_buffer_the_repository(struct commit *item, const void *buffer, unsigned long size, int check_graph);
 int parse_commit_gently(struct commit *item, int quiet_on_missing);
 static inline int parse_commit(struct commit *item)
 {
diff --git a/object.c b/object.c
index 530c55e41e4..5494c0cbaa1 100644
--- a/object.c
+++ b/object.c
@@ -214,7 +214,7 @@ struct object *parse_object_buffer_the_repository(const struct object_id *oid, e
 	} else if (type == OBJ_COMMIT) {
 		struct commit *commit = lookup_commit(the_repository, oid);
 		if (commit) {
-			if (parse_commit_buffer(commit, buffer, size, 1))
+			if (parse_commit_buffer(the_repository, commit, buffer, size, 1))
 				return NULL;
 			if (!get_cached_commit_buffer(commit, NULL)) {
 				set_commit_buffer(commit, buffer, size);
diff --git a/sha1-file.c b/sha1-file.c
index de4839e634c..75ba30b4ab1 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1801,7 +1801,7 @@ static void check_commit(const void *buf, size_t size)
 {
 	struct commit c;
 	memset(&c, 0, sizeof(c));
-	if (parse_commit_buffer(&c, buf, size, 0))
+	if (parse_commit_buffer(the_repository, &c, buf, size, 0))
 		die("corrupt commit");
 }
 
-- 
2.18.0.399.gad0ab374a1-goog

