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
	by dcvr.yhbt.net (Postfix) with ESMTP id E92AC1F576
	for <e@80x24.org>; Mon, 12 Feb 2018 08:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933024AbeBLIJN (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 03:09:13 -0500
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:46186
        "EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932997AbeBLIIz (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Feb 2018 03:08:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1518422934;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=ay7EzIH4lFeRjc3YWe8WXg/aUr0TA7kjocJhQlds9uQ=;
        b=b41dxjAYo7lj5+/qZxT6QD+1xz35RDfSwGuGRE1FnI3lh+QTvuvOM9/TJ2/8SsBU
        gL3tIXYfG3qzlqwm0/6dhcxY/ZEdR2zCpdBAbfCLjXxlksjTBXXNv2wQkdJ/ehduUzH
        ik+WIyS1bzt8LmwDB6eXe16plNnUgGZzqgrhyMgQ=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020161890f4370-4ae9a8d6-4f01-4f56-9fde-c40fd76d69b5-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
Subject: [PATCH v3 19/23] ref-filter: make populate_value() internal again
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 12 Feb 2018 08:08:54 +0000
X-SES-Outgoing: 2018.02.12-54.240.7.18
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
index eb53b0babdb83..8d104b567eb7c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1428,7 +1428,7 @@ static int check_and_fill_for_cat(struct ref_array_item *ref)
  * Parse the object referred by ref, and grab needed value.
  * Return 0 if everything was successful, -1 otherwise.
  */
-int populate_value(struct ref_array_item *ref)
+static int populate_value(struct ref_array_item *ref)
 {
 	void *buf;
 	struct object *obj;
diff --git a/ref-filter.h b/ref-filter.h
index 4eaf6d0514502..115d00288fdee 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -174,9 +174,6 @@ void setup_ref_filter_porcelain_msg(void);
 void pretty_print_ref(const char *name, const unsigned char *sha1,
 		      const struct ref_format *format);
 
-/* Fill the values of request and prepare all data for final string creation */
-int populate_value(struct ref_array_item *ref);
-
 /* Search for atom in given format. */
 int is_atom_used(const struct ref_format *format, const char *atom);
 

--
https://github.com/git/git/pull/452
