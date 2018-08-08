Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E4521F405
	for <e@80x24.org>; Wed,  8 Aug 2018 22:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731789AbeHIAzR (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 20:55:17 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:51060 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731123AbeHIAzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 20:55:16 -0400
Received: by mail-ua0-f201.google.com with SMTP id g9-v6so2985185uam.17
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 15:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AVNULVQ25yam2AnAdbjEXe8iFV328mCaXNEqnsXoV2Q=;
        b=KM9SSfe6p8cQicnX4cJKAp0ZniR7BVbmn+tGG6HQZ1Z4Z2+xwDUK+VNc7aM/fAqfqP
         frYWZKO9IlSTMFDtj9WsTzOOzVcPzpqSg90FFsG/LcisuLnyBmMBVbNLHpWB0AB6jfcl
         Cc4bMFVQ2yzvzNQ0y7Bs1pLlltz4IAAHEovou1RLqaME//EE1jXUGPAEVAEXTX5ADcOc
         3KZW3Wzh8A0bLLifGWk3g5Zm7nzcDU9rfW49rPt7P/U67z4dIt8xGLfrvpTTZSx3rZjR
         O0ywfPCPen1dkdwg6EPTUH4QPeGHYFeT9d9/11G38Ck0hS52XTlQRnEEHxTQBMp/8Gws
         LTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AVNULVQ25yam2AnAdbjEXe8iFV328mCaXNEqnsXoV2Q=;
        b=H4hsRaH3tt9bx3k/PQTQIRHCXwbpaa9cbBzEQC5e6a1v3wHfTm8A6AFMEl5/E7t8c5
         BWPYJso4K7ZA5pWp0KZEeDQCOiNsfvIe09w1+uvzmtcGgo6uPAVWYhn3DJvR0FUmrTMF
         fYKLw6w/2Y2jkAUpHx/GtxPHoQpg7QzpLc/OgMJnOFV6RJQvG/sKsgZXJx87Ai5K+dZ3
         xyrciQ3wG9fsA1a3MytQmJ8P25u0tIhRTBb7NUblxzaJqbO+Ao4EdLz+5QReCnzdc0wV
         2yArRYoRpl94Gq9EvmskrbXPCdgXp4PAcS6izIlQJRg6kk7qZrT6Bln2bikVB34lKN8H
         xLaA==
X-Gm-Message-State: AOUpUlGpHYNXIq8ommSrbVJP/WlcQXshdFtqFaDbYozrVUNJLE/vvZTS
        G/yM5ullOqeDuLGTTFJIyt5h1p9n56I/gmmJdZUBKn4hTosVILlKa97hX7LQj3WJdtuQMG0tUbS
        a/jAAsjiTBYGmjJbrFcymMA+Dupmyzjzbg5nczPfLrIxqJ9GVt3vdvU/KzA==
X-Google-Smtp-Source: AA+uWPzOOwKu9BjF1rJJVLRkCXMJ8xQpHoJKiDP+Uyyt5fGYeLcIu06Pa9Fk5ullGdMQiBQ3Szm+Gmbs7lU=
X-Received: by 2002:a1f:6b5b:: with SMTP id g88-v6mr2417450vkc.99.1533767611649;
 Wed, 08 Aug 2018 15:33:31 -0700 (PDT)
Date:   Wed,  8 Aug 2018 15:33:23 -0700
In-Reply-To: <20180808223323.79989-1-bmwill@google.com>
Message-Id: <20180808223323.79989-3-bmwill@google.com>
Mime-Version: 1.0
References: <20180807230637.247200-1-bmwill@google.com> <20180808223323.79989-1-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH 2/2] submodule: munge paths to submodule git directories
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 0383bbb901 (submodule-config: verify submodule names as paths,
2018-04-30) introduced some checks to ensure that submodule names don't
include directory traversal components (e.g. "../").

This addresses the vulnerability identified in 0383bbb901 but the root
cause is that we use submodule names to construct paths to the
submodule's git directory.  What we really should do is munge the
submodule name before using it to construct a path.

Teach "submodule_name_to_gitdir()" to munge a submodule's name (by url
encoding it) before using it to build a path to the submodule's gitdir.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 submodule.c                 | 14 ++++++++++++++
 t/t7400-submodule-basic.sh  | 32 +++++++++++++++++++++++++++++++-
 t/t7406-submodule-update.sh | 21 ++++++---------------
 3 files changed, 51 insertions(+), 16 deletions(-)

