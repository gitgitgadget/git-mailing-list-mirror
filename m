Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C609C49361
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E0B9613BF
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbhFQLAC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 07:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbhFQK75 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:59:57 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCAAC061760
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:57:49 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l7-20020a05600c1d07b02901b0e2ebd6deso3428360wms.1
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pu+77s0V4l031kxzJBk0xvkCfchX6l2gU6Ik+6hSP+M=;
        b=kwjAIcnPYUipGGByNwOIQv65FI3i9fNdZq2w51Kr7Rg2vkO6ToOskXgYtamXbeZd+p
         VIxQEjY8J2XHbb50LeD6ZA9IxOr/4ri+NpIfn/KiNMa7fdyxHTKi4yom7mQK6qUso4HH
         ueS9kRBKpGLSJnGeN5zqHNe8pLMRbgDSyg3boTX2dU5URRjMT2fxeWcjWXr0Y/sIBfZN
         1k9uT5H/2mw7WYmcnEVBpYUPi1juXeVeIRGyEVX+zj+DZrjJ/tfFhACW0lgYExij3VuK
         f3tjUkw3hy1pxwhN//AJ1DRs3y+nL1V4Jxjat85t619JKqiDXGrFSzp4HgyPgHITx+wd
         khbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pu+77s0V4l031kxzJBk0xvkCfchX6l2gU6Ik+6hSP+M=;
        b=OmcQhOlMNILEDelVNOdFrm46HJFeN05Nc4odmjgOztMI/B7opDDg9+av+zvjzYpaEE
         2MVIk0Omu4+SeX1DdjEDa1OQCH0ece35/FknzucCnePG38zpcCP09f0o9Olg5iahBcEu
         GhU6tx/pSKbvxTvwRJ0VgESxbZfzK9IdUkxl1oWoAzrTD7W5MtOl3kDP8oPsUEdcdECU
         HZMYB9MZWvnrFWtwGGzfaaiaAXWMAXlySIkh1FTJdo56s4xWQYv5Am5klmHUBFa3HK6V
         OWm2Vg/OIEZTzNPwlRpsZQ42IByjJFZoqqpIDy/1Zl2mRFnWHjqGaVnPAI0O1aC6GUSL
         yUpQ==
X-Gm-Message-State: AOAM533VNjzQEl3RhSq/O12j7fTJxMJNRm9jARPQToutqtqtDUYBMxt5
        3KhLvuV3MtZTU4dGUVRo4/0JHyMLll+qwQ==
X-Google-Smtp-Source: ABdhPJwoxayiA0xaec6ke/JnsCmmyR4UiHkknx7UPb9pCAVuTCRexQSbbQ8ST8Q+UTDfG2P3RO9N+g==
X-Received: by 2002:a7b:c192:: with SMTP id y18mr4390973wmi.65.1623927467716;
        Thu, 17 Jun 2021 03:57:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k5sm4897948wmk.11.2021.06.17.03.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:57:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/4] pack-objects.c: make use of REV_INFO_STDIN_LINE_PROCESS
Date:   Thu, 17 Jun 2021 12:57:37 +0200
Message-Id: <patch-4.4-e59a06c314-20210617T105537Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.571.gdba276db2c
In-Reply-To: <cover-0.4-0000000000-20210617T105537Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210608T121008Z-avarab@gmail.com> <cover-0.4-0000000000-20210617T105537Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Continue the work started in the preceding commit of porting
pack-objects.c over to the new handle_stdin_line callback pattern. The
common case for the users of this API is to do some of their own
parsing or munging, and then have handle_revision_arg() handle the
rest.

The existing users of the --stdin parsing always wanted a flag of "0"
to be passed to handle_revision_arg(), but pack-objects.c wants to set
custom flags. Let's support this common case by having a
"revarg_flags" member in the "rev_info" struct.

This allows us to return REV_INFO_STDIN_LINE_PROCESS in the new
get_object_list_handle_stdin_line() instead of
REV_INFO_STDIN_LINE_CONTINUE, as read_revisions_from_stdin() will now
pass down the right flag for us.

This also means that we can make the handle_revision_arg() function
static. Now that the only external user of the API has been migrated
over to the callback mechanism nothing external to revision.c needs to
call handle_revision_arg() anymore.

That handle_revision_arg() function was made public in a combination
of 5d6f0935e6d (revision.c: allow injecting revision parameters after
setup_revisions()., 2006-09-05) and b5d97e6b0a0 (pack-objects: run
rev-list equivalent internally., 2006-09-04).

This change leaves the briefly-used in preceding commits
"void *stdin_line_priv" without any in-tree user, as
builtin/pack-objects.c could be ported over to our new "revarg_flags"
common case.

