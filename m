Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8E0D20445
	for <e@80x24.org>; Thu, 12 Oct 2017 23:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753116AbdJLXd1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 19:33:27 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:50438 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752243AbdJLXd1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 19:33:27 -0400
Received: by mail-pf0-f175.google.com with SMTP id m63so7148438pfk.7
        for <git@vger.kernel.org>; Thu, 12 Oct 2017 16:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fyv/MJ0Am6yBiODeAuJCRS3v8GlVibs+O3/S3y/M2CE=;
        b=gWdd3OHF67Nz53IcV8/CcOuWefciT6qlF4jbkmphM19wlv80gzV++8HEvbcPqWcCz0
         lSvd4ruO+Ms3VDXE0vFTC64/LGVPefjWCnEnihf+3H8DAmS/PwB61kXZw/13hPww0iwn
         tCD5Q8lVdN+vRlnpTSg20XNtHuenE0sDCm/vRAJr0V1jImiV2NOLpIUZ6mADa1w86XUK
         CFxGzk4PmzkSeyuEKx2ieyKrUsNwGAFojeUeuEoA+0uwDbvkhALhLUpCfPG4J/mHTm8r
         ZmUz4nTELkonzuCcLbTGQ2Fx4wzrOHa94tdMssGZACZi5FSF3f6kZd+NrqAWlhW1H9EI
         L47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fyv/MJ0Am6yBiODeAuJCRS3v8GlVibs+O3/S3y/M2CE=;
        b=E9my5IBtR9xqRHzHg983n77rlVJvwISqJzznMSkClr+brGWIXx2pBQj3erUMt6zt0s
         2a3hUa3wfFj/sttOHbIoZVLSQ6LHimkb+noRaQrQAaOX++IgQK26583ic5vo9UTkBJlf
         A03/6ErbWUrjPCJ8yFx2lmOWyNTjbiP/6GBRPbj+EirlqIdBarq9bShn7xOe24PTn5XY
         iNUVaL/FqqYrNe18S+1cOk+wEKSJwZto7YT1PX0wJMJheuIQHIAbi3nfhW/ONDR74AZG
         259WjmFmk0wLBvy56G5h359ai827OhoUdcVLgDAMce88f4AfZIRQiub4C6jHKVfODDGb
         sKyQ==
X-Gm-Message-State: AMCzsaUR/8tyKQq1MLeGFYmjm94l1UZ+jNYPfygAewHfBQ2w4sHsQNUv
        ACHszEtt+k+vLxghAQiPNLLNvg==
X-Google-Smtp-Source: AOwi7QAIsSIgE1BZBNsg5gsHR8Bm/RqCVW+7pYAM24wGMHiXmr//Vt8zxBhTDx30JSEqYIDcdzaIIA==
X-Received: by 10.84.217.206 with SMTP id d14mr1500029plj.196.1507851206497;
        Thu, 12 Oct 2017 16:33:26 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:9cc2:8741:42ae:ff22])
        by smtp.gmail.com with ESMTPSA id s86sm32726444pfi.74.2017.10.12.16.33.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 12 Oct 2017 16:33:25 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     peff@peff.net
Cc:     git@vger.kernel.org, orgads@gmail.com, sbeller@google.com
Subject: [PATCH] diff.c: increment buffer pointer in all code path
Date:   Thu, 12 Oct 2017 16:33:22 -0700
Message-Id: <20171012233322.31203-1-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
In-Reply-To: <20171012200536.m6oz4zrjcze3yw4i@sigill.intra.peff.net>
References: <20171012200536.m6oz4zrjcze3yw4i@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The added test would hang up Git due to an infinite loop. The function
`next_byte()` doesn't make any forward progress in the buffer with
`--ignore-space-change`.

Fix this by only returning early when there was actual white space
to be covered, fall back to the default case at the end of the function
when there is no white space.

Reported-by: Orgad Shaneh <orgads@gmail.com>
Debugged-by: Jeff King <peff@peff.net>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

Peff, feel free to take ownership here. I merely made it to a patch.

Thanks,
Stefan

 diff.c                     | 12 ++++++++----
 t/t4015-diff-whitespace.sh |  8 ++++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 69f03570ad..6fe84e6994 100644
--- a/diff.c
+++ b/diff.c
@@ -713,13 +713,17 @@ static int next_byte(const char **cp, const char **endp,
 		return -1;
 
 	if (DIFF_XDL_TST(diffopt, IGNORE_WHITESPACE_CHANGE)) {
-		while (*cp < *endp && isspace(**cp))
+		int saw_whitespace = 0;
+		while (*cp < *endp && isspace(**cp)) {
 			(*cp)++;
+			saw_whitespace = 1;
+		}
 		/*
-		 * After skipping a couple of whitespaces, we still have to
-		 * account for one space.
+		 * After skipping a couple of whitespaces,
+		 * we still have to account for one space.
 		 */
-		return (int)' ';
+		if (saw_whitespace)
+			return (int)' ';
 	}
 
 	if (DIFF_XDL_TST(diffopt, IGNORE_WHITESPACE)) {
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index bd0f75d9f7..c088ae86af 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1530,4 +1530,12 @@ test_expect_success 'move detection with submodules' '
 	test_cmp expect decoded_actual
 '
 
+test_expect_success 'move detection with whitespace changes' '
+	test_seq 10 > test &&
+	git add test &&
+	sed -i "s/3/42/" test &&
+	git -c diff.colormoved diff --ignore-space-change -- test &&
+	git reset --hard
+'
+
 test_done
-- 
2.14.0.rc0.3.g6c2e499285