diff --git a/submodule.c b/submodule.c
index 24eced34e7..4854d88ce8 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1965,6 +1965,20 @@ int submodule_to_gitdir(struct strbuf *buf, const char *submodule)
 void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
 			      const char *submodule_name)
 {
+	size_t modules_len;
+
 	strbuf_git_common_path(buf, r, "modules/");
+	modules_len = buf->len;
 	strbuf_addstr(buf, submodule_name);
+
+	/*
+	 * If the submodule gitdir already exists using the old-fashioned
+	 * location (which uses the submodule name as-is, without munging it)
+	 * then return that.
+	 */
+	if (!access(buf->buf, F_OK))
+		return;
+
+	strbuf_setlen(buf, modules_len);
+	strbuf_addstr_urlencode(buf, submodule_name, 1);
 }
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 2c2c97e144..963693332c 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -933,7 +933,7 @@ test_expect_success 'recursive relative submodules stay relative' '
 		cd clone2 &&
 		git submodule update --init --recursive &&
 		echo "gitdir: ../.git/modules/sub3" >./sub3/.git_expect &&
-		echo "gitdir: ../../../.git/modules/sub3/modules/dirdir/subsub" >./sub3/dirdir/subsub/.git_expect
+		echo "gitdir: ../../../.git/modules/sub3/modules/dirdir%2fsubsub" >./sub3/dirdir/subsub/.git_expect
 	) &&
 	test_cmp clone2/sub3/.git_expect clone2/sub3/.git &&
 	test_cmp clone2/sub3/dirdir/subsub/.git_expect clone2/sub3/dirdir/subsub/.git
@@ -1324,4 +1324,34 @@ test_expect_success 'recursive clone respects -q' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'resolve submodule gitdir in superprojects modules directory' '
+	test_when_finished "rm -rf superproject submodule" &&
+
+	# Create a superproject with a submodule which contains a "/"
+	test_create_repo submodule &&
+	test_commit -C submodule one &&
+	test_create_repo superproject &&
+	git -C superproject submodule add ../submodule sub/module &&
+	git -C superproject commit -m "add submodule" &&
+
+	# "/" characters in submodule names are properly urlencoded before
+	# being used to construct a path to the submodules gitdir.
+	cat >expect <<-EOF &&
+	$(git -C superproject rev-parse --git-common-dir)/modules/sub%2fmodule
+	EOF
+	git -C superproject submodule--helper gitdir "sub/module" >actual &&
+	test_cmp expect actual &&
+	test_path_is_dir "superproject/.git/modules/sub%2fmodule" &&
+
+	# Test the old-fashioned way of storing submodules in the
+	# "modules" directory by directly renaming the submodules gitdir
+	mkdir superproject/.git/modules/sub/ &&
+	mv superproject/.git/modules/sub%2fmodule superproject/.git/modules/sub/module &&
+	cat >expect <<-EOF &&
+	$(git -C superproject rev-parse --git-common-dir)/modules/sub/module
+	EOF
+	git -C superproject submodule--helper gitdir "sub/module" >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index f604ef7a72..fb744c5c39 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -777,12 +777,8 @@ test_expect_success 'submodule add places git-dir in superprojects git-dir' '
 	(cd super &&
 	 mkdir deeper &&
 	 git submodule add ../submodule deeper/submodule &&
-	 (cd deeper/submodule &&
-	  git log > ../../expected
-	 ) &&
-	 (cd .git/modules/deeper/submodule &&
-	  git log > ../../../../actual
-	 ) &&
+	 git -C deeper/submodule log >expected &&
+	 git -C .git/modules/deeper%2fsubmodule log >actual &&
 	 test_cmp actual expected
 	)
 '
@@ -795,12 +791,9 @@ test_expect_success 'submodule update places git-dir in superprojects git-dir' '
 	(cd super2 &&
 	 git submodule init deeper/submodule &&
 	 git submodule update &&
-	 (cd deeper/submodule &&
-	  git log > ../../expected
-	 ) &&
-	 (cd .git/modules/deeper/submodule &&
-	  git log > ../../../../actual
-	 ) &&
+
+	 git -C deeper/submodule log >expected &&
+	 git -C .git/modules/deeper%2fsubmodule log >actual &&
 	 test_cmp actual expected
 	)
 '
@@ -815,9 +808,7 @@ test_expect_success 'submodule add places git-dir in superprojects git-dir recur
 	  git commit -m "added subsubmodule" &&
 	  git push origin :
 	 ) &&
-	 (cd .git/modules/deeper/submodule/modules/subsubmodule &&
-	  git log > ../../../../../actual
-	 ) &&
+	 git -C .git/modules/deeper%2fsubmodule/modules/subsubmodule log >actual &&
 	 git add deeper/submodule &&
 	 git commit -m "update submodule" &&
 	 git push origin : &&
-- 
2.18.0.597.ga71716f1ad-goog

