Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1674F1F516
	for <e@80x24.org>; Wed, 27 Jun 2018 22:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966487AbeF0Wan (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 18:30:43 -0400
Received: from mail-yb0-f201.google.com ([209.85.213.201]:46743 "EHLO
        mail-yb0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966474AbeF0Waj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 18:30:39 -0400
Received: by mail-yb0-f201.google.com with SMTP id i11-v6so2876222ybk.13
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 15:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=fP1eCApgwHA9tl/oZPR5dSzXBc7WfLP3SX3VyHzYjCE=;
        b=PbESt9wCjZRoJlT4iwemxVhB+1llB3w2stZKlt+CGOshTLKtoREhFIWF1v0zjia4CW
         Dz+CImXMOxa2PW6FjvUTeJJXHDkwFZBNyCcElKN2+jSFIKSdQ/qJVs0fWjdE7XETi5g/
         QxswCAuRcHBWXfAoM8c/xmtMd3tbkjM9rFcC5uXnXH+sp5MIDOZCZbaShlXSIsfOAsiK
         M5tNvcd8qKF2ZGNtlPbyRmaC8cVI94/50tmsWQy9bvEeJrrSQaEDd9D6n4iQDVw1CpV5
         ldDpaNwLqTxH5HbHiBX7++GYYZMJ+JoDzb4lThEHK82lMNSDyeyON3mrZ1pwAUf1oXSH
         yoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=fP1eCApgwHA9tl/oZPR5dSzXBc7WfLP3SX3VyHzYjCE=;
        b=fLRdjw4GWjcR31UoVagE6wZ47HIAIRKBQjYzEzZ7z6pz5P4T7jiSBC4PSC0tbElU+g
         UrodOxPI0W+7/SuPeHPklUyD7j/f6OmeTJ2RPqivjobNbN5TXP8zgFC9uE5Jdzv+3sgR
         oKnfumUbEq/DzS9j41oFw1Vh7LeZmINJXxT0Euq9U6mFcrFwrn0oKK7exIYE9PUg+jMs
         Svgb48OPb+eIk6FNmNdT8x4yeXPJQd3iPhVdfiMiEjcoK2gDj9GEvLH6P4N6R0wG4tU+
         YwFFzwiH1evo6dGWjsCYn198VPeFr5oX/HgXcmRW9WAF6MMBqQK3xsIPWNoZz0DAIwAf
         byYA==
X-Gm-Message-State: APt69E3BE0JvobvY2Ho2Iq1ih/Qp6gwrR3/2QSpRZzBgoeXw5CIlQubI
        6jSurTtioJ5VuJq/I1VUmhRgusdCeIkxwW9j+Siysv0R7+UHo1tP7L4L01lzbpy0FkfaScOeDHB
        PQ7PZoxAmeZMM4M7XEzj/ybeCgSGiGLLRpAYuj1f/cwbrHuPYyZGWCWS41g==
X-Google-Smtp-Source: AAOMgpcA4gj30nvOIaHp89OPNd7/eUmBWA9simYVu0ZZmEQTvhgmjCdqNXgCqDjPmaXV3qXsVmVeX3mdBDk=
MIME-Version: 1.0
X-Received: by 2002:a0d:fe07:: with SMTP id o7-v6mr2178053ywf.195.1530138638634;
 Wed, 27 Jun 2018 15:30:38 -0700 (PDT)
Date:   Wed, 27 Jun 2018 15:30:20 -0700
In-Reply-To: <20180627223023.49659-1-bmwill@google.com>
Message-Id: <20180627223023.49659-6-bmwill@google.com>
References: <20180626205438.110764-1-bmwill@google.com> <20180627223023.49659-1-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v6 5/8] fetch: refactor fetch_refs into two functions
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
2.18.0.399.gad0ab374a1-goog

