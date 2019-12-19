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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE12C43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 15:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D850F218AC
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 15:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuUj/gzW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfLSPJi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 10:09:38 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42585 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfLSPJh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 10:09:37 -0500
Received: by mail-ed1-f68.google.com with SMTP id e10so5185539edv.9
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 07:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sMOsSTcUib/0Oo6jSASJfIPkvF/od7VhhAhfKVBa5BM=;
        b=NuUj/gzW2uWBL7ni4y6q8EjZPUNKFhPIkFjMhr5DNNh3ewhC/QHfhkgiYhDiOy1WKA
         1L5Nnge44M0l5sAZr+Wc99Es3rPNpbe3Zt+bTQoQe3LSYi0DQ2DcJT5+Kq3nJSf6TJA4
         Dsv8xfQaBkTTuaeV4/ZPV9K5OH3q3CKuY70DqrHSfiuOffSAFWSJYaoolf4Timqff/AL
         9pODNkmCLU8hQauTYVTB/NbqB9QQYRL3V1xqMeYLtLh+d7MkqeYPedumcb6J1xuSKihe
         3tYBdEuBdM8937c1g6twWEnBSMu1WuzgIG48fvXyq5LQILXtUKr73sM4136lcoa3LESv
         a3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sMOsSTcUib/0Oo6jSASJfIPkvF/od7VhhAhfKVBa5BM=;
        b=DktJRx5Dyej7MUMNUZgZvlAy7qBo2muT8YRoLL5nEUrhzcr5bjMd6x0DMJB9etLf3f
         MKRoOp1wvmsi1ykbRwnUKn60M9j5eVWFZfxuEeuK/2qj5Y9zR2wvinNiW2XGNfgPG6JR
         he6AkmirE730OaBsK8vR6Wi50KwaD1MQwZJqZ3fpFP3pCGdMs9i2xLyxRZ26BQ9CTvaf
         B2eONVmy4Z8vxWgnnYFZJVAbIUg8t2w3R8DkDbwkVlbu3zzoIyhjJZItIx0JO6HAn4YL
         qpJKGYV7DNfjjaIY5ZDiEzT+/e1OTzzJfyBl3ABHU9IvvwoDwR1ZNLMbr4SxBKEF7Y5w
         i7Eg==
X-Gm-Message-State: APjAAAWvrw0KcITkAjEs0wlHwO6ETLKFSwVTbW05TcUrxQBkTOrJ1M9n
        ztnuQDG2W/P2gmmri+Oi4PU=
X-Google-Smtp-Source: APXvYqyjBsXuDRlQEvlz8mJgFkWf1DuosXc/8NOmxCk6avEIeIWSlaSRKIFi1oQjyGW51Tp4eQvRgw==
X-Received: by 2002:a17:906:4089:: with SMTP id u9mr10139932ejj.205.1576768176343;
        Thu, 19 Dec 2019 07:09:36 -0800 (PST)
Received: from localhost.localdomain (x4db583fb.dyn.telefonica.de. [77.181.131.251])
        by smtp.gmail.com with ESMTPSA id b27sm546584ejg.40.2019.12.19.07.09.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Dec 2019 07:09:35 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 1/6] t9902-completion: add tests for the __git_find_on_cmdline() helper
Date:   Thu, 19 Dec 2019 16:09:16 +0100
Message-Id: <20191219150921.5889-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.1.982.ga4d4aba446
In-Reply-To: <20191219150921.5889-1-szeder.dev@gmail.com>
References: <20191017173501.3198-1-szeder.dev@gmail.com>
 <20191219150921.5889-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The following two patches will refactor and extend the
__git_find_on_cmdline() helper function, so let's add a few tests
first to make sure that its basic behavior doesn't change.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t9902-completion.sh | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 54f8ce18cb..847ce601d2 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1363,6 +1363,34 @@ test_expect_success 'teardown after path completion tests' '
 	       BS\\dir '$'separators\034in\035dir''
 '
 
+test_expect_success '__git_find_on_cmdline - single match' '
+	echo list >expect &&
+	(
+		words=(git command --opt list) &&
+		cword=${#words[@]} &&
+		__git_find_on_cmdline "add list remove" >actual
+	) &&
+	test_cmp expect actual
+'
+
+test_expect_success '__git_find_on_cmdline - multiple matches' '
+	echo remove >expect &&
+	(
+		words=(git command -o --opt remove list add) &&
+		cword=${#words[@]} &&
+		__git_find_on_cmdline "add list remove" >actual
+	) &&
+	test_cmp expect actual
+'
+
+test_expect_success '__git_find_on_cmdline - no match' '
+	(
+		words=(git command --opt branch) &&
+		cword=${#words[@]} &&
+		__git_find_on_cmdline "add list remove" >actual
+	) &&
+	test_must_be_empty actual
+'
 
 test_expect_success '__git_get_config_variables' '
 	cat >expect <<-EOF &&
-- 
2.24.1.982.ga4d4aba446

