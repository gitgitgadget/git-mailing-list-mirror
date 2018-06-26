Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81C1B1F516
	for <e@80x24.org>; Tue, 26 Jun 2018 07:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932274AbeFZHcg (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 03:32:36 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:39927 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752697AbeFZHbD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 03:31:03 -0400
Received: by mail-io0-f194.google.com with SMTP id f1-v6so15005282ioh.6
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 00:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rDTejHLo7KC7y1uuJPuRl2zQyEQQ9zW3BkJSKgfEzCM=;
        b=OIEusbLPqZ0j6PquR557h+TC/vNeLh48/9EXlcHAc5rZ7QErH1oz7e2xtxTLsWnYWK
         yY8aSXvT5iIk/hmB6TvmqIhDDfh68OOm05QI4Eq6FBB6T6V5hZz7XCxD1gHixMkxKE6W
         N8Prnc92u9egM0TsEwK/oUa5Z4y+0h7jZrYs59psRL4zW+Jn+UL4JHI/05wUQQJcxAS1
         4ciVSkN6aTMkCAOucHbIV/aRgrmu8ESW/VhY63chx4+sEagRGcSErEYC6tLFMDmK2UdT
         PIolVpPNpfs24PuL8LkvMixNZoreXenfjnY8G4y48O23CGZ0/YutptHvrws8iUSfU0XV
         JNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=rDTejHLo7KC7y1uuJPuRl2zQyEQQ9zW3BkJSKgfEzCM=;
        b=bWJsO5dVX63uIkmOMySIdRonmKEQ/ipjhpJEuXa1yyE4snXpDLGvr1LnB5Nb+RdRKI
         9D87U+96s4sHvh65zSIx4a8Rzz219kYqzboTbKJS2gvsZHBgzUKvDx67pbAEBw9jhgoa
         9GXZYzGwyNWCl18b1ida6JSpEuv14G3Ms7rV8be3i9/n4zGrzAwLBm03PJR7RIBLybuA
         /z/BHc2b3EmKTYbKWErod67NtsNZ01oxQx9rw+689pgaTXdmkf6zeTdO7Wa8VB4uZcki
         Yxunsd6yDJXWINSPy/8gP6WtRgO/RYYzKxmC1kw4bNXuOIqYAuKdDuFZIIOT2rRQDr4e
         I+7Q==
X-Gm-Message-State: APt69E3hZGJ+OgJXa3lV5FUKh6VUv9tbRNHIosM6Y7KcWfCysoQs7WN0
        DcQMMhc0l/bLIdLJfnr+ubYeQg==
X-Google-Smtp-Source: AAOMgpdzD0cECng6SG1wRs5iSTWLD2TsfKOc/twzN3YukzL3MJUfmQmcIcM2E3PVPDiTldihQ//aUw==
X-Received: by 2002:a6b:c696:: with SMTP id w144-v6mr288639iof.79.1529998262712;
        Tue, 26 Jun 2018 00:31:02 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id k20-v6sm471361iok.9.2018.06.26.00.31.01
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 00:31:02 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 13/29] t/lib-submodule-update: fix broken "replace submodule must-fail" test
Date:   Tue, 26 Jun 2018 03:29:45 -0400
Message-Id: <20180626073001.6555-14-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.419.gfe4b301394
In-Reply-To: <20180626073001.6555-1-sunshine@sunshineco.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test has been dysfunctional since it was added by 259f3ee296
(lib-submodule-update.sh: define tests for recursing into submodules,
2017-03-14), however, problems went unnoticed due to a broken &&-chain
toward the end of the test.

The test wants to verify that replacing a submodule containing a .git
directory must fail. All other "must fail" tests in this script invoke
the supplied command as 'test_must_fail', however, this test neglects to
do so.

To make matters worse, the command actually succeeds even though it's
not supposed to. Presumably, this is a "known breakage", which means
that the entire test should be marked 'test_expect_failure', however, it
is instead marked 'test_expect_success'.

Fix both problems, as well as the broken &&-chain behind which these
problems hid.

While at it, fix broken &&-chains in a couple neighboring tests.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/lib-submodule-update.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 1f38a85371..8a2edee1cb 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -755,7 +755,7 @@ test_submodule_recursing_with_args_common() {
 			: >sub1/untrackedfile &&
 			test_must_fail $command replace_sub1_with_file &&
 			test_superproject_content origin/add_sub1 &&
-			test_submodule_content sub1 origin/add_sub1
+			test_submodule_content sub1 origin/add_sub1 &&
 			test -f sub1/untracked_file
 		)
 	'
@@ -842,7 +842,7 @@ test_submodule_switch_recursing_with_args () {
 			cd submodule_update &&
 			git branch -t add_sub1 origin/add_sub1 &&
 			: >sub1 &&
-			echo sub1 >.git/info/exclude
+			echo sub1 >.git/info/exclude &&
 			$command add_sub1 &&
 			test_superproject_content origin/add_sub1 &&
 			test_submodule_content sub1 origin/add_sub1
@@ -959,7 +959,7 @@ test_submodule_forced_switch_recursing_with_args () {
 		)
 	'
 	# ... absorbing a .git directory.
-	test_expect_success "$command: replace submodule containing a .git directory with a directory must fail" '
+	test_expect_failure "$command: replace submodule containing a .git directory with a directory must fail" '
 		prolog &&
 		reset_work_tree_to_interested add_sub1 &&
 		(
@@ -967,9 +967,9 @@ test_submodule_forced_switch_recursing_with_args () {
 			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
 			replace_gitfile_with_git_dir sub1 &&
 			rm -rf .git/modules/sub1 &&
-			$command replace_sub1_with_directory &&
+			test_must_fail $command replace_sub1_with_directory &&
 			test_superproject_content origin/replace_sub1_with_directory &&
-			test_submodule_content sub1 origin/modify_sub1
+			test_submodule_content sub1 origin/modify_sub1 &&
 			test_git_directory_exists sub1
 		)
 	'
-- 
2.18.0.419.gfe4b301394

