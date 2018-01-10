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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DF6D1FADF
	for <e@80x24.org>; Wed, 10 Jan 2018 09:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964997AbeAJJip (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 04:38:45 -0500
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:56992
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755599AbeAJJgm (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 10 Jan 2018 04:36:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1515577001;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=8VNw5TJYr20nXHkBTHEB/C4L8EYIm/aEzynrdAV0iCI=;
        b=kDZ3tMBqgYfzhBc9qln4twENGo6m5crOlzfJqbAHkbZClPFS4iWAvqFGAwY3+07Q
        XjdagQjaP3tD8NQzddaGGkzpvG7n2elMT5mf1iGIyr/+XluI0SCTCyT8I6t7pqGCiCO
        iMnRQY3fYlwG/vFX/qw6441KGk49iM4j+9Xje+7U=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020160df6dc587-aae8f2f1-48a8-4fdd-9917-0e5f4e62cf03-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
References: <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2 12/18] ref-filter: make populate_value global
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

Make function global for further using in cat-file.
Also added return value for handling errors.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 ref-filter.c | 4 ++--
 ref-filter.h | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 575c5351d0f79..c15906cb091c7 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1454,7 +1454,7 @@ static void need_object(struct ref_array_item *ref) {
 /*
  * Parse the object referred by ref, and grab needed value.
  */
-static void populate_value(struct ref_array_item *ref)
+int populate_value(struct ref_array_item *ref)
 {
 	int i;
 
@@ -1575,7 +1575,7 @@ static void populate_value(struct ref_array_item *ref)
 			break;
 		}
 	}
-	return;
+	return 0;
 }
 
 /*
diff --git a/ref-filter.h b/ref-filter.h
index 9bd36243481b4..6df45c5bd9dcb 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -176,4 +176,7 @@ void setup_ref_filter_porcelain_msg(void);
 void pretty_print_ref(const char *name, const unsigned char *sha1,
 		      const struct ref_format *format);
 
+/* Fill the values of request and prepare all data for final string creation */
+int populate_value(struct ref_array_item *ref);
+
 #endif /*  REF_FILTER_H  */

--
https://github.com/git/git/pull/450
