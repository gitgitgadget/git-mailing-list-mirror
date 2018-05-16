Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 479741F406
	for <e@80x24.org>; Wed, 16 May 2018 22:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752327AbeEPW7m (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 18:59:42 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:56026 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752318AbeEPW7k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:59:40 -0400
Received: by mail-it0-f73.google.com with SMTP id i127-v6so5237404ita.5
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=RLZDl5loY9bT8kaSuhlMlVSt650DPuAKQUkzeepa8F0=;
        b=bnA/rh+tfCXEMLQmtKkoPJ1UI/Cccuaydd5qGDRKIi7iRieD80NIHYuqCooj6IvEG/
         MfYQswpOWTGiOm21IllyL5hxZWTn0D55Jc97Awt5IduKuLhsI5mUlgBGEmtzcG9TMJ9l
         /FNa2D3qdORKilwFCp799hUw0kqaAB/8/q8aDJRlao90/i69/5mcKJJC5SXDlPeHbtZw
         YFJCdYsy9bS5e86Nj1xbNHxFMTX1x0+pgjoq6QBBJrgNceLB7wodfESax9JbYT9FRejB
         1Gi9XJNOIxKIdXjSzadN0DtjRFq3M2+2x/d8+uN4Q+J0NlVJDeTr8kOPbXfhKOBnyngz
         fgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=RLZDl5loY9bT8kaSuhlMlVSt650DPuAKQUkzeepa8F0=;
        b=W9ddxvE0EcUASFzdc7l1AhJts+j5NCWLf0kIXL9dutXt1EoVQLerpDRawID7sUsEbk
         3mKvLkuZ9kQwpuNaZoNjRYBgUKhjAUQa5qKM9zq/9KXzrJOnU5KwWMU520iVOogx+hGv
         YJ/CTVKbgurWDauaJ5Q0jSW9vYGLNAxpfXwu6AwQf8GzX3VCCNvsPYtlOdGlfgPajPA9
         15iOkjUQYuRoXMOyW4JM39++m/GHbCyQAg0zB5At8qwbD3oZ7J68QJUdJbh833n6noM8
         vLK4Jx7G9MVZD+9Bjfuo78TA/xqc7P++llnOuB0Vr2xApCKhrjTS0Bqr6BBDxWmeHVMB
         0laA==
X-Gm-Message-State: ALKqPweHJbFB/k1HeUd8ySZPlZb3fE/zjojFdCS/B29B/f1HoI/NOENd
        XyJbaPbXqeWKWeUcDtDnu4XjQSrnE7zgBRLu4u5XxzVmX1Nc1VTaqQwrjKLVYcQc1zWTrOeMdj9
        NMQUJt1cvVQlGohIDSRrLSH7V2c7hRJgajh3L6nR+hMnhsIveBi7RnLjnNw==
X-Google-Smtp-Source: AB8JxZokgdygzFih3Pxskxv4jA0Bt33BvYS6eWJPc8uqYMrl1KtP+YHioTaWU+rQn4r0WA7coHtBYL5KzMQ=
MIME-Version: 1.0
X-Received: by 2002:a24:ee8f:: with SMTP id b137-v6mr221885iti.0.1526511579829;
 Wed, 16 May 2018 15:59:39 -0700 (PDT)
Date:   Wed, 16 May 2018 15:58:13 -0700
In-Reply-To: <20180516225823.235426-1-bmwill@google.com>
Message-Id: <20180516225823.235426-27-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com> <20180516225823.235426-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH v2 26/36] remote: convert get_ref_match to take a struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com,
        sbeller@google.com, bmwill@google.com
Cc:     avarab@gmail.com, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
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
index dd68e6b22..9eb79ea19 100644
--- a/remote.c
+++ b/remote.c
@@ -1082,27 +1082,29 @@ static int match_explicit_refs(struct ref *src, struct ref *dst,
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
@@ -1112,7 +1114,7 @@ static char *get_ref_match(const struct refspec_item *rs, int rs_nr, const struc
 	if (matching_refs == -1)
 		return NULL;
 
-	pat = rs + matching_refs;
+	pat = &rs->items[matching_refs];
 	if (pat->matching) {
 		/*
 		 * "matching refs"; traditionally we pushed everything
@@ -1309,7 +1311,7 @@ int match_push_refs(struct ref *src, struct ref **dst,
 		const struct refspec_item *pat = NULL;
 		char *dst_name;
 
-		dst_name = get_ref_match(rs.items, rs.nr, ref, send_mirror, FROM_SRC, &pat);
+		dst_name = get_ref_match(&rs, ref, send_mirror, FROM_SRC, &pat);
 		if (!dst_name)
 			continue;
 
@@ -1358,7 +1360,7 @@ int match_push_refs(struct ref *src, struct ref **dst,
 				/* We're already sending something to this ref. */
 				continue;
 
-			src_name = get_ref_match(rs.items, rs.nr, ref, send_mirror, FROM_DST, NULL);
+			src_name = get_ref_match(&rs, ref, send_mirror, FROM_DST, NULL);
 			if (src_name) {
 				if (!src_ref_index.nr)
 					prepare_ref_index(&src_ref_index, src);
-- 
2.17.0.441.gb46fe60e1d-goog

