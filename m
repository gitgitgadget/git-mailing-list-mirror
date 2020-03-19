Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F5FC4332D
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 14:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A3A5208E4
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 14:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhfBwN7J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgCSOA6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:00:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41277 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbgCSOA6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 10:00:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id b1so1322515pgm.8
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 07:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k3KX9/oCcAXEyD+tqSwWrIjc05hRql0ltEu5j1M3TPw=;
        b=WhfBwN7J18XFY8G/BsbhO2ajxXPr769BQnwsJhSv1hlB2+bxNNxY84nPNLU7Pv1X8P
         7tqi7ggpi5JzdXL70swHWvv849ZOzrMIh0ovvVli2Nnf8rcxR515kJmh+0Cp1njofGiL
         JHJBKV7ClTLLcJR1DIxSVu30mBKv762Ops1g0EEgz0hjqclpchZVm45/GR4YFGurCsrc
         oSX9loIswxlA5Znt3uVCJZI+YfTExRlu9MrBEn8hlno2n7IgCob5uE+MoaRTPjsNuzDK
         3KYsUTrtuwxQt+TQny4OohBFkIQcfOcTZ+t7kgpWYcFECXA4iViy2ovX+RNgU7CNIVWO
         vdMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k3KX9/oCcAXEyD+tqSwWrIjc05hRql0ltEu5j1M3TPw=;
        b=iv6Hauni14+ZBwlNusyBTl9JmK6B5hJru5xNq1hWUbmyRdWKiLrSR3QB4QsLrRHM2x
         4pcVbT3dLBtOhnMkNKbZwR4eB41O92wZCQl+6cNrmpN1NH27ElJnal42rjbIHeT9xcF+
         RbDah1qC0+oK9aFO1RwoF9RyjrGzK+n7uy+UAi0Rjp3qI5NdTRaomvllWS/IllfVAXWG
         +sSGPVpwZmluwok1cIGvrr9bk3Z1Z0umZYca2076wOGbmE4kRKtQ6YRt+PrNAN9wzIpj
         H+jdxo4dEGqmqgmj7LNegEbqCk1irfeVXfzc5bR5DVNeR7WSzcYR54qAivMLB6LVvgnl
         FdYw==
X-Gm-Message-State: ANhLgQ2DYBHlZJFM1alA4MBVHfMuERlxHinXc5eK+tbLZ/ZfD8J8xVqS
        pJa7eoLru5ZLT1a0CjHsxSR+nH3x
X-Google-Smtp-Source: ADFU+vuFOgI857lbZuqUH2j4dlOQEehPbPxGTTjbL7C11JYVrMB+m3kQJHVYqcAEYJcZJk180vhjvA==
X-Received: by 2002:aa7:8650:: with SMTP id a16mr4323217pfo.35.1584626456176;
        Thu, 19 Mar 2020 07:00:56 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:576b:56ff:d97c:a505:3e0c])
        by smtp.gmail.com with ESMTPSA id 189sm2654005pfg.170.2020.03.19.07.00.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2020 07:00:54 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 6/6] t4124: fix test for non-compliance diff
Date:   Thu, 19 Mar 2020 21:00:07 +0700
Message-Id: <285c6830c5182cb602d4fe559525083f69a158e9.1584625896.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.234.g969ad452ca
In-Reply-To: <cover.1584625896.git.congdanhqx@gmail.com>
References: <cover.1584625896.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

POSIX's diff(1) requires output in normal diff format.
However, busybox's diff's output is written in unified format.

POSIX requires no option for normal-diff format.

A hint in test-lib-functions::test_cmp said `diff -u` isn't available
everywhere.

Workaround this problem by assuming `diff(1)` output is unified
if we couldn't make anything from normal-diff format.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t4124-apply-ws-rule.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index 971a5a7512..2a54ce96b5 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -52,6 +52,12 @@ test_fix () {
 
 	# find touched lines
 	$DIFF file target | sed -n -e "s/^> //p" >fixed
+	if ! test -s fixed; then
+		$DIFF file target |
+		grep '^+' |
+		grep -v '^+++' |
+		sed -e "s/+//" >fixed
+	fi
 
 	# the changed lines are all expected to change
 	fixed_cnt=$(wc -l <fixed)
-- 
2.26.0.rc2.234.g969ad452ca

