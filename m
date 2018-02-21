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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D0E11F576
	for <e@80x24.org>; Wed, 21 Feb 2018 06:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751245AbeBUG7C (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 01:59:02 -0500
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:49762
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750740AbeBUG7C (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 21 Feb 2018 01:59:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1519196341;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=HhFVhuopFzXer1gKMHG2Fw61p6MkRRZGGUFGu3zNksA=;
        b=ETOubrQuUqwMboedsUidkOq9c6D6XYtIcedRMmMn4u7ZdJ211E7eCvfmwegGfT8J
        bCL/rOGICQsqKuVrN+NOkyBF8jBeloOQ2IZOyhSE73H6HAMarZJ7ewjJ2hfcNaSCIss
        smi6+h5NQTV3PlqfCOSdljd0GC2LC3bFYP5PFrSA=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020161b7288324-d478f224-7a37-4341-993f-3c82a9941b7f-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020161b728823f-daec904e-44ff-45f9-9c89-d447b89c7802-000000@eu-west-1.amazonses.com>
References: <01020161b728823f-daec904e-44ff-45f9-9c89-d447b89c7802-000000@eu-west-1.amazonses.com>
Subject: [PATCH 2/2] ref-filter: get rid of goto
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Wed, 21 Feb 2018 06:59:01 +0000
X-SES-Outgoing: 2018.02.21-54.240.7.11
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
 ref-filter.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 83ffd84affe52..28df6e21fb996 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1494,11 +1494,11 @@ static void populate_value(struct ref_array_item *ref)
 	for (i = 0; i < used_atom_cnt; i++) {
 		struct atom_value *v = &ref->value[i];
 		if (v->s == NULL)
-			goto need_obj;
+			break;
 	}
-	return;
+	if (used_atom_cnt <= i)
+		return;
 
- need_obj:
 	get_object(ref, &ref->objectname, 0, &obj);
 
 	/*

--
https://github.com/git/git/pull/460
