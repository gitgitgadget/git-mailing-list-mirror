Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0508AC433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF84764E4B
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbhBQTnt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 14:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbhBQTnr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 14:43:47 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584D9C061574
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:43:05 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id bl23so24343185ejb.5
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rIMywvCt53LfRvaUvSMGg5mVN+fTURQyl9c6wE6U9Co=;
        b=Hwhu8qClatz3MKbPJ1uLeozaWH/EylI53UB15oxEO0F0BTR+7PUQPITh/XFFB00okG
         cyhyYUetB00UP4tCTqzWMCnF7e4dkZ8WE47hKV8GY1GBAqvySxwy2EvQ/yr5jLPrY7Rk
         TPmJAc7XovsUjXWEJe43k1FJ+km/7lzNveY7/1T/CbKzglDJoPQQZt+XtclGK2PIS+eK
         T6BLrbW9zUaa8j6V5wkBlsOlHIG7BIdtfynsJUDS3/BxZmsRgKtW7c7aE4o8JIZq24u9
         nCgWNANQk+9LPcHgjeVNibKQKpNIcfKfmowGUsl2ICv85LtXhCDru5kzkV6+9GVbZqQF
         AqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rIMywvCt53LfRvaUvSMGg5mVN+fTURQyl9c6wE6U9Co=;
        b=pSk6Zjg/9NkMfZ03UTp2oEdqhoE+Mnl1sjISE7E0FyaRpsQ8QuvWzBgLmGC6iOTUkc
         wr7OkygHBE2INwZvLTweK/osY7U9AZI+80OILhJ5IukGgjvXt3SsZa7HgAdoXR5NFo+P
         lYdHMindzvUHcceeILWXrysDaK7pyyMYxlIsE0FURS9Vcr7ygSCEKYgVcOyUWcTj/CsD
         Q93bnIXMIYtf6JIoaHQzzVmvRJfOrHvVDySD8+b94X1rgPmxfkbmrQc/RxUWxUc79sn+
         PIsnw7ZwtgV0trMGwTuDcsJLvfwGpwvKpRA1qMl2VpAKpxAJWxn4JpEibd9WbUiKpEcU
         wFXg==
X-Gm-Message-State: AOAM5300NjcQV9qfIg7r6eLej0jv0Bm9CP2C/AzvJ4d+wXoZB+uchH44
        g18AkAJQu/lltLTkY9aDh5+LoABHBKUMlw==
X-Google-Smtp-Source: ABdhPJxcd463A4CNP2huzb2G0pYk90cXnzZb+CwnUY350gz7C7nH45q5AiqjVMVWURdSHrPbfytsxQ==
X-Received: by 2002:a17:907:98c3:: with SMTP id kd3mr536847ejc.482.1613590983504;
        Wed, 17 Feb 2021 11:43:03 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o10sm1479706eju.89.2021.02.17.11.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 11:43:03 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/14] fsck: API improvements
Date:   Wed, 17 Feb 2021 20:42:32 +0100
Message-Id: <20210217194246.25342-1-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87blcja2ha.fsf@evledraar.gmail.com>
References: <87blcja2ha.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan pointed out that the fsck error_func doesn't pass you the
ID of the fsck failure in [1]. This series improves the API so it
does, and moves the gitmodules_{found,done} variables into the
fsck_options struct.

The result is that instead of the "print_dangling_gitmodules" member
in that series we can just implement that with the diff at the end of
this cover letter (goes on top of a merge of this series & "seen"),
and without any changes to fsck_finish().

This conflicts with other in-flight fsck changes but the conflict is
rather trivial. Jeff King has another concurrent series to add a
couple of new fsck checks, those need to be moved to fsck.h, and
there's another trivial conflict in 2 hunks due to the
gitmodules_{found,done} move.

1. https://lore.kernel.org/git/87blcja2ha.fsf@evledraar.gmail.com/

