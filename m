Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6352C433EF
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 22:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbiF1WZ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 18:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiF1WZP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 18:25:15 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8571958E
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 15:22:47 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id g39-20020a05600c4ca700b003a03ac7d540so7597606wmp.3
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 15:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=v6v9mXbDXCWqPP3MGl7Soe967bko8vmZ4D/7QALsg/E=;
        b=KTsyjJ8rB2fknrIBh0KindslgfqsC+c1ipenkGf1Q6r8+l8TMRsOlaJleW250OgqZ3
         rTOK4Q7W7+43zx36SvMjWL6BCORcHZ6+xFXMoFqgYpiazToHYgnysq6igF07XC0n5v5O
         0fj0Gzo7tyWuHASWOqTVwuowKD/guBkLkR8t073IZJGoNzbKZUKPDuOXob9U+LdEcIOI
         iVx3jIaTUh2/SXlbK5O2cgWF2tBMuSwi10q3BdYq2oCKfCFV9pwEObODm2EXwapNcAJt
         gyZ9euaSCeuHIocDkK0GwWvT/4FYC3gjvJxlh8w/PXhR+8OdnyE70JxYum2qWeeYnU8f
         RWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=v6v9mXbDXCWqPP3MGl7Soe967bko8vmZ4D/7QALsg/E=;
        b=U/A8sO6xaw8ZqXmN75DxGnxs5HoCX3O96pmInP/3La6nBbMeY00xqTdJq+s+H3tU1N
         0idfGV0eTq+fjWtyDSoVvJHcGhjQgXIxV+xxh6tnFExrGHSJHC7Hvczh63YdsX+GxH9N
         rzVENsrE7PBzjGT0Bza+/6VEoFQuCxqwJ2C/EtHEXjUKyY7JnLRrnsUn0X84AR/x9qny
         +RT36gYFDtoVtCrjTpupYxkDfMslJEFFHBDC91YLJP7ixjyG+2zuCePUSAfBZ8uL/nQX
         z1wg5Ypuc93Hb5qSnhRNOPq5QK3wlbSNorU2Cx+F7LJDjbsui+sTOZmVKHjmfChYIkYO
         268A==
X-Gm-Message-State: AJIora/B8l2np+1q6SWIEAiqekn27W7J5hrwxbqaEaxjOCr1pnC96H17
        ssT65WyFkmxZ6KiU2oRjKwZjuEwimWrFBg==
X-Google-Smtp-Source: AGRyM1vZOh82TiVsu1Zfu5jNxBB7xghNrSDO/V7Fpi/pYGBM3OvNYPWIJh2skPZurpabd7ZcyvCWOA==
X-Received: by 2002:a05:600c:274b:b0:3a0:47e8:ca85 with SMTP id 11-20020a05600c274b00b003a047e8ca85mr2083171wmw.156.1656454965911;
        Tue, 28 Jun 2022 15:22:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r16-20020a05600c35d000b003a0375c4f73sm875149wmq.44.2022.06.28.15.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 15:22:45 -0700 (PDT)
Message-Id: <pull.1273.git.1656454964378.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Jun 2022 22:22:44 +0000
Subject: [PATCH] add --interactive: allow `update` to stage deleted files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christoph Reiter <reiter.christoph@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The scripted version of `git add -i` used `git update-index --add
--remove`, but the built-in version implemented only the `--add` part.

This fixes https://github.com/msys2/MSYS2-packages/issues/3066

Reported-by: Christoph Reiter <reiter.christoph@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    add --interactive: fix bug in built-in variant
    
    This fixes a bug when using the built-in version of git add -i to update
    a file that has been deleted (in order to stage its deletion), where it
    fails with:
    
    fatal: unable to stat 'myfile': No such file or directory
    
    
    Since the built-in version of git add -i has been made the default in
    v2.37.0, from the users' point of view this is a regression, and this
    patch fixes it. I therefore consider this v2.37.1 material.
    
    This addresses https://github.com/msys2/MSYS2-packages/issues/3066

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1273%2Fdscho%2Fadd-i-update-deleted-file-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1273/dscho/add-i-update-deleted-file-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1273

 add-interactive.c          | 12 ++++++++++--
 t/t3701-add-interactive.sh |  9 +++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 6047e8f6489..22fcd3412ca 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -697,8 +697,16 @@ static int run_update(struct add_i_state *s, const struct pathspec *ps,
 
 	for (i = 0; i < files->items.nr; i++) {
 		const char *name = files->items.items[i].string;
-		if (files->selected[i] &&
-		    add_file_to_index(s->r->index, name, 0) < 0) {
+		struct stat st;
+
+		if (!files->selected[i])
+			continue;
+		if (lstat(name, &st) && is_missing_file_error(errno)) {
+			if (remove_file_from_index(s->r->index, name) < 0) {
+				res = error(_("could not stage '%s'"), name);
+				break;
+			}
+		} else if (add_file_to_index(s->r->index, name, 0) < 0) {
 			res = error(_("could not stage '%s'"), name);
 			break;
 		}
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index fc26cb8bae8..b354fb39de8 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -103,6 +103,15 @@ test_expect_success 'status works (commit)' '
 	grep "+1/-0 *+2/-0 file" output
 '
 
+test_expect_success 'update can stage deletions' '
+	>to-delete &&
+	git add to-delete &&
+	rm to-delete &&
+	test_write_lines u t "" | git add -i &&
+	git ls-files to-delete >output &&
+	test_must_be_empty output
+'
+
 test_expect_success 'setup expected' '
 	cat >expected <<-\EOF
 	index 180b47c..b6f2c08 100644

base-commit: e4a4b31577c7419497ac30cebe30d755b97752c5
-- 
gitgitgadget
