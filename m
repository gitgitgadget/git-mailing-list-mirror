Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F06C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 12:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF60207FF
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 12:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n19m+5EN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfLQMBv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:01:51 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40023 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbfLQMBt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 07:01:49 -0500
Received: by mail-pg1-f195.google.com with SMTP id k25so5556095pgt.7
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 04:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tpUbgt4OCs0Mx0LsvTWXKmwc8VOcR5i+pTPppUKj8No=;
        b=n19m+5ENwdbbmjhO71zkgTSxnZMU0U1vuw/ePB1iG2zuZ0XYR6PQQmNPyPfmH9tZl7
         yQ8u1uni1yJgYttGfsCdOhShZzzMHN9+gbu7Chwk/47DIYj1yCmyomzkdbsn08HfSL4b
         m/q8Lj0yVXmB+QnFdmz6ABm7u4FRzGnAmynsgebi1zJeQ+LwW1s0E47p73upT98gOG4A
         NLOuJMSNqSeBQGfEBSqZGDL56Wv+Lx7D9e5+Qm6owC3zA4dsq3fir0xmuHD1ZZU5jjuv
         E+ZmZpFzcxKnfjE780KFNECL9kPryLzLwNWVblYFhf/wE9qjePAY+Xr5wkm9nmYmZv4d
         xzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tpUbgt4OCs0Mx0LsvTWXKmwc8VOcR5i+pTPppUKj8No=;
        b=aXNXmkMl72QRDnZ/v5FEKSLOCJ8pUa1PHuZzEY5XB1pigVHUWKWiS1KRyZ35FRvU1i
         NjBKtRkZdJ4dQ7omsUPHxKG5DP+w9PPCOMAZVrfCoQ0WXj4psedmJbxdPs9O0suiWAua
         uoc6niDLCNwECbTPQsAuDx5i9FES30wcC52yjsdcjj3pSZJLPDgXhN03B0ULir4FOKsy
         I61hRaUbPt19VlguBeORcp9mBRAr5mq21EgIDC0uKvWZxrWw822uNImc2AKXCPnzNPkH
         ODuDjmfSwgrkxjTEkbyLHUxTI9s6TDJ5bQ/UNHtALQjWcHyEs42ZqXysHWR2s+GITC92
         wgdQ==
X-Gm-Message-State: APjAAAWXCZUdc5zpRtochooRMTg1Opf/45vrpWVk48PK0oF2CoyO9eZZ
        PxQXGd8XkLiLfcuUmfc7ccJDpHJe
X-Google-Smtp-Source: APXvYqz+k233OwudOrosTSTrOg0auRdv0LeXaHwg6T4lUbmxSXjttQGH0OX0tg07nZ/fkgpuUSJdRQ==
X-Received: by 2002:a62:1552:: with SMTP id 79mr21782465pfv.156.1576584108914;
        Tue, 17 Dec 2019 04:01:48 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id a15sm27531723pfh.169.2019.12.17.04.01.48
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 04:01:48 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 08/15] t0020: s/test_must_fail has_cr/! has_cr/
Date:   Tue, 17 Dec 2019 04:01:33 -0800
Message-Id: <8adc5cd5aaeef76ddeef459c79ecec7a05a1fd7b.1576583819.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.0.627.geba02921db
In-Reply-To: <cover.1576583819.git.liu.denton@gmail.com>
References: <cover.1576583819.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_must_fail function should only be used for git commands since
we should assume that external commands work sanely. Since has_cr() just
wraps a tr and grep pipeline, replace `test_must_fail has_cr` with
`! has_cr`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t0020-crlf.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index 8281babde0..4940e05a2e 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -159,8 +159,8 @@ test_expect_success 'checkout with autocrlf=input' '
 	rm -f tmp one dir/two three &&
 	git config core.autocrlf input &&
 	git read-tree --reset -u HEAD &&
-	test_must_fail has_cr one &&
-	test_must_fail has_cr dir/two &&
+	! has_cr one &&
+	! has_cr dir/two &&
 	git update-index -- one dir/two &&
 	test "$one" = $(git hash-object --stdin <one) &&
 	test "$two" = $(git hash-object --stdin <dir/two) &&
@@ -237,9 +237,9 @@ test_expect_success '.gitattributes says two is binary' '
 	git config core.autocrlf true &&
 	git read-tree --reset -u HEAD &&
 
-	test_must_fail has_cr dir/two &&
+	! has_cr dir/two &&
 	verbose has_cr one &&
-	test_must_fail has_cr three
+	! has_cr three
 '
 
 test_expect_success '.gitattributes says two is input' '
@@ -248,7 +248,7 @@ test_expect_success '.gitattributes says two is input' '
 	echo "two crlf=input" >.gitattributes &&
 	git read-tree --reset -u HEAD &&
 
-	test_must_fail has_cr dir/two
+	! has_cr dir/two
 '
 
 test_expect_success '.gitattributes says two and three are text' '
@@ -270,7 +270,7 @@ test_expect_success 'in-tree .gitattributes (1)' '
 	rm -rf tmp one dir .gitattributes patch.file three &&
 	git read-tree --reset -u HEAD &&
 
-	test_must_fail has_cr one &&
+	! has_cr one &&
 	verbose has_cr three
 '
 
@@ -280,7 +280,7 @@ test_expect_success 'in-tree .gitattributes (2)' '
 	git read-tree --reset HEAD &&
 	git checkout-index -f -q -u -a &&
 
-	test_must_fail has_cr one &&
+	! has_cr one &&
 	verbose has_cr three
 '
 
@@ -291,7 +291,7 @@ test_expect_success 'in-tree .gitattributes (3)' '
 	git checkout-index -u .gitattributes &&
 	git checkout-index -u one dir/two three &&
 
-	test_must_fail has_cr one &&
+	! has_cr one &&
 	verbose has_cr three
 '
 
@@ -302,7 +302,7 @@ test_expect_success 'in-tree .gitattributes (4)' '
 	git checkout-index -u one dir/two three &&
 	git checkout-index -u .gitattributes &&
 
-	test_must_fail has_cr one &&
+	! has_cr one &&
 	verbose has_cr three
 '
 
-- 
2.24.0.627.geba02921db