I'm leaving that "void *stdin_line_priv" in place anyway for two
reasons:

 1. It's a common pattern to allow such a "void *" to be used for
    callback data, so we might as well follow that pattern here in
    anticipation of a future in-tree user.

 2. I have patches for such an in-tree user already in a series
    that'll be submitted after this one.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/pack-objects.c | 9 ++-------
 revision.c             | 4 ++--
 revision.h             | 8 ++++++--
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index cbb01f2b2d..0ab2d10853 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3748,7 +3748,6 @@ static void mark_bitmap_preferred_tips(void)
 static enum rev_info_stdin_line get_object_list_handle_stdin_line(
 	struct rev_info *revs, struct strbuf *line_sb, void *stdin_line_priv)
 {
-	int *flags = stdin_line_priv;
 	char *line = line_sb->buf;
 	size_t len = line_sb->len;
 
@@ -3756,7 +3755,7 @@ static enum rev_info_stdin_line get_object_list_handle_stdin_line(
 		return REV_INFO_STDIN_LINE_BREAK;
 	if (*line == '-') {
 		if (!strcmp(line, "--not")) {
-			*flags ^= UNINTERESTING;
+			revs->revarg_flags ^= UNINTERESTING;
 			write_bitmap_index = 0;
 			return REV_INFO_STDIN_LINE_CONTINUE;
 		}
@@ -3770,9 +3769,7 @@ static enum rev_info_stdin_line get_object_list_handle_stdin_line(
 		}
 		die(_("not a rev '%s'"), line);
 	}
-	if (handle_revision_arg(line, revs, *flags, REVARG_CANNOT_BE_FILENAME))
-			die(_("bad revision '%s'"), line);
-	return REV_INFO_STDIN_LINE_CONTINUE;
+	return REV_INFO_STDIN_LINE_PROCESS;
 }
 
 static void get_object_list(int ac, const char **av)
@@ -3781,7 +3778,6 @@ static void get_object_list(int ac, const char **av)
 	struct setup_revision_opt s_r_opt = {
 		.allow_exclude_promisor_objects = 1,
 	};
-	int flags = 0;
 
 	repo_init_revisions(the_repository, &revs, NULL);
 	save_commit_buffer = 0;
@@ -3791,7 +3787,6 @@ static void get_object_list(int ac, const char **av)
 
 	revs.stdin_handling = REV_INFO_STDIN_ALWAYS_READ;
 	revs.handle_stdin_line = get_object_list_handle_stdin_line;
-	revs.stdin_line_priv = &flags;
 	setup_revisions(ac, av, &revs, &s_r_opt);
 
 	if (use_bitmap_index && !get_object_list_from_bitmap(&revs))
diff --git a/revision.c b/revision.c
index 2ca2c38447..ad94a646f7 100644
--- a/revision.c
+++ b/revision.c
@@ -2089,7 +2089,7 @@ static int handle_revision_arg_1(const char *arg_, struct rev_info *revs, int fl
 	return 0;
 }
 
-int handle_revision_arg(const char *arg, struct rev_info *revs, int flags, unsigned revarg_opt)
+static int handle_revision_arg(const char *arg, struct rev_info *revs, int flags, unsigned revarg_opt)
 {
 	int ret = handle_revision_arg_1(arg, revs, flags, revarg_opt);
 	if (!ret)
@@ -2145,7 +2145,7 @@ static void read_revisions_from_stdin(struct rev_info *revs,
 			}
 			die("options not supported in --stdin mode");
 		}
-		if (handle_revision_arg(sb.buf, revs, 0,
+		if (handle_revision_arg(sb.buf, revs, revs->revarg_flags,
 					REVARG_CANNOT_BE_FILENAME))
 			die("bad revision '%s'", sb.buf);
 	}
diff --git a/revision.h b/revision.h
index 5df1523a6c..c473567d82 100644
--- a/revision.h
+++ b/revision.h
@@ -157,11 +157,16 @@ struct rev_info {
 	 *   revision.c's normal processing of the line (after
 	 *   possibly munging the provided strbuf).
 	 *
+	 *   Change "revarg_flags" to affect the subsequent handling
+	 *   in handle_revision_arg()
+	 *
 	 * - Return REV_INFO_STDIN_LINE_BREAK to process no further
 	 *   lines, or anything further from the current line (just
 	 *   like REV_INFO_STDIN_LINE_CONTINUE).
 	 *
 	 * - Return REV_INFO_STDIN_LINE_CONTINUE to indicate that the
+	 *
+	 * - Return REV_INFO_STDIN_LINE_BREAK to indicate that the
 	 *   line is fully processed, moving onto the next line (if
 	 *   any)
 	 *
@@ -169,6 +174,7 @@ struct rev_info {
 	 * around.
 	 */
 	rev_info_stdin_line_func handle_stdin_line;
+	int revarg_flags;
 	void *stdin_line_priv;
 
 	/* topo-sort */
@@ -426,8 +432,6 @@ void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
 			const char * const usagestr[]);
 #define REVARG_CANNOT_BE_FILENAME 01
 #define REVARG_COMMITTISH 02
-int handle_revision_arg(const char *arg, struct rev_info *revs,
-			int flags, unsigned revarg_opt);
 
 /**
  * Reset the flags used by the revision walking api. You can use this to do
-- 
2.32.0.571.gdba276db2c

