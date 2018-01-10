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
	by dcvr.yhbt.net (Postfix) with ESMTP id CE2A51FADF
	for <e@80x24.org>; Wed, 10 Jan 2018 09:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965407AbeAJJhz (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 04:37:55 -0500
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:56996
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755673AbeAJJgm (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 10 Jan 2018 04:36:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1515577001;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=BOlndjYJIHr5aU940X2DIFRCxQTQhuMKgSR/kVcJIDU=;
        b=dxbMGqtOhgF8tm3+MdrWgCZvTyN7VN8cNAN9KmkHQSTwO7OVnW9eELCdVHzwjC+R
        dQNtlz7zkm0Se8X0CM83bA6Z8dqS/L6CcT5oDpKA0GYzUawQOx7s/jJPZECFfdl1Dga
        fa5UUKv7Ko1QjqgNVUZYGlfcPD7S0ksshuFZ2sVA=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020160df6dc56f-955e97ff-4dc8-4471-8fb6-32dc9572781e-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
References: <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2 09/18] cat-file: simplify expand_atom function
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Wed, 10 Jan 2018 09:36:41 +0000
X-SES-Outgoing: 2018.01.10-54.240.7.20
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
