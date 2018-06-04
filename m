Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9B9F1F403
	for <e@80x24.org>; Mon,  4 Jun 2018 13:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753148AbeFDNje (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 09:39:34 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39925 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753131AbeFDNjd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 09:39:33 -0400
Received: by mail-wr0-f193.google.com with SMTP id w7-v6so31640394wrn.6
        for <git@vger.kernel.org>; Mon, 04 Jun 2018 06:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EAn/VoDV4hkExrbz2oa9eBAt2gsRJdCgi3+kfuRzd/M=;
        b=VERXnPosy5iYe6m8n6/ZVVEqHp5K21UnycsjAmBbL6u2UtVk82IFqpmsRIlhCpf8Ql
         bRxC/mpt/RlgrxdR9btCimLYAWi8Xxu1cwNltYkwzUPyythHiX+pIM3KfmxGLHXGdmpW
         j1aSTbRUftSKKjJ/LAPsXTC7PFq9Ik92dYj8t5gV6mlpTIfw6asnG8JtK5PzUPcAts5L
         X2U2r6Lo0pUPlytWkzwP6IBCI7Ra4HSMeNl3OO9Sgs6NUSfIldQMkmakJz4Cx9uk1Ux1
         O70LbFVYEUmIfE5LAlSPkjuZ0Gv3eMAfA1RVWlc0JG3pOon5JjrJgC43/jcG1+TxyhCm
         pFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EAn/VoDV4hkExrbz2oa9eBAt2gsRJdCgi3+kfuRzd/M=;
        b=lmAN+mIwuOBEom6C+Es7trOTNEFigC/dsfgUbDMT/tmGL8aAQYkhCq7FEZbTEDLhpT
         1bIdyjcUXw7ujUMjWeqBT5l2V92udH8jjCvHOJ9aTBGRn1mamxcgQHlTCs8qqMZmOkYM
         7YidYbnbytFaRW0FPuoixFZA0s5vYo7CdhIfHcFKxO8Irhve2134FFjoSBxdogA1JTXU
         hmAHcV0ImrlTQSkQro82wOewBHd0XpssLaohR45isH0LU5CzsRo8V4M0+39FmPecqbQA
         WmJZSewrvAoRjocMEHCyiNHKBjqtMWqqneemwjxqIbk0y/7pTMjBZrlmGu05VTKJcP30
         /zqg==
X-Gm-Message-State: ALKqPweiDBToskkfmB5sNtBJvIiADAJ/NHvcDxdQslXlImAP7Gvf+mqK
        PzTlqphe3qWs8Q2ZsUYjKNlOwg==
X-Google-Smtp-Source: ADUXVKJWf8eSN+2zDD7xauosMote6bTXA9qR/64bYYUZvMI1vu3RJoBFGwTSJ8vj3DdU66xIp3yyoA==
X-Received: by 2002:a50:db8c:: with SMTP id p12-v6mr24539017edk.298.1528119571873;
        Mon, 04 Jun 2018 06:39:31 -0700 (PDT)
Received: from localhost.localdomain (x590cb90a.dyn.telefonica.de. [89.12.185.10])
        by smtp.gmail.com with ESMTPSA id j22-v6sm24970750edq.92.2018.06.04.06.39.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Jun 2018 06:39:31 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/2] tests: make forging GPG signed commits and tags more robust
Date:   Mon,  4 Jun 2018 15:39:26 +0200
Message-Id: <20180604133926.16558-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.207.ga6211da864
In-Reply-To: <20180604133926.16558-1-szeder.dev@gmail.com>
References: <20180604133926.16558-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A couple of test scripts create forged GPG signed commits or tags to
check that such forgery can't fool various git commands' signature
verification.  All but one of those test scripts are prone to
occasional failures because the forgery creates a bogus GPG signature,
and git commands error out with an unexpected error message, e.g.
"Commit deadbeef does not have a GPG signature" instead of "...  has a
bad GPG signature".

't5573-pull-verify-signatures.sh', 't7510-signed-commit.sh' and
't7612-merge-verify-signatures.sh' create forged signed commits like
this:

  git commit -S -m "bad on side" &&
  git cat-file commit side-bad >raw &&
  sed -e "s/bad/forged bad/" raw >forged &&
  git hash-object -w -t commit forged >forged.commit

