Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CA0C1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 08:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbeGQIyY (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 04:54:24 -0400
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:50800
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728102AbeGQIyY (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 17 Jul 2018 04:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1531815777;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=AIsRwshyOEDxZ4vojXIR6BMDINLofHPV8+FQUQkf9Cs=;
        b=jJeJGPXFniE307IxjxhvSXu/cxcwAYOclqdMtEir0WaUOZJLYW5VqOxmsIIdfcxg
        25+Bl/cufN/xe0ICZOV+UjQ0x7crKFsjX2P7ewZVyAf79eRyxC1/zcv/XpY5Sb6FLfb
        lpYML0sSRu63VqF0ExCEFcgyZ0z1alLWdVRd+oqU=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020164a755d3de-ac85c59f-6a13-4601-b529-9957d9e8b05f-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020164a755d376-b1b86aec-5d26-4d6c-8f8f-2adbb6a8ed65-000000@eu-west-1.amazonses.com>
References: <01020164a755d376-b1b86aec-5d26-4d6c-8f8f-2adbb6a8ed65-000000@eu-west-1.amazonses.com>
Subject: [PATCH v3 3/5] ref-filter: initialize eaten variable
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 17 Jul 2018 08:22:57 +0000
X-SES-Outgoing: 2018.07.17-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Initialize variable `eaten` before its using. We may initialize it in
parse_object_buffer(), but there are cases when we do not reach this
invocation.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 ref-filter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index 27733ef013bed..8db7ca95b12c0 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1439,7 +1439,8 @@ static const char *get_refname(struct used_atom *atom, struct ref_array_item *re
 static int get_object(struct ref_array_item *ref, const struct object_id *oid,
 		       int deref, struct object **obj, struct strbuf *err)
 {
-	int eaten;
+	/* parse_object_buffer() will set eaten to 0 if free() will be needed */
+	int eaten = 1;
 	int ret = 0;
 	unsigned long size;
 	void *buf = get_obj(oid, obj, &size, &eaten);

--
https://github.com/git/git/pull/520
