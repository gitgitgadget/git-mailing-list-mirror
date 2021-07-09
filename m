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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F875C07E9E
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 11:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 418B361249
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 11:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhGILJP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 07:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhGILJH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 07:09:07 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0B8C0613E5
        for <git@vger.kernel.org>; Fri,  9 Jul 2021 04:06:24 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id k32so2872783wms.4
        for <git@vger.kernel.org>; Fri, 09 Jul 2021 04:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1tpPHUUpA5JrhaSpICu2+SS+EJCrGrqK303GIk4lIAc=;
        b=XEau2KZWVxta+DTxWjmK6nUIuXcWOknoNik0K1Zx6Mzeq5bBT+h1KYyG/kwuNYx8Qa
         SyZGcrQ92TDyfwX/dFoUB3RpiRKRRn1gSXsmzWCVHHNicLYm22YZylV6GHF3V1L9bfgk
         L/qok34pmWFThDqe+ITpLitg9d+71V3SsKQOLQtWQviY8iWSNrIZtepE9H7XVf7tz8dl
         4RQ1v2bn9XR/uqgKwdYlkkpaUbS1A0TiT7ElOGKRGxYloSR8V0oyU+4lLqhDxgKJugdc
         eihovg58Sqc1/cCfPeM+g9Nvo+7c0hi1DYV+NE6aKLLdlkGEJN5Zvfcv8zYQVjjud+pE
         Q4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1tpPHUUpA5JrhaSpICu2+SS+EJCrGrqK303GIk4lIAc=;
        b=c9lCQa71OBJb0mH4UZiW6SAkHu94yu0KW/sN73dYldkKoQmnRubZE/2G3OY21eBA+H
         0DpVUnlb6e7xaIyB+krFr1D6sjQHXS+DNA8TX25Jq/Jespfpd63pZYVspS/zEHpAVzBW
         80TWHx1XGXmnQ/ziCTgWiyHXs+V5AX2EYhYaw2fgPbpJ6AoOg4CbPsBoOwynUI5fZv70
         eKu6tEHg4MdQUF+SMxUQG78xcfgrk0uGAs+4zrfGoFrJUSEbk89qufRfsYgJz6mo0Bjq
         aVi9Q8U+g7Ux8OkcpvRKy0VyUbGMQCQ63Z/gU2ydxz7+NlnLhc8brHaKLTYRabc/cktH
         W53Q==
X-Gm-Message-State: AOAM532mKUSZbOhibApDIzSuQJBxxN8xsMis1006qBsEtu3o/9LB/EWf
        BnHV+lmRCDVv8BxCHtxoclSZPZxYuw8K7g==
X-Google-Smtp-Source: ABdhPJyQ3nmKAufNKGqTqT8APv88VJdT9ouLPNvkNYUJN1uBwgOmGSO+wGlCRvIeS5kqy5Wyly3tWQ==
X-Received: by 2002:a1c:790e:: with SMTP id l14mr10765329wme.119.1625828782591;
        Fri, 09 Jul 2021 04:06:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a4sm4978167wru.55.2021.07.09.04.06.21
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
Subject: [PATCH v4 3/5] revision.[ch]: add a "handle_stdin_line" API
Date:   Fri,  9 Jul 2021 13:06:14 +0200
Message-Id: <patch-3.5-60ef49df3b8-20210709T105851Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-0.5-00000000000-20210709T105850Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20210621T150651Z-avarab@gmail.com> <cover-0.5-00000000000-20210709T105850Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the rev_info stdin parsing API to support hooking into its
read_revisions_from_stdin() function, in the next commit we'll change
the the custom stdin parsing in pack-objects.c to use it..

For that use-case adding API is barely justified. We'll be able to
make the handle_revision_arg() static in exchange for it, and we'll
avoid the duplicate dance around setting "save_warning" and
"warn_on_object_refname_ambiguity", but we could just continue to do
that ourselves in builtin/pack-objects.c

The real reason to add this is for a change not part of this
series. We'll soon teach "git bundle create" to accept
revision/refname pairs on stdin, and thus do away with the limitation
of it being impossible to create bundles with ref tips that don't
correspond to the state of the current repository. I.e. this will
work:

    $ printf "e83c5163316f89bfbde7\trefs/heads/first-git-dot-git-commit\n" |
    git bundle create initial.bundle --stdin

As well as things like:

    $ git for-each-ref 'refs/remotes/origin' |
    sed 's!\trefs/remotes/origin/!\trefs/heads/!' |
    git bundle create origin.bundle --stdin

