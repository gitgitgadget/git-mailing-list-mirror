Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D1221F51C
	for <e@80x24.org>; Thu, 24 May 2018 06:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755050AbeEXG1t (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 02:27:49 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:38732 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754847AbeEXG1s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 02:27:48 -0400
Received: by mail-ot0-f193.google.com with SMTP id n3-v6so605653ota.5
        for <git@vger.kernel.org>; Wed, 23 May 2018 23:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=igaDHmdSsnbNvzMGAXArQuKgo04PLeho+DlllvZC/fs=;
        b=LHwTHYwosw/huEn1rbsMDLwivHt33EsXIUzS0fSjn38o7+mSlvZxhx+SYdEqyPV8x5
         n2oUzlUQGBGiobAei2sIsZMKOuKX71stXBQGkvpTfaz4Fe0sfgBshZdsLfnBIXVL2pAt
         9pZImpbwdK/bVXqrxiuZweOoUgab7l4d2SYOai+3NymbFORp9xwoPaiOyKbmWlv9BLxP
         Y2+ShrgsRThiw5elncUDf2vwYWoStWP8FP15JR39tzxdvNL/Qbo8CwaAAeKFeivXmci2
         cuEphPoRolzAn86G1/h7uSpOP2DDTwZkFyOjSrlt5WmBeV8DpqSbG+/3S0iNwL3MgAUi
         njSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=igaDHmdSsnbNvzMGAXArQuKgo04PLeho+DlllvZC/fs=;
        b=jXYJDn27ViH1jZMlw8KHxfMlPFsjyVX40JKhBjV6OauaIdRLfxjBsF5vG8Aknjwt7S
         y33IX2DTFENOi/aS2BAKQpiMy95UEprDh/VoAUXs8tLoGKpNX2my/S/abSHjkfSI/cZd
         +zDpQj6L8FXSGTR0EBAiN+3REPt5oNoaGuEzlEf/Sxwz3oHzoa7uNsd0iqMQHsB1eD/I
         FL6ltmkhECnB9YoC5BOlsvkF0vZTetl5qkbCE//1lburRrYLOKCIRbU/tMfILFRJfj+U
         91uFsKNZjyo0Q9leiFoh3ztfjECl3dDG6KWJrqK+MOap6anSdsGb7OioYgIspUGDfbrB
         TdEw==
X-Gm-Message-State: ALKqPwdMXmCrpJ3snsZzYhvXm4zqv9yZMzAmmwZhDzchvQtLcIv5yl5q
        j0c+eA0SqFQ2DcZYeSvkSbMo8g==
X-Google-Smtp-Source: AB8JxZqe/HKRM2Hh23qLIVTaMFW31GOlyELc0NTjh3QrtaZ8i2RjLiJsAFC/+uOhDqdikw6XI/CX6g==
X-Received: by 2002:a9d:462:: with SMTP id 89-v6mr3547656otc.54.1527143267809;
        Wed, 23 May 2018 23:27:47 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id s9-v6sm11109405otb.41.2018.05.23.23.27.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 May 2018 23:27:47 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, B.Steinbrink@gmx.de,
        sbejar@gmail.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH v2] rev-parse: check lookup'ed commit references for NULL
Date:   Wed, 23 May 2018 23:27:33 -0700
Message-Id: <20180524062733.5412-1-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.1.gda85003413
In-Reply-To: <20180523220915.GB32171@sigill.intra.peff.net>
References: <20180523220915.GB32171@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commits 2122f8b963d4 ("rev-parse: Add support for the ^! and ^@ syntax",
2008-07-26) and 3dd4e7320d ("Teach rev-parse the ... syntax.", 2006-07-04)
taught rev-parse new syntax, and used lookup_commit_reference() as part of
their logic.  Neither usage checked the returned commit to see if it was
non-NULL before using it.  Check for NULL and ensure an appropriate error
is reported to the user.

Reported by Florian Weimer and Todd Zullinger.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Elijah Newren <newren@gmail.com>
---

I would have used a Reported-by tag for Florian and Todd, but looking at
the bugzilla.redhat.com bug report doesn't show me Florian's email
address.  I grepped through git logs and found two associated with that
name, but didn't know if they were still accurate, or were a different
Florian.  So I just went with the sentence instead.

 builtin/rev-parse.c          | 8 ++++++--
 t/t6101-rev-parse-parents.sh | 8 ++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index a1e680b5e9..a0a0ace38d 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -282,6 +282,10 @@ static int try_difference(const char *arg)
 			struct commit *a, *b;
 			a = lookup_commit_reference(&start_oid);
 			b = lookup_commit_reference(&end_oid);
+			if (!a || !b) {
+				*dotdot = '.';
+				return 0;
+			}
 			exclude = get_merge_bases(a, b);
 			while (exclude) {
 				struct commit *commit = pop_commit(&exclude);
@@ -328,12 +332,12 @@ static int try_parent_shorthands(const char *arg)
 		return 0;
 
 	*dotdot = 0;
-	if (get_oid_committish(arg, &oid)) {
+	if (get_oid_committish(arg, &oid) ||
+	    !(commit = lookup_commit_reference(&oid))) {
 		*dotdot = '^';
 		return 0;
 	}
 
-	commit = lookup_commit_reference(&oid);
 	if (exclude_parent &&
 	    exclude_parent > commit_list_count(commit->parents)) {
 		*dotdot = '^';
diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.sh
index 8c617981a3..7683e4a114 100755
--- a/t/t6101-rev-parse-parents.sh
+++ b/t/t6101-rev-parse-parents.sh
@@ -214,4 +214,12 @@ test_expect_success 'rev-list merge^-1x (garbage after ^-1)' '
 	test_must_fail git rev-list merge^-1x
 '
 
+test_expect_success 'rev-parse $garbage^@ does not segfault' '
+	test_must_fail git rev-parse $EMPTY_TREE^@
+'
+
+test_expect_success 'rev-parse $garbage...$garbage does not segfault' '
+	test_must_fail git rev-parse $EMPTY_TREE...$EMPTY_BLOB
+'
+
 test_done
-- 
2.17.0.1.gda85003413

