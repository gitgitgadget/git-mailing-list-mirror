Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4D8C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 291862146E
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFmIZp8Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfLTSOj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:14:39 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37652 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbfLTSOi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 13:14:38 -0500
Received: by mail-pj1-f66.google.com with SMTP id m13so4476936pjb.2
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 10:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ISkCmzf91CTIU8RodTdihc1hjhX0gWKk58ZbMkwYFMI=;
        b=OFmIZp8QnzExLqq2YYUtr+ElA54mu0RYmdAsGCSCS+UilZIV66DdnE3EGvEpWfAxvF
         xUBRBkiR0pUS5BP1GXo9lPiC/zq+l0191JCuunlR2+XVHRJewMKShFBDSmsEAIAP7S4F
         w1i9svXzOzuToVVFJ5DSMYn1AVbygU01fuAzTVd4HRxi+rFbJo5XDDvJouitO303VVWU
         OnPpYFAKB1EI27fhhmaiAIz4yyu7/aWSwdnsJlEpqaXptbCHdqBmvGhZqSeU6Q/4UlkZ
         sLLQ6kdgHtnY0ZmZ2ps1ce851OyET27Nt771S5CPoVXPr+/qTnRYp1JoOmg3Uo3urPwg
         uDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ISkCmzf91CTIU8RodTdihc1hjhX0gWKk58ZbMkwYFMI=;
        b=QxABzGCS4eFtGnRzOPj/jPL5DLx7Q9ExddhCrdWKzziTaKFH/FS4mh2OdzfH986NFy
         3/emkEwbc61aKgPBRJ3BKuj2DMkubwYCuzpVu3uZKciDvEBC7ZLENbd2gcVciK/LE06i
         FPEtKvW1ISw3D1ST79jVDIho3DcxZ7OG7KO5FslKRydOWKFMiuHEIGTgKLmL8QQwP1C/
         qXdO0Z9g+OPTYEKmN6zjCa9TPlY70aqZAT68TpiptUo0rT7cJjs4qRllVEKuVW3SR8TM
         nyO6hyPoOL3aCPFDzFvxojzdi/cX+HxZ39D+ohunzpdrbliWd/8wnwFeMnx7ciER04Sd
         5EvQ==
X-Gm-Message-State: APjAAAWyjTJlvSR0pGb0AHjsvHLHla5cXiMy+76GYXRTzIFrepy47g9b
        kh1Ob9bdOpU8XLEWxsLd9PObdt2s
X-Google-Smtp-Source: APXvYqyjdsGv7e6zoWWG01ytOrpA7jfkg2MI68wRl0HnFwUUxEszJAHbZpVVHOnR1QdEEJp6DONs9A==
X-Received: by 2002:a17:902:7484:: with SMTP id h4mr16000934pll.206.1576865677196;
        Fri, 20 Dec 2019 10:14:37 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com.com ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id c78sm14063082pfb.122.2019.12.20.10.14.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 10:14:36 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 04/15] t0003: use test_must_be_empty()
Date:   Fri, 20 Dec 2019 10:15:51 -0800
Message-Id: <7f8808a850cd01a605794fc5b5bb276330d7abb5.1576865664.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.703.g2f499f1283
In-Reply-To: <cover.1576865663.git.liu.denton@gmail.com>
References: <cover.1576794144.git.liu.denton@gmail.com> <cover.1576865663.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In several places, we used `test_line_count = 0` to check for an empty
file. Although this is correct, it's overkill. Use test_must_be_empty()
instead because it's more suited for this purpose.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t0003-attributes.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 3569bef75d..c30c736d3f 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -10,7 +10,7 @@ attr_check () {
 	git $git_opts check-attr test -- "$path" >actual 2>err &&
 	echo "$path: test: $expect" >expect &&
 	test_cmp expect actual &&
-	test_line_count = 0 err
+	test_must_be_empty err
 }
 
 attr_check_quote () {
@@ -241,7 +241,7 @@ EOF
 	git check-attr foo -- "a/b/f" >>actual 2>>err &&
 	git check-attr foo -- "a/b/c/f" >>actual 2>>err &&
 	test_cmp expect actual &&
-	test_line_count = 0 err
+	test_must_be_empty err
 '
 
 test_expect_success '"**" with no slashes test' '
@@ -262,7 +262,7 @@ EOF
 	git check-attr foo -- "a/b/f" >>actual 2>>err &&
 	git check-attr foo -- "a/b/c/f" >>actual 2>>err &&
 	test_cmp expect actual &&
-	test_line_count = 0 err
+	test_must_be_empty err
 '
 
 test_expect_success 'using --git-dir and --work-tree' '
-- 
2.24.1.703.g2f499f1283

