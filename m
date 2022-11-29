Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFDDC4321E
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 13:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbiK2NQG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 08:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbiK2NP3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 08:15:29 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432C0EAD
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 05:15:18 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso1104308pjb.1
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 05:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oA8OA+zobhG9dG413joULa3NxyTq2sKS3VMEM/7lN8=;
        b=WKTQq/hWSG99dv4L7OUacPJGrPjHAfBkofuvx6g50R4Q0EDRzT3IwrYCcvcOJDDsXO
         zMbtUYZjsXaViJ6QBdXwL/gjfSidHLk4EdwATtdOnfj11IpQQEXlY3iKlVTjxdW11GRT
         sT3O1fbAAPt5sk7N+Sgn86rg0uE/NQTzgSq2yFmjZ0e7Ft2s7yANuXg12CLRG5B6vfbx
         G5nymISQ1BRfdR3ekyxTGlKiLLmLBlHmrkxU97NYhUC987atH/zi1e8Q/Ryge8qxQ4C3
         2oH87sU0qslxfbUZnLPvC0j3jUPXo2SPVN+vQzg9qomoLhwTJvwefW9n75+vwedvvfgF
         o3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/oA8OA+zobhG9dG413joULa3NxyTq2sKS3VMEM/7lN8=;
        b=hmnoBJ8M8LVNBJvPLR6BrC7SpguuZPly1TXXuETt0fPfb8xG28QuHFVhqlhqCqbVnb
         XllomrH6Bsk2uEJjVX6zPfaT83s13pXcoax68JKH+dVXqKoKzQR78yMBOzRArYRQpVy/
         pfcjbYLXXg8DFxH9TBSUWPhAcsux3ydRaYk38sovLqDwQ16ma91sjmeaeHYboLzxtwoV
         Gjv8nzvn6z5D8aLhIcufJ2ceN/63Oh1bDfvMjOCh0oKLi+zBYDO3ZJ8+4YZmaxp8Ou8Z
         blrHwJZI2n0PyZ9sFdqPUlb0HcYzcUXc5FlkRPFzGiHtqgCJnORFf1nRBee80uqfjn0S
         ta8Q==
X-Gm-Message-State: ANoB5pmiYN3fx8ElrHSiF307qKf8r4nZ/0U6THRdBeNdTahxnaEzZ6KN
        fXxJILTWCPavjwRo6N0gF7O7cIE/4Gw=
X-Google-Smtp-Source: AA0mqf5jMUQRJFuTBN97o1giYsyHyF5+fTj6sXToWk6urdQMKYXvTmtMjLPG7JokqbCTvgimbOGXzw==
X-Received: by 2002:a17:902:f609:b0:178:2a08:2e7f with SMTP id n9-20020a170902f60900b001782a082e7fmr2150377plg.128.1669727717591;
        Tue, 29 Nov 2022 05:15:17 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id o7-20020aa79787000000b005745635c5b5sm9904524pfp.183.2022.11.29.05.15.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2022 05:15:16 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v3 2/3] t1301: use test_when_finished for cleanup
Date:   Tue, 29 Nov 2022 21:15:10 +0800
Message-Id: <20221129131511.7173-3-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20221128130323.8914-1-worldhello.net@gmail.com>
References: <20221128130323.8914-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Refactor several test cases to use "test_when_finished" for cleanup.

1. For first of these, we used to clean-up outside the test, but instead
   let's use test_when_finished for that.

2. For the second, we used to leave "new" after we are done, but not use
   it at all later. Now we do clean up.

3. For the rest, these child.git test repositories used to follow
   "initialize what we are going to use to a known state before we use"
   pattern, which is not wrong per-se, but now we use "clean up the
   cruft we made after we are done" pattern, which may arguably be
   better simply because the test that makes cruft should know what
   cruft it created better than whatever comes later that may not know.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t1301-shared-repo.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 7578e75d77..1225abbb6d 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -25,6 +25,7 @@ test_expect_success 'shared = 0400 (faulty permission u-w)' '
 for u in 002 022
 do
 	test_expect_success POSIXPERM "shared=1 does not clear bits preset by umask $u" '
+		test_when_finished "rm -rf sub" &&
 		mkdir sub && (
 			cd sub &&
 			umask $u &&
@@ -42,7 +43,6 @@ do
 			;;
 		esac
 	'
-	rm -rf sub
 done
 
 test_expect_success 'shared=all' '
@@ -132,6 +132,7 @@ test_expect_success POSIXPERM 'git reflog expire honors core.sharedRepository' '
 '
 
 test_expect_success POSIXPERM 'forced modes' '
+	test_when_finished "rm -rf new" &&
 	mkdir -p templates/hooks &&
 	echo update-server-info >templates/hooks/post-update &&
 	chmod +x templates/hooks/post-update &&
@@ -174,6 +175,7 @@ test_expect_success POSIXPERM 'forced modes' '
 '
 
 test_expect_success POSIXPERM 'remote init does not use config from cwd' '
+	test_when_finished "rm -rf child.git" &&
 	git config core.sharedrepository 0666 &&
 	umask 0022 &&
 	git init --bare child.git &&
@@ -193,7 +195,7 @@ test_expect_success POSIXPERM 're-init respects core.sharedrepository (local)' '
 '
 
 test_expect_success POSIXPERM 're-init respects core.sharedrepository (remote)' '
-	rm -rf child.git &&
+	test_when_finished "rm -rf child.git" &&
 	umask 0022 &&
 	git init --bare --shared=0666 child.git &&
 	test_path_is_missing child.git/foo &&
@@ -204,7 +206,7 @@ test_expect_success POSIXPERM 're-init respects core.sharedrepository (remote)'
 '
 
 test_expect_success POSIXPERM 'template can set core.sharedrepository' '
-	rm -rf child.git &&
+	test_when_finished "rm -rf child.git" &&
 	umask 0022 &&
 	git config core.sharedrepository 0666 &&
 	cp .git/config templates/config &&
-- 
2.39.0.rc0