Ævar Arnfjörð Bjarmason (14):
  fsck.h: indent arguments to of fsck_set_msg_type
  fsck.h: use use "enum object_type" instead of "int"
  fsck.c: rename variables in fsck_set_msg_type() for less confusion
  fsck.c: move definition of msg_id into append_msg_id()
  fsck.c: rename remaining fsck_msg_id "id" to "msg_id"
  fsck.h: move FSCK_{FATAL,INFO,ERROR,WARN,IGNORE} into an enum
  fsck.c: call parse_msg_type() early in fsck_set_msg_type()
  fsck.c: undefine temporary STR macro after use
  fsck.c: give "FOREACH_MSG_ID" a more specific name
  fsck.[ch]: move FOREACH_FSCK_MSG_ID & fsck_msg_id from *.c to *.h
  fsck.c: pass along the fsck_msg_id in the fsck_error callback
  fsck.c: add an fsck_set_msg_type() API that takes enums
  fsck.h: update FSCK_OPTIONS_* for object_name
  fsck.c: move gitmodules_{found,done} into fsck_options

 builtin/fsck.c           |   7 +-
 builtin/index-pack.c     |   3 +-
 builtin/mktag.c          |   7 +-
 builtin/unpack-objects.c |   3 +-
 fsck.c                   | 160 ++++++++++++---------------------------
 fsck.h                   |  98 +++++++++++++++++++++---
 6 files changed, 152 insertions(+), 126 deletions(-)

-- 

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 82f381f854..22dfcfc5de 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1713,6 +1713,20 @@ static void show_pack_info(int stat_only)
 	}
 }
 
+static int index_pack_fsck_error_func(struct fsck_options *o,
+				      const struct object_id *oid,
+				      enum object_type object_type,
+				      enum fsck_msg_type msg_type,
+				      enum fsck_msg_id msg_id,
+				      const char *message)
+{
+	if (msg_id == FSCK_MSG_GITMODULES_MISSING) {
+		puts(oid_to_hex(oid));
+		return 0;
+	}
+	return fsck_error_function(o, oid, object_type, msg_type, msg_id, message);
+}
+
 int cmd_index_pack(int argc, const char **argv, const char *prefix)
 {
 	int i, fix_thin_pack = 0, verify = 0, stat_only = 0, rev_index;
@@ -1934,10 +1948,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 		close(input_fd);
 
 	if (do_fsck_object) {
-		struct fsck_options fo = FSCK_OPTIONS_STRICT;
-
-		fo.print_dangling_gitmodules = 1;
-		if (fsck_finish(&fo))
+		fsck_options.error_func = index_pack_fsck_error_func;
+		if (fsck_finish(&fsck_options))
 			die(_("fsck error in pack objects"));
 	}
 
diff --git a/fetch-pack.c b/fetch-pack.c
index 0a337a04f1..9fc2ce86e4 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -40,6 +40,7 @@ static struct shallow_lock shallow_lock;
 static const char *alternate_shallow_file;
 static struct strbuf fsck_msg_types = STRBUF_INIT;
 static struct string_list uri_protocols = STRING_LIST_INIT_DUP;
+static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
 
 /* Remember to update object flag allocation in object.h */
 #define COMPLETE	(1U << 0)
@@ -993,19 +994,34 @@ static int cmp_ref_by_name(const void *a_, const void *b_)
 	return strcmp(a->name, b->name);
 }
 
+static int fetch_pack_fsck_error_func(struct fsck_options *o,
+				      const struct object_id *oid,
+				      enum object_type object_type,
+				      enum fsck_msg_type msg_type,
+				      enum fsck_msg_id msg_id,
+				      const char *message)
+{
+	if (msg_id == FSCK_MSG_GITMODULES_MISSING) {
+		puts(oid_to_hex(oid));
+		return 0;
+	}
+	return fsck_error_function(o, oid, object_type, msg_type, msg_id, message);
+}
+
 static void fsck_gitmodules_oids(struct oidset *gitmodules_oids)
 {
 	struct oidset_iter iter;
 	const struct object_id *oid;
-	struct fsck_options fo = FSCK_OPTIONS_STRICT;
 
 	if (!oidset_size(gitmodules_oids))
 		return;
 
 	oidset_iter_init(gitmodules_oids, &iter);
 	while ((oid = oidset_iter_next(&iter)))
-		register_found_gitmodules(oid);
-	if (fsck_finish(&fo))
+		oidset_insert(&fsck_options.gitmodules_found, oid);
+
+	fsck_options.error_func = fetch_pack_fsck_error_func;
+	if (fsck_finish(&fsck_options))
 		die("fsck failed");
 }
 
2.30.0.284.gd98b1dd5eaa7

