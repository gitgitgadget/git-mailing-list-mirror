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
	by dcvr.yhbt.net (Postfix) with ESMTP id 491B31F406
	for <e@80x24.org>; Tue,  9 Jan 2018 13:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757148AbeAINFu (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 08:05:50 -0500
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:43902
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757022AbeAINFZ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Jan 2018 08:05:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1515503123;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=SuM8j0IPZvSbFB7Kwjk8/mKUEX6RKsbew2SgohiPTs8=;
        b=QTOc1lZKnCQw/SpUxE26B3CL/iNFr0R/X/wS8OZys0zUbH/5rF4tWkG8iP7+dGiy
        z1ubBsiwsdNIPbswfOk2VH9DSLuCpspKPSlqy1JKAL0JGQlct737d0raIUfhW4mt1YZ
        9w/+VNrlfeg1PDXIXWMc97hWT3hKfBeFUOuy2qII=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020160db067bda-4be1f1f1-22c8-45bf-983d-053ae428cb2d-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020160db0679c9-799a0bc4-b6d1-43e2-ad3b-80be4e4c55e9-000000@eu-west-1.amazonses.com>
References: <01020160db0679c9-799a0bc4-b6d1-43e2-ad3b-80be4e4c55e9-000000@eu-west-1.amazonses.com>
Subject: [PATCH 14/20] cat-file: make populate_value global
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 9 Jan 2018 13:05:23 +0000
X-SES-Outgoing: 2018.01.09-54.240.7.19
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
index 56d2687e07df9..ed1b78943b8b4 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1456,7 +1456,7 @@ static void need_object(struct ref_array_item *ref) {
 /*
  * Parse the object referred by ref, and grab needed value.
  */
-static void populate_value(struct ref_array_item *ref)
+int populate_value(struct ref_array_item *ref)
 {
 	int i;
 
@@ -1577,7 +1577,7 @@ static void populate_value(struct ref_array_item *ref)
 			break;
 		}
 	}
-	return;
+	return 0;
 }
 
 /*
diff --git a/ref-filter.h b/ref-filter.h
index 28774e8e0f771..d541749f9b1dc 100644
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
