Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61C562018E
	for <e@80x24.org>; Tue,  9 Aug 2016 04:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbcHIEIj (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 00:08:39 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35708 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbcHIEIg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 00:08:36 -0400
Received: by mail-pa0-f48.google.com with SMTP id iw10so1186806pac.2
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 21:08:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fyc4qgyfAwm3fpvy56EoEgfFj5WKzfNj+JkikMmR/2w=;
        b=VFbsusCfF5MXdQEoCg2Qh6zoQOgs0HewPGBMEiIIYPTzZvlrOMTLswjJ+8me76TD6i
         Z2PfF+BObPFIHcSlGoxA76Twl8/yxN99zTzwCVNUWhPkOg4mKW54FJ7hWzVXnDYaDRI2
         l6eE/SECEhVvWa8x2vhnCXiHHxMrOeczG0yva3MupcKOstsK6tgsqM/2t/eashznpjml
         TWegxalM3SDpGCvKS5I4fl4IFTwwK0vXcFYR7m+uz9qmkTCKstuqfitzfFvX5ABMhEiX
         GUNaY0Rlj3nVdJ+VA120vY0C8DC0U7/kMcPA5684vCDyzHdo3+ALpKPaTIzuOFcdcdlT
         74Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fyc4qgyfAwm3fpvy56EoEgfFj5WKzfNj+JkikMmR/2w=;
        b=iQZ2r0C3Ehrz5XX2Y0A0S0JbqxzV5AWApRn5jBFEABzPw1QlCmp4O4Jt8GYseE2gDV
         7NtDguXgZNkr9IA51xmJ1dJQaVBV50TaWFhcQmB104g3ciQ96lc6EB/RI7nYQzQd35aI
         dJjMhgehXdIwtFc0MwbLm3K2MWb5ETGGrBjUSZwonAJX2Lg3+LsB0w4A0CWVMw6t7TwG
         DquS7kA5gW1BJ9Is7sg8z8KksLTGW/BGng+jVAKym6e7+PbEWzhJOdKf6CZCv1lwt2o9
         vnznYj/xyOd/pGrQWw18t4f5CF3Mk7B3MvX8UeoqCSba/fRGWGQUrTAhc4XEpiU9eYs+
         h4SA==
X-Gm-Message-State: AEkoouvqxm82vSfM+P7RVOiWqikIfl9s2QEhH96Gwq/1fOcEZSsleM4dT/CARg5v29/Kz6J+
X-Received: by 10.66.49.67 with SMTP id s3mr57738461pan.100.1470715715647;
        Mon, 08 Aug 2016 21:08:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:ad25:78d3:1e25:67ef])
        by smtp.gmail.com with ESMTPSA id c64sm51540051pfg.35.2016.08.08.21.08.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 21:08:35 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Jens.Lehmann@web.de, mst@redhat.com,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 8/9] submodule: try alternates when superproject has an alternate
Date:	Mon,  8 Aug 2016 21:08:10 -0700
Message-Id: <20160809040811.21408-11-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.583.gd6329be.dirty
In-Reply-To: <20160809040811.21408-1-sbeller@google.com>
References: <20160809040811.21408-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-clone.txt    |  4 ++++
 builtin/submodule--helper.c    | 47 ++++++++++++++++++++++++++++++++++++++++++
 t/t7408-submodule-reference.sh | 29 +++++++++++++++++++++++++-
 3 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index e316c4b..cadf138 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -103,6 +103,10 @@ objects from the source repository into a pack in the cloned repository.
 +
 *NOTE*: see the NOTE for the `--shared` option, and also the
 `--dissociate` option.
++
+When using --reference any submodule that is cloned
+sets up a corresponding alternate at $GIT_DIR/modules if such a
+an alternate exists.
 
 --dissociate::
 	Borrow the objects from reference repositories specified
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f360473..fc14843 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -635,6 +635,45 @@ static void next_submodule_warn_missing(struct submodule_update_clone *suc,
 	}
 }
 
