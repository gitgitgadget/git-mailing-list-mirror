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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D5511F576
	for <e@80x24.org>; Mon,  5 Feb 2018 11:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752941AbeBEL2B (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 06:28:01 -0500
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:59192
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752767AbeBEL1k (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Feb 2018 06:27:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1517830059;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=9rz2i2o28qkXtA1/WuDh/ExtC4FlQvrgsw1bHWoYkqo=;
        b=WSj63gGhAnCujYxmKhkIjU5ey5xwty/8KYjDMxVN2VbEhuHFvaP8ohjmDdIUSoJE
        KoX84RgpKvX3e/YA8fxQ1o9YojBH4IJGRdGJYvpq/t86pClsZKPqBuC6Z7g1ePF0mZK
        SnwuLOF02G5g2hMbroQZd0ghc51CDxWVv7zDT5fk=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016165b8b3c4-54efe4c4-6d19-435d-b5b9-6c727771353b-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
References: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC v2 01/25] ref-filter: get rid of goto
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 5 Feb 2018 11:27:38 +0000
X-SES-Outgoing: 2018.02.05-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Get rid of goto command in ref-filter for better readability.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 ref-filter.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index f9e25aea7a97e..d04295e33448e 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1477,12 +1477,13 @@ static void populate_value(struct ref_array_item *ref)
 
 	for (i = 0; i < used_atom_cnt; i++) {
 		struct atom_value *v = &ref->value[i];
-		if (v->s == NULL)
-			goto need_obj;
+		if (v->s == NULL) {
+			break;
+		}
 	}
-	return;
+	if (used_atom_cnt <= i)
+		return;
 
- need_obj:
 	buf = get_obj(&ref->objectname, &obj, &size, &eaten);
 	if (!buf)
 		die(_("missing object %s for %s"),

--
https://github.com/git/git/pull/452
