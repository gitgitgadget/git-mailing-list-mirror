Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 924F7201A7
	for <e@80x24.org>; Wed, 17 May 2017 12:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750795AbdEQMGJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 08:06:09 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:58669 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751300AbdEQMGG (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 May 2017 08:06:06 -0400
X-AuditID: 1207440f-719ff700000004e5-e1-591c3cacedb5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 9F.68.01253.CAC3C195; Wed, 17 May 2017 08:06:05 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B104B68.dip0.t-ipconnect.de [91.16.75.104])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4HC5pfu000430
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 17 May 2017 08:06:03 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 05/23] refs_ref_iterator_begin(): don't check prefixes redundantly
Date:   Wed, 17 May 2017 14:05:28 +0200
Message-Id: <c9e1d561825a63630a09a2815b9b296c9e4bd1f5.1495014840.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495014840.git.mhagger@alum.mit.edu>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsUixO6iqLvWRibSYP1dLou1z+4wWXRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj672I2we
        z3r3MHpcvKTs8XmTXAB7FJdNSmpOZllqkb5dAldGw+LlbAVP2SrOTGliaWDcw9rFyMkhIWAi
        sa7jMUsXIxeHkMAOJoltP54wQjgnmCR+9zYwg1SxCehKLOppZgKxRQTUJCa2HQLrYBZ4zCTx
        d1k3kMPBISwQJLHoISdIDYuAqsSmhefAenkFoiSOv1nKArFNXmJX20WwzZwCFhL33z9iB2kV
        EjCX2H69cgIjzwJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFuiZ6uZkleqkppZsYIYHGv4Ox
        a73MIUYBDkYlHt4JXNKRQqyJZcWVuYcYJTmYlER59z8ACvEl5adUZiQWZ8QXleakFh9ilOBg
        VhLhvWkqEynEm5JYWZValA+TkuZgURLnVV+i7ickkJ5YkpqdmlqQWgSTleHgUJLgnWIN1ChY
        lJqeWpGWmVOCkGbi4AQZzgM0nAukhre4IDG3ODMdIn+KUZdjzr2v75mEWPLy81KlxHkPgBQJ
        gBRllObBzYEliFeM4kBvCfOuBqniASYXuEmvgJYwAS1pBvmOt7gkESEl1cC4ZL6Sha6S6JbW
        OpZ9BsV62/fObfg+Jfj9nOr+4KC/txb5NZ06Mok75IzX1Z+JDKKyohkNOk1ret//jX4uekhP
        tme2TOcWXY91N1zcLompns3WzoxvDj76svpL2PkHQplTemsXntfoqd2hoOS5o+THu1dP5r/e
        IdfD79aZuGve4x+9P4xtw5SVWIozEg21mIuKEwHmWZBu6wIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The backend already takes care of the prefix. By passing the prefix
again to `prefix_ref_iterator`, we were forcing that iterator to do
redundant prefix comparisons. So set it to the empty string.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 26d40f9927..f4a485cd8a 100644
--- a/refs.c
+++ b/refs.c
@@ -1247,7 +1247,13 @@ struct ref_iterator *refs_ref_iterator_begin(
 	struct ref_iterator *iter;
 
 	iter = refs->be->iterator_begin(refs, prefix, flags);
-	iter = prefix_ref_iterator_begin(iter, prefix, trim);
+
+	/*
+	 * `iterator_begin()` already takes care of prefix, but we
+	 * might need to do some trimming:
+	 */
+	if (trim)
+		iter = prefix_ref_iterator_begin(iter, "", trim);
 
 	return iter;
 }
-- 
2.11.0

