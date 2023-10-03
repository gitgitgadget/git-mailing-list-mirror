Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7679CE776C4
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 18:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240843AbjJCSvK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 14:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240811AbjJCSvE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 14:51:04 -0400
Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E5EB8
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 11:50:58 -0700 (PDT)
From:   "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1696359055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pvyT4RBKoDVaoynRlsQgeP8TyOF8pMx6dBxEAHOzq1Y=;
        b=JnyMG+gD59aXnh/fzI+9iJle2F66Ut0VVVzfBMV8gMx5fX1Xzj8XJjdKoH7kxm0qaLaVga
        WhdU4oAhv3pgE/A7sD2KYiU9JDn1l7JtaSWeSj+trN3NfT4S/IY/grfpwXLIhi8yQQtYjg
        ycbU5gox4QneNcS7m4ddEBbahvbTcR41s1s6U0tPBE9DRpn1FX60MKukGNIlw1iVv1WZdg
        4+YybSfcHcZZLgBdVjZjFF/3DyzItahtGGUXOGFxOXVyrKJz5p9l6l6XWdjaTQ0nCEzOFq
        zS5QBhxG7JIQvKlojln9YYSDN4t7IQUrYxfMktCzVLYSNVw8F9NrXIJNJQR40oh86WC1ls
        pbe4lE2m3zL+ThJQesiFR/fgJRZy5+8faiCf/cPvZydjSp1KcWKAzoR5og3jQxCK5LRGHe
        0AByRorhyORHSzeIrDKXSUnkVbSkJbbod14S38ItIgoGbhbKDiJV0o8lJx8RQP1aojE9G1
        ZmHjKhnye58TAWB34PRt2TkfQiBE7MsbFHYzkDRdDhRAGxtPM/3UXd7FpVTQ3GStS8L7zH
        DkgzQpGhx8iCxrHSv8b6IvgMZ6vBzyUaFjvRvzoXQQ/7+8YgVbJ0XZ3u3rivc8vr8OaCwc
        E3AgwrRkCqmLuctlIZ3JNnne8R4djBNYfAX0vOoCajyGGfySkjGJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1696359055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pvyT4RBKoDVaoynRlsQgeP8TyOF8pMx6dBxEAHOzq1Y=;
        b=kgZTCRDFjJa/qeXVAyfT7QFS0MOsIcNaNmmfADXu5Jd3l2vTOzx1xvkyNono0hhH+hDynV
        XQONzrb0lprkBpBQ==
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=heftig smtp.mailfrom=heftig@archlinux.org
To:     git@vger.kernel.org
Cc:     "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>
Subject: [PATCH 3/6] t7419: Actually test the branch switching
Date:   Tue,  3 Oct 2023 20:50:44 +0200
Message-ID: <20231003185047.2697995-3-heftig@archlinux.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231003185047.2697995-1-heftig@archlinux.org>
References: <0a0a157f88321d25fdb0be771a454b3410a449f3.camel@archlinux.org>
 <20231003185047.2697995-1-heftig@archlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The submodule repo the test set up had the 'topic' branch checked out,
meaning the repo's default branch (HEAD) is the 'topic' branch.

The following tests then pretended to switch between the default branch
and the 'topic' branch. This was papered over by continually adding
commits to the 'topic' branch and checking if the submodule gets updated
to this new commit.

Return the submodule repo to the 'main' branch after setup so we can
actually test the switching behavior.

Signed-off-by: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
---
 t/t7419-submodule-set-branch.sh | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/t/t7419-submodule-set-branch.sh b/t/t7419-submodule-set-branch.sh
index 232065504c..5ac16d0eb7 100755
--- a/t/t7419-submodule-set-branch.sh
+++ b/t/t7419-submodule-set-branch.sh
@@ -11,23 +11,28 @@ as expected.
 
 TEST_PASSES_SANITIZE_LEAK=true
 TEST_NO_CREATE_REPO=1
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup' '
 	git config --global protocol.file.allow always
 '
 
 test_expect_success 'submodule config cache setup' '
 	mkdir submodule &&
 	(cd submodule &&
 		git init &&
 		echo a >a &&
 		git add . &&
 		git commit -ma &&
 		git checkout -b topic &&
 		echo b >a &&
 		git add . &&
-		git commit -mb
+		git commit -mb &&
+		git checkout main
 	) &&
 	mkdir super &&
 	(cd super &&
@@ -57,41 +62,38 @@ test_expect_success 'test submodule set-branch --branch' '
 '
 
 test_expect_success 'test submodule set-branch --default' '
-	test_commit -C submodule c &&
 	(cd super &&
 		git submodule set-branch --default submodule &&
 		! grep branch .gitmodules &&
 		git submodule update --remote &&
 		cat <<-\EOF >expect &&
-		c
+		a
 		EOF
 		git -C submodule show -s --pretty=%s >actual &&
 		test_cmp expect actual
 	)
 '
 
 test_expect_success 'test submodule set-branch -b' '
-	test_commit -C submodule b &&
 	(cd super &&
 		git submodule set-branch -b topic submodule &&
 		grep "branch = topic" .gitmodules &&
 		git submodule update --remote &&
 		cat <<-\EOF >expect &&
 		b
 		EOF
 		git -C submodule show -s --pretty=%s >actual &&
 		test_cmp expect actual
 	)
 '
 
 test_expect_success 'test submodule set-branch -d' '
-	test_commit -C submodule d &&
 	(cd super &&
 		git submodule set-branch -d submodule &&
 		! grep branch .gitmodules &&
 		git submodule update --remote &&
 		cat <<-\EOF >expect &&
-		d
+		a
 		EOF
 		git -C submodule show -s --pretty=%s >actual &&
 		test_cmp expect actual
-- 
2.42.0

