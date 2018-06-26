Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED02D1F516
	for <e@80x24.org>; Tue, 26 Jun 2018 20:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934010AbeFZUy5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 16:54:57 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:51347 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933482AbeFZUyy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 16:54:54 -0400
Received: by mail-qt0-f201.google.com with SMTP id k8-v6so4868526qtj.18
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 13:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=wC4rTD4iOF1+fjTkPMOV0bq5OW3d9E1xtAc7ciKHXSU=;
        b=IqlZFMOURgqP5XyloxT//foCgVkYT0+m7fDIxl6QjmsyNivDmu2TGEVaGGSxQTOzBg
         c21TRUpJxH775hHWpTjQ+8kHleQCEIKJUu+GQShYCzw6BHjfDpWrxFPGuy3AL0WbXSfc
         rDymTOXJute024/GKrEbfoHaz8xtB7FIqr0XIzQSg9yas6/tDm0G0Da4jKrpSM9yIi2a
         ZpjOyKbZ3E+4ZkG5acO4qsX0/7ExJIo/pttkJ0cLgZIFbcu9rz2i0qX6HsUxlusgmVrV
         rNUT79fYxnHFsozRjOKgLzZEPE8Y3Frxg4PvDCjS7ya0jkWSBaoC1itnlv+s2L3qo8/6
         QIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=wC4rTD4iOF1+fjTkPMOV0bq5OW3d9E1xtAc7ciKHXSU=;
        b=sYT7mAI1xnyKHJvuokQrP7T3MI58oCET3W2cUOlLxe7W61/1rKgCVWkkMyZIIujiYz
         htmGFVjGWBRXm4xnAH7FHn9rONf/QkFM4ARZxvTMR8cg3lOdDOV1+jncbXNZ8oBhBgZ4
         /wlNpJcvyvmEcdERLgowjNsjmFJby0pP46y2Oj+Yj3pAl4VQHNvNJMr5pRv5lyEH6H8n
         TpPXtofisbHlWfqXINM2sD7rTt+6Sw+ougMo1Qvpjrug90MNYL3ZuW/irq6//FefRZj5
         wInEj7crH2xHCvLVl+gt1pdAqQUAWcL+ZvGiXRDUedzHWsmOOq2gUwsSDZZHFm9Pd2eU
         Op7Q==
X-Gm-Message-State: APt69E0SBGDUxo9wFD5Se98n1YjKGqVFdChmGEcfXGS/cmRiprdUxQqm
        iIWx2NMj+5KZUzM84x8n7Es2/rHi03fvNySFedP+FHMDXBFR0uPmsee3v/twNZrYTz+ANDrV3kD
        uFGnJsNaEci41Y73xFdxCrqqUPlA+6oALYpCAAV0rqPrticBU9XWbNCm56w==
X-Google-Smtp-Source: AAOMgpcwRhl4T7IHT9w/QkxKj89wTwUlI3UvjNrvFBGI8R0dLIbY76PvJSRpkl+3eyCUaE/hpzSDvICY1gg=
MIME-Version: 1.0
X-Received: by 2002:a0c:f751:: with SMTP id e17-v6mr1715374qvo.29.1530046493796;
 Tue, 26 Jun 2018 13:54:53 -0700 (PDT)
Date:   Tue, 26 Jun 2018 13:54:35 -0700
In-Reply-To: <20180626205438.110764-1-bmwill@google.com>
Message-Id: <20180626205438.110764-6-bmwill@google.com>
References: <20180625185332.164142-1-bmwill@google.com> <20180626205438.110764-1-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v5 5/8] fetch: refactor fetch_refs into two functions
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, gitster@pobox.com, sbeller@google.com,
        jrnieder@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the fetch_refs function into a function that does the fetching
of refs and another function that stores them.  This is in preparation
for allowing additional processing of the fetched refs before updating
the local ref store.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fetch.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 545635448..2fabfed0e 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -968,9 +968,21 @@ static int fetch_refs(struct transport *transport, struct ref *ref_map)
 	if (ret)
 		ret = transport_fetch_refs(transport, ref_map);
 	if (!ret)
-		ret |= store_updated_refs(transport->url,
-				transport->remote->name,
-				ref_map);
+		/*
+		 * Keep the new pack's ".keep" file around to allow the caller
+		 * time to update refs to reference the new objects.
+		 */
+		return 0;
+	transport_unlock_pack(transport);
+	return ret;
+}
+
+/* Update local refs based on the ref values fetched from a remote */
+static int consume_refs(struct transport *transport, struct ref *ref_map)
+{
+	int ret = store_updated_refs(transport->url,
+				     transport->remote->name,
+				     ref_map);
 	transport_unlock_pack(transport);
 	return ret;
 }
@@ -1116,7 +1128,8 @@ static void backfill_tags(struct transport *transport, struct ref *ref_map)
 	transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
 	transport_set_option(transport, TRANS_OPT_DEPTH, "0");
 	transport_set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, NULL);
-	fetch_refs(transport, ref_map);
+	if (!fetch_refs(transport, ref_map))
+		consume_refs(transport, ref_map);
 
 	if (gsecondary) {
 		transport_disconnect(gsecondary);
@@ -1165,7 +1178,7 @@ static int do_fetch(struct transport *transport,
 				   transport->url);
 		}
 	}
-	if (fetch_refs(transport, ref_map)) {
+	if (fetch_refs(transport, ref_map) || consume_refs(transport, ref_map)) {
 		free_refs(ref_map);
 		retcode = 1;
 		goto cleanup;
-- 
2.18.0.rc2.346.g013aa6912e-goog

