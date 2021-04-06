Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BCEC433B4
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 23:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88E4161205
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 23:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbhDFXZp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 19:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhDFXZo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 19:25:44 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307B6C06174A
        for <git@vger.kernel.org>; Tue,  6 Apr 2021 16:25:36 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id mj7-20020a17090b3687b029014d162a65b6so275302pjb.2
        for <git@vger.kernel.org>; Tue, 06 Apr 2021 16:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=74jV9edTpUgFwnQCJ0r/deza4SURfhyM1zt/f1VmzOA=;
        b=OFp+ZHcXuimz54JYuv1LHt+rxkwc4613iEim/TPIHpiqvLnZukYmBbYK6df/RWZkAT
         XmET6G+uYv2f2Gte3qLnmVyCT2ZDF1TauDh5cebajdpOeCa8+PGoEay1zBK27v0Y1YWK
         EgoZPwFUhwpnDQ7TSPuP2eRTJtXjuLxPToKfiwg/6qhv6MSq/jtnNoYvYZoxAUs0IUYV
         Qr25NBH0Jfcq+OiwdUL11jImPCMUfyH2zeMfhs76Xf34yEem4erb8tuoYoAVdir1dxSe
         yOayJYEb+ZmomT248x6+EdelM86wG837z61F+WiVEYayVooM5Sss/8Ku1/U70jZMWXZS
         EEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=74jV9edTpUgFwnQCJ0r/deza4SURfhyM1zt/f1VmzOA=;
        b=itFNphhD4Uy/6uAZHscoRerPD48YTxFRsCArybvoxdvVp1+PXKXnV57cKQ89/rJkaH
         bgT7YnGjqMWdJvhSCeUoNJvfpNJHvllXlDM4eMj0uTHtv52pzg2syY9ETgmxu/c5GZsJ
         bLdHCiafU9qdjcRzYllEtc8T9BUf2Yd6+/WmiN15BJKZtPGr3ut8ZbFWH/7ftSptRpIq
         xh4CuTMLo3YcEGrks0c/PD+d7n80/UeuZzimMSpZw+zM5rA++Bx7AQYhYpusT4TQ59+X
         AyeGWGNTtnfyDC7coVU/xvEQynW8hRy8TvLafpuRZ7ZuHkjAl9f5kLkZ3MI49K6Hgt/q
         ZNfQ==
X-Gm-Message-State: AOAM5332jX7k9a7BDasoAFX4L1MhUGWI/NokEKifnKLDdZqNFwckXJEH
        9M0XtiTQppHqYHxAt/39CNkFdI5X3mZbGSLR
X-Google-Smtp-Source: ABdhPJy6DvIw11Emb8wYebf5NMPs9Za0UjZPMwp5HHH3wWxQaOs3RsR8EdEBJtBEAqqL9ABLV8LG/g==
X-Received: by 2002:a17:902:7786:b029:e6:cc0f:4dff with SMTP id o6-20020a1709027786b02900e6cc0f4dffmr562042pll.4.1617751535196;
        Tue, 06 Apr 2021 16:25:35 -0700 (PDT)
Received: from jerry-desktop.localdomain ([50.236.240.214])
        by smtp.gmail.com with ESMTPSA id x22sm18971137pfa.24.2021.04.06.16.25.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Apr 2021 16:25:34 -0700 (PDT)
From:   Jerry Zhang <jerry@skydio.com>
To:     git@vger.kernel.org, newren@gmail.com, gitster@pobox.com
Cc:     ross@skydio.com, abe@skydio.com, brian.kubisiak@skydio.com,
        Jerry Zhang <jerry@skydio.com>
Subject: [PATCH] git-apply: try threeway first when "--3way" is used
Date:   Tue,  6 Apr 2021 16:25:32 -0700
Message-Id: <20210406232532.3543-1-jerry@skydio.com>
X-Mailer: git-send-email 2.31.1.165.gb6fb64cead
In-Reply-To: <20210406025551.25213-1-jerry@skydio.com>
References: <20210406025551.25213-1-jerry@skydio.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The apply_fragments() method of "git apply"
can silently apply patches incorrectly if
a file has repeating contents. In these
cases a three-way merge is capable of applying
it correctly in more situations, and will
show a conflict rather than applying it
incorrectly. However, because the patches
apply "successfully" using apply_fragments(),
git will never fall back to the merge, even
if the "--3way" flag is used, and the user has
no way to ensure correctness by forcing the
three-way merge method.

Change the behavior so that when "--3way" is used,
git will always try the three-way merge first and
will only fall back to apply_fragments() in cases
where blobs are not available or some other error
(but not in the case of a merge conflict).

Since user-facing results will be different,
this has backwards compatibility implications
for users depending on the old behavior. In
addition, the three-way merge will be slower
than direct patch application.

