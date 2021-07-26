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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF18C43216
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 12:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2AAC60F4F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 12:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbhGZMGY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 08:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbhGZMFv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 08:05:51 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD158C0613C1
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 05:46:17 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id f14-20020a05600c154eb02902519e4abe10so1921318wmg.4
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 05:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ynEu1jl1gTVyIMiJeZeFPtz266FsAS7PTrg/gUPDBRI=;
        b=BsntoY/WOz5/fMUOpcr+UHWlgB2WLQtNTDQrBaEyw4a3iDVnldyv/VOJRkYVYTDPqw
         tW3yiTH9Hs03BAhtAkTM23Lpr249utPJPLWLE4Gf3Xy5G2QBzdPv3upWOR1SA9HT+VIS
         jPaTs6iFliNBhwSlSjQvu+LCXLONhyfizD8qfNhZ5qOVPeuheD+syZv7HGD8oBjotZZR
         G0X7ZZMPrTvxxRtxxwm/h48ZLOjeBH9c1SLYjbKVpAoNdNbkxvp2ImNbiKAXhU1+3ogR
         Hvt6xFkoWCZUddzRGgE8FXRcY68e0KL6aAbp6cX524mB44lcZ6BboSERP30iSnjPZYLi
         cajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ynEu1jl1gTVyIMiJeZeFPtz266FsAS7PTrg/gUPDBRI=;
        b=MAUMnUhtQAkIF5LSZ6feS75EsbVeU17gpwSwRCfeeH8gmpqzhXLRpKg+aYak+hsDPs
         5cXAz20LpEr9rB+WCuI7GKEBt4VeyU25uADyi8r4c7P/EJJx8mbvua+CuEeY1JodnYAt
         GReOWObxDnjX1WCjJj5nFhlNgVm9lPoZwPmuvDdqhxM2twYjbQbaGPb/6wd1a9987JL2
         lVdKPhY9RU9P0QgivgXPHMVIRK6IxwO/Npl9qSM2VPGOMZgqvUKi9d2iNmi2iKAQkJbx
         UNQ6e3sz2Hp0M/YcreIskRSxNxehPgQ+/FHWCx8Jsf+gxF9Va097eUS8zc1gRyqgO6Nn
         3Nug==
X-Gm-Message-State: AOAM5319fYjyEHVfMV8oNUZ/HKJ7dzSAsF/iZNIJ5vl9KR1mzf64lipw
        vGqR5h/VOqO3dUt/67kmdM8mnGW+m34KOA==
X-Google-Smtp-Source: ABdhPJyTLDPzAhRA8KbpQ9/4DwVCsnGSOa+DoEpBb+9vZcaCdmNtwHVkm9NZWRc3QBor8E5W71x7cg==
X-Received: by 2002:a7b:cb4d:: with SMTP id v13mr15775121wmj.68.1627303576133;
        Mon, 26 Jul 2021 05:46:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w18sm45155444wrg.68.2021.07.26.05.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 05:46:15 -0700 (PDT)
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
Subject: [PATCH v5 4/5] pack-objects.c: do stdin parsing via revision.c's API
Date:   Mon, 26 Jul 2021 14:46:09 +0200
Message-Id: <patch-4.5-4787490a90f-20210726T124425Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.956.g6b0c84ceda8
In-Reply-To: <cover-0.5-00000000000-20210726T124425Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210709T105850Z-avarab@gmail.com> <cover-0.5-00000000000-20210726T124425Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the new "handle_stdin_line" API in revision.c to parse stdin in
pack-objects.c, instead of using custom pack-objects.c-specific code
to do so.

This means that we can remove the "if (len && line[len - 1] == '\n')"
check, it's now redundant to using strbuf_getline(), and we get to
skip the whole "warn_on_object_refname_ambiguity" dance. The
read_revisions_from_stdin() function in revision.c we're now using
does it for us.

The pack-objects.c code being refactored away here was first added in
Linus's c323ac7d9c5 (git-pack-objects: create a packed object
representation., 2005-06-25).

Later on rev-list started doing similar parsing in 42cabc341c4 (Teach
rev-list an option to read revs from the standard input., 2006-09-05).
That code was promoted to a more general API in 1fc561d169a (Move
read_revisions_from_stdin from builtin-rev-list.c to revision.c,
2008-07-05).

