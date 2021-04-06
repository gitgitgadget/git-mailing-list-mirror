Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEB9C43460
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 02:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E025613AD
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 02:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243486AbhDFC4I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 22:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbhDFC4I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 22:56:08 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BF1C06174A
        for <git@vger.kernel.org>; Mon,  5 Apr 2021 19:56:00 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id b17so5696743pgh.7
        for <git@vger.kernel.org>; Mon, 05 Apr 2021 19:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h8m4mlM7hDn5cOGEFFlvz9sCxK1sqaLtJ2TIBvVjOkU=;
        b=d+YVuYnws3c04Yvgjg0Te6WZdNW/gyMIaulm1tbhnN985udI9V4H4aP+Bbx/Wnrb2H
         1AVUjS4VCwi+tjdxfMLL/0be2I+sX94PDgSYoGq1/ADMM1JnDVQyH0i9e3cpcU0QArDj
         BvcPIaWxKDt/Tu3506uJJb5lU2KU5GFQANwx4etbQoyQZQMsLSQy07lR57UTUcoJp/Bh
         nsIMU5aM9Zo2WZsx8hMAUgbho8yXZbKGj+bnXk59diVp/FAF4J8/Kqfl5VcILw2i4Db+
         tfbPAEEXYQz0PVJNoUxCJepiaaJxBhtIJh4dvlE7WBVAfOLmap+EkHNtnuBenMPCX80A
         mJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h8m4mlM7hDn5cOGEFFlvz9sCxK1sqaLtJ2TIBvVjOkU=;
        b=SrYKqAJp7dn+aIq5LqbIG0LSsM74MSsO4iwbdjGF5QANVFNWlRzPZ5PUgkhep/7jUq
         VhSuwI3/tW0eHSAFHLzhprFZwk5Z1I20wUvJ0yck9CezmKW+2nTXW6eB1f9YLazyh0eh
         l+s+Qu0CHmgUYC/eTiWHEgC+LYTVaYWElEa1hhBQDrwraP59XEahafrk8eufGJC7wB8f
         h2ppLmtto6dyzDdkKwNDdP5mIeFdJ1qlPPftCcOnrSZwpdlgaXXGi7S9dWEWbDfpXzT7
         uZ3WfuHcQyTq7RouN4z44HsJ+zNiRV7c0kA4KvdLM5z4l02GNqB5Brc+xVpAApFisCAl
         PLZw==
X-Gm-Message-State: AOAM532ZJKryrTBKIhUMHL7lQ2Fi3pwXmA8XKKREIv6IyWhRLRqP2Jfa
        MLv93SHVxl8K0vcpZm0+vwJ0/dzQz44VLvFa
X-Google-Smtp-Source: ABdhPJy7oCoylbgKqH4jeOiwNzQV54svbFxbSnUq+Q/VuAMImYXKSHfMnpACYxiflK4GZCpPpYQeqg==
X-Received: by 2002:aa7:956d:0:b029:1f1:5ba6:2a58 with SMTP id x13-20020aa7956d0000b02901f15ba62a58mr26269326pfq.63.1617677759005;
        Mon, 05 Apr 2021 19:55:59 -0700 (PDT)
Received: from jerry-desktop.localdomain ([50.236.240.214])
        by smtp.gmail.com with ESMTPSA id u25sm16877992pgk.34.2021.04.05.19.55.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Apr 2021 19:55:58 -0700 (PDT)
From:   Jerry Zhang <jerry@skydio.com>
To:     git@vger.kernel.org, newren@gmail.com, gitster@pobox.com
Cc:     ross@skydio.com, abe@skydio.com, brian.kubisiak@skydio.com,
        Jerry Zhang <jerry@skydio.com>
Subject: [PATCH] git-apply: try threeway first when "--3way" is used
Date:   Mon,  5 Apr 2021 19:55:51 -0700
Message-Id: <20210406025551.25213-1-jerry@skydio.com>
X-Mailer: git-send-email 2.31.1.165.g83e21c9f89
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The apply_fragments() method of "git apply"
can silently apply patches incorrectly if
a file has repeating contents. In these
cases a three-way merge can apply it correctly
or show a conflict. However, because the patches
apply "successfully" using apply_fragments(),
git will never fall back to the merge, even
if the "--3way" flag is used, and the user has
no way to ensure correctness by forcing the
three-way merge method.

Change the behavior so that when "--3way" is
used, git will always try the three-way merge
first and will only fall back to apply_fragments()
in caseswhere blobs are not available or some other
error (but not in the case of a merge conflict).

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
index 6695a931e979a968b28af88d425d0c76ba17d0d4..62d65ef8d9c0b68857db55198c73db1f41589df1 100644
--- a/apply.c
+++ b/apply.c
@@ -3569,10 +3569,10 @@ static int try_threeway(struct apply_state *state,
 		write_object_file("", 0, blob_type, &pre_oid);
 	else if (get_oid(patch->old_oid_prefix, &pre_oid) ||
 		 read_blob_object(&buf, &pre_oid, patch->old_mode))
-		return error(_("repository lacks the necessary blob to fall back on 3-way merge."));
+		return error(_("repository lacks the necessary blob to do 3-way merge."));
 
 	if (state->apply_verbosity > verbosity_silent)
-		fprintf(stderr, _("Falling back to three-way merge...\n"));
+		fprintf(stderr, _("Doing three-way merge...\n"));
 
 	img = strbuf_detach(&buf, &len);
 	prepare_image(&tmp_image, img, len, 1);
@@ -3604,7 +3604,7 @@ static int try_threeway(struct apply_state *state,
 	if (status < 0) {
 		if (state->apply_verbosity > verbosity_silent)
 			fprintf(stderr,
-				_("Failed to fall back on three-way merge...\n"));
+				_("Failed to do three-way merge...\n"));
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
index d62db3fbe16f35a625a4a14eebb70034f695d3eb..0a7332fed5f60a8a2c9c25fc6713d513c3f0ace1 100755
--- a/t/t4108-apply-threeway.sh
+++ b/t/t4108-apply-threeway.sh
@@ -160,4 +160,24 @@ test_expect_success 'apply -3 with add/add conflict (dirty working tree)' '
 	test_cmp three.save three
 '
 
+test_expect_success 'apply -3 with ambiguous repeating file' '
+	git reset --hard &&
+	test_write_lines 1 2 1 2 1 2 1 2 1 2 1>one_two_repeat &&
+	git add one_two_repeat &&
+	git commit -m "init one" &&
+	test_write_lines 1 2 1 2 1 2 1 2 one 2 1>one_two_repeat &&
+	git commit -a -m "change one" &&
+
+	git diff HEAD~ >Repeat.diff &&
+	git reset --hard HEAD~ &&
+
+	test_write_lines 1 2 1 2 1 2 one 2 1 2 one>one_two_repeat &&
+	git commit -a -m "change surrounding one" &&
+
+	git apply --index --3way Repeat.diff &&
+	test_write_lines 1 2 1 2 1 2 one 2 one 2 one>expect &&
+
+	test_cmp expect one_two_repeat
+'
+
 test_done
-- 
2.29.0