Signed-off-by: Jerry Zhang <jerry@skydio.com>
---
 Documentation/git-apply.txt |  5 ++---
 apply.c                     | 13 ++++++-------
 t/t4108-apply-threeway.sh   | 20 ++++++++++++++++++++
 3 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 91d9a8601c8c316d4649c405af42e531c39991a8..9144575299c264dd299b542b7b5948eef35f211c 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -84,9 +84,8 @@ OPTIONS
 
 -3::
 --3way::
-	When the patch does not apply cleanly, fall back on 3-way merge if
-	the patch records the identity of blobs it is supposed to apply to,
-	and we have those blobs available locally, possibly leaving the
+	Attempt 3-way merge if the patch records the identity of blobs it is supposed
+	to apply to and we have those blobs available locally, possibly leaving the
 	conflict markers in the files in the working tree for the user to
 	resolve.  This option implies the `--index` option, and is incompatible
 	with the `--reject` and the `--cached` options.
diff --git a/apply.c b/apply.c
index 6695a931e979a968b28af88d425d0c76ba17d0d4..9bd4efcbced842d2c5c030a0f2178ddb36114600 100644
--- a/apply.c
+++ b/apply.c
@@ -3569,10 +3569,10 @@ static int try_threeway(struct apply_state *state,
 		write_object_file("", 0, blob_type, &pre_oid);
 	else if (get_oid(patch->old_oid_prefix, &pre_oid) ||
 		 read_blob_object(&buf, &pre_oid, patch->old_mode))
-		return error(_("repository lacks the necessary blob to fall back on 3-way merge."));
+		return error(_("repository lacks the necessary blob to perform 3-way merge."));
 
 	if (state->apply_verbosity > verbosity_silent)
-		fprintf(stderr, _("Falling back to three-way merge...\n"));
+		fprintf(stderr, _("Performing three-way merge...\n"));
 
 	img = strbuf_detach(&buf, &len);
 	prepare_image(&tmp_image, img, len, 1);
@@ -3604,7 +3604,7 @@ static int try_threeway(struct apply_state *state,
 	if (status < 0) {
 		if (state->apply_verbosity > verbosity_silent)
 			fprintf(stderr,
-				_("Failed to fall back on three-way merge...\n"));
+				_("Failed to perform three-way merge...\n"));
 		return status;
 	}
 
@@ -3637,10 +3637,9 @@ static int apply_data(struct apply_state *state, struct patch *patch,
 	if (load_preimage(state, &image, patch, st, ce) < 0)
 		return -1;
 
-	if (patch->direct_to_threeway ||
-	    apply_fragments(state, &image, patch) < 0) {
+	if (!state->threeway || try_threeway(state, &image, patch, st, ce) < 0) {
 		/* Note: with --reject, apply_fragments() returns 0 */
-		if (!state->threeway || try_threeway(state, &image, patch, st, ce) < 0)
+		if (patch->direct_to_threeway || apply_fragments(state, &image, patch) < 0)
 			return -1;
 	}
 	patch->result = image.buf;
@@ -5017,7 +5016,7 @@ int apply_parse_options(int argc, const char **argv,
 		OPT_BOOL(0, "apply", force_apply,
 			N_("also apply the patch (use with --stat/--summary/--check)")),
 		OPT_BOOL('3', "3way", &state->threeway,
-			 N_( "attempt three-way merge if a patch does not apply")),
+			 N_( "attempt three-way merge, fall back on normal patch if that fails")),
 		OPT_FILENAME(0, "build-fake-ancestor", &state->fake_ancestor,
 			N_("build a temporary index based on embedded index information")),
 		/* Think twice before adding "--nul" synonym to this */
diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
index d62db3fbe16f35a625a4a14eebb70034f695d3eb..9ff313f976422f9c12dc8032d14567b54cfe3765 100755
--- a/t/t4108-apply-threeway.sh
+++ b/t/t4108-apply-threeway.sh
@@ -160,4 +160,24 @@ test_expect_success 'apply -3 with add/add conflict (dirty working tree)' '
 	test_cmp three.save three
 '
 
+test_expect_success 'apply -3 with ambiguous repeating file' '
+	git reset --hard &&
+	test_write_lines 1 2 1 2 1 2 1 2 1 2 1 >one_two_repeat &&
+	git add one_two_repeat &&
+	git commit -m "init one" &&
+	test_write_lines 1 2 1 2 1 2 1 2 one 2 1 >one_two_repeat &&
+	git commit -a -m "change one" &&
+
+	git diff HEAD~ >Repeat.diff &&
+	git reset --hard HEAD~ &&
+
+	test_write_lines 1 2 1 2 1 2 one 2 1 2 one >one_two_repeat &&
+	git commit -a -m "change surrounding one" &&
+
+	git apply --index --3way Repeat.diff &&
+	test_write_lines 1 2 1 2 1 2 one 2 one 2 one >expect &&
+
+	test_cmp expect one_two_repeat
+'
+
 test_done
-- 
2.29.0

