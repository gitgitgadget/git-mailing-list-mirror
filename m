Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC591E784A7
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 02:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbjJBClh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Oct 2023 22:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235490AbjJBClP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 22:41:15 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A53CC4
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 19:40:59 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id ca18e2360f4ac-79faf4210b2so459447739f.2
        for <git@vger.kernel.org>; Sun, 01 Oct 2023 19:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696214458; x=1696819258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ah9lMgvMVvnNRn//l/9eCmgPadLsslMM4KL7LWB14S4=;
        b=XoFr9vzMvmHovO4JwTJs637algt7T1k5JYWys4uPIgr2h7IzCTTeve6aJIkuVSI5ed
         hXAqnplg2skbQbsgnCBcGGWQ2YbiMSg6krbcRgoreZ2DPe8elJhvYYmf0RzbTO5p4k0j
         owmnYO2rZcszaUT7V/whO2WvZk2BGgrG3lBIhsUFABxgrJ1RZp7ZCByBah5Wb77xy/Z6
         X+bzS9nlGJgAFY+Y3Cxj5geOAsnSrpxFpIr7yMzjV7cljJBctSOCe1x8H2zC0WzLf6lx
         LCclrjQJTVW9hOgKfbUIUD7GazTMzNSQaox5P+hWf/Z7v6/X1p4n9c2gzPQ+m9qO6RTV
         wGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696214458; x=1696819258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ah9lMgvMVvnNRn//l/9eCmgPadLsslMM4KL7LWB14S4=;
        b=rnSw89CKsen4LqE0z9Iodg+qSSuvGC8bf+ZuuSyxAU29aN7+tXvPrs+/G7oTxUMbDu
         oPINYorlQ3ZmohJkmcz4ZaHEiMRbv7pR5eQurmfIyHcl5u+zagh1S2OWshb5LlZbniSE
         XbNUVzadbCC7dOr7ZCEL0wFOmhnrgC3iwlBdNqHJ91v62dBaLJKOvmHg9oYnEn53e9QK
         bFvM7SdMafmDDQ5AFs7+EAaB0lZX8AZyJbhLdfagZBKF2SLdNlyZTrA8Iu5lgdkZRRuo
         xtQHSWsyimBR4cf1pH5/4cCHFDJDUo39GRio1LtEYL1oIkk+kKsWjw4JpYeu/wKYLUvz
         IrEA==
X-Gm-Message-State: AOJu0YwpBCQuaA9ohJ9tGJkIgehUejkJTb28MQREdBuTB2L+gWqSRjUu
        jm3DschE0Qp7GlfowJTohfFXI01rt5v5wxJM
X-Google-Smtp-Source: AGHT+IHp/NiOmqU6UF4EK3Kmu2gk+VGwaa6BzcqBIOUS9NbPL2rRHfTdGw45X/z240iG5FBiDXUsSA==
X-Received: by 2002:a5e:aa09:0:b0:783:4bc6:636e with SMTP id s9-20020a5eaa09000000b007834bc6636emr10314707ioe.21.1696214458611;
        Sun, 01 Oct 2023 19:40:58 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id v6-20020a056602058600b0079f9f7a2565sm6346113iox.38.2023.10.01.19.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 19:40:58 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH v2 22/30] rev-parse: add an --output-object-format parameter
Date:   Sun,  1 Oct 2023 21:40:26 -0500
Message-Id: <20231002024034.2611-22-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

The new --output-object-format parameter returns the oid in the
specified format.

This is a generally useful plumbing facility.  It is useful for writing
test cases and for directly querying the translation maps.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 Documentation/git-rev-parse.txt | 12 ++++++++++++
 builtin/rev-parse.c             | 23 +++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index f26a7591e373..f0f9021f2a5a 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -159,6 +159,18 @@ for another option.
 	unfortunately named tag "master"), and show them as full
 	refnames (e.g. "refs/heads/master").
 
+--output-object-format=(sha1|sha256|storage)::
+
+	Allow oids to be input from any object format that the current
+	repository supports.
+
+	Specifying "sha1" translates if necessary and returns a sha1 oid.
+
+	Specifying "sha256" translates if necessary and returns a sha256 oid.
+
+	Specifying "storage" translates if necessary and returns an oid in
+	encoded in the storage hash algorithm.
+
 Options for Objects
 ~~~~~~~~~~~~~~~~~~~
 
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 43e96765400c..0ef3e658cc5b 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -25,6 +25,7 @@
 #include "submodule.h"
 #include "commit-reach.h"
 #include "shallow.h"
+#include "object-file-convert.h"
 
 #define DO_REVS		1
 #define DO_NOREV	2
@@ -675,6 +676,8 @@ static void print_path(const char *path, const char *prefix, enum format_type fo
 int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 {
 	int i, as_is = 0, verify = 0, quiet = 0, revs_count = 0, type = 0;
+	const struct git_hash_algo *output_algo = NULL;
+	const struct git_hash_algo *compat = NULL;
 	int did_repo_setup = 0;
 	int has_dashdash = 0;
 	int output_prefix = 0;
@@ -746,6 +749,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 
 			prepare_repo_settings(the_repository);
 			the_repository->settings.command_requires_full_index = 0;
+			compat = the_repository->compat_hash_algo;
 		}
 
 		if (!strcmp(arg, "--")) {
@@ -833,6 +837,22 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				flags |= GET_OID_QUIETLY;
 				continue;
 			}
+			if (opt_with_value(arg, "--output-object-format", &arg)) {
+				if (!arg)
+					die(_("no object format specified"));
+				if (!strcmp(arg, the_hash_algo->name) ||
+				    !strcmp(arg, "storage")) {
+					flags |= GET_OID_HASH_ANY;
+					output_algo = the_hash_algo;
+					continue;
+				}
+				else if (compat && !strcmp(arg, compat->name)) {
+					flags |= GET_OID_HASH_ANY;
+					output_algo = compat;
+					continue;
+				}
+				else die(_("unsupported object format: %s"), arg);
+			}
 			if (opt_with_value(arg, "--short", &arg)) {
 				filter &= ~(DO_FLAGS|DO_NOREV);
 				verify = 1;
@@ -1083,6 +1103,9 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 		}
 		if (!get_oid_with_context(the_repository, name,
 					  flags, &oid, &unused)) {
+			if (output_algo)
+				repo_oid_to_algop(the_repository, &oid,
+						  output_algo, &oid);
 			if (verify)
 				revs_count++;
 			else
-- 
2.41.0

