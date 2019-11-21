Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D510C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7604620878
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llcwNRcP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfKUAqh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 19:46:37 -0500
Received: from mail-pl1-f173.google.com ([209.85.214.173]:37257 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfKUAqh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 19:46:37 -0500
Received: by mail-pl1-f173.google.com with SMTP id bb5so683882plb.4
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 16:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c+5mv6ive1pKjWVBVhkAHUQa+npexdh3kZLIX7jFerk=;
        b=llcwNRcPKvFB0K593JoI/M7ejfru5IuLewA82xebB6qfR8WQIHjD1/b9YpW5jQSi3y
         +3IOBVMWOimXtK67apqxyWVJ11toj3nIB3dRD5PgXMTTANlEc9ecwRhjHb27+nvnWRBm
         QH7tQobMQuudp6QhSy5kiYm2szPt7PXRS3dOXMByNpdhfo5B04LtV1sFdPjORC6eERNZ
         Yl7lOZZkMM+gmM5uLkkS2bfRXG8gy8os35AV7aeRz69ZHQxjMCFF2MQV30fVB/tPmCrm
         JNFk/qNZFdH5NTr+Mzl9gs8pl83cg6n3c9D8SKqLBNk5TdjOfRthac6vTCegAeKqMrd8
         FWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c+5mv6ive1pKjWVBVhkAHUQa+npexdh3kZLIX7jFerk=;
        b=X8FbJQVSJOlxEa7tYLrczCwjfIfuG094spWTQmOTCtET5X0C+djdvnDlssE7SPptol
         hMkiK638ZqCvIhuB5LAhYCdWLYEiEotpXqKhRnQEMmL4ekvXtTFpbrLTXmyQaxhNl+WM
         iYlqUD2+fXAd1xFo4ROx5ZDA4SOkwOLldQu4y4+WAvtBZY07kmXq9ydJv5XUeOH3H8ht
         vDIcdzWUM2XmVSqEq7Z4IJRYdljai2XMGZhms/cjOGj3DO74rf0tOPZMqUx9FQoNezaS
         TLbRA2D0MNSb+lXxPUWv7fNsaa0hgNszH3bHXrUfs5DvbdqNLp7XhPxnltG9XzQk9pNg
         upqA==
X-Gm-Message-State: APjAAAW6V4vtwEY8+0BAStCUquEF/kSi8TF7wmDnLvlOt7HwLmU3leEC
        /oskJhgQSN6iCTnno78LVonXYq8W
X-Google-Smtp-Source: APXvYqxskWIb9z3rpH6mf1tvEZv2x+qnx8afxNyaucfX0yPaQzI1GTPTpxTy8HaSzm1qr3SCwVns9g==
X-Received: by 2002:a17:902:d685:: with SMTP id v5mr5466746ply.188.1574297196126;
        Wed, 20 Nov 2019 16:46:36 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id y17sm592997pfl.92.2019.11.20.16.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 16:46:35 -0800 (PST)
Date:   Wed, 20 Nov 2019 16:46:34 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 20/21] t7700: s/test -f/test_path_is_file/
Message-ID: <079a42c45b99417656f044d5359e19541dc449ed.1574296987.git.liu.denton@gmail.com>
References: <cover.1573779465.git.liu.denton@gmail.com>
 <cover.1574296987.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574296987.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since we have debugging-friendly alternatives to `test -f`, replace
instances of `test -f` with `test_path_is_file` so that if a command
ever fails, we get better debugging information.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7700-repack.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index a96e876c4e..1d14ddcbdb 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -106,7 +106,7 @@ test_expect_success 'packed obs in alt ODB are repacked even when local repo is
 	mv .git/objects/pack/* alt_objects/pack &&
 	git repack -a &&
 	myidx=$(ls -1 .git/objects/pack/*.idx) &&
-	test -f "$myidx" &&
+	test_path_is_file "$myidx" &&
 	for p in alt_objects/pack/*.idx
 	do
 		git verify-pack -v $p | sed -n -e "/^[0-9a-f]\{40\}/p"
@@ -129,7 +129,7 @@ test_expect_success 'packed obs in alt ODB are repacked when local repo has pack
 	git repack &&
 	git repack -a -d &&
 	myidx=$(ls -1 .git/objects/pack/*.idx) &&
-	test -f "$myidx" &&
+	test_path_is_file "$myidx" &&
 	for p in alt_objects/pack/*.idx
 	do
 		git verify-pack -v $p | sed -n -e "/^[0-9a-f]\{40\}/p"
@@ -148,7 +148,7 @@ test_expect_success 'packed obs in alternate ODB kept pack are repacked' '
 	for p in alt_objects/pack/*.pack
 	do
 		base_name=$(basename $p .pack) &&
-		if test -f alt_objects/pack/$base_name.keep
+		if test_path_is_file alt_objects/pack/$base_name.keep
 		then
 			rm alt_objects/pack/$base_name.keep
 		else
@@ -157,7 +157,7 @@ test_expect_success 'packed obs in alternate ODB kept pack are repacked' '
 	done &&
 	git repack -a -d &&
 	myidx=$(ls -1 .git/objects/pack/*.idx) &&
-	test -f "$myidx" &&
+	test_path_is_file "$myidx" &&
 	for p in alt_objects/pack/*.idx
 	do
 		git verify-pack -v $p | sed -n -e "/^[0-9a-f]\{40\}/p"
-- 
2.24.0.450.g7a9a4598a9

