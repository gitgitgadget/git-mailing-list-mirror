Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AEFE92703
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 14:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjJEOFU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 10:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjJEODq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 10:03:46 -0400
Received: from mail.smrk.net (mail.smrk.net [IPv6:2001:19f0:6c01:2788:5400:4ff:fe27:adaa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC6D9ECD
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 02:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smrk.net; s=20221002;
        t=1696496534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bTzAQMiRk5+qjbfhvpDLfexLntzTNz6ecxAthnzMxHU=;
        b=ijYD0SalTWrRhpFoBkCznK03ZLuvZbtd0SoO6QAXzMoMhhccaC/AO7/l05fx3pCp+hoWWH
        QCeYg3ItYMVVNQSqtU0y7wk8aS3L4dvSMN7Kop5WDcdTPkcaiqb1szG/M4rOXeaZ4aC22L
        ZWsWrTP8aNs2J7OvCkphRUo+OdRp5hkdC0AQkIsP5S4tEvxImiWE+Cp84fQNPVxYY8eTln
        9I0DYG0KfFkDxGyEUUf8Htagj22Zwk3mwJHc8rdvvo1TKg7sMFiDz1AuA6dKvPm5JKFJgh
        ApBIOXb7BzlGIHF2X1W8/lZgn2/ExKUQtULb8tYNE3hnxYZTX0gmS7Z7nGIKKQ==
Received: from localhost (<unknown> [192.168.5.2])
        by smrk (OpenSMTPD) with ESMTPSA id 425a4770 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 5 Oct 2023 11:02:14 +0200 (CEST)
From:   =?UTF-8?q?=C5=A0t=C4=9Bp=C3=A1n=20N=C4=9Bmec?= <stepnem@smrk.net>
To:     git@vger.kernel.org
Subject: [PATCH v2 5/5] t/README: fix multi-prerequisite example
Date:   Thu,  5 Oct 2023 11:00:55 +0200
Message-ID: <20231005090055.3097783-5-stepnem@smrk.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231005090055.3097783-1-stepnem@smrk.net>
References: <20231003082107.3002173-1-stepnem@smrk.net>
 <20231005090055.3097783-1-stepnem@smrk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With the broken quoting the test wouldn't even parse correctly, but
there's also the '==' instead of POSIX '=' (of the shells I tested,
busybox ash, bash and ksh (93 and OpenBSD) accept '==', dash and zsh do
not), and 'print 2' from Python 2 days.

(I assume the test failing due to 3 != 4 is intentional or immaterial.)

Fixes: 93a572461386 ("test-lib: Add support for multiple test prerequisites")
Signed-off-by: Štěpán Němec <stepnem@smrk.net>
---
 t/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/README b/t/README
index 2ef89785f831..a0ebe294848d 100644
--- a/t/README
+++ b/t/README
@@ -887,7 +887,7 @@ see test-lib-functions.sh for the full list and their options.
    rare case where your test depends on more than one:
 
 	test_expect_success PERL,PYTHON 'yo dawg' \
-	    ' test $(perl -E 'print eval "1 +" . qx[python -c "print 2"]') == "4" '
+	    ' test $(perl -E '\''print eval "1 +" . qx[python -c "print(2)"]'\'') = "4" '
 
  - test_expect_failure [<prereq>] <message> <script>
 
-- 
2.42.0

