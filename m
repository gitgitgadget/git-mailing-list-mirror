Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB8F61F576
	for <e@80x24.org>; Wed, 24 Jan 2018 11:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933342AbeAXLOg (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 06:14:36 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:49012 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933170AbeAXLO1 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 24 Jan 2018 06:14:27 -0500
X-AuditID: 1207440f-ab7ff70000000ab0-19-5a686a91007a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 5F.D9.02736.19A686A5; Wed, 24 Jan 2018 06:14:26 -0500 (EST)
Received: from bagpipes.fritz.box (p54AAE3E5.dip0.t-ipconnect.de [84.170.227.229])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id w0OBEIi6004669
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Jan 2018 06:14:23 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kim Gybels <kgybels@infogroep.be>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/6] create_snapshot(): use `xmemdupz()` rather than a strbuf
Date:   Wed, 24 Jan 2018 12:14:12 +0100
Message-Id: <612a0b909d1f73bb706e9c44a6e1d737f3a2bf95.1516791909.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <cea5e366-dc95-6f41-6373-f8bbef103561@alum.mit.edu>
References: <cea5e366-dc95-6f41-6373-f8bbef103561@alum.mit.edu>
In-Reply-To: <cover.1516791909.git.mhagger@alum.mit.edu>
References: <cover.1516791909.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsUixO6iqDspKyPK4OBrKYuuK91MFg29V5gt
        +pd3sVkc7JzJanF7xXxmix8tPcwObB5/339g8vjwMc6j78gaRo9nvXsYPS5eUvb4vEkugC2K
        yyYlNSezLLVI3y6BK2Pe3t+MBbe4KxZc287awLiVs4uRk0NCwERiyfzzbF2MXBxCAjuYJBb+
        /ssK4Vxikmi5v4AZpIpNQFdiUU8zE4gtIqAmMbHtEAtIEbPAaUaJXfuXsYAkhAV8JbbdPwnW
        wCKgKtFwspu9i5GDg1cgSuLxTgeIbfIS7xfcZwSxOQUcJLp3XGIDsYUE7CW6rx1iBinnFLCQ
        uLxIC8QUEjCXuPOPZwIj3wJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFuiZ6uZkleqkppZsY
        IYHHv4Oxa73MIUYBDkYlHt4bFulRQqyJZcWVuYcYJTmYlER584MyooT4kvJTKjMSizPii0pz
        UosPMUpwMCuJ8OaxApXzpiRWVqUW5cOkpDlYlMR51Zeo+wkJpCeWpGanphakFsFkZTg4lCR4
        z2YCDRUsSk1PrUjLzClBSDNxcIIM5wEafgekhre4IDG3ODMdIn+KUZfjxovXbcxCLHn5ealS
        4rwVIEUCIEUZpXlwc2AJ4xWjONBbwryLQap4gMkGbtIroCVMQEtu1KSCLClJREhJNTBq1bV9
        SNrF8PvQmfj7C08o7tRUWL97dy1z/9VEp28vrlVJJAUeaBF4O+movnPCw5kn/mvJdckq+Qt+
        f/P0d/LcxX632ePmc3RHeioemVPTfkOSVeP+OzXvuZKWN5Z5nL326uG9pSdsckwExAsCGiJu
        8Yce9H9dZnd5UvHRP4J5X78e80vjNwxWYinOSDTUYi4qTgQAtMElLvMCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's lighter weight.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index b872267f02..08698de6ea 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -620,8 +620,7 @@ static struct snapshot *create_snapshot(struct packed_ref_store *refs)
 
 	/* If the file has a header line, process it: */
 	if (snapshot->buf < snapshot->eof && *snapshot->buf == '#') {
-		struct strbuf tmp = STRBUF_INIT;
-		char *p, *eol;
+		char *tmp, *p, *eol;
 		struct string_list traits = STRING_LIST_INIT_NODUP;
 
 		eol = memchr(snapshot->buf, '\n',
@@ -631,9 +630,9 @@ static struct snapshot *create_snapshot(struct packed_ref_store *refs)
 					      snapshot->buf,
 					      snapshot->eof - snapshot->buf);
 
-		strbuf_add(&tmp, snapshot->buf, eol - snapshot->buf);
+		tmp = xmemdupz(snapshot->buf, eol - snapshot->buf);
 
-		if (!skip_prefix(tmp.buf, "# pack-refs with:", (const char **)&p))
+		if (!skip_prefix(tmp, "# pack-refs with:", (const char **)&p))
 			die_invalid_line(refs->path,
 					 snapshot->buf,
 					 snapshot->eof - snapshot->buf);
@@ -653,7 +652,7 @@ static struct snapshot *create_snapshot(struct packed_ref_store *refs)
 		snapshot->start = eol + 1;
 
 		string_list_clear(&traits, 0);
-		strbuf_release(&tmp);
+		free(tmp);
 	}
 
 	verify_buffer_safe(snapshot);
-- 
2.14.2

