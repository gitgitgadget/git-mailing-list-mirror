Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 188CD1F770
	for <e@80x24.org>; Tue,  1 Jan 2019 23:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfAAXUC (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Jan 2019 18:20:02 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40482 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfAAXUC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jan 2019 18:20:02 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so28975567wrt.7
        for <git@vger.kernel.org>; Tue, 01 Jan 2019 15:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u4Vh4I8Xs3u2dTWQrJ3o2qwRLjN9CFXVnLmq/4QNk9Y=;
        b=c+clHBEI4x7gVaBDsuVfSetD0MoSsanZFhnxvwg6Bi39EIJMPDAyHkUFJZCk8QUifM
         LpiWt2g+mNWV0NTJg78JeFmsVZZDHFpKMLW3DtJmB7ieYvLsDJUBoq2B4VjMSHEDXamA
         aG+qpQm1jdWXqg805JP9ZlE4gcaTJrIjv5ZXkEOFN6FUQXwAxebXv7u6/u9oZ889ext5
         OYQkl08kfEbndTLCkrEgrQJsz+UXQ58yO9skU3LaDyL4iMZN49wU3BDLIDf8dXe64tVh
         lclcPZgnQP9WDSTz0Vqi7Q3mIeYVWgaIkn8nhVrOUaAXHCP3UtzJoevPLCOlNdAHdbTJ
         UwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u4Vh4I8Xs3u2dTWQrJ3o2qwRLjN9CFXVnLmq/4QNk9Y=;
        b=oR0G0HiFl/wrKKqPnLsZ39oI+fbOUGWG141LBHrp4WlNPzjblkzltKshCDgBKUtF+g
         YLMTe7GfhQieaqx8BHe5ADeNv0PgIcCQy81wwlBRsQJl9UUOJeaxqi7/gJNqvFlt6gS3
         DhFBGfFkRNdr3l/hgOahT6GtcYyOTBNRJuKFONz4vY2oa8wjtwrZoE7rsRBEIpCpt95o
         WmFe/VUKBhdhPprCQmqocps+fMcJ2/Qac/OKh6G7/pOY4iyXaRgdh2iS89/s04oRFeGH
         62EE23iVGxfV+IG2loPCl6Z7gM33PoP7ZWh+0LPAnDBqBtKd6tY9pwX31s3BsRbWI4NK
         eoTg==
X-Gm-Message-State: AJcUukfcQtHjWIiEJUK67h4TBitBYyqGge1Yng9RO0JJ7/b+mCvwkL0J
        dTPt72xgHdszIAwDed1mslI=
X-Google-Smtp-Source: ALg8bN4W3pzFh5u2/ExYOQevMTuNbEzXL6JG6cyFI8yLXmFU9A3cGNFyw+67xk5inC7cR/yIyZxWOQ==
X-Received: by 2002:adf:dfd1:: with SMTP id q17mr38615139wrn.27.1546384800489;
        Tue, 01 Jan 2019 15:20:00 -0800 (PST)
Received: from localhost.localdomain (94-21-23-250.pool.digikabel.hu. [94.21.23.250])
        by smtp.gmail.com with ESMTPSA id y13sm43896844wme.2.2019.01.01.15.19.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 01 Jan 2019 15:19:59 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Max Kirillov <max@max630.net>, Carlo Arenas <carenas@gmail.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] test-lib: check Bash version for '-x' without using shell arrays
Date:   Wed,  2 Jan 2019 00:19:49 +0100
Message-Id: <20190101231949.8184-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.1.151.gec613c4b75
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

This condition uses non-portable shell array accesses to easily get
Bash's major and minor version number.  This didn't seem to be
problematic, because the simple commands expanding those array
accesses are only executed when the test script is actually run with
Bash.  When run with Dash, the only shell I have at hand that doesn't
support shell arrays, there are no issues, as it apparently skips
right over the non-executed simple commands without noticing the
non-supported constructs.

Alas, it has been reported that NetBSD's /bin/sh does complain about
them:

  ./test-lib.sh: 327: Syntax error: Bad substitution

where line 327 contains the first ${BASH_VERSINFO[0]} array access.

To my understanding both shells are right and conform to POSIX,
because the standard allows both behavior by stating the following
under '2.8.1 Consequences of Shell Errors':

  "An expansion error is one that occurs when the shell expansions
  define in wordexp are carried out (for example, "${x!y}", because
  '!' is not a valid operator); an implementation may treat these as
  syntax errors if it is able to detect them during tokenization,
  rather than during expansion."

Avoid this issue with NetBSD's /bin/sh (and potentially with other,
less common shells) by using a couple of parameter expansions to
extract the major and minor version numbers from $BASH_VERSION.

[1] 5827506928 (t1510-repo-setup: mark as untraceable with '-x',
    2018-02-24)
[2] 5fc98e79fc (t: add means to disable '-x' tracing for individual
    test scripts, 2018-02-24)

Reported-by: Max Kirillov <max@max630.net>
Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

This will certainly conflict with patches 3 and 6 in my stress testing
patch series at

  https://public-inbox.org/git/20181230191629.3232-1-szeder.dev@gmail.com/T/#u


 t/test-lib.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0f1faa24b2..f47a191e3b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -324,9 +324,12 @@ do
 		# isn't executed with a suitable Bash version.
 		if test -z "$test_untraceable" || {
 		     test -n "$BASH_VERSION" && {
-		       test ${BASH_VERSINFO[0]} -gt 4 || {
-			 test ${BASH_VERSINFO[0]} -eq 4 &&
-			 test ${BASH_VERSINFO[1]} -ge 1
+		       bash_major=${BASH_VERSION%%.*}
+		       bash_minor=${BASH_VERSION#*.}
+		       bash_minor=${bash_minor%%.*}
+		       test $bash_major -gt 4 || {
+			 test $bash_major -eq 4 &&
+			 test $bash_minor -ge 1
 		       }
 		     }
 		   }
-- 
2.20.1.151.gec613c4b75