In order to do that we'll need to modify the lines we consume on stdin
revision.c (which bundle.c uses already), and be assured that that
stripping extra bundle-specific data from them is the only change in
behavior.

That change will be much more complex if bundle.c needs to start doing
its own stdin parsing again outside of revision.c, it was recently
converted to use revision.c's parsing in 5bb0fd2cab5 (bundle:
arguments can be read from stdin, 2021-01-11)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 revision.c | 22 ++++++++++++++++++++++
 revision.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/revision.c b/revision.c
index f30b9d40af4..557b7f113a9 100644
--- a/revision.c
+++ b/revision.c
@@ -2120,6 +2120,19 @@ static void read_revisions_from_stdin(struct rev_info *revs,
 		int len = sb.len;
 		if (!len)
 			break;
+
+		if (revs->handle_stdin_line) {
+			enum rev_info_stdin_line ret = revs->handle_stdin_line(
+				revs, &sb, revs->stdin_line_priv);
+
+			switch (ret) {
+			case REV_INFO_STDIN_LINE_PROCESS:
+				break;
+			case REV_INFO_STDIN_LINE_CONTINUE:
+				continue;
+			}
+		}
+
 		if (sb.buf[0] == '-') {
 			if (len == 2 && sb.buf[1] == '-') {
 				seen_dashdash = 1;
@@ -2743,6 +2756,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 
 			if (!strcmp(arg, "--stdin")) {
 				switch (revs->stdin_handling) {
+				case REV_INFO_STDIN_ALWAYS_READ:
 				case REV_INFO_STDIN_IGNORE:
 					argv[left++] = arg;
 					continue;
@@ -2791,6 +2805,14 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		}
 	}
 
+	/*
+	 * We're asked to ALWAYS_READ from stdin, but no --stdin
+	 * option (or "consumed_stdin" would be set).
+	 */
+	if (!revs->consumed_stdin &&
+	    revs->stdin_handling == REV_INFO_STDIN_ALWAYS_READ)
+		read_revisions_from_stdin(revs, &prune_data);
+
 	if (prune_data.nr) {
 		/*
 		 * If we need to introduce the magic "a lone ':' means no
diff --git a/revision.h b/revision.h
index a942b1250ad..52241c84c5b 100644
--- a/revision.h
+++ b/revision.h
@@ -89,8 +89,17 @@ struct topo_walk_info;
 enum rev_info_stdin {
 	REV_INFO_STDIN_CONSUME_ON_OPTION,
 	REV_INFO_STDIN_IGNORE,
+	REV_INFO_STDIN_ALWAYS_READ,
 };
 
+enum rev_info_stdin_line {
+	REV_INFO_STDIN_LINE_PROCESS,
+	REV_INFO_STDIN_LINE_CONTINUE,
+};
+
+typedef enum rev_info_stdin_line (*rev_info_stdin_line_func)(
+	struct rev_info *revs, struct strbuf *line, void *stdin_line_priv);
+
 struct rev_info {
 	/* Starting list */
 	struct commit_list *commits;
@@ -126,6 +135,9 @@ struct rev_info {
 	 *
 	 * Can be set to REV_INFO_STDIN_IGNORE to ignore the --stdin
 	 * option.
+	 *
+	 * Set it to REV_INFO_STDIN_ALWAYS_READ if there's always data
+	 * on stdin to be read, even if no --stdin option is provided.
 	 */
 	enum rev_info_stdin stdin_handling;
 
@@ -136,6 +148,24 @@ struct rev_info {
 	 */
 	int consumed_stdin:1;
 
+	/*
+	 * When reading from stdin (see "stdin_handling" above) define
+	 * a handle_stdin_line function to consume the lines.
+	 *
+	 * - Return REV_INFO_STDIN_LINE_PROCESS to continue
+	 *   revision.c's normal processing of the line (after
+	 *   possibly munging the provided strbuf).
+	 *
+	 * - Return REV_INFO_STDIN_LINE_CONTINUE to indicate that the
+	 *   line is fully processed, moving onto the next line (if
+	 *   any)
+	 *
+	 * Use the "stdin_line_priv" to optionally pass your own data
+	 * around.
+	 */
+	rev_info_stdin_line_func handle_stdin_line;
+	void *stdin_line_priv;
+
 	/* topo-sort */
 	enum rev_sort_order sort_order;
 
-- 
2.32.0.636.g43e71d69cff

