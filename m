Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56617C43331
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 16:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2739620774
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 16:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqjHylZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbgCXQA6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:00:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42395 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbgCXQA6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 12:00:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id h8so9216176pgs.9
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 09:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ld6nJ+2BysYcXOhNZgaFNRNZqbac3YsF5QcaEiWSUDU=;
        b=UqjHylZb3OioopHpd5aZjTQZXvQXAI95aKYBaR7U8UOR5Ufs3pf8NiO21BkXtpz3YT
         MeQXQCHnVSoU2XFH8RmH6L9Psq8+/nGVUi2ZdkXzf3KOqZGv+zPjDNThcqC3izyEG+Bm
         kqmROyCtttJbrD/7j1Q8cICnZBx+7ID3lmCzXoSb1NIVXnwGUgOR7pKTfNMQJ6niIEZN
         gP5LZdX3/DpJC8ScwbmgSmil2zPyeEF61oa4+sIW0VLq7PheAgHxoF09iBx5luJQfGrN
         CNSzyX9326f3t7i7FvTyDI6cohpRulZWSDw1jDkdk1Qc2+iVksSAnXxBgYKlN8tabI2T
         UF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ld6nJ+2BysYcXOhNZgaFNRNZqbac3YsF5QcaEiWSUDU=;
        b=O7wFfB2RuH3ULCZeF94fe+HsZqFC9cSPS/RqGXtJDZx135nhi3evcTz/QvbPycvFvC
         kSiBhKgZPBOZApgU9BN1/cVs/zWMZOV+lfGcoD2p8Cwo1XAczM6mwEKpcmPmihXz7/xO
         7mYc/adTyNQpa5oN/VnScEN5HG77e7jW9WpyXuH4pYkVyeh1sPTvUdVrscQvoJaz8Sh/
         5ShHyRWys1zKJnlva/OyfCn5vlWakFh7EcX9GeZiftJitNrhAS3KKcqJyTASvRJZTol5
         h28OQnDyG/bzRfVPoYkrMj3ZrfhkFDsbTluC10C6UThCv95H0QxhrOIWB21jklBiGbyt
         K9sw==
X-Gm-Message-State: ANhLgQ1PRMCgKWiWgNL7jZl3r8OnBpP16Mz5NPEwqVVYnZr7EcEEEh0Z
        4ALWKHObiJJXM1Jcnc7H2AbY+vpP
X-Google-Smtp-Source: ADFU+vsnNVHYGniWldZqAEWmcjUjpe4+sszHOtDBVhkoyQtY3BCJhOuKxbflTaIN4BHyAEhfdn3oBw==
X-Received: by 2002:a63:195a:: with SMTP id 26mr26067220pgz.400.1585065656632;
        Tue, 24 Mar 2020 09:00:56 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e28f])
        by smtp.gmail.com with ESMTPSA id 193sm9472182pfa.182.2020.03.24.09.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 09:00:55 -0700 (PDT)
From:   Daniel Sommermann <dcsommer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: [RFC PATCH] git-apply: Permit change of file mode when filename does not change
Date:   Tue, 24 Mar 2020 09:00:54 -0700
Message-Id: <20200324160054.1535824-1-dcsommer@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation for git's diff format does not expressly disallow
changing the mode of a file without splitting it into a delete and
create. Mercurial's `hg diff --git` in fact produces git diffs with such
format. When applying such patches in Git, this assert can be hit. The check
preventing this type of diff has been around since 2005 in
3cca928d4aae691572ef9a73dcc29a04f66900a1.

Simply deleting the check that prevents changing the mode when not
renaming allows such diffs to work out of the box, as the attached test
case shows.
---
 apply.c                  | 18 ------------------
 t/t4115-apply-symlink.sh | 23 +++++++++++++++++++++++
 2 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/apply.c b/apply.c
index bdc008fae2..1b9d315771 100644
--- a/apply.c
+++ b/apply.c
@@ -3950,24 +3950,6 @@ static int check_patch(struct apply_state *state, struct patch *patch)
 		}
 	}
 
-	if (new_name && old_name) {
-		int same = !strcmp(old_name, new_name);
-		if (!patch->new_mode)
-			patch->new_mode = patch->old_mode;
-		if ((patch->old_mode ^ patch->new_mode) & S_IFMT) {
-			if (same)
-				return error(_("new mode (%o) of %s does not "
-					       "match old mode (%o)"),
-					patch->new_mode, new_name,
-					patch->old_mode);
-			else
-				return error(_("new mode (%o) of %s does not "
-					       "match old mode (%o) of %s"),
-					patch->new_mode, new_name,
-					patch->old_mode, old_name);
-		}
-	}
-
 	if (!state->unsafe_paths && check_unsafe_path(patch))
 		return -128;
 
diff --git a/t/t4115-apply-symlink.sh b/t/t4115-apply-symlink.sh
index 872fcda6cb..593e6142b4 100755
--- a/t/t4115-apply-symlink.sh
+++ b/t/t4115-apply-symlink.sh
@@ -44,4 +44,27 @@ test_expect_success 'apply --index symlink patch' '
 
 '
 
+cat >move_patch <<\EOF
+diff --git a/file_to_be_link b/file_to_be_link
+old mode 100644
+new mode 120000
+--- a/file_to_be_link
++++ b/file_to_be_link
+@@ -0,0 +1,1 @@
++target
+\ No newline at end of file
+EOF
+
+test_expect_success 'apply file-to-symlink patch' '
+
+	git checkout -f master &&
+	touch file_to_be_link &&
+	git add file_to_be_link &&
+	git commit -m initial &&
+
+	git apply move_patch &&
+	test target = $(readlink file_to_be_link)
+
+'
+
 test_done
-- 
2.25.1

