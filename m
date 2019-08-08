Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 118AA1F731
	for <e@80x24.org>; Thu,  8 Aug 2019 04:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725785AbfHHEAG (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 00:00:06 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36850 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbfHHEAG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 00:00:06 -0400
Received: by mail-pg1-f195.google.com with SMTP id l21so43288379pgm.3
        for <git@vger.kernel.org>; Wed, 07 Aug 2019 21:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pskyr1MMFDOvkPuomurGXBXnuoW8uU7eb/9da0naitw=;
        b=KzlK+ofVIQnFHtPdaFI8RW1T0tqK7x4QwRydYrDxpLCvZiRNVjqrlVx9LsZ2eQh4oq
         zDmEL7bTWvlxl3O7Evalg/++HJSH8o3f/UU86tyIWKWYZynMfPyHzcLKshikN6HdQPQ0
         x2Ri3wyyTD4k+dPICd729vqGq8b1o4ohVz8iXzSShERpcBt7+NzsuAVjFiU8Dmok1lzE
         lcbpd9bJ69zOTKd0+g72cC2BqeUJfXozy0OHtdk06C1NR72dfL8mXjT0kLxL0iuFcFhS
         u42PmhC+ErxwMEHYoyqponOEInB478VtIecORqflw4UxbRsLwb5o55+DzyT1j2vHEd4S
         MJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pskyr1MMFDOvkPuomurGXBXnuoW8uU7eb/9da0naitw=;
        b=ayxiakkTq+Ddv3B1RNmbOM+0gCwx5b2mk8QxtxytCanmitVTtKEij+MFFgNIGbZwQs
         l4358NK8sEhwGX/LrnWkt+SQQvr3f6bScPeLhb8u43eQKc8RPeQ+TCdmsLV03d5lYXxM
         OcC6kzXr8+V2ZNkzQEbgpYsj5xwu4XnBoBmaJVeg32v1Y0fyraRdSsiko3NtK8WbS+Pj
         5GMKMBIsMg0AK7NIWEmhBmHBNrK0Zl2GFylN3+blrTD2qDtsnrE0+ro8eZARhdWYZoZr
         uRXAa8hriK/y92DyvAyzgSuB2YX4wR1YvmfwI5HM2NDyOGgQ3sP+Ug92Iq+4EblssHIn
         oLrQ==
X-Gm-Message-State: APjAAAXX+N3kq0sLEKAtbR8egepmhr6Zvw9kP5sUgOaLjcCJlCbzcedm
        qqU91p5pAdR5j3+B6gBI1F9O/9+y
X-Google-Smtp-Source: APXvYqz5vgVYCOwG4XZpsrfNEeMPkpPV3Z98vQIzgZVdkTYeZxsHAt21jH49KAMWB/nYoAReiBXhWQ==
X-Received: by 2002:a63:e70f:: with SMTP id b15mr10809813pgi.152.1565236804801;
        Wed, 07 Aug 2019 21:00:04 -0700 (PDT)
Received: from phord-x1.purestorage.com ([64.84.68.252])
        by smtp.gmail.com with ESMTPSA id 125sm128851352pfg.23.2019.08.07.21.00.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 21:00:03 -0700 (PDT)
From:   Phil Hord <phil.hord@gmail.com>
X-Google-Original-From: Phil Hord
To:     git@vger.kernel.org
Cc:     Phil Hord <phil.hord@gmail.com>
Subject: [PATCH 1/1] delete multiple tags in a single transaction
Date:   Wed,  7 Aug 2019 20:59:35 -0700
Message-Id: <20190808035935.30023-1-phil.hord@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1.174.g4cc1b04b4c.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phil Hord <phil.hord@gmail.com>

'git tag -d' accepts one or more tag refs to delete, but each deletion
is done by calling `delete_ref` on each argv. This is painfully slow
when removing from packed refs. Use delete_refs instead so all the
removals can be done inside a single transaction with a single write.

I have a repo with 24,000 tags, most of which are not useful to any
developers. Having this many refs slows down many operations that
would otherwise be very fast. Removing these tags when they've been
accidentally fetched again takes about 30 minutes using delete_ref.

    git tag -l feature/* | xargs git tag -d

Removing the same tags using delete_refs takes less than 5 seconds.

Signed-off-by: Phil Hord <phil.hord@gmail.com>
---
 builtin/tag.c | 52 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 10 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index e0a4c25382..f652af83e7 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -72,10 +72,10 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting,
 }
 
 typedef int (*each_tag_name_fn)(const char *name, const char *ref,
-				const struct object_id *oid, const void *cb_data);
+				const struct object_id *oid, void *cb_data);
 
 static int for_each_tag_name(const char **argv, each_tag_name_fn fn,
-			     const void *cb_data)
+			     void *cb_data)
 {
 	const char **p;
 	struct strbuf ref = STRBUF_INIT;
@@ -97,18 +97,50 @@ static int for_each_tag_name(const char **argv, each_tag_name_fn fn,
 	return had_error;
 }
 
-static int delete_tag(const char *name, const char *ref,
-		      const struct object_id *oid, const void *cb_data)
+struct tag_args {
+	char *oid_abbrev;
+	char *refname;
+};
+
+static int make_string_list(const char *name, const char *ref,
+			    const struct object_id *oid, void *cb_data)
 {
-	if (delete_ref(NULL, ref, oid, 0))
-		return 1;
-	printf(_("Deleted tag '%s' (was %s)\n"), name,
-	       find_unique_abbrev(oid, DEFAULT_ABBREV));
+	struct string_list *ref_list = cb_data;
+	struct tag_args *info = xmalloc(sizeof(struct tag_args));
+
+	string_list_append(ref_list, ref);
+
+	info->oid_abbrev = xstrdup(find_unique_abbrev(oid, DEFAULT_ABBREV));
+	info->refname = xstrdup(name);
+	ref_list->items[ref_list->nr - 1].util = info;
 	return 0;
 }
 
+static int delete_tags(const char **argv)
+{
+	int result;
+	struct string_list ref_list = STRING_LIST_INIT_DUP;
+	struct string_list_item *ref_list_item;
+
+	result = for_each_tag_name(argv, make_string_list, (void *) &ref_list);
+	if (!result)
+		result = delete_refs(NULL, &ref_list, REF_NO_DEREF);
+
+	for_each_string_list_item(ref_list_item, &ref_list) {
+		struct tag_args * info = ref_list_item->util;
+		if (!result)
+			printf(_("Deleted tag '%s' (was %s)\n"), info->refname,
+				info->oid_abbrev);
+		free(info->oid_abbrev);
+		free(info->refname);
+		free(info);
+	}
+	string_list_clear(&ref_list, 0);
+	return result;
+}
+
 static int verify_tag(const char *name, const char *ref,
-		      const struct object_id *oid, const void *cb_data)
+		      const struct object_id *oid, void *cb_data)
 {
 	int flags;
 	const struct ref_format *format = cb_data;
@@ -511,7 +543,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (filter.merge_commit)
 		die(_("--merged and --no-merged options are only allowed in list mode"));
 	if (cmdmode == 'd')
-		return for_each_tag_name(argv, delete_tag, NULL);
+		return delete_tags(argv);
 	if (cmdmode == 'v') {
 		if (format.format && verify_ref_format(&format))
 			usage_with_options(git_tag_usage, options);
-- 
2.23.0.rc1.174.g4cc1b04b4c.dirty