Since then the API in revision.c has received improvements that have
been missed here. E.g. the arbitrary limit of 1000 bytes was removed
in 63d564b3002 (read_revision_from_stdin(): use strbuf, 2009-11-20),
and it moved to a more simpler strbuf API in 6e8d46f9d4b (revision:
read --stdin with strbuf_getline(), 2015-10-28).

For now we've just made setup_revisions() loop over stdin for us, but
the callback we define makes no use of REV_INFO_STDIN_LINE_PROCESS. We
still need to call handle_revision_arg() ourselves because we'd like
to call it with different flags.

This very light use of the API will be further refined in a subsequent
commit, for now we're just doing the bare minimum to move this
existing code over to the new callback pattern without any functional
changes, and making it as friendly to "git show -w" and "the
--color-moved-ws=allow-indentation-change" mode as possible.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/pack-objects.c | 63 ++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 33 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1fbaa34f91b..35d5247f85a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3745,15 +3745,40 @@ static void mark_bitmap_preferred_tips(void)
 	}
 }
 
+static enum rev_info_stdin_line get_object_list_handle_stdin_line(
+	struct rev_info *revs, struct strbuf *line_sb, void *stdin_line_priv)
+{
+	int *flags = stdin_line_priv;
+	char *line = line_sb->buf;
+
+	if (*line == '-') {
+		if (!strcmp(line, "--not")) {
+			*flags ^= UNINTERESTING;
+			write_bitmap_index = 0;
+			return REV_INFO_STDIN_LINE_CONTINUE;
+		}
+		if (starts_with(line, "--shallow ")) {
+			struct object_id oid;
+			if (get_oid_hex(line + 10, &oid))
+				die("not an object name '%s'", line + 10);
+			register_shallow(the_repository, &oid);
+			use_bitmap_index = 0;
+			return REV_INFO_STDIN_LINE_CONTINUE;
+		}
+		die(_("not a rev '%s'"), line);
+	}
+	if (handle_revision_arg(line, revs, *flags, REVARG_CANNOT_BE_FILENAME))
+			die(_("bad revision '%s'"), line);
+	return REV_INFO_STDIN_LINE_CONTINUE;
+}
+
 static void get_object_list(int ac, const char **av)
 {
 	struct rev_info revs;
 	struct setup_revision_opt s_r_opt = {
 		.allow_exclude_promisor_objects = 1,
 	};
-	char line[1000];
 	int flags = 0;
-	int save_warning;
 
 	repo_init_revisions(the_repository, &revs, NULL);
 	save_commit_buffer = 0;
@@ -3761,39 +3786,11 @@ static void get_object_list(int ac, const char **av)
 	/* make sure shallows are read */
 	is_repository_shallow(the_repository);
 
+	revs.stdin_handling = REV_INFO_STDIN_ALWAYS_READ;
+	revs.handle_stdin_line = get_object_list_handle_stdin_line;
+	revs.stdin_line_priv = &flags;
 	setup_revisions(ac, av, &revs, &s_r_opt);
 
-	save_warning = warn_on_object_refname_ambiguity;
-	warn_on_object_refname_ambiguity = 0;
-
-	while (fgets(line, sizeof(line), stdin) != NULL) {
-		int len = strlen(line);
-		if (len && line[len - 1] == '\n')
-			line[--len] = 0;
-		if (!len)
-			break;
-		if (*line == '-') {
-			if (!strcmp(line, "--not")) {
-				flags ^= UNINTERESTING;
-				write_bitmap_index = 0;
-				continue;
-			}
-			if (starts_with(line, "--shallow ")) {
-				struct object_id oid;
-				if (get_oid_hex(line + 10, &oid))
-					die("not an object name '%s'", line + 10);
-				register_shallow(the_repository, &oid);
-				use_bitmap_index = 0;
-				continue;
-			}
-			die(_("not a rev '%s'"), line);
-		}
-		if (handle_revision_arg(line, &revs, flags, REVARG_CANNOT_BE_FILENAME))
-			die(_("bad revision '%s'"), line);
-	}
-
-	warn_on_object_refname_ambiguity = save_warning;
-
 	if (use_bitmap_index && !get_object_list_from_bitmap(&revs))
 		return;
 
-- 
2.32.0.956.g6b0c84ceda8

