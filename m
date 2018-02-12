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
	by dcvr.yhbt.net (Postfix) with ESMTP id AC1391F576
	for <e@80x24.org>; Mon, 12 Feb 2018 08:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933033AbeBLIJn (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 03:09:43 -0500
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:41340
        "EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932989AbeBLIIz (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Feb 2018 03:08:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1518422934;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=OaXeNXVIEpibWX7yqIr2f8Qdirmo2OpM+YJ2fWXywhE=;
        b=h+wzZVw6zm9XIVS48p0+DRmBRIxxvA01sNzSNPpwd2w9yRb+OJKcglajLXqYd1qw
        gl+ydcsXjvsuH17NyzRsqZyx/cGV2L7glS5c5xLnEtm1L/mqhIqptX6dYNZ2RcLQe54
        IypgzRxCKPraCGBLFUe+8yHnnAqq7BO0BBW3AwTo=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020161890f4356-2cfaddc9-cd7d-4bd7-9da4-df08783ed06b-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
Subject: [PATCH v3 10/23] ref-filter: make populate_value() global
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 12 Feb 2018 08:08:54 +0000
X-SES-Outgoing: 2018.02.12-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make function global for further using in cat-file.
In the end of patch series this function becomes internal again,
so this is a part of middle step. cat-file would use more general
functions further.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 ref-filter.c | 2 +-
 ref-filter.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index 5c75259b1ab8c..4acd391b5dfac 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1407,7 +1407,7 @@ static const char *get_refname(struct used_atom *atom, struct ref_array_item *re
  * Parse the object referred by ref, and grab needed value.
  * Return 0 if everything was successful, -1 otherwise.
  */
-static int populate_value(struct ref_array_item *ref)
+int populate_value(struct ref_array_item *ref)
 {
 	void *buf;
 	struct object *obj;
diff --git a/ref-filter.h b/ref-filter.h
index 781921d4e0978..e16ea2a990119 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -182,4 +182,7 @@ void setup_ref_filter_porcelain_msg(void);
 void pretty_print_ref(const char *name, const unsigned char *sha1,
 		      const struct ref_format *format);
 
+/* Fill the values of request and prepare all data for final string creation */
+int populate_value(struct ref_array_item *ref);
+
 #endif /*  REF_FILTER_H  */

--
https://github.com/git/git/pull/452
