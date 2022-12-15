Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3F1C4708D
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 09:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiLOJL0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 04:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiLOJLW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 04:11:22 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCE72A96B
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:11:20 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h16so2311294wrz.12
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgabFXxI8mpq5+3P+Tb0jVqbo3Ptu9bBfUUaApTNQTQ=;
        b=DvfcKGgHgq0ZAzvm9aBQ6YhxEOYVO7EoCrP+NXpbQ/o7ad0zshG1kcBQZMu18HrtA2
         3UMom3v//F+wJHs0dL2NklG71FUwePBMD4TL4yTl0MKyICIIcWATf3PZeMVBTWR74JN5
         iqzY24TBfWD/PPJgS1VXGY3yB6qTlU+ccicv8Y7cxcYdGOYBnOt02zObr6VbMsHJ+Qiq
         esCrrcdSOrRCgYrYr9osmNe/0PYlFTjJ7LTewBiMwb0QsbJmASsoX495KRX+Cq5eKWz0
         356upSEzztdrudnN/65N/pv+ogAo3WPPly/ctOrTj/neeLVg3wm3yRZpPkzzKuuYyIMW
         gT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rgabFXxI8mpq5+3P+Tb0jVqbo3Ptu9bBfUUaApTNQTQ=;
        b=WxgdTpd7B+vKKf4e+CVfTAGulamqI2SgVRVWrsewEQOKrjZSQFDvsJDLIRSlBduAnn
         2UbN3w0kFIyBBTGqJGByZpqAWo+5G1IpvberwOpev88bQrrVGTs9uqQfvOMt5PeihfR4
         +sjVfNacTvP3Q+v81Z0iXBdQqq6rWkOuGp+uocfZT2wA84vIFkGCurEp41ZWHxGv7Ex7
         qbmiCIrDzkKFj8llxhIHo0kV/yXbYlqmJgs0mXV+ifUFMs8puT29nW8WqAbbf46cxpwQ
         FKU0wM/s7/MI0j1VXqUdVd47RDWZsYtQES/mbF5B4zC+Hf+MtexPttT9qGid4XjHgtmb
         reIQ==
X-Gm-Message-State: ANoB5pleeZW1ZxjT9i59geXj37524ZltxzDyREEx2EyqG1Q2PuzkwyLx
        EaUqZFEYfPdQsPT2py/V1bRgMR1brVts8A==
X-Google-Smtp-Source: AA0mqf7IwESjgR94p3qmxwPOLWb++3eRS6imXMEk6sia8m+PWgf3t9ZDZE+2jXSlbkzbQvbI0Z/Bjg==
X-Received: by 2002:a5d:404f:0:b0:242:7c7a:7ee7 with SMTP id w15-20020a5d404f000000b002427c7a7ee7mr17959181wrp.53.1671095479906;
        Thu, 15 Dec 2022 01:11:19 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m7-20020a056000024700b002366f9bd717sm6193835wrz.45.2022.12.15.01.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 01:11:19 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 2/5] various: add missing strvec_clear()
Date:   Thu, 15 Dec 2022 10:11:08 +0100
Message-Id: <RFC-patch-2.5-9785934c6d7-20221215T090226Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1048.g0e5493b8d5b
In-Reply-To: <RFC-cover-0.5-00000000000-20221215T090226Z-avarab@gmail.com>
References: <221214.86ilie48cv.gmgdl@evledraar.gmail.com> <RFC-cover-0.5-00000000000-20221215T090226Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix or partially fix memory leaks that happened because a
strvec_clear() was missing. The "partially" will be addressed in a
subsequent commit, we'll still leak in cases where the function we're
calling munges our "v" member.

In the case of "builtin/describe.c" let's change it to use the macro
initializer rather than the strvec_init() while we're at it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/annotate.c       | 5 ++++-
 builtin/describe.c       | 8 +++++---
 builtin/stash.c          | 6 +++++-
 builtin/upload-archive.c | 7 +++++--
 4 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/builtin/annotate.c b/builtin/annotate.c
index e37b269196f..de58deadfc7 100644
--- a/builtin/annotate.c
+++ b/builtin/annotate.c
@@ -10,9 +10,12 @@
 int cmd_annotate(int argc UNUSED, const char **argv, const char *prefix)
 {
 	struct strvec args = STRVEC_INIT;
+	int ret;
 
 	strvec_pushl(&args, argv[0], "-c", NULL);
 	strvec_pushv(&args, &argv[1]);
 
-	return cmd_blame(args.nr, args.v, prefix);
+	ret = cmd_blame(args.nr, args.v, prefix);
+	strvec_clear(&args);
+	return ret;
 }
diff --git a/builtin/describe.c b/builtin/describe.c
index eea1e330c00..cb205f6b561 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -597,9 +597,9 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 
 	if (contains) {
 		struct string_list_item *item;
-		struct strvec args;
+		struct strvec args = STRVEC_INIT;
+		int ret;
 
-		strvec_init(&args);
 		strvec_pushl(&args, "name-rev",
 			     "--peel-tag", "--name-only", "--no-undefined",
 			     NULL);
@@ -616,7 +616,9 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			strvec_pushv(&args, argv);
 		else
 			strvec_push(&args, "HEAD");
-		return cmd_name_rev(args.nr, args.v, prefix);
+		ret = cmd_name_rev(args.nr, args.v, prefix);
+		strvec_clear(&args);
+		return ret;
 	}
 
 	hashmap_init(&names, commit_name_neq, NULL, 0);
diff --git a/builtin/stash.c b/builtin/stash.c
index bb0fd861434..e504e22e0b9 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -961,6 +961,7 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 	ret = diff_result_code(&rev.diffopt, 0);
 cleanup:
 	strvec_clear(&stash_args);
+	strvec_clear(&revision_args);
 	free_stash_info(&info);
 	release_revisions(&rev);
 	if (do_usage)
@@ -1838,6 +1839,7 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
 		OPT_SUBCOMMAND_F("save", &fn, save_stash, PARSE_OPT_NOCOMPLETE),
 		OPT_END()
 	};
+	int ret;
 
 	git_config(git_stash_config, NULL);
 
@@ -1861,5 +1863,7 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
 	/* Assume 'stash push' */
 	strvec_push(&args, "push");
 	strvec_pushv(&args, argv);
-	return !!push_stash(args.nr, args.v, prefix, 1);
+	ret = !!push_stash(args.nr, args.v, prefix, 1);
+	strvec_clear(&args);
+	return ret;
 }
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 945ee2b4126..6ef0d06ee8b 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -21,6 +21,7 @@ int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix)
 {
 	struct strvec sent_argv = STRVEC_INIT;
 	const char *arg_cmd = "argument ";
+	int ret;
 
 	if (argc != 2 || !strcmp(argv[1], "-h"))
 		usage(upload_archive_usage);
@@ -45,8 +46,10 @@ int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix)
 	}
 
 	/* parse all options sent by the client */
-	return write_archive(sent_argv.nr, sent_argv.v, prefix,
-			     the_repository, NULL, 1);
+	ret = write_archive(sent_argv.nr, sent_argv.v, prefix,
+			    the_repository, NULL, 1);
+	strvec_clear(&sent_argv);
+	return ret;
 }
 
 __attribute__((format (printf, 1, 2)))
-- 
2.39.0.rc2.1048.g0e5493b8d5b

