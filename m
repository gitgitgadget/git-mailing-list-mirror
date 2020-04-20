Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83ACBC3815B
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 08:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FF8D2145D
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 08:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3vK95Xk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgDTIzH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726208AbgDTIzD (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Apr 2020 04:55:03 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71099C061A10
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 01:55:01 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id n143so2937825qkn.8
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 01:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lA3rZUgviNB3jkCSJaUQlgYG1gAy+MDb20J3+/yYBDo=;
        b=R3vK95XkktOuksdyw64/YK10aCHEQh3xZmIciXiY1tbnOicNas+IFF7PL5DFcKiFfS
         R1MExldhFWTXdnaxWdVCkTtLo5cFrRNBJ67VYho6n6gpf1epbAqE2Jo49LtN9R96uoP0
         XhZa+e6oYTdqI11XnLJzSqL0evKYVIbvng5UdLsiN3IifUbwUe4QmmUe2fkETOZ5BGye
         rXKWkTk7vBPEZRehCwbQODWsVMHgpTDPObdpZmY03lt7KhR5/7TMAzBZSbJXmwDxt2mS
         0QSWvcumdVjL4KeFxOkZWIK0Y1ySh5RF6ZDTJBbty+dSgG2t15a/pIb8dKphGT9CVRUy
         CEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lA3rZUgviNB3jkCSJaUQlgYG1gAy+MDb20J3+/yYBDo=;
        b=Afr62KDOurXIrqg+93uuvR9Jjy/KBHzedHQOmqd6Ah3rFEzZUs602icwOBdlwlqmuD
         77ekE4KMStC4vyqV7mFadjvfMZ3hfq0j4rt3HbQOv5Br9vFAOcg+iO/UMAwtE7K9P3lY
         FJAfT24viZBSy8y7/UQd8a76zugSlw0YE1tXlnYV/0qfjUjqdZR15Y5LTVu4nml2oizn
         1/CFsJKWYhdTV8sML08TouxjBS/yoykgAasW8nxv4WmxdjIZmtcQHPdIHw92djKoOCBn
         n2a8d26sXDUWzLRC6PzpU2+edff/LI5ggefe8/A/KpszG1YgZmsTFnInh12zIPcri7yl
         qqEg==
X-Gm-Message-State: AGi0PuaGWMvuSituneZcfRhdz941v7mSFQAs9oTh4z273s9fXAoEiIJm
        P2d2sTkzxHtXLyD2+7pqEAgVkCbn
X-Google-Smtp-Source: APiQypLdH/5GkIgByBxjOVmDcnTVG67/bcFBv/5c9H5YPdeJ0pDjI5kbKOMJ1LNLsyJQAThX/1jOFw==
X-Received: by 2002:a37:690:: with SMTP id 138mr15400691qkg.414.1587372900531;
        Mon, 20 Apr 2020 01:55:00 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id p25sm203222qkk.18.2020.04.20.01.54.59
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 01:55:00 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 7/8] t9819: don't use test_must_fail with p4
Date:   Mon, 20 Apr 2020 04:54:45 -0400
Message-Id: <e0d2bf4a204d56a629a417aa798e9efc208f4b08.1587372771.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1587372771.git.liu.denton@gmail.com>
References: <cover.1587372771.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We were using `test_must_fail p4` to test that the p4 command failed as
expected. However, test_must_fail() is used to ensure that commands fail
in an expected way, not due to something like a segv. Since we are not
in the business of verifying the sanity of the external world, replace
`test_must_fail p4` with `! p4` and assume that the `p4` command does
not die unexpectedly.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t9819-git-p4-case-folding.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9819-git-p4-case-folding.sh b/t/t9819-git-p4-case-folding.sh
index 600ce1e0b0..b4d93f0c17 100755
--- a/t/t9819-git-p4-case-folding.sh
+++ b/t/t9819-git-p4-case-folding.sh
@@ -30,7 +30,7 @@ test_expect_success 'Check p4 is in case-folding mode' '
 		cd "$cli" &&
 		>lc/FILE.TXT &&
 		p4 add lc/FILE.TXT &&
-		test_must_fail p4 submit -d "Cannot add file differing only in case" lc/FILE.TXT
+		! p4 submit -d "Cannot add file differing only in case" lc/FILE.TXT
 	)
 '
 
-- 
2.26.0.159.g23e2136ad0

