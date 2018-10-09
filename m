Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 784901F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 08:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbeJIPeH (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 11:34:07 -0400
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:40154
        "EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726160AbeJIPeH (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Oct 2018 11:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1539073101;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=X0D3Y1eknE20JZyhUnD46W0nvoJPB1irdUpRfSXNmjI=;
        b=DNyH3USA8PSqYiBcW0d2eV04aeV3Xt/5Rol3wGXDz9KtpMtVPuDlU05FZ6518XCC
        nLa2Vjy1pVT/Wr+tV/ruYz8IWHQljGPy7mudGXbS1N0dj+InGbNLDTcnKTietul3/o6
        hWTOehz1UMd5YffK041xNq8/o+BrC58BNvNTcYzk=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016657e7cfee-f1343b1e-9a85-4cae-990a-cc7177ea8487-000000@eu-west-1.amazonses.com>
In-Reply-To: <CAL21BmkdUiNgr4NqpwTdi9f47i85s8oXCZMmVx5VyNKotL78uA@mail.gmail.com>
References: <CAL21BmkdUiNgr4NqpwTdi9f47i85s8oXCZMmVx5VyNKotL78uA@mail.gmail.com>
Subject: [PATCH 1/3] ref-filter: free memory from used_atom
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 9 Oct 2018 08:18:21 +0000
X-SES-Outgoing: 2018.10.09-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Release memory from used_atom variable.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 ref-filter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ref-filter.c b/ref-filter.c
index e1bcb4ca8a197..1b71d08a43a84 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1996,6 +1996,9 @@ void ref_array_clear(struct ref_array *array)
 {
 	int i;
 
+	for (i = 0; i < used_atom_cnt; i++)
+		free((char *)used_atom[i].name);
+	free(used_atom);
 	for (i = 0; i < array->nr; i++)
 		free_array_item(array->items[i]);
 	FREE_AND_NULL(array->items);

--
https://github.com/git/git/pull/538
