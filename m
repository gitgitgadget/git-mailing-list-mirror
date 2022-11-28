Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFEDC433FE
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 13:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiK1NDe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 08:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiK1ND3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 08:03:29 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1C9BE0A
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 05:03:28 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id v3so9862304pgh.4
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 05:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oA8OA+zobhG9dG413joULa3NxyTq2sKS3VMEM/7lN8=;
        b=PdYW+t/M3gBdG0iR0LDFPupdLNXp+67G+CmtK9UANPwtzC4raT7wYqW7IpSasNvWBL
         rcThA8meoDJWqDE7MOIpxLzlwZbRr60Oa+KjXtnxh5o0ld7rGRMTIZWnW1fwp7i9QRkS
         7V3i1NNBeJf9+Fvn7YpeQWfBkudX1aIeNNuK/ZDkcPpyrrWOdRBgStYen48J+bwljPZL
         kRY7cUkbNePIzOdtQL9eHm1QDDq6RrMNBdhlHc+M+jeec8yOsKLK83kI5WS26tJoG05I
         U2EUX34ojXqvTllCnX4+ijDl4Hved1/4in4Ke/6xGNVor6+zmCiuhoK/roCuhxucopYm
         ddiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/oA8OA+zobhG9dG413joULa3NxyTq2sKS3VMEM/7lN8=;
        b=OdXo1sx4VmUqzMyrS45e2oGuYHvv9/ktjCyEM+mvXSETFCeKdaKj/w3gOdGRpQ/ANJ
         WTJk3wbXhuVORKev5h5ncWqZs/9+wlb31doP+8bY5Dwcub0f9YcpxgZiiXwAjWl+XZAk
         7oOx6u60JB0829XQbMt+V4jYLXBdjztAWp+QfwoGbhn+tgMGVZLfrcMLmKh3ErcUDiux
         WU6r3ZsNuBxK7wCbv8qHreZK61uXqynr/IOTyojEYLksEk2XCkzBnERe+8R9vHvvJg/d
         K2gJpjlK01X+QjX6DihTwVKyF9JYwOp+rZwLUq7HVNoEQZmt+8huFYMVuNWc7kPy7tXe
         Tt+A==
X-Gm-Message-State: ANoB5pm7UOIQma+h6mD/rwlgwEsosEvXaev+HZK2zYMCITU9d4Y2EQzV
        M6MrOmDj8nA2mtfaOfGoNVwq4KOcT3A=
X-Google-Smtp-Source: AA0mqf4rMfmb2eGIhRQVL5fl6/cRYdElMNU/EvEeqK2JFMto5ZTF4GHZz6D6wWs7s2TnMvTxw7TsEg==
X-Received: by 2002:a65:49c2:0:b0:478:42f:42e9 with SMTP id t2-20020a6549c2000000b00478042f42e9mr8439395pgs.53.1669640607835;
        Mon, 28 Nov 2022 05:03:27 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id x127-20020a626385000000b0057409583c09sm7977301pfb.163.2022.11.28.05.03.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Nov 2022 05:03:27 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 2/3] t1301: use test_when_finished for cleanup
Date:   Mon, 28 Nov 2022 21:03:22 +0800
Message-Id: <20221128130323.8914-3-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20221127145130.16155-1-worldhello.net@gmail.com>
References: <20221127145130.16155-1-worldhello.net@gmail.com>
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

