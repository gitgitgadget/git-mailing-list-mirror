Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C95C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 06:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbiGUGvx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 02:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiGUGvw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 02:51:52 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B8B42ADC
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 23:51:51 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id r1-20020a05600c35c100b003a326685e7cso2755186wmq.1
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 23:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xwNUnKeoNQm5DMYSMRaMHH0JVn64qjEyjTvR/aBNjg4=;
        b=cOEmI0J2742Eaq8Fsq8dHWFiMJ1KkecdpzBPWhawYTfHCDRQJ8mv2G7Fji6l+yE678
         w7El8ejhX7X5HIYkaJQCu4w1+0hDZ5FfUJsg+rdfx+fuzQZrlLkUxTfhdoUtcKgVKWnS
         gSVk5lxtb2BktJ58Wx6dsTROzuHojGrexilnViWHBm5dGR89qEm5/CrTlcpdTBAqvOZV
         8OidE1O2gfXK2u4JCVUEE7kbRTGNxFXuAIAN8DNDJWDWmWwieF+G62dI9zL6zq4Zw6EP
         ut9RYOL0YjA3HMVAgjcGDmS7s8GkhCJXgxDgLDUGwyIdf6FQ8bDN0JfWwaMbopuEfQw3
         /XgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xwNUnKeoNQm5DMYSMRaMHH0JVn64qjEyjTvR/aBNjg4=;
        b=Dfk7ZSonn/91QlPfrvgM3iUI0G4RY0SMlDrlvWUFGZQjVtbXwVgfBozGgFoqdBBRCS
         J2XKmiJYMupFJewsDZ94aWSB6TwePFsw23NlrpFqhk9eqtzZ3KvZ+RyIp9EtmEzDJIoA
         7BiHDPTnC0PV4KXGYJq/J4li9ijtFK7W4vIMhAFHQ6Zd4leFP7b45nSMDeAeirJRXtM0
         7cW5SkWuPhkadtcte+5dNIyfbz3OFem71XsMrxrN6noHnZxZP6scd3Utk1wS3+9g6ufa
         53nml9GEpWBPQqIZQOUQ0ZBy3rFCnkPSM3Gt6Gt6f4D6NKoPLpZupBR0ky4yX8imh9br
         LOvw==
X-Gm-Message-State: AJIora8Tw2OdEsewMG+hXkQsLtjaYkTorLeeOki8BOHTcZeJHZx/XyZC
        oR3XZTW3d7+84PIRaxH/E6iijlEDzsADwA==
X-Google-Smtp-Source: AGRyM1vy/6jdKansqiG6kvZu4R7rqZLd1pQqy4zQnRA5SBSCCDwAqtAKhjg5K5l4R5bQdNdjqP9lQg==
X-Received: by 2002:a1c:a382:0:b0:3a3:2644:664f with SMTP id m124-20020a1ca382000000b003a32644664fmr7009390wme.41.1658386309370;
        Wed, 20 Jul 2022 23:51:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n124-20020a1c2782000000b003a2c67aa6c0sm1006746wmn.23.2022.07.20.23.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 23:51:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/6] diff tests: fix ignored exit codes in t4023
Date:   Thu, 21 Jul 2022 08:51:38 +0200
Message-Id: <patch-1.6-f8a382841d5-20220721T064349Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g64a1e8362fd
In-Reply-To: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a "git diff-tree" command to be &&-chained so that we won't
ignore its exit code, see the ea05fd5fbf7 (Merge branch
'ab/keep-git-exit-codes-in-tests', 2022-03-16) topic for prior art.

This fixes code added in b45563a229f (rename: Break filepairs with
different types., 2007-11-30). Due to hiding the exit code we hid a
memory leak under SANITIZE=leak.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4023-diff-rename-typechange.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t4023-diff-rename-typechange.sh b/t/t4023-diff-rename-typechange.sh
index 7cb99092938..25c31b0cb1b 100755
--- a/t/t4023-diff-rename-typechange.sh
+++ b/t/t4023-diff-rename-typechange.sh
@@ -52,8 +52,8 @@ test_expect_success setup '
 '
 
 test_expect_success 'cross renames to be detected for regular files' '
-
-	git diff-tree five six -r --name-status -B -M | sort >actual &&
+	git diff-tree five six -r --name-status -B -M >out &&
+	sort <out >actual &&
 	{
 		echo "R100	foo	bar" &&
 		echo "R100	bar	foo"
@@ -63,8 +63,8 @@ test_expect_success 'cross renames to be detected for regular files' '
 '
 
 test_expect_success 'cross renames to be detected for typechange' '
-
-	git diff-tree one two -r --name-status -B -M | sort >actual &&
+	git diff-tree one two -r --name-status -B -M >out &&
+	sort <out >actual &&
 	{
 		echo "R100	foo	bar" &&
 		echo "R100	bar	foo"
@@ -74,8 +74,8 @@ test_expect_success 'cross renames to be detected for typechange' '
 '
 
 test_expect_success 'moves and renames' '
-
-	git diff-tree three four -r --name-status -B -M | sort >actual &&
+	git diff-tree three four -r --name-status -B -M >out &&
+	sort <out >actual &&
 	{
 		# see -B -M (#6) in t4008
 		echo "C100	foo	bar" &&
-- 
2.37.1.1095.g64a1e8362fd

