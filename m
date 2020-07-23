Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5E0C4345D
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A04F220684
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="mEhKdvjS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387651AbgGWBK2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:10:28 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40528 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387641AbgGWBK0 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Jul 2020 21:10:26 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 03F4860758
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 01:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595466595;
        bh=vM3TI4/RbUP1dFvpkiIgLxj2UZc7pmERZjdUoWlLhOs=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=mEhKdvjS2F8SToy6N73FbKUj1+iIHuiHlK3nGFDgcnkguo8D7nettojpRAam1NBkW
         gUUCBwzZc+k4hOMYPow7EVwaN9NLp5C4G8oMWuaCOhs2296oA9KMJiFSD36+r/Ozwg
         nMGUUA3LJRHmvAE8aG4MMUW+pbBJEhPSZ1LAc15B1Nzjr9cih7AjRjQVCXZmaTQmVC
         FqAj2TFn2bkp6CmoM21jfTP6tmHPHkyTJpQbOjYR9+ZhdA4qyb/syZPMKffuoZFJVk
         fr4ytKTlLXSOXgk+W2Ytgf8lNgoYYWLCM2IG+g0HqYkIAKUiWOmAO3bdZgPcNcmS6M
         CzgRU7O0QrftHuE+ogA6FfghoW214u9dj9R1uUtjWJDxI9cvKqPLn5Atm42BYeGWf6
         a/E+9xrRmHJj1JnhkHikggEppolG7ddTfY9pbvNtwefO8CG9ETcjgctiKCC+7ZDztF
         S2NmwwsmXWn4XJzLmZ+8KhV1bLG/Zm562xLL+7d3OP2lkXw+T+g
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v3 10/39] t7003: compute appropriate length constant
Date:   Thu, 23 Jul 2020 01:09:14 +0000
Message-Id: <20200723010943.2329634-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc1.129.ge9626dbbb9f
In-Reply-To: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
References: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using a specific invalid hard-coded object ID, look one
up from the translation table.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t7003-filter-branch.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index e23de7d0b5..beeb2b855a 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -5,6 +5,7 @@ test_description='git filter-branch'
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
 test_expect_success 'setup' '
+	test_oid_init &&
 	test_commit A &&
 	GIT_COMMITTER_DATE="@0 +0000" GIT_AUTHOR_DATE="@0 +0000" &&
 	test_commit --notick B &&
@@ -463,10 +464,11 @@ test_expect_success 'rewrite submodule with another content' '
 '
 
 test_expect_success 'replace submodule revision' '
+	invalid=$(test_oid numeric) &&
 	git reset --hard original &&
 	git filter-branch -f --tree-filter \
 	    "if git ls-files --error-unmatch -- submod > /dev/null 2>&1
-	     then git update-index --cacheinfo 160000 0123456789012345678901234567890123456789 submod
+	     then git update-index --cacheinfo 160000 $invalid submod
 	     fi" HEAD &&
 	test $orig_head != $(git show-ref --hash --head HEAD)
 '