On rare occasions the given pattern occurs not only in the commit
message but in the GPG signature as well, and after it's replaced in
the signature the resulting signature becomes invalid, GPG will report
CRC error and that it couldn't find any signature, which will then
ultimately cause the test failure.

Since in all three cases the pattern to be replaced during the forgery
is the first word of the commit message's subject line, and since the
GPG signature in the commit object is indented by a space, let's just
anchor those patterns to the beginning of the line to prevent this
issue.

The test script 't7030-verify-tag.sh' creates a forged signed tag
object in a similar way by replacing the pattern "seventh", but the
GPG signature in tag objects is not indented by a space, so the above
solution is not applicable in this case.  However, in the tag object
in question the pattern "seventh" occurs not only in the tag message
but in the 'tag' header as well.  To create a forged tag object it's
sufficient to replace only one of the two occurences, so modify the
sed script to limit the pattern to the 'tag' header (i.e. a line
beginning with "tag ", which, because of the space character, can
never occur in the base64-encoded GPG signature).

Note that the forgery in 't7004-tag.sh' is not affected by this issue:
while 't7004' does create a forged signed tag kind of the same way,
it replaces "signed-tag" in the tag object, which, because of the '-'
character, can never occur in the base64-encoded GPG signarute.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t5573-pull-verify-signatures.sh  | 2 +-
 t/t7030-verify-tag.sh              | 2 +-
 t/t7510-signed-commit.sh           | 3 +--
 t/t7612-merge-verify-signatures.sh | 2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/t/t5573-pull-verify-signatures.sh b/t/t5573-pull-verify-signatures.sh
index 9594e891f4..747775c147 100755
--- a/t/t5573-pull-verify-signatures.sh
+++ b/t/t5573-pull-verify-signatures.sh
@@ -29,7 +29,7 @@ test_expect_success GPG 'create repositories with signed commits' '
 		echo 4 >d && git add d &&
 		test_tick && git commit -S -m "bad" &&
 		git cat-file commit HEAD >raw &&
-		sed -e "s/bad/forged bad/" raw >forged &&
+		sed -e "s/^bad/forged bad/" raw >forged &&
 		git hash-object -w -t commit forged >forged.commit &&
 		git checkout $(cat forged.commit)
 	) &&
diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index b4b49eeb08..291a1e2b07 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -74,7 +74,7 @@ test_expect_success GPG 'verify and show signatures' '
 
 test_expect_success GPG 'detect fudged signature' '
 	git cat-file tag seventh-signed >raw &&
-	sed -e "s/seventh/7th forged/" raw >forged1 &&
+	sed -e "/^tag / s/seventh/7th forged/" raw >forged1 &&
 	git hash-object -w -t tag forged1 >forged1.tag &&
 	test_must_fail git verify-tag $(cat forged1.tag) 2>actual1 &&
 	grep "BAD signature from" actual1 &&
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 663bf68def..6e2015ed9a 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -142,8 +142,7 @@ test_expect_success GPG 'show signed commit with signature' '
 
 test_expect_success GPG 'detect fudged signature' '
 	git cat-file commit seventh-signed >raw &&
-
-	sed -e "s/seventh/7th forged/" raw >forged1 &&
+	sed -e "s/^seventh/7th forged/" raw >forged1 &&
 	git hash-object -w -t commit forged1 >forged1.commit &&
 	test_must_fail git verify-commit $(cat forged1.commit) &&
 	git show --pretty=short --show-signature $(cat forged1.commit) >actual1 &&
diff --git a/t/t7612-merge-verify-signatures.sh b/t/t7612-merge-verify-signatures.sh
index e797c74112..e2b1df817a 100755
--- a/t/t7612-merge-verify-signatures.sh
+++ b/t/t7612-merge-verify-signatures.sh
@@ -23,7 +23,7 @@ test_expect_success GPG 'create signed commits' '
 	echo 3 >bar && git add bar &&
 	test_tick && git commit -S -m "bad on side" &&
 	git cat-file commit side-bad >raw &&
-	sed -e "s/bad/forged bad/" raw >forged &&
+	sed -e "s/^bad/forged bad/" raw >forged &&
 	git hash-object -w -t commit forged >forged.commit &&
 	git checkout initial &&
 
-- 
2.18.0.rc0.207.ga6211da864

