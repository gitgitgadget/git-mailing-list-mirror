Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2420C43215
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 18:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84DB2070B
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 18:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BR1wLHv5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfK0SNs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 13:13:48 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33150 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfK0SNr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 13:13:47 -0500
Received: by mail-pg1-f195.google.com with SMTP id 6so6741689pgk.0
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 10:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bPe4LFsftv70u2OUy2/fUI40CX4aU9IvFy7Uq8RYoCM=;
        b=BR1wLHv5ctntw0eB917D8TQ1v3t9CnlV7sDxsAe7dlnMoWrD1WWbmiKU7UgLsvAdLH
         BTNgBwamfxRqv+z1qQI5PY4hxqkJ0nicp9dYrpjUgkP4dPI9X6CnQJNMVRaZGWzZr1Q1
         TX6HRUteELLZYm2MfM5VgG8fs8wh4WeSwywlPx/UGWcgZsxXUMdJXdwANjAl8TnCFG8X
         fkeocs3FlDp88G1z+bIOGL8qAXTBUOCVu/cRAaXtqhzj5l7n6B1Q3wMd2WSLTTJ2jVlg
         1Ddsxh4dqUXOfbXWXjXtnK45zWZrHm9X9hzyOk1vJAUTLntylxkw7zWYc+Hl7AE3BAtV
         QQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bPe4LFsftv70u2OUy2/fUI40CX4aU9IvFy7Uq8RYoCM=;
        b=q/anGlpFU9baj4Oxufd6gBFeAeV9eXvIsomq0R9Ifti2FehWMv3eGfSDa1kEcLNWh4
         hvGp6ECZ4i1+ilcCLjtydgJCtPOcqx5d41/QARLv1gUAZy6PeDzDgFyC+zC6iTKVponO
         v4Qy8BkzoK3qYyKh1J8gV0+j2y0C1rHsKmoy+IfIDhV4m7JyY10wDqmjLL3Bf8ftRJm5
         xhRPsazk98eii7FRPDDQe3GmFNHiwFh7racZ6NltmTSup7eew4Zb3kF5HX7IKvjG/4Ey
         XzO0vBKhRGIPIs/Kr0me24Y170mo9+YnlU6/HTj4Reh18I/bgDiXwau2XyWfaqCke26U
         ug7Q==
X-Gm-Message-State: APjAAAXofQ6SXbFn6bah+DeqcwkKTjnt69GgbcphX5iqm1RA+2/IsXyg
        b5Iir1WkZHbb5j6XLL5RMSI4Us3A
X-Google-Smtp-Source: APXvYqySBwCVs0RxQGwn8bVB+M+5C024g3mtZ0KdKhRM571idR3fRfM1kApdAJ5sE9k0/OsXYJPrsQ==
X-Received: by 2002:a63:fe4d:: with SMTP id x13mr6259279pgj.82.1574878426527;
        Wed, 27 Nov 2019 10:13:46 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id w138sm18187564pfc.68.2019.11.27.10.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 10:13:46 -0800 (PST)
Date:   Wed, 27 Nov 2019 10:13:44 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Christian Biesinger <cbiesinger@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 3/5] t4014: use test_config()
Message-ID: <196b5d8dbccfa550608c9a6c19ae4b7743089f41.1574878089.git.liu.denton@gmail.com>
References: <cover.1574820308.git.liu.denton@gmail.com>
 <cover.1574878089.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574878089.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of manually unsetting the config after the test case is done,
use test_config() to do it automatically. While we're at it, fix a typo
in a test case name.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4014-format-patch.sh | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 69267b16f0..c7cc643adf 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1939,10 +1939,9 @@ test_expect_success 'format-patch errors out when history involves criss-cross'
 	test_must_fail 	git format-patch --base=auto -1
 '
 
-test_expect_success 'format-patch format.useAutoBaseoption' '
-	test_when_finished "git config --unset format.useAutoBase" &&
+test_expect_success 'format-patch format.useAutoBase option' '
 	git checkout local &&
-	git config format.useAutoBase true &&
+	test_config format.useAutoBase true &&
 	git format-patch --stdout -1 >patch &&
 	grep "^base-commit:" patch >actual &&
 	git rev-parse upstream >commit-id-base &&
@@ -1951,8 +1950,7 @@ test_expect_success 'format-patch format.useAutoBaseoption' '
 '
 
 test_expect_success 'format-patch --base overrides format.useAutoBase' '
-	test_when_finished "git config --unset format.useAutoBase" &&
-	git config format.useAutoBase true &&
+	test_config format.useAutoBase true &&
 	git format-patch --stdout --base=HEAD~1 -1 >patch &&
 	grep "^base-commit:" patch >actual &&
 	git rev-parse HEAD~1 >commit-id-base &&
-- 
2.24.0.504.g3cd56eb17d

