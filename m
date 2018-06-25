Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7060C1F597
	for <e@80x24.org>; Mon, 25 Jun 2018 18:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965041AbeFYSxu (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 14:53:50 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:39215 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965029AbeFYSxt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 14:53:49 -0400
Received: by mail-qt0-f202.google.com with SMTP id c1-v6so13826671qtj.6
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 11:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=wC4rTD4iOF1+fjTkPMOV0bq5OW3d9E1xtAc7ciKHXSU=;
        b=mkYofm3nQgyTKmURY7EDd7lGh8Go6NHtp+qS9gIHFCpgo5LuLhR0Ztepd5qye2sHmb
         MavQfp1ZUZ435/O/sEfAQInH4ZRZbG1f8APHCiQAPd4Kb/ozdzcpRne1W3PEOoSilW9B
         OD2Jo8bUb7N0NUrI5sBGqT+VDVz0NF17z4b3Pkr1k09WuN6O+0SXR2YGLSsbenb0DtQd
         792jyD6kqmNpyxgdL20FQeZPoTNVbWOPwhRZ7pBrJ9OoB/ua28JzOgjAZqUDC+Yavn7F
         8dg+gbsempEbt16VR02PvLOlqbjUOUuqMiwHKZJPxsbeGw1vQsEHffJGb+YfmldV/r7Q
         MEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=wC4rTD4iOF1+fjTkPMOV0bq5OW3d9E1xtAc7ciKHXSU=;
        b=GVRCuDogJm6oDUJdC/tdQWVKgAZ8Jc1yilbY+aQU0w/KfyMlscz9FeRJts9sODs1Iz
         6jVLYL1UztO+c8+/oDhoOQqB3lHuTQvYdfZY53w4Su7QETDeX9GpSS/Bm8yUjig3XuTH
         FyK7jtXYskrYBp+X4jC70wO5ypsMLD0LKqm7qZFoEvwn0suEDSakfA72p2Chm43Eaxni
         odtsHoZlBgj+O8U3Dc4EXbPE/EEzssdZWDnUgTQkKECUqNWW9YEdWw6AdIvbxEtjadTw
         47o9OC7capeGGZuA83GGbmkrxTGRee8ThpacMg/6LdKw/yRmwJWkDluJkvVY3Gk+o0DW
         SZag==
X-Gm-Message-State: APt69E16M2ugtjO0GqEJTM+ag4usxtSSwF9JsTziaNZH+CtsKH1w6BiF
        Gtf7Joj2eFM5eIIE5FDfEs7ofJtmGBLlLavAYlDZc/Pr6JNI8KIXesyyR9ERQfDSJmraCPLOqEa
        3dIWbJtpSFddxsrhhnD8YF/pcZgUcgODyf7fEcq2TFw9NYArjq39AuNKDkA==
X-Google-Smtp-Source: ADUXVKLEMBSqDUXAZZRbnDGynP2RmxC/BlxSL+4ihd87h69RWhHA3X/DkiRMU1iOdYRWIprzzDD6vvOocRA=
MIME-Version: 1.0
X-Received: by 2002:ac8:44d3:: with SMTP id b19-v6mr7827099qto.51.1529952828434;
 Mon, 25 Jun 2018 11:53:48 -0700 (PDT)
Date:   Mon, 25 Jun 2018 11:53:29 -0700
In-Reply-To: <20180625185332.164142-1-bmwill@google.com>
Message-Id: <20180625185332.164142-6-bmwill@google.com>
References: <20180620213235.10952-1-bmwill@google.com> <20180625185332.164142-1-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v4 5/8] fetch: refactor fetch_refs into two functions
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

