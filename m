Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D45C2D0E7
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 08:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD5620772
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 08:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AryNEg3I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgCZI2g (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 04:28:36 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:47085 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbgCZI2f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 04:28:35 -0400
Received: by mail-qk1-f195.google.com with SMTP id u4so5503774qkj.13
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 01:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=B5o02/rQfQnbpSb7SQlxFYVvIOSMk/M9YYa7iJaCwVA=;
        b=AryNEg3Il8kGHtuLxXUsBz5BoVhmaxsvrdh1EG4Gxb66qopLP78lHHLqrtUaS81Afg
         H0dC0wjh19kbSg1QXoi5bLZ/AJmsTT+/mx6UKOqU56asr+q9HPGZ6tY7N/jQt0X/zj5f
         A1yULU3eQ8wiX98aTeK13Lm0Bjx1EEL2UvqXRAyctDoOzfbjl0/rpCiy5fe7AZ/BJTrC
         aKGxsxx/18mOTv9ATYHAON49rqVe9ELhsxa1qlWq8hmiR2Gh8Qhvk3KvNYrsbX4Hdeyo
         xCF2mEvNRbCXbM9sc6K5SMcvWHtIrKYl9SP030CA01gBez/clsV6SzP7WVw6iCUjNb22
         1cfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B5o02/rQfQnbpSb7SQlxFYVvIOSMk/M9YYa7iJaCwVA=;
        b=hzZsNC3k65Q4Gg+vtZiYn8aM6YDBsJr+aorXeIT/3msbnmkVbG61mcGMlgW2C8yX13
         Ej8Tw9lzqquOFqbj/gWlFBRpaLKG15idrXT39Xd66Vimrla/3pozmxrfiD1x7EOBoboa
         HreT3G4WPFpoJUZa1+fFIImiSCF37rULeJzBr5BFgcWP4SAuEqS5PSF4E1O7GPoQZ913
         he+UCotMYYJF8pG7WNyZgpym29KjsKcvYPuaRJA7kl7w0S6PPvD0icoAf3q9W4HZo7EI
         D4ySItUt4Xv3dnckMArEcFqs84wmn5BcSv/UK3yfwWmCWFT15FFSjNvucxKWXaX36VZ3
         jGSg==
X-Gm-Message-State: ANhLgQ3/0O14JqaC3KgAbyPyTRrWmm69+WiaL0MB7ZdLAY4O1MuamTLo
        vzGQgXEBFVQTj4wkfyr0QYkvJrjM
X-Google-Smtp-Source: ADFU+vt4bjwvpwB5xG/3hczVLWAdLTrCp+cWz0pOZvzVL5k6pftCFSIiLbRoR5d7VQKTdWR6aoqovg==
X-Received: by 2002:a37:9b51:: with SMTP id d78mr7060796qke.65.1585211314229;
        Thu, 26 Mar 2020 01:28:34 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id g187sm935789qkf.115.2020.03.26.01.28.33
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 01:28:33 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH v2 8/8] t5801: teach compare_refs() to accept !
Date:   Thu, 26 Mar 2020 04:27:55 -0400
Message-Id: <6a9d3cef2a0daf1b058921bd0cd3397f7753e537.1585209554.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1585209554.git.liu.denton@gmail.com>
References: <cover.1585115341.git.liu.denton@gmail.com> <cover.1585209554.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, testing if two refs weren't equal with compare_refs() was done
with `test_must_fail compare_refs`. This was wrong for two reasons.
First, test_must_fail should only be used on git commands. Second,
negating the error code is a little heavy-handed since in the case where
one of the git invocations within compare_refs() fails, we will report
success, even though it failed at an unexpected point.

Teach compare_refs() to accept `!` as the first argument which would
_only_ negate the test_cmp()'s return code.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5801-remote-helpers.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 121e5c6edb..0f04b6cddb 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -11,9 +11,15 @@ test_description='Test remote-helper import and export commands'
 PATH="$TEST_DIRECTORY/t5801:$PATH"
 
 compare_refs() {
+	fail= &&
+	if test "x$1" = 'x!'
+	then
+		fail='!' &&
+		shift
+	fi &&
 	git --git-dir="$1/.git" rev-parse --verify $2 >expect &&
 	git --git-dir="$3/.git" rev-parse --verify $4 >actual &&
-	test_cmp expect actual
+	eval $fail test_cmp expect actual
 }
 
 test_expect_success 'setup repository' '
@@ -189,7 +195,7 @@ test_expect_success GPG 'push signed tag' '
 	git push origin signed-tag
 	) &&
 	compare_refs local signed-tag^{} server signed-tag^{} &&
-	test_must_fail compare_refs local signed-tag server signed-tag
+	compare_refs ! local signed-tag server signed-tag
 '
 
 test_expect_success GPG 'push signed tag with signed-tags capability' '
-- 
2.26.0.159.g23e2136ad0

