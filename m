Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 689681FBB0
	for <e@80x24.org>; Mon, 28 Nov 2016 19:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753123AbcK1TCk (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 14:02:40 -0500
Received: from mail.nottheoilrig.com ([52.27.13.164]:49668 "EHLO
        mail.nottheoilrig.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbcK1TCi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 14:02:38 -0500
Received: from mail.nottheoilrig.com (localhost [127.0.0.1])
        by mail.nottheoilrig.com (Postfix) with ESMTP id 16A5320290
        for <git@vger.kernel.org>; Mon, 28 Nov 2016 18:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=nottheoilrig.com;
        s=3532ada; t=1480357577;
        bh=gLCVXzfIBeIoQl/JPJK5I40DdNmj6hW8drepRq46gJg=;
        h=From:To:Cc:Subject:Date:From;
        b=D0quJpeyq9yrn3Dy6KTEsJs9SDyHHDvr3QY+KP2WH6Rl10FrB48K3iSCXP/7h7sjw
         wTG9N/WHxf2xXE6xILV4rqv4JSacNeJv5oOBVfq+ZEuWMnchAF71hQdoI24CBDx3Xb
         l6j8/D6mbbea/+9f/Cv/Ec7Ph48e/TQYj2NhJZto=
Received: from debian (S0106c8fb26402908.ek.shawcable.net [24.66.132.201])
        by mail.nottheoilrig.com (Postfix) with ESMTPSA;
        Mon, 28 Nov 2016 18:26:16 +0000 (UTC)
Received: from nottheoilrig by debian with local (Exim 4.88)
        (envelope-from <nottheoilrig@debian>)
        id 1cBQd5-0003ky-ML; Mon, 28 Nov 2016 11:26:15 -0700
From:   Jack Bates <bk874k@nottheoilrig.com>
To:     git@vger.kernel.org
Cc:     Jack Bates <jack@nottheoilrig.com>
Subject: [PATCH] diff: handle --no-abbrev outside of repository
Date:   Mon, 28 Nov 2016 11:25:08 -0700
Message-Id: <20161128182508.10570-1-jack@nottheoilrig.com>
X-Mailer: git-send-email 2.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "git diff --no-index" codepath
doesn't handle the --no-abbrev option.

Signed-off-by: Jack Bates <jack@nottheoilrig.com>
---
 diff.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index ec87283..0447eff 100644
--- a/diff.c
+++ b/diff.c
@@ -3106,7 +3106,8 @@ static const char *diff_abbrev_oid(const struct object_id *oid, int abbrev)
 			abbrev = FALLBACK_DEFAULT_ABBREV;
 		if (abbrev > GIT_SHA1_HEXSZ)
 			die("BUG: oid abbreviation out of range: %d", abbrev);
-		hex[abbrev] = '\0';
+		if (abbrev)
+			hex[abbrev] = '\0';
 		return hex;
 	}
 }
@@ -4024,6 +4025,8 @@ int diff_opt_parse(struct diff_options *options,
 			    offending, optarg);
 		return argcount;
 	}
+	else if (!strcmp(arg, "--no-abbrev"))
+		options->abbrev = 0;
 	else if (!strcmp(arg, "--abbrev"))
 		options->abbrev = DEFAULT_ABBREV;
 	else if (skip_prefix(arg, "--abbrev=", &arg)) {
-- 
2.10.2
