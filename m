Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2583E1F406
	for <e@80x24.org>; Tue,  9 Jan 2018 13:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757063AbeAINF3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 08:05:29 -0500
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:49096
        "EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756981AbeAINFY (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Jan 2018 08:05:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1515503123;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=BOlndjYJIHr5aU940X2DIFRCxQTQhuMKgSR/kVcJIDU=;
        b=Hhk0csRlSbYe/xdfz6XOHHv3mIyOkhXBKuOe7XB+PAlHlSdu5H/NQKMautOVB0nf
        Pt5LW9RNedY0ejlK7MMroPPL8yAdp1Z+RIB2ZCsSnALdBJm92yH/yZCCPuoiKWKiZ8t
        peNmhp8vJwSsPlYemne8uEdzRo48yLzK1WDMpveI=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020160db067b07-5333ec0b-ce92-4f85-bceb-bbb9761793a9-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020160db0679c9-799a0bc4-b6d1-43e2-ad3b-80be4e4c55e9-000000@eu-west-1.amazonses.com>
References: <01020160db0679c9-799a0bc4-b6d1-43e2-ad3b-80be4e4c55e9-000000@eu-west-1.amazonses.com>
Subject: [PATCH 10/20] cat-file: simplify expand_atom function
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 9 Jan 2018 13:05:23 +0000
X-SES-Outgoing: 2018.01.09-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Not sure, but looks like there is no need in that checking.
There is a checking before whether it is null and we die in such case.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 9055fa3a8b0ae..dd43457c0ad7e 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -193,10 +193,9 @@ static void expand_atom(struct strbuf *sb, const char *atom, int len,
 		strbuf_addf(sb, "%lu", data->size);
 	else if (is_atom("objectsize:disk", atom, len))
 		strbuf_addf(sb, "%"PRIuMAX, (uintmax_t)data->disk_size);
-	else if (is_atom("rest", atom, len)) {
-		if (data->rest)
-			strbuf_addstr(sb, data->rest);
-	} else if (is_atom("deltabase", atom, len))
+	else if (is_atom("rest", atom, len))
+		strbuf_addstr(sb, data->rest);
+	else if (is_atom("deltabase", atom, len))
 		strbuf_addstr(sb, oid_to_hex(&data->delta_base_oid));
 	else
 		die("unknown format element: %.*s", len, atom);

--
https://github.com/git/git/pull/450
