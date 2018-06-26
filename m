Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36C521F516
	for <e@80x24.org>; Tue, 26 Jun 2018 20:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934039AbeFZUy7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 16:54:59 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:36780 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933810AbeFZUyw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 16:54:52 -0400
Received: by mail-it0-f74.google.com with SMTP id d70-v6so2278228itd.1
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 13:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=rLOxeAejN/gP1LVKYA9UGMsw/ue5K5yR3AKLI/xRcIU=;
        b=UCux5ri2ycS27unOH2mMccGwn6gmXxO7sKSVU+mnkt92mXbMBAa4hOHgjn9MvPsp6X
         uB963nPLOEqEo0+rZwz1R1BvrXgu+37wiYAjza7/J+16ZG/eUat2sixPxw66oEUZZghC
         5FEyY4RtXi7vsP+EXoubJmn6MU9P1yf3Kn12Eu7hcShH0RE9YnuBkK967R3lnffC9MDT
         HrUdJBvp1OglWgf7hKlubSAp7zxctxdM/oeYmgBdXNFwT+S2pAk5g1KRkTS0xl++fSkr
         faNCuR7WCA6N9iexdhL3b6j/wzFPp8nounaXEsfBJDzTvtN+8WgH8HKbMnWVCflV/4mk
         SuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=rLOxeAejN/gP1LVKYA9UGMsw/ue5K5yR3AKLI/xRcIU=;
        b=pE97bO+iuMwJYsiSqgNKBKUOlbZ1gVcsGB7EJ5xb1/RYh9n+/+NU1vAp4GQy02zpWJ
         IQNNJ/5MzAqUisSXTGsMJJ61xFe3X/1DBsAnumvddfDXp9Hg6UWFt3S/HE0Gy6WySkU0
         Px5bIaew/V8eRSfArAncCzcldmC8tCkoBOByyxZDkeDe1aJImr2DnFB2O5dewPNaLWGW
         IQT9u06ufOeoS7k7ID5137Rowg6okVE1jzH7juwd4Pd6Nh/vAlgOQWB48vEYFRngew9g
         qlhrT/e62vVR6xHY02Vql68t5CjG13qLz30v+Pv2oVEuvcEQkUCNexcKJAJyqJeqPurm
         ljhw==
X-Gm-Message-State: APt69E3DQu1WTPw5rnwoklBEAsEuto/f6fqCaB6PvMwtTrvczbyRPpkC
        tvIYBM/PFjmOLx9Y2XpRTS4awb7cV8g8QsrwSTiimq1LJD4bbaf3CyUGOdF1gKDXIuJ5LvwC3k8
        hjtgfdZV+kKqFaZk0hkXgITRgwPrFd6slWSogJkINeDCyYGI/Bh6NVuqRkg==
X-Google-Smtp-Source: ADUXVKKCP66qYgQrM0UJif4a7Dw4SYTbL/6hcOyMrjPi2eib/aMM3MhCCNnmNg/uliNW61ukDn9gPSsUA7c=
MIME-Version: 1.0
X-Received: by 2002:a24:d587:: with SMTP id a129-v6mr1329436itg.3.1530046491568;
 Tue, 26 Jun 2018 13:54:51 -0700 (PDT)
Date:   Tue, 26 Jun 2018 13:54:34 -0700
In-Reply-To: <20180626205438.110764-1-bmwill@google.com>
Message-Id: <20180626205438.110764-5-bmwill@google.com>
References: <20180625185332.164142-1-bmwill@google.com> <20180626205438.110764-1-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v5 4/8] fetch: refactor the population of peer ref OIDs
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, gitster@pobox.com, sbeller@google.com,
        jrnieder@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Populate peer ref OIDs in get_ref_map instead of do_fetch. Besides
tightening scopes of variables in the code, this also prepares for
get_ref_map being able to be called multiple times within do_fetch.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fetch.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index ea5b9669a..545635448 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -351,6 +351,7 @@ static struct ref *get_ref_map(struct transport *transport,
 	/* opportunistically-updated references: */
 	struct ref *orefs = NULL, **oref_tail = &orefs;
 
+	struct string_list existing_refs = STRING_LIST_INIT_DUP;
 	const struct ref *remote_refs;
 
 	if (rs->nr)
@@ -458,7 +459,23 @@ static struct ref *get_ref_map(struct transport *transport,
 		tail = &rm->next;
 	}
 
-	return ref_remove_duplicates(ref_map);
+	ref_map = ref_remove_duplicates(ref_map);
+
+	for_each_ref(add_existing, &existing_refs);
+	for (rm = ref_map; rm; rm = rm->next) {
+		if (rm->peer_ref) {
+			struct string_list_item *peer_item =
+				string_list_lookup(&existing_refs,
+						   rm->peer_ref->name);
+			if (peer_item) {
+				struct object_id *old_oid = peer_item->util;
+				oidcpy(&rm->peer_ref->old_oid, old_oid);
+			}
+		}
+	}
+	string_list_clear(&existing_refs, 1);
+
+	return ref_map;
 }
 
 #define STORE_REF_ERROR_OTHER 1
@@ -1110,14 +1127,10 @@ static void backfill_tags(struct transport *transport, struct ref *ref_map)
 static int do_fetch(struct transport *transport,
 		    struct refspec *rs)
 {
-	struct string_list existing_refs = STRING_LIST_INIT_DUP;
 	struct ref *ref_map;
-	struct ref *rm;
 	int autotags = (transport->remote->fetch_tags == 1);
 	int retcode = 0;
 
-	for_each_ref(add_existing, &existing_refs);
-
 	if (tags == TAGS_DEFAULT) {
 		if (transport->remote->fetch_tags == 2)
 			tags = TAGS_SET;
@@ -1136,18 +1149,6 @@ static int do_fetch(struct transport *transport,
 	if (!update_head_ok)
 		check_not_current_branch(ref_map);
 
-	for (rm = ref_map; rm; rm = rm->next) {
-		if (rm->peer_ref) {
-			struct string_list_item *peer_item =
-				string_list_lookup(&existing_refs,
-						   rm->peer_ref->name);
-			if (peer_item) {
-				struct object_id *old_oid = peer_item->util;
-				oidcpy(&rm->peer_ref->old_oid, old_oid);
-			}
-		}
-	}
-
 	if (tags == TAGS_DEFAULT && autotags)
 		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
 	if (prune) {
@@ -1183,7 +1184,6 @@ static int do_fetch(struct transport *transport,
 	}
 
  cleanup:
-	string_list_clear(&existing_refs, 1);
 	return retcode;
 }
 
-- 
2.18.0.rc2.346.g013aa6912e-goog

