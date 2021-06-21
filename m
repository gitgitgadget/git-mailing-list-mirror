Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC5AC4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 15:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 258CF61151
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 15:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhFUPMp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 11:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhFUPMk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 11:12:40 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E94C061756
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 08:10:24 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id c84so10733288wme.5
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 08:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LdjL3DK//vcRZ+2kUTK//4uDE0BL8Chb8Mi4MPMz+Uk=;
        b=bcwvFvmut0IHTOc0yH9NeDJ6bupHA+SydVGeBcWkEr7Bt4u3dLjFcsQ97fxmkiLaiV
         4tK/6aXFde1FgwKlr5r1/QRZronSc8RUpJ9NUMIoKnU9viVuNwpxdjDGj04WgdSOybvO
         ZMSMwsABNkO9uYyqW1qjyCEh10EKVXkKS/D+4S1uZKFcQ0ycIdWFqlQCr1/WXibXlv7U
         nvBF1ZoZ0iKv6c9ea8xPae2YrZM1Gv1fCjPdR+b4JRLsKnAkuqiAkiAjRsGc+JONeh93
         ClHDcm0IfXOtsAsn1osR5xN0rbB3E7cfVZVsVWP+cXYoDbxWYLrS/8TQn6Z8YZQ66khF
         PCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LdjL3DK//vcRZ+2kUTK//4uDE0BL8Chb8Mi4MPMz+Uk=;
        b=QdhhvyQ0jcyK5hInqzCm+Mv0bkFLQxIKkmxpPSsrntsRJq43jbhCaR2qg0XE7HAdmv
         StsBjhr3RtqB0v1aBCuqkyNQwOZgBo9th5fYhmZRsUDJ7QY5uOK1XOT8X2t45D1GAFJi
         7kRP/aq51OEzAYOwzKFiXCjx/b8Rf1VMEAYlR8n8/H45z/5VmDHHoV2NwXO/NQ4/R/kX
         PuAcbztDJKJbZPnI54FqAhuBFt8UISrCKhCxwxefV7QmorUoRT7CJERrZJFbmLl9+LsH
         GG7GIM3Ad6TdzbYTMRaQ+m3U/hJ1P9NAvMHQX69JsXZykc0IZ5qyL8NhejedODQGwJNe
         BMDw==
X-Gm-Message-State: AOAM532TcqLU8HSXjzZaJdfcpp426Q30I7qcTnuuHQm1SJlVmwrmKluu
        sJaUzmHeB4/SS+7YuOMqIwRD4yB42dRLJA==
X-Google-Smtp-Source: ABdhPJwauKYMwHCJxhcxsqlo1JhPplxq0Xi6Ngxw8nP4JP3YkqVeOj3ligtuv0hDN+0OjMP3DVJikA==
X-Received: by 2002:a7b:c346:: with SMTP id l6mr27506242wmj.109.1624288223257;
        Mon, 21 Jun 2021 08:10:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t17sm16676383wmi.47.2021.06.21.08.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 08:10:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/4] pack-objects.c: make use of REV_INFO_STDIN_LINE_PROCESS
Date:   Mon, 21 Jun 2021 17:10:16 +0200
Message-Id: <patch-4.4-34750ab81cf-20210621T150651Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
In-Reply-To: <cover-0.4-00000000000-20210621T150651Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210617T105537Z-avarab@gmail.com> <cover-0.4-00000000000-20210621T150651Z-avarab@gmail.com>
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

I considered making the "--not" parsing be another flag handled by the
revision.c API itself, but since there's only one caller who wants
this, and the "write_bitmap_index = 0" case is more specific than
marking things UNINTERESTING I think it's better to handle it with a
more general mechanism.

