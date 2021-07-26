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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87448C432BE
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 12:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68058608FB
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 12:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbhGZMGc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 08:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbhGZMFv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 08:05:51 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FD7C061765
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 05:46:17 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l11-20020a7bc34b0000b029021f84fcaf75so8110058wmj.1
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 05:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TPblhcHA6097nBq4dRK5qfiVYoDWzlFBEFuiC8qcpME=;
        b=REKBPT3/0uyv/jxNluACSUguf2SSTutPnrxCJY7CIffmpqw6+TR7FxdmZclQOXGVZt
         AKgrLKe6FPwrG2SBUNG8+KtgjGCCrE0x7rmvJ0jT0XhRdl6hQlxwuHRnBclEFg/deDj0
         aET+Yn5INBjlrkBXGvBc6LZoJfKmTHLj2/vqoZ7s4JUcXSNfhjcgqPQ8Z0DqQ9QJ1G8F
         OvxyBJhF8HkdEnKRUHDhO+5fzI4Y9yFuLWWDUZ5Wcjs/kSQw6q9Zv/G3fHdouOUo7FhT
         PUpmJcoOrsOk8u7ruak7fALXXoLT3CCQO//SsJAib30SIzJBApRBd3baxqtuLv3nQSuD
         Uxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TPblhcHA6097nBq4dRK5qfiVYoDWzlFBEFuiC8qcpME=;
        b=gxWpEXQ46i0H0gqdghN8t6/ledo0xwIBbX+T2MIed0LiU7DMVVFTDV/K85szas5hbr
         0eOXnVhIJAIng8HIGt+J1ZB7JkBcQlpsyZubDNS4wO6Mn9n3NEqQy4nvIqZQIL9K9X0E
         NHQhy/0QQeos0qx+9iQe7ehPGt4NeX2mEWmMGN1CWHvBRjHw3leSTltt2XFqjW8FYN7I
         iy9RhGmGtkpp5TWqvP/CnCrY/Ak+sLSrNQ5rNFuEIuIvjcuKWOB9BTAEMjJADulWI1KT
         h0v1MbHrNqLp4ofDyD6Ud0nlcugO24sUxV0yIP+wNi/+tqchq1H4cQsWgf0nysm0DtDr
         uOVg==
X-Gm-Message-State: AOAM532O8Vd1wtpsPm/YYLyOu9HzFqAG+74nqpxOl0bo+f+MoAmL3PSB
        y0ZxoL+zKvdAtjd1022/lkTG9ypXvAfUuQ==
X-Google-Smtp-Source: ABdhPJysFm4+CQixsZxypH1bOQ5OdQVIafsTXQkYF8GFTZ+mvcbWC5FZ2X8ijMzF0e0A95hqYlpRdw==
X-Received: by 2002:a1c:f214:: with SMTP id s20mr16908694wmc.14.1627303575275;
        Mon, 26 Jul 2021 05:46:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w18sm45155444wrg.68.2021.07.26.05.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 05:46:14 -0700 (PDT)
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
Subject: [PATCH v5 3/5] revision.[ch]: add a "handle_stdin_line" API
Date:   Mon, 26 Jul 2021 14:46:08 +0200
Message-Id: <patch-3.5-e3d24bd6e8a-20210726T124425Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.956.g6b0c84ceda8
In-Reply-To: <cover-0.5-00000000000-20210726T124425Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210709T105850Z-avarab@gmail.com> <cover-0.5-00000000000-20210726T124425Z-avarab@gmail.com>
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
index 50909339a59..3f6ab834aff 100644
--- a/revision.c
+++ b/revision.c
@@ -2119,6 +2119,19 @@ static void read_revisions_from_stdin(struct rev_info *revs,
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
@@ -2742,6 +2755,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 
 			if (!strcmp(arg, "--stdin")) {
 				switch (revs->stdin_handling) {
+				case REV_INFO_STDIN_ALWAYS_READ:
 				case REV_INFO_STDIN_IGNORE:
 					argv[left++] = arg;
 					continue;
@@ -2790,6 +2804,14 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
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
index 99458cc0647..644b7c8a217 100644
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
 	unsigned int consumed_stdin:1;
 
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
2.32.0.956.g6b0c84ceda8

