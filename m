Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 180BC1F770
	for <e@80x24.org>; Sun, 30 Dec 2018 19:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbeL3TRB (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Dec 2018 14:17:01 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34932 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbeL3TRA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Dec 2018 14:17:00 -0500
Received: by mail-wm1-f66.google.com with SMTP id t200so11273658wmt.0
        for <git@vger.kernel.org>; Sun, 30 Dec 2018 11:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4GrnKFR07mS7TdVR05EkIjdQNgfKMJ8yO+J4kh6C6Wg=;
        b=BJ/hmDxqMD4VS0jmg2Qq/RxMADMUlqRT3m98coFYLIlAgXaDYEEUtyLIKLmKhXmFwk
         pXLOTXQFsNSJDMsrdnjFTstL/s9JixtyWiN3xh4Vmy4wztANyfQZ/o1mFNYQTwP+4Q2t
         b1capMsc/mxWEVjS6sdS0O3AXRVgMjV/MdoIIUtsDagRt+ej63vJDlR7R0cVLW8npXRG
         MbRvkXNExIgXlroUo8AoyDO96WT0ruc9bMItbynFL1gZlO2xLS20h0GVB+9KPvzyZ8u4
         7H7kgZIYffiR8ISGOUlCuGwAIdEolBcrmECLZXQE0Zpf5gNQqkQ0WESXDfwZyBATQ3oq
         MU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4GrnKFR07mS7TdVR05EkIjdQNgfKMJ8yO+J4kh6C6Wg=;
        b=lGDl/Lye2cecuNFFQndI07H8yheIAi5Q2budaMH+/rRz/TVXANJzujFeTvt+/WuuIt
         9kGcGGtPsTmgwDKHS6VkeH02gBVOx9Sh9bKNtUOpppITHRI0EGgFLKvxjTCCuRh80RvW
         FhUqGm7DkUEM9M3s4PoU1EWm+Etq0mHR9bkeGdM9RlJv1nzDNODzYBeobMnk++s6kJkA
         zIyeX5jyXVXkxc1xOsmvGs9ul221vR1jJJU1QA3K0qReSyAivGuKxJp7k2AzhISsecAD
         mrK6TA4MYVDMaLmt9lGJQ2V5XpsmVu85B/XlT14k7TgBApqU0KgWBg1dDiEsG/1UptzD
         hvOA==
X-Gm-Message-State: AJcUukcQV8MaToRFIHqbv1re/KLAVTTrsLhPwLv75Qzn+WQgdsdu4cLw
        dJWY8FZTw3L8QAc3R2Uc528=
X-Google-Smtp-Source: ALg8bN6gaFQ09kSLx04ri+j0sO4gidfk7ALkqbIpGBYaAUeZc3pNvt6eOFvngANbOOy5iqhTlsEg/Q==
X-Received: by 2002:a1c:578e:: with SMTP id l136mr16699328wmb.124.1546197418038;
        Sun, 30 Dec 2018 11:16:58 -0800 (PST)
Received: from localhost.localdomain (84-236-109-65.pool.digikabel.hu. [84.236.109.65])
        by smtp.gmail.com with ESMTPSA id h62sm28954226wmf.11.2018.12.30.11.16.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 30 Dec 2018 11:16:57 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 6/8] test-lib: extract Bash version check for '-x' tracing
Date:   Sun, 30 Dec 2018 20:16:27 +0100
Message-Id: <20181230191629.3232-7-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.1.151.gec613c4b75
In-Reply-To: <20181230191629.3232-1-szeder.dev@gmail.com>
References: <20181209225628.22216-1-szeder.dev@gmail.com>
 <20181230191629.3232-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of our test scripts, 't1510-repo-setup.sh' [1], still can't be
reliably run with '-x' tracing enabled, unless it's executed with a
Bash version supporting BASH_XTRACEFD (since v4.1).  We have a lengthy
condition to check the version of the shell running the test script,
and disable tracing if it's not executed with a suitable Bash version
[2].

Move this check out from the option parsing loop, so other options can
imply '-x' by setting 'trace=t', without missing this Bash version
check.

[1] 5827506928 (t1510-repo-setup: mark as untraceable with '-x',
    2018-02-24)
[2] 5fc98e79fc (t: add means to disable '-x' tracing for individual
    test scripts, 2018-02-24)

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/test-lib.sh | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 2b88ba2de1..7d77a26d44 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -134,25 +134,7 @@ do
 	--no-chain-lint)
 		GIT_TEST_CHAIN_LINT=0 ;;
 	-x)
-		# Some test scripts can't be reliably traced  with '-x',
-		# unless the test is run with a Bash version supporting
-		# BASH_XTRACEFD (introduced in Bash v4.1).  Check whether
-		# this test is marked as such, and ignore '-x' if it
-		# isn't executed with a suitable Bash version.
-		if test -z "$test_untraceable" || {
-		     test -n "$BASH_VERSION" && {
-		       test ${BASH_VERSINFO[0]} -gt 4 || {
-			 test ${BASH_VERSINFO[0]} -eq 4 &&
-			 test ${BASH_VERSINFO[1]} -ge 1
-		       }
-		     }
-		   }
-		then
-			trace=t
-		else
-			echo >&2 "warning: ignoring -x; '$0' is untraceable without BASH_XTRACEFD"
-		fi
-		;;
+		trace=t ;;
 	-V|--verbose-log)
 		verbose_log=t
 		tee=t
@@ -178,6 +160,24 @@ then
 	test -z "$verbose_log" && verbose=t
 fi
 
+if test -n "$trace" && test -n "$test_untraceable"
+then
+	# '-x' tracing requested, but this test script can't be reliably
+	# traced, unless it is run with a Bash version supporting
+	# BASH_XTRACEFD (introduced in Bash v4.1).
+	if test -n "$BASH_VERSION" && {
+	     test ${BASH_VERSINFO[0]} -gt 4 || {
+	       test ${BASH_VERSINFO[0]} -eq 4 &&
+	       test ${BASH_VERSINFO[1]} -ge 1
+	     }
+	   }
+	then
+		: Executed by a Bash version supporting BASH_XTRACEFD.  Good.
+	else
+		echo >&2 "warning: ignoring -x; '$0' is untraceable without BASH_XTRACEFD"
+		trace=
+	fi
+fi
 if test -n "$trace" && test -z "$verbose_log"
 then
 	verbose=t
-- 
2.20.1.151.gec613c4b75

