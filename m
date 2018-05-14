Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 925EA1F406
	for <e@80x24.org>; Mon, 14 May 2018 21:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752570AbeENV5m (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 17:57:42 -0400
Received: from mail-vk0-f74.google.com ([209.85.213.74]:54123 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752376AbeENV5k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 17:57:40 -0400
Received: by mail-vk0-f74.google.com with SMTP id m7-v6so17189159vke.20
        for <git@vger.kernel.org>; Mon, 14 May 2018 14:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=zX1DG6nQVKbSSODave3iU62hGIXmUrZff4D0tycWBp0=;
        b=luSgU6X3m4h4b+3Vo82Ek0VB/e+5YyAz/N1JwroCJkt9wdZYxZ6SIcuLvDw8PvTn85
         R+IAsKPqMCc10vCIAdesVUloCrPH4b6oeWumaaoHjKOMCdvcv9GhtRBRGQ0PSKu7vdCB
         KEm/TfUbuCq0KBrG0/Y4Cp3m0s0f/ITbIwXNRTfACL6NV7GHy5SvIiRnwodqCFbOhjno
         7cYMjNfJuBBn7isrnerQ1YJmM3OqE/WD4Cr6XF2je9avSkYhHB8AfOIHgUPnqEaL+Mkf
         o8qQ0dZ2tsP5WVw+4PeU7PoDQpmi685rQjqiap0M6L0RR6fIy9WjiC1kIfivroMfxfiZ
         dSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=zX1DG6nQVKbSSODave3iU62hGIXmUrZff4D0tycWBp0=;
        b=JILCuTPMDsFwKwfGJThOBZ7EiHy9sSBdz67VwK6wyh6tnBwpSK26koFpO2gKn+/L6N
         pIgUo2y+kr2RyiQXIAnOAgVEUQGsFdhPQELzkBWvLTSamaxPclfioDDKTfwrGJZPj/KF
         nSJ/aqcQkCsWufvpclIGgAPbY0Y8ZN9ZO+5HdreuU6KmhrBKnt0xUOoT4Wth4gU1Qw5g
         ngd3Zlko/XK5cHwfNyd1Rrp9214bK2Axt/hZBRY9RZDrJOWUwO+XSEzo8xOUYM7JE+TJ
         8MmO76nUQzpqLrlWSYrAp25DESuCgLMriFRhME+NdtWFQPznBk54TDyMDsUVZu/u9It4
         a93g==
X-Gm-Message-State: ALKqPwfptIJIPeI5qAPI3Ed4Eusst8KjqLylyyATQYDChI4KumWfzewU
        GymEgU4Sr6FVO+M3NBXmQ2ybyUh23pdLmbgqwubMmSlWvmSC2OKQaTO7Ab79+i0I9G9wrXDRvr9
        SWC7eUQCxnDKA8BvkH60lKCqa3v+GvRXi24CroJCoychwmsyItLPuebCm1Q==
X-Google-Smtp-Source: AB8JxZof+7ao4dsgtcWriedWt6SBnikzO4Dojy+3aWHFzNrTvWuV4sUOdK1KtThg2Wj3hmRMmkJ775hSuFI=
MIME-Version: 1.0
X-Received: by 2002:ab0:3011:: with SMTP id f17-v6mr13275991ual.101.1526335059608;
 Mon, 14 May 2018 14:57:39 -0700 (PDT)
Date:   Mon, 14 May 2018 14:56:16 -0700
In-Reply-To: <20180514215626.164960-1-bmwill@google.com>
Message-Id: <20180514215626.164960-26-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH 25/35] remote: convert get_ref_match to take a struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert 'get_ref_match()' to take a 'struct refspec' as a parameter
instead of a list of 'struct refspec_item'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 remote.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/remote.c b/remote.c
index 3d7bc7504..0879ee587 100644
--- a/remote.c
+++ b/remote.c
@@ -1091,27 +1091,29 @@ static int match_explicit_refs(struct ref *src, struct ref *dst,
 	return errs;
 }
 
-static char *get_ref_match(const struct refspec_item *rs, int rs_nr, const struct ref *ref,
-		int send_mirror, int direction, const struct refspec_item **ret_pat)
+static char *get_ref_match(const struct refspec *rs, const struct ref *ref,
+			   int send_mirror, int direction,
+			   const struct refspec_item **ret_pat)
 {
 	const struct refspec_item *pat;
 	char *name;
 	int i;
 	int matching_refs = -1;
-	for (i = 0; i < rs_nr; i++) {
-		if (rs[i].matching &&
-		    (matching_refs == -1 || rs[i].force)) {
+	for (i = 0; i < rs->nr; i++) {
+		const struct refspec_item *item = &rs->items[i];
+		if (item->matching &&
+		    (matching_refs == -1 || item->force)) {
 			matching_refs = i;
 			continue;
 		}
 
-		if (rs[i].pattern) {
-			const char *dst_side = rs[i].dst ? rs[i].dst : rs[i].src;
+		if (item->pattern) {
+			const char *dst_side = item->dst ? item->dst : item->src;
 			int match;
 			if (direction == FROM_SRC)
-				match = match_name_with_pattern(rs[i].src, ref->name, dst_side, &name);
+				match = match_name_with_pattern(item->src, ref->name, dst_side, &name);
 			else
-				match = match_name_with_pattern(dst_side, ref->name, rs[i].src, &name);
+				match = match_name_with_pattern(dst_side, ref->name, item->src, &name);
 			if (match) {
 				matching_refs = i;
 				break;
@@ -1121,7 +1123,7 @@ static char *get_ref_match(const struct refspec_item *rs, int rs_nr, const struc
 	if (matching_refs == -1)
 		return NULL;
 
-	pat = rs + matching_refs;
+	pat = &rs->items[matching_refs];
 	if (pat->matching) {
 		/*
 		 * "matching refs"; traditionally we pushed everything
@@ -1318,7 +1320,7 @@ int match_push_refs(struct ref *src, struct ref **dst,
 		const struct refspec_item *pat = NULL;
 		char *dst_name;
 
-		dst_name = get_ref_match(rs.items, rs.nr, ref, send_mirror, FROM_SRC, &pat);
+		dst_name = get_ref_match(&rs, ref, send_mirror, FROM_SRC, &pat);
 		if (!dst_name)
 			continue;
 
@@ -1367,7 +1369,7 @@ int match_push_refs(struct ref *src, struct ref **dst,
 				/* We're already sending something to this ref. */
 				continue;
 
-			src_name = get_ref_match(rs.items, rs.nr, ref, send_mirror, FROM_DST, NULL);
+			src_name = get_ref_match(&rs, ref, send_mirror, FROM_DST, NULL);
 			if (src_name) {
 				if (!src_ref_index.nr)
 					prepare_ref_index(&src_ref_index, src);
-- 
2.17.0.441.gb46fe60e1d-goog

