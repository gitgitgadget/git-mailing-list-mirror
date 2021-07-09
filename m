Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5EEC07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 11:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6ECF613D6
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 11:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhGILJN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 07:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbhGILJJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 07:09:09 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F664C0613DD
        for <git@vger.kernel.org>; Fri,  9 Jul 2021 04:06:25 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id g16so1720184wrw.5
        for <git@vger.kernel.org>; Fri, 09 Jul 2021 04:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OVP+he5IQw5W/Xm+I1uQ6X/4pF3ZsGTO5va8vdSRmiE=;
        b=RHpayUNu6HJBDPFWMFPKSR5R+z5CWiKuHIO/TeGiMexpRhZ3sQjySbcyikmKi9M80F
         qtW6nF0hviHPoEB0ptb2Z4YSYVXV9E2g5xG6jeI/xEDKQyer9E80rC0cdj7V3jqHAaQX
         sp2+oH5SZ4AIz9SCKCCirwvbm7U9u+YqL5lNpv7KmAGTQuxDEMWAto6ppBNK+7GWDmpD
         o7ARzH746PwZ7c/hOy46tUHRZEpz2GfmpGjzoYpDF2/jtnpQF8H5VwCcicQ36uipYmV7
         mvHdsEZbtqC9GXp4a+6bmKjNDWXzlb0JMpXnT8aw1okyRpfA/dv62zFTitdtHv7MweJV
         ke6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OVP+he5IQw5W/Xm+I1uQ6X/4pF3ZsGTO5va8vdSRmiE=;
        b=Nh2HVddtX5NqL50/gr7KI69aK+gIjldLEJwzmeYjNzuEu4yfW8YXzjPbvPWRwoRSCX
         4S1i03OtBf4fuUqvQLU1J8LoqL2Nhji7/kt4TEf02ynk2PFpQLE0ns+uNAoJoIDJNMMB
         4I+UD+FZEv9cbHgiYZh07jYc6bl2xWtPZ1B3cdRf1i7baW5yM5eE4V2JWrWQVuzyFF9v
         joTq29sPeIlZGz9Tw3xPs4Fbj0U4hIHyL3ihrlAkeFaN/o7kymM4McgPDFJoXJiHQk/+
         vuLZOW8+vGd4jhDeA7U8TWgfr3+UVefq1RlwWOlNg9jCfBq1ZV+dOrtX6xS/LOkAd48N
         XYog==
X-Gm-Message-State: AOAM530jKX6Gxof5Lapcd/ZFVzzZjWWRxQUkFlPiiKdo5LtSwFYLh6uT
        IYD85witblPRRdPNDenmJ7mP2PYw9bOQng==
X-Google-Smtp-Source: ABdhPJyo7rDJfSpgmnNpmcZcVYwAGStTn2lNZgE7UwFVec6aTT+TD7R7AsroXNq6IxNKK6vzOd/OcQ==
X-Received: by 2002:adf:ea08:: with SMTP id q8mr39969321wrm.297.1625828783381;
        Fri, 09 Jul 2021 04:06:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a4sm4978167wru.55.2021.07.09.04.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 04:06:22 -0700 (PDT)
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
Subject: [PATCH v4 4/5] pack-objects.c: do stdin parsing via revision.c's API
Date:   Fri,  9 Jul 2021 13:06:15 +0200
Message-Id: <patch-4.5-ebffeb5891f-20210709T105851Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-0.5-00000000000-20210709T105850Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20210621T150651Z-avarab@gmail.com> <cover-0.5-00000000000-20210709T105850Z-avarab@gmail.com>
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
index 3639d0379ed..595adc89c12 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3762,15 +3762,40 @@ static void mark_bitmap_preferred_tips(void)
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
@@ -3778,39 +3803,11 @@ static void get_object_list(int ac, const char **av)
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
2.32.0.636.g43e71d69cff

