Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAE7C1975A
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 15:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C2520789
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 15:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uIFImBvm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgCYPHA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:07:00 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35063 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbgCYPHA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 11:07:00 -0400
Received: by mail-pf1-f196.google.com with SMTP id u68so1173560pfb.2
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 08:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rk93iIFXLxxfBSCv6fjokclVhOQ1+eI0Uc28Ooz/j2M=;
        b=uIFImBvmi3tVaEc+xkeVFAxdYAO0C2HNucgKP+m083JqvxgsWL1yC4MEOQEqrKP0N7
         WqR9CiaeGVDBbDmk6iSLr8ND9rekJ4og1o+X9/g0BWzkYVKsSjXlzLFqHftg7BkPMtsE
         wF5CfGZ5caD/52tSe2fRl8fBgzBq2/+mZd5yiMAw8UJUcHKkloMoSHJeUKtnAuyl3E0N
         DNxHKUpCAbwTkRYEocGBS+WG0aNRS9vkgNCwzevF6Hlru/0/C/Q1NBEv2mfGu36RnT+7
         a7DLk1nf/k95Q/CcZK7Jb8/QPrLQArOz/fVh1TPQCk/Ze/byAvYe1S0ntYkShkqerBIl
         DN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rk93iIFXLxxfBSCv6fjokclVhOQ1+eI0Uc28Ooz/j2M=;
        b=dIiWWbPdywPZNCFadh16lt2JGBbSAU3D3trEUfOj+JnIo7u46zbvbyG/VTzfYo+3Av
         uhbwqxzWjqiUFht73+Vwi5SXc0OIoR642Y3NfztGGC97fDEO0C8rAx6Pm4VxuhOPswjy
         CzYhTI3zoGtZedkBRJlBuJgMs3C7dGDg8PnWg8VnEfNjFxQ31c61revS/WcIayPISuOp
         J22dTzOwZCxN5cg2btiSGRQ86kIK33tvz9nrBUhr+OuHKhY1+aPUJtilPJmrXZH1w7di
         Xw5XbDPHMUlrSN/WDURP6TOb+3T7AOaFLIvOdk5do7n7cXPbPwN1FAb6lIbC3wMeqdwS
         gQhg==
X-Gm-Message-State: ANhLgQ0UL7bgsf/Zv4QrReJxzzzEQHEdbAoXD+6StXtu1x1FHuD5ZikD
        ce7f03SlU5IUIPWklVydMb/R0SCa
X-Google-Smtp-Source: ADFU+vtEFzpRh6TsICQf6egWl4yNwfblu2GRZzlnJIoxdKbngwX0vGQO7z7HH4d2Ar4kAAvatxIJfA==
X-Received: by 2002:a65:6805:: with SMTP id l5mr3490868pgt.256.1585148818358;
        Wed, 25 Mar 2020 08:06:58 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:c347:544a:f0cc:8a21:fee3])
        by smtp.gmail.com with ESMTPSA id f127sm18232538pfa.112.2020.03.25.08.06.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 08:06:57 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v3 3/8] t5003: drop the subshell in test_lazy_prereq
Date:   Wed, 25 Mar 2020 22:06:16 +0700
Message-Id: <759a589b83515cc7a676009d820e11fc36c5a0a2.1585148327.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.357.g1e1ba0441d
In-Reply-To: <cover.1585148327.git.congdanhqx@gmail.com>
References: <cover.1585148327.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

test_lazy_prereq will be evaluated in a throw-away directory.

Drop unnecessary subshell and mkdir.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t5003-archive-zip.sh | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index 106eddbd85..df1374a312 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -7,12 +7,8 @@ test_description='git archive --format=zip test'
 SUBSTFORMAT=%H%n
 
 test_lazy_prereq UNZIP_SYMLINKS '
-	(
-		mkdir unzip-symlinks &&
-		cd unzip-symlinks &&
-		"$GIT_UNZIP" "$TEST_DIRECTORY"/t5003/infozip-symlinks.zip &&
-		test -h symlink
-	)
+	"$GIT_UNZIP" "$TEST_DIRECTORY"/t5003/infozip-symlinks.zip &&
+	test -h symlink
 '
 
 check_zip() {
-- 
2.26.0.rc2.357.g1e1ba0441d

