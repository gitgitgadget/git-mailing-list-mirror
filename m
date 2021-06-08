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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9A0C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 12:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32C7261182
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 12:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbhFHMTs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 08:19:48 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:41627 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbhFHMTr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 08:19:47 -0400
Received: by mail-wr1-f50.google.com with SMTP id o3so2948943wri.8
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 05:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XRaqzm7k7AqQbOy3fFiUgR+oprsXIe4BRiLMjxIi0Us=;
        b=ZK6uasVdFUIVCpmi6CLej/X5XDDN0/CjMV2cV7OIuAsDbgTqUhTfT7FqinVBN83RqV
         EWRscpY9ZhuAPIh7yUjnNZ42y9zuUKwtJ7oCQTmLIxWvlvQ919/Lx9IwkLClvUTfP7MF
         /TLS6J3eRy/Th6efqdrU7Sk8CIZLakbNdTZAHb/HGnybb5Jg9SYVSMxsW7v2s8bl9n9r
         zkx1ifjdT65C8xdZq5BywII8gT7rPvljPH/JU6VTb+QgbMNEItVQ3xcaCXxgJaFbajtg
         +xuyX86ci+aswzkCMTQfDCV4ZZoPaiDDeDXTa4V3IDBOkZlSl6Udnmv6hHbjFEv80MUT
         2EAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XRaqzm7k7AqQbOy3fFiUgR+oprsXIe4BRiLMjxIi0Us=;
        b=XwuM1d1ZNWBFC1+BKuZ+ChNefuulRh4G91PWILcQQMZIbZZ90KtC1m4Hqn1leDZpT1
         1gq2QHOiqEUUqAD0cgmFPlVNnq4o7EqwVONImBS3Le7+znTfnTtJoUtSq8w2ilzPairO
         QPA7CuTBhSsLBX3kwGP65hi4ujgX+8wx3fAjq5TyHIGW9D5Ize3UHFmfCpSrBPRv++gP
         QdVIOy4yCpb2iITgAr5WCdr7uWIfEzXkB45GEsBYmiVe24lMXMrBfD43F4qeQUmR5I0f
         jH2neEDm2TOzFX75leJkoRpPTf0brR3R0swnLX4SHjpwG6ilK7WUSTgtyOuiSKkqKtdV
         QO8A==
X-Gm-Message-State: AOAM530TRhNWCSzLBLp8m/O81brpIQxIybOas8fMLZJ2QbUNzsLgoTek
        PjZSNxF9hxPxnhGrX1iBe/mSK//Gg8rpUg==
X-Google-Smtp-Source: ABdhPJyCGWLGoxdlOEaMLiJsxyBuNSeTGeUJyVcnIZx7JDu0poTq/C4NzjZbhY+S/aLOj+RVoCys6Q==
X-Received: by 2002:adf:f5c9:: with SMTP id k9mr21415400wrp.180.1623154600662;
        Tue, 08 Jun 2021 05:16:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x20sm12976378wmc.39.2021.06.08.05.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 05:16:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/4] pack-objects.c: make use of REV_INFO_STDIN_LINE_PROCESS
Date:   Tue,  8 Jun 2021 14:16:30 +0200
Message-Id: <patch-4.4-15a3a5d047-20210608T121008Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
In-Reply-To: <cover-0.4-0000000000-20210608T121008Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210608T121008Z-avarab@gmail.com>
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
 revision.h             | 6 ++++--
 3 files changed, 8 insertions(+), 11 deletions(-)

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
index 878eb51032..8054a9d037 100644
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
index 9d977cd3cc..c55147e7f2 100644
--- a/revision.h
+++ b/revision.h
@@ -156,6 +156,9 @@ struct rev_info {
 	 * - Return 0 to continue revision.c's normal processing of the
 	 *   line (after possibly munging the provided strbuf).
 	 *
+	 *   Change "revarg_flags" to affect the subsequent handling
+	 *   in handle_revision_arg()
+	 *
 	 * - Return 1 to indicate that the line is fully processed,
          *   moving onto the next line (if any)
 	 *
@@ -165,6 +168,7 @@ struct rev_info {
 	 * around.
 	 */
 	rev_info_stdin_line_func handle_stdin_line;
+	int revarg_flags;
 	void *stdin_line_priv;
 
 	/* topo-sort */
@@ -422,8 +426,6 @@ void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
 			const char * const usagestr[]);
 #define REVARG_CANNOT_BE_FILENAME 01
 #define REVARG_COMMITTISH 02
-int handle_revision_arg(const char *arg, struct rev_info *revs,
-			int flags, unsigned revarg_opt);
 
 /**
  * Reset the flags used by the revision walking api. You can use this to do
-- 
2.32.0.rc3.434.gd8aed1f08a7

