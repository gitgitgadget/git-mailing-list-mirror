Return-Path: <SRS0=2Qsv=4E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEF0C76199
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 13:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 382A922522
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 13:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sQx+FEmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgBPNsq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Feb 2020 08:48:46 -0500
Received: from mail-pj1-f51.google.com ([209.85.216.51]:38654 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgBPNsq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Feb 2020 08:48:46 -0500
Received: by mail-pj1-f51.google.com with SMTP id j17so6036351pjz.3
        for <git@vger.kernel.org>; Sun, 16 Feb 2020 05:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KTV9rbANTvRkzMiJeqVMO2m/e1XB+3dM7BN7HEUv9TE=;
        b=sQx+FEmOTdgEvDzEWqjp2u/ultd3FC+noMdZGIdxIidbN38Y0j6iffllmQOnGMUkjc
         6ubb5p1ZpcWB7L+ByMQA51Nh0JClwUtY+9gCNObpoQc8AVdo1Ks6o3vbB9NpUq++jero
         LXmPh9dvnA+kBWITfYDwDIsHkBZ57CpuzIOy5CaHchRFckj9mETxTJl3Kyebs9qISCAX
         J5/lGdJhXBBtYPIDTYYK8+F7Fvuz9bb+eplfJVXpCk+3hHuXfLA39DrPF/isUuul/nA8
         mPI38bvN0YOAc1erC0P9d63G2sFMpdzTnPUJ6un2nSvmq61gEi7lqehlBAX2dwjJPEFX
         LHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KTV9rbANTvRkzMiJeqVMO2m/e1XB+3dM7BN7HEUv9TE=;
        b=et5ya6cAr5mrRW8LEyPOwskLqPYvFdeC0R/qNg3Rhw1YlX4P2I0EvK5yEPmx1/plWo
         ZNsw+blgMvW23hWOj95eyyigw6u71TCi1uIJE37lYeB3x890NgZL9cJ040Yqabd6T8zc
         EYgG26xvuEXkZhHaG2Bwa0fip/TPbFnNq2Tk38DdOVniOOiG4dYkBX8bylmf1Sq9Dlio
         /eGAVr/xSgwn5dcXt9pOpJjg09M1r23FfGATUIeGL9hjKhxT2a9ALIFw4IOzhrjM/PCj
         7B4AxLzKLlV47L9k2S7EIZMaWc29e4XuGq0WyIuIOekzV9xBAzUcG2znVlof2VWNxfx/
         N7FA==
X-Gm-Message-State: APjAAAVUKAsvfa4nT89xnuYZ6ADBoE2Z2DQotVRk48zv6BsCXXfwfFkN
        +MkgNY+M6pQimqUqAqRFsuU+HIcEOeQ=
X-Google-Smtp-Source: APXvYqzLhqjZYd/YKPpA6u6bhBzhGJDo3ju02j9+qXNvZ7KlzgnYEayPlFzo52TEWLEj1Lj5tuYqEw==
X-Received: by 2002:a17:90b:3cc:: with SMTP id go12mr14477644pjb.89.1581860924875;
        Sun, 16 Feb 2020 05:48:44 -0800 (PST)
Received: from Abhishek-Arch.nitk.ac.in ([218.248.46.83])
        by smtp.gmail.com with ESMTPSA id m12sm13302006pjf.25.2020.02.16.05.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 05:48:44 -0800 (PST)
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [GSoC Patch 2/5] t3430: use lib-log-graph functions
Date:   Sun, 16 Feb 2020 19:17:47 +0530
Message-Id: <20200216134750.18947-2-abhishekkumar8222@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200216134750.18947-1-abhishekkumar8222@gmail.com>
References: <20200216134750.18947-1-abhishekkumar8222@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 t/t3430-rebase-merges.sh | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index e72ca348ea..74c61fa787 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -20,13 +20,7 @@ Initial setup:
 '
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
-
-test_cmp_graph () {
-	cat >expect &&
-	git log --graph --boundary --format=%s "$@" >output &&
-	sed "s/ *$//" <output >output.trimmed &&
-	test_cmp expect output.trimmed
-}
+. "$TEST_DIRECTORY"/lib-log-graph.sh
 
 test_expect_success 'setup' '
 	write_script replace-editor.sh <<-\EOF &&
@@ -84,7 +78,7 @@ test_expect_success 'create completely different structure' '
 	test_config sequence.editor \""$PWD"/replace-editor.sh\" &&
 	test_tick &&
 	git rebase -i -r A master &&
-	test_cmp_graph <<-\EOF
+	test_cmp_graph --pretty=tformat:%s --boundary <<-\EOF
 	*   Merge the topic branch '\''onebranch'\''
 	|\
 	| * D
@@ -201,7 +195,7 @@ test_expect_success 'with a branch tip that was cherry-picked already' '
 	git checkout already-upstream &&
 	test_tick &&
 	git rebase -i -r upstream-with-a2 &&
-	test_cmp_graph upstream-with-a2.. <<-\EOF
+	test_cmp_graph --pretty=tformat:%s --boundary upstream-with-a2.. <<-\EOF
 	*   Merge branch A
 	|\
 	| * A1
@@ -219,7 +213,7 @@ test_expect_success 'do not rebase cousins unless asked for' '
 	test_cmp_rev HEAD $before &&
 	test_tick &&
 	git rebase --rebase-merges=rebase-cousins HEAD^ &&
-	test_cmp_graph HEAD^.. <<-\EOF
+	test_cmp_graph --pretty=tformat:%s --boundary HEAD^.. <<-\EOF
 	*   Merge the topic branch '\''onebranch'\''
 	|\
 	| * D
@@ -311,7 +305,7 @@ test_expect_success 'root commits' '
 	test $(git rev-parse second-root^0) != $(git rev-parse HEAD^) &&
 	test $(git rev-parse second-root:second-root.t) = \
 		$(git rev-parse HEAD^:second-root.t) &&
-	test_cmp_graph HEAD <<-\EOF &&
+	test_cmp_graph --pretty=tformat:%s --boundary HEAD <<-\EOF &&
 	*   Merge the 3rd root
 	|\
 	| * third-root
@@ -347,7 +341,7 @@ test_expect_success 'A root commit can be a cousin, treat it that way' '
 	test_tick &&
 	git rebase -f -r HEAD^ &&
 	test_cmp_rev ! HEAD^2 khnum &&
-	test_cmp_graph HEAD^.. <<-\EOF &&
+	test_cmp_graph --pretty=tformat:%s --boundary HEAD^.. <<-\EOF &&
 	*   Merge branch '\''khnum'\'' into asherah
 	|\
 	| * yama
@@ -355,7 +349,7 @@ test_expect_success 'A root commit can be a cousin, treat it that way' '
 	EOF
 	test_tick &&
 	git rebase --rebase-merges=rebase-cousins HEAD^ &&
-	test_cmp_graph HEAD^.. <<-\EOF
+	test_cmp_graph --pretty=tformat:%s --boundary HEAD^.. <<-\EOF
 	*   Merge branch '\''khnum'\'' into asherah
 	|\
 	| * yama
@@ -402,7 +396,7 @@ test_expect_success 'octopus merges' '
 	git rebase -i --force-rebase -r HEAD^^ &&
 	test "Hank" = "$(git show -s --format=%an HEAD)" &&
 	test "$before" != $(git rev-parse HEAD) &&
-	test_cmp_graph HEAD^^.. <<-\EOF
+	test_cmp_graph --pretty=tformat:%s --boundary HEAD^^.. <<-\EOF
 	*-.   Tüntenfüsch
 	|\ \
 	| | * three
@@ -478,7 +472,7 @@ test_expect_success '--rebase-merges with message matched with onto label' '
 	git checkout -b onto-label E &&
 	git merge -m onto G &&
 	git rebase --rebase-merges --force-rebase E &&
-	test_cmp_graph <<-\EOF
+	test_cmp_graph --pretty=tformat:%s --boundary <<-\EOF
 	*   onto
 	|\
 	| * G
-- 
2.25.0

