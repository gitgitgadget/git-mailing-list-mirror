Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85708E82CCD
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 19:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjI0T4m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 15:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjI0T4c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 15:56:32 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED2C126
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:56:07 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-79fce245bf6so234936039f.1
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695844566; x=1696449366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ah9lMgvMVvnNRn//l/9eCmgPadLsslMM4KL7LWB14S4=;
        b=VLA16e5Bj4ZL0Gx1KKNz31ByK4WqWd5ZA7ZlYrMGf/SWJ/f6QOb2NLpuJ4zZuHjySZ
         +uJpXY0ZcodzQiA/GigrgcTWuvSqhftiZuZCVlasQ2K0oLOeM5a5kT3snTYS5hOeoDMb
         X8sOEOw0UrSZCVHsv8cKIZqrgeNdsKg69Cr4IeAjwGnfHz1P69u6ALtHHS80zcEPx0bk
         cgpnC8h+ZHYQuQ5ZL6fvN+rJamlH2GyVT6VwUioDkOC4RrNZmRglb1en0g0bgc/rFrhK
         cYJfgQS2r4BzzQGW01fJQr9lyA/Uzqz7aTKB/qj97j49kGmDMaL6Nf2voxfpYiiUC3cs
         8zfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695844566; x=1696449366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ah9lMgvMVvnNRn//l/9eCmgPadLsslMM4KL7LWB14S4=;
        b=Khzp2V6z9IEyx8Z8xdW63s0a6qxb7APBguSaBSJb/3z/vIbPu9DspNo97y1pukxtk4
         PIoq37Gymtf5GmP38FYSytVjE9whOJ3By9+gKl7RdXQa16kYVqKik2d7mSmeiovDtZk3
         gSxJsn0stSRihEDI8JaFLcEGYz4CyLKIJwAfXBOdLRYE0fA9pydNh/0feokcGoho2Kp5
         oelnLupJpzLa7CKMFX32CpBMeGx+o8nSI2aQLlswUYCIcFp7Kii3oE6KlEpBse5ms3II
         flw9uOskHH8AtfW9wsSP7x4QX/nqaVqNk4/vPw8SxkBQMFxQedev7l+X/sS7mwt79kAo
         H8/w==
X-Gm-Message-State: AOJu0YyhUKqEWopMfzmN0y2F5KmCyrce82C46aIFs6sERIiuprkOSj6F
        5vSbIv6+yEH4iVyOGvsBLe6WoOY61IA=
X-Google-Smtp-Source: AGHT+IEH01IYQox6bknbY8GUZgezteVACSFM2QNRdDRVyWbTeo+7POg5TVX2E9crR2GGPCfS3HddQQ==
X-Received: by 2002:a6b:dd07:0:b0:79f:cb49:f476 with SMTP id f7-20020a6bdd07000000b0079fcb49f476mr2480136ioc.21.1695844566667;
        Wed, 27 Sep 2023 12:56:06 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id o23-20020a6b5a17000000b007836c7e8dccsm2935628iob.17.2023.09.27.12.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 12:56:06 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 22/30] rev-parse: Add an --output-object-format parameter
Date:   Wed, 27 Sep 2023 14:55:29 -0500
Message-Id: <20230927195537.1682-22-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
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

