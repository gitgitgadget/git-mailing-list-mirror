Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2474BC43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C6E24672
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8U7J6YS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfLSWVr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 17:21:47 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41692 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbfLSWVj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 17:21:39 -0500
Received: by mail-pf1-f193.google.com with SMTP id w62so4069046pfw.8
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 14:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wWeg/wl9RrK6mqFq+reQZd+RrvAMP1+PT+GY5lcwJck=;
        b=N8U7J6YSxGDmmo/IS4/gssUaKbtMv/P6hJJ6fvylhND7vjBdZxvn8RNYLGY6k4eLXz
         NyKAtjLpFlBFW1avS/0GfWvGzuDAK5geOWpGIS7Q9Lp1mebC2rloC/T+clt9ZaXkKipa
         ucU2803yxK//Fhki6kxi0pW12G9qtLwlH/hW+tVDBL3uiQh6+6lA6z5qp5zATRtznosG
         cHVEO/1FoKivqGdgendgUc2ICS4poX8rKaumHvQ9QDAfd12tYspj/T91DKRCJtoxjpJb
         kxUJGwIjNoedviamfexQTH+s2GtzXLlmMkfQUqr3IJiOjS6PFEWSH7YvUZUxyZJCK5ls
         W6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wWeg/wl9RrK6mqFq+reQZd+RrvAMP1+PT+GY5lcwJck=;
        b=SQTxMQP5QvVa/ts/2r7YPccG5Lsn3sNnCjtV1fRkRAzzCuRT1QFkwCkat63m9K00rL
         WzwmplSxrA/sqNacTP5i7r6DOY+WAEoMnMbuwz0I2Qc7N6WlUue3K5r+vW/IBWDeUOzK
         +QtJcdSggNdrhG3rjaUz1hTgzVgQiXdyRywi4yETrQwdgxfCySC5Pm4BiUYFb6npqrna
         p44S/CnIGYfGQOpPIqwzkIaNpoqDIAh/W7LJCN2rW7KV1+4y0hrBh7fn5k3Xh0IgkxcG
         v0geoyd447wwaAmzVSm1NQSm4deoSlnUHnDZlJfQSlGiyb3DSFFwQ6p3/7BBl+StIDE+
         lTyg==
X-Gm-Message-State: APjAAAW49XF6I6o+kvvnhr3E8N3TrltDLniRSB27rXqWtqa1igEYl9AN
        f4t8SwBXlBG/8gX3W5JQUzNM+vIy
X-Google-Smtp-Source: APXvYqwwOgfbQ9buJ0iBC0dkdaU2svIOLP6NCkNn3feon0XsoJOq2oulu2Oscd5eFacm0KWq9ltzyQ==
X-Received: by 2002:a63:fb05:: with SMTP id o5mr11577951pgh.355.1576794098956;
        Thu, 19 Dec 2019 14:21:38 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com ([216.52.21.197])
        by smtp.gmail.com with ESMTPSA id o19sm11428528pjr.2.2019.12.19.14.21.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 14:21:38 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 04/16] t0003: use named parameters in attr_check()
Date:   Thu, 19 Dec 2019 14:22:39 -0800
Message-Id: <dbc82d45c613e82a1905314e7b40eaf096c73102.1576794144.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.703.g2f499f1283
In-Reply-To: <cover.1576794144.git.liu.denton@gmail.com>
References: <cover.1576583819.git.liu.denton@gmail.com> <cover.1576794144.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We had named the parameters in attr_check() but $2 was being used
instead of $expect. Make all variable accesses in attr_check() use named
variables instead of numbered arguments for clarity.

While we're at it, add variable assignments to the &&-chain. These
aren't ever expected to fail but if a future developer ever adds some
code above the assignments and they could fail in some way, the intact
&&-chain will ensure that the failure is caught.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t0003-attributes.sh | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 71e63d8b50..3569bef75d 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -5,19 +5,16 @@ test_description=gitattributes
 . ./test-lib.sh
 
 attr_check () {
-	path="$1" expect="$2"
+	path="$1" expect="$2" git_opts="$3" &&
 
-	git $3 check-attr test -- "$path" >actual 2>err &&
-	echo "$path: test: $2" >expect &&
+	git $git_opts check-attr test -- "$path" >actual 2>err &&
+	echo "$path: test: $expect" >expect &&
 	test_cmp expect actual &&
 	test_line_count = 0 err
 }
 
 attr_check_quote () {
-
-	path="$1"
-	quoted_path="$2"
-	expect="$3"
+	path="$1" quoted_path="$2" expect="$3" &&
 
 	git check-attr test -- "$path" >actual &&
 	echo "\"$quoted_path\": test: $expect" >expect &&
-- 
2.24.1.703.g2f499f1283

