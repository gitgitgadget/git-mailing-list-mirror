Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71756C43465
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 11:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31A1B21D42
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 11:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDyBOfx4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgIRLTh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 07:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgIRLTg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 07:19:36 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDCEC06174A
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 04:19:36 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id y1so3283281pgk.8
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 04:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OF+DcgfZVaY5a9qdI91H3wnJhvr2yxUA11R9BvhWr9U=;
        b=GDyBOfx4oVNW5brwqUKNJqFEViu5qw5TPUXYCUHBf55aptpE3BDKAvUtFGaqsxqzfL
         egIvsVrG1QxpncGJVmepUqemvkypT/wwkkQmuDIcgsILNL2qVY5Jy6aqmEO2e/gEIIpJ
         d3idvxO+d42TMLoTc8PoFTf7LglF2uRiW5NNrgpHaiEL/vfzmJrJt7BA8ttXVpkpQFNG
         ubrgg0vwTRg+myf85lM7WasBSH6xOtCXXNfcgnb3tEhCBQRoVOV6W93jdy61hFucuAk8
         F43dAPLhRj2W5Msq623w92OfDiX68jx533pVKQ7bV3oE5TKUR1tuP9p+l6G4D6Y+zMcb
         anaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OF+DcgfZVaY5a9qdI91H3wnJhvr2yxUA11R9BvhWr9U=;
        b=D0+36vlGT1vLDBhx5D+KXKRsiFL/MKzlwEUkp2CgggPOmIXdeH+Ljub3eoH+hElvbf
         mxDCZBJ+nU9mNg+8uFfV01fPumXvHYYjnbD5sBSf5mYZg7RpAn0ZP2JMWVMYxMx0IIED
         XOIwYVow5lCQPGYe59IDsZcBNX6MZ9xyGhS68cSljPTCNrPooSbjpMmxwbxQJVTGxLq8
         sRLybHHsoxks789ad2eYNeiPRoOXe/b2Bwu+/vQsyjECEU764MdzqThAWVLFwJjshXUe
         1NLlVkpyaKbqTzg8YSoKREs0gKCxYEWBMRZYSQln1HywabV5MNpemUn1YV5EGHVDHYzE
         1ZUg==
X-Gm-Message-State: AOAM5311GDKhZmKZIbNNYIDhqsiCMxRIE4B+MoNhsQcxWmnx25U5yhuo
        O+cnjiCSGikBssfs8VQlPJg+7Uo2cLQ=
X-Google-Smtp-Source: ABdhPJyvTy6+mgJ8maMd3PE9H9tfm500yC+oEYjOLZgE76aCrZBa9YZSGdZkRGadh5bL2yF+ZuCIzw==
X-Received: by 2002:a63:1c4a:: with SMTP id c10mr25668108pgm.22.1600427975611;
        Fri, 18 Sep 2020 04:19:35 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id x4sm3034120pff.57.2020.09.18.04.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 04:19:34 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 3/4] hooks--pre-push.sample: use hash-agnostic null OID
Date:   Fri, 18 Sep 2020 04:19:04 -0700
Message-Id: <9d6c2951ab0a2c2e92353c238b008538fe6a6327.1600427894.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7
In-Reply-To: <cover.1600427894.git.liu.denton@gmail.com>
References: <cover.1600427894.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The pre-push sample hook has the null OID hardcoded as 40 zeros.
However, with the introduction of SHA-256 support, this assumption no
longer holds true. Replace the hardcoded $z40 with a call to
`git rev-parse --null-oid` so the sample hook becomes hash-agnostic.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 templates/hooks--pre-push.sample | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/templates/hooks--pre-push.sample b/templates/hooks--pre-push.sample
index 64b5707553..b3bc5276bf 100755
--- a/templates/hooks--pre-push.sample
+++ b/templates/hooks--pre-push.sample
@@ -22,16 +22,16 @@
 remote="$1"
 url="$2"
 
-z40=0000000000000000000000000000000000000000
+null_oid="$(git rev-parse --null-oid)"
 
 while read local_ref local_sha remote_ref remote_sha
 do
-	if [ "$local_sha" = $z40 ]
+	if [ "$local_sha" = "$null_oid" ]
 	then
 		# Handle delete
 		:
 	else
-		if [ "$remote_sha" = $z40 ]
+		if [ "$remote_sha" = "$null_oid" ]
 		then
 			# New branch, examine all commits
 			range="$local_sha"
-- 
2.28.0.618.gf4bc123cb7