These changes means that we can make the handle_revision_arg()
function static. Now that the only external user of the API has been
migrated over to the callback mechanism nothing external to revision.c
needs to call handle_revision_arg() anymore.

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
 builtin/pack-objects.c | 35 +++++++++++++++--------------------
 revision.c             |  4 ++--
 revision.h             |  6 ++++--
 3 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f8cae6c305a..50f703e1795 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3758,28 +3758,25 @@ static void mark_bitmap_preferred_tips(void)
 static enum rev_info_stdin_line get_object_list_handle_stdin_line(
 	struct rev_info *revs, struct strbuf *line_sb, void *stdin_line_priv)
 {
-	int *flags = stdin_line_priv;
 	char *line = line_sb->buf;
 
-	if (*line == '-') {
-		if (!strcmp(line, "--not")) {
-			*flags ^= UNINTERESTING;
-			write_bitmap_index = 0;
-			return REV_INFO_STDIN_LINE_CONTINUE;
-		}
-		if (starts_with(line, "--shallow ")) {
-			struct object_id oid;
-			if (get_oid_hex(line + 10, &oid))
-				die("not an object name '%s'", line + 10);
-			register_shallow(the_repository, &oid);
-			use_bitmap_index = 0;
-			return REV_INFO_STDIN_LINE_CONTINUE;
-		}
+	if (*line != '-')
+		return REV_INFO_STDIN_LINE_PROCESS;
+
+	if (!strcmp(line, "--not")) {
+		revs->revarg_flags ^= UNINTERESTING;
+		write_bitmap_index = 0;
+		return REV_INFO_STDIN_LINE_CONTINUE;
+	} else if (starts_with(line, "--shallow ")) {
+		struct object_id oid;
+		if (get_oid_hex(line + 10, &oid))
+			die("not an object name '%s'", line + 10);
+		register_shallow(the_repository, &oid);
+		use_bitmap_index = 0;
+		return REV_INFO_STDIN_LINE_CONTINUE;
+	} else {
 		die(_("not a rev '%s'"), line);
 	}
-	if (handle_revision_arg(line, revs, *flags, REVARG_CANNOT_BE_FILENAME))
-			die(_("bad revision '%s'"), line);
-	return REV_INFO_STDIN_LINE_CONTINUE;
 }
 
 static void get_object_list(int ac, const char **av)
@@ -3788,7 +3785,6 @@ static void get_object_list(int ac, const char **av)
 	struct setup_revision_opt s_r_opt = {
 		.allow_exclude_promisor_objects = 1,
 	};
-	int flags = 0;
 
 	repo_init_revisions(the_repository, &revs, NULL);
 	save_commit_buffer = 0;
@@ -3798,7 +3794,6 @@ static void get_object_list(int ac, const char **av)
 
 	revs.stdin_handling = REV_INFO_STDIN_ALWAYS_READ;
 	revs.handle_stdin_line = get_object_list_handle_stdin_line;
-	revs.stdin_line_priv = &flags;
 	setup_revisions(ac, av, &revs, &s_r_opt);
 
 	if (use_bitmap_index && !get_object_list_from_bitmap(&revs))
diff --git a/revision.c b/revision.c
index f55b3a1caf4..17121f40c0b 100644
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
@@ -2139,7 +2139,7 @@ static void read_revisions_from_stdin(struct rev_info *revs,
 			}
 			die("options not supported in --stdin mode");
 		}
-		if (handle_revision_arg(sb.buf, revs, 0,
+		if (handle_revision_arg(sb.buf, revs, revs->revarg_flags,
 					REVARG_CANNOT_BE_FILENAME))
 			die("bad revision '%s'", sb.buf);
 	}
diff --git a/revision.h b/revision.h
index ff7994bb13d..2b96c05ced8 100644
--- a/revision.h
+++ b/revision.h
@@ -156,6 +156,9 @@ struct rev_info {
 	 *   revision.c's normal processing of the line (after
 	 *   possibly munging the provided strbuf).
 	 *
+	 *   Change "revarg_flags" to affect the subsequent handling
+	 *   in handle_revision_arg()
+	 *
 	 * - Return REV_INFO_STDIN_LINE_CONTINUE to indicate that the
 	 *   line is fully processed, moving onto the next line (if
 	 *   any)
@@ -164,6 +167,7 @@ struct rev_info {
 	 * around.
 	 */
 	rev_info_stdin_line_func handle_stdin_line;
+	int revarg_flags;
 	void *stdin_line_priv;
 
 	/* topo-sort */
@@ -421,8 +425,6 @@ void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
 			const char * const usagestr[]);
 #define REVARG_CANNOT_BE_FILENAME 01
 #define REVARG_COMMITTISH 02
-int handle_revision_arg(const char *arg, struct rev_info *revs,
-			int flags, unsigned revarg_opt);
 
 /**
  * Reset the flags used by the revision walking api. You can use this to do
-- 
2.32.0.599.g3967b4fa4ac

