Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCA7C0018C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C38412342C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731139AbgLPSvv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbgLPSvv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 13:51:51 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D4DC0611CD
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:42 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id l11so51010555lfg.0
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iPZBgNe/CnnTJLkmODqda//1HtZVycy3DAT/Qha+4cE=;
        b=pWu9fSQ3XE5lBi9yeoBv7/RaGmxK6Hbsr9ZwSnIbmPBIp248F1jLKtHCqNtlZhvO+h
         MuDeYpnpO6x7ufrnp+avmJIRxvBzIZgE+KRBIzRD9Pgr3xg1msNIODJZltYf4pdv1WZ3
         IuAKeCNU2Bv9cnFAnJbPC3F4hYpTJHX2zMzwu2kVL9o7NfikFC/ECpPpxSlwEyppthtw
         OjDaAlHY4I4XJXjOWYLuOA1GgvaYK6MPG+62AeA3AYS+bpAclyB1C16/mw0GQGVay8lT
         ZHkxD2bDmWQ36enru3b/NZ4FqKJxrFw36okugg/TjB1k/zg4WFSFe77636eH5g31RrrV
         5xYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iPZBgNe/CnnTJLkmODqda//1HtZVycy3DAT/Qha+4cE=;
        b=Dypc/irAWrdPTTQgQ2PkYJtKXIdK4TZInbzMVjMoFyBuChitPLU79NEWirwHbWYw5h
         EDvghC/rxRfG2da6ydFB7gsWa3pURxnGjTTaiFUeKo+X84JlKbjSn/c4TdCgvnPeaM9+
         Tt8KoNTAXxlYpweHCKmfKBWhInf4PmaF79a+CzXGMYj+SRNX4H247U30b/9Q2chdAKvv
         1clVCNBYOw3NiC91rhNpgyF4WQeSSrcCxXD+/j5KC4NPaFc9cthM4Irddav0BvHfjzgt
         ee5glbv31Ftz+SUU0VtqOPNUrWjEi/DvuKDojaEdnI6sSJ9cGrGi1wQ+ELbESt0OOOp8
         66mA==
X-Gm-Message-State: AOAM531lor44HNvqetjkQGZvb+ZMCZBq7D3VEBom0JyL+hfuNq5kyqm1
        VGnuMmLY+icbkZVUamJk+UA=
X-Google-Smtp-Source: ABdhPJxIo5VQKY/Gu4SfsJsnNak0US0q1XbIfY8ux5gV8W/RhNVhvTMDtiNlJjw8riucbWxEXAdUEg==
X-Received: by 2002:a2e:b1c9:: with SMTP id e9mr15743676lja.283.1608144640581;
        Wed, 16 Dec 2020 10:50:40 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 197sm313871lfe.158.2020.12.16.10.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 10:50:40 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 14/33] t4013: support test_expect_failure through ':failure' magic
Date:   Wed, 16 Dec 2020 21:49:10 +0300
Message-Id: <20201216184929.3924-15-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201216184929.3924-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201216184929.3924-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add support to be able to specify expected failure, through :failure
magic, like this:

:failure cmd args

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 t/t4013-diff-various.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 5c7b0122b4f1..935d10ac0572 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -174,6 +174,7 @@ process_diffs () {
 V=$(git version | sed -e 's/^git version //' -e 's/\./\\./g')
 while read magic cmd
 do
+	status=success
 	case "$magic" in
 	'' | '#'*)
 		continue ;;
@@ -182,6 +183,10 @@ do
 		label="$magic-$cmd"
 		case "$magic" in
 		noellipses) ;;
+		failure)
+			status=failure
+			magic=
+			label="$cmd" ;;
 		*)
 			BUG "unknown magic $magic" ;;
 		esac ;;
@@ -194,7 +199,7 @@ do
 	expect="$TEST_DIRECTORY/t4013/diff.$test"
 	actual="$pfx-diff.$test"
 
-	test_expect_success "git $cmd # magic is ${magic:-(not used)}" '
+	test_expect_$status "git $cmd # magic is ${magic:-(not used)}" '
 		{
 			echo "$ git $cmd"
 			case "$magic" in
-- 
2.25.1

