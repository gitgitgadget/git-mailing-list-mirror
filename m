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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D2C81F576
	for <e@80x24.org>; Mon,  5 Feb 2018 11:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752995AbeBEL2Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 06:28:25 -0500
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:44214
        "EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752854AbeBEL1k (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Feb 2018 06:27:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1517830059;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=GRsr2SoamNN45LjoWPUpIOmJ5lpzc/J1KxUOGY7r+Gs=;
        b=MLBhanSjFAFfXEWlFqjS+/KEUD8rr14GgNWvZyq5AgVeQ4mWRrSPcZn9vvsZaChG
        Z4ycT/SjJ30UmyQNYjxXKxpN4NIl/YRDRoUws379boCOkk9nqF9m1jzkU0juoc6IFRG
        yJEh97i18FyGlIjXHp3S+rNVvPnwIw8MPmYrYN5Y=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016165b8b45f-ef11e989-4095-4130-8708-9a335136a8e6-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016165b8b3c4-54efe4c4-6d19-435d-b5b9-6c727771353b-000000@eu-west-1.amazonses.com>
References: <0102016165b8b3c4-54efe4c4-6d19-435d-b5b9-6c727771353b-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC v2 20/25] ref-filter: make populate_value() internal
 again
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 5 Feb 2018 11:27:39 +0000
X-SES-Outgoing: 2018.02.05-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove populate_value() from header file. We needed that
for interim step, now it could be returned back.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 ref-filter.c | 2 +-
 ref-filter.h | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index e34580e8db508..70c685851466b 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1429,7 +1429,7 @@ static int check_and_fill_for_cat(struct ref_array_item *ref)
  * Parse the object referred by ref, and grab needed value.
  * Return 0 if everything was successful, -1 otherwise.
  */
-int populate_value(struct ref_array_item *ref)
+static int populate_value(struct ref_array_item *ref)
 {
 	void *buf;
 	struct object *obj;
diff --git a/ref-filter.h b/ref-filter.h
index 244a27bfc4e12..c0edb17aa404a 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -177,9 +177,6 @@ void setup_ref_filter_porcelain_msg(void);
 void pretty_print_ref(const char *name, const unsigned char *sha1,
 		      const struct ref_format *format);
 
-/* Fill the values of request and prepare all data for final string creation */
-int populate_value(struct ref_array_item *ref);
-
 /* Search for atom in given format. */
 int is_atom_used(const struct ref_format *format, const char *atom);
 

--
https://github.com/git/git/pull/452