+struct submodule_alternate_setup {
+	struct submodule_update_clone *suc;
+	const char *submodule_name;
+	struct child_process *child;
+	struct strbuf *out;
+};
+
+int add_possible_reference(struct alternate_object_database *alt, void *sas_cb)
+{
+	struct submodule_alternate_setup *sas = sas_cb;
+
+	/* directory name, minus trailing slash */
+	size_t namelen = alt->name - alt->base - 1;
+	struct strbuf name = STRBUF_INIT;
+	strbuf_add(&name, alt->base, namelen);
+
+	/*
+	 * If the alternate object store is another repository, try the
+	 * standard layout with .git/modules/<name>/objects
+	 */
+	if (ends_with(name.buf, ".git/objects")) {
+		struct strbuf sb = STRBUF_INIT;
+		strbuf_add(&sb, name.buf, name.len - strlen("objects"));
+		/*
+		 * We need to end the new path with '/' to mark it as a dir,
+		 * otherwise a submodule name containing '/' will be broken
+		 * as the last part of a missing submodule reference would
+		 * be taken as a file name.
+		 */
+		strbuf_addf(&sb, "modules/%s/", sas->submodule_name);
+		argv_array_pushf(&sas->child->args,
+				 "--reference-if-able=%s", sb.buf);
+		strbuf_release(&sb);
+	}
+
+	strbuf_release(&name);
+	return 0;
+}
+
 /**
  * Determine whether 'ce' needs to be cloned. If so, prepare the 'child' to
  * run the clone. Returns 1 if 'ce' needs to be cloned, 0 otherwise.
@@ -650,6 +689,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	const char *displaypath = NULL;
 	char *url = NULL;
 	int needs_cloning = 0;
+	struct submodule_alternate_setup sas;
 
 	if (ce_stage(ce)) {
 		if (suc->recursive_prefix)
@@ -728,6 +768,13 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 		for_each_string_list_item(item, &suc->references)
 			argv_array_pushl(&child->args, "--reference", item->string, NULL);
 	}
+
+	sas.submodule_name = sub->name;
+	sas.suc = suc;
+	sas.child = child;
+	sas.out = out;
+	foreach_alt_odb(add_possible_reference, &sas);
+
 	if (suc->depth)
 		argv_array_push(&child->args, suc->depth);
 
diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
index 4a1b8f0..a9b89a3 100755
--- a/t/t7408-submodule-reference.sh
+++ b/t/t7408-submodule-reference.sh
@@ -7,7 +7,6 @@ test_description='test clone --reference'
 . ./test-lib.sh
 
 base_dir=$(pwd)
-
 test_alternate_is_used () {
 	alternates_file="$1" &&
 	working_dir="$2" &&
@@ -73,4 +72,32 @@ test_expect_success 'updating superproject keeps alternates' '
 	test_alternate_is_used super-clone/.git/modules/sub/objects/info/alternates super-clone/sub
 '
 
+test_expect_success 'submodules use alternates when cloning a superproject' '
+	test_when_finished "rm -rf super-clone" &&
+	git clone --reference super --recursive super super-clone &&
+	(
+		cd super-clone &&
+		# test superproject has alternates setup correctly
+		test_alternate_is_used .git/objects/info/alternates . &&
+		# test submodule has correct setup
+		test_alternate_is_used .git/modules/sub/objects/info/alternates sub
+	)
+'
+
+test_expect_success 'cloning superproject, missing submodule alternates' '
+	test_when_finished "rm -rf super-clone" &&
+	git clone super super2 &&
+	git clone --recursive --reference super2 super2 super-clone &&
+	(
+		cd super-clone &&
+		# test superproject has alternates setup correctly
+		test_alternate_is_used .git/objects/info/alternates . &&
+		# update of the submodule succeeds
+		git submodule update --init &&
+		# and we have no alternates:
+		test_must_fail test_alternate_is_used .git/modules/sub/objects/info/alternates sub &&
+		test_path_is_file sub/file1
+	)
+'
+
 test_done
-- 
2.9.2.583.gd6329be.dirty

