Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E92F1F406
	for <e@80x24.org>; Mon, 14 May 2018 21:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752344AbeENV5G (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 17:57:06 -0400
Received: from mail-yw0-f201.google.com ([209.85.161.201]:39503 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752318AbeENV5C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 17:57:02 -0400
Received: by mail-yw0-f201.google.com with SMTP id j11-v6so5803613ywi.6
        for <git@vger.kernel.org>; Mon, 14 May 2018 14:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=sjTzO6dLyFs9xOE8UdF869oPr3e1GAtbcZVGuMWc1s4=;
        b=HL0ttCQHTVqdxL289029OLZz2gvvrX4+DAPTyLQOCVuya3HvUQyd6wAhDr8k0L8FZz
         cFzUfIQXfeXb/tYBRsXH9PHR+kL2HVL2xTcbp5t2SAZoBwrb+MeaNNpJQWo1XzhAPezQ
         i+SNrgF4KkZv0/Ynzc538FvYRdLPcVoaUz7PRpnrUYzOpojGX9P2InAyFJApscfFAxMg
         d8AWqra4JrRY/7Yc1HyXiPTIUWRg0k3NEvwUpCMafDs9Hlt3UqK9Tn+NChPrzJd5Ngpf
         TZ7xBbttCa+fzpVzQCmf4RwgQlO+AgcLUbXajLo6INR8fIPh+tb8eW/AdSHtqzujRM5r
         5hyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=sjTzO6dLyFs9xOE8UdF869oPr3e1GAtbcZVGuMWc1s4=;
        b=fFtFQmqBr8GlsADKtumhAbRVciOoj0eQhPqY2tZfbrRWp7HL64uJ92xRNZcZFW/lpi
         zLJfdlIv135mb301cah/JAwS4w2wP3349jdrK3amwIET9bD7C/3OpOOL3hVfoKOLr66H
         A4QEx+/PxYXWo5Ah+0qpg4wvLRZ+wxp2JF5OU09YAn93eUfe0FgLx7BvOJLRjhS+OiWZ
         8O8zhg/E71ADp/yR+YviJ9RL+w3Rb1yqvpLn59R7pyy/ulSFkqIMJdw7pT7EKf9B2Ldi
         F663u5aE0upwTKoFKgm7qPneTbqoQ0OqmRD6LwdGuy7nJS5BnhyjoONQyYQCeok5eJAI
         saDw==
X-Gm-Message-State: ALKqPwfGZMY9tLgZT0NEy6UaFN2o5yay88FeRxFG6Jf6lTOcArW/ieT5
        ghV1Hgp2VOhi+k+T1Icw2WLKJrQKM2v0oYeDwJSVnBIJDaLaSP9iiZVd4XAtIgr+GEXjrORbUVW
        U5RIX2bHrllZjNNbAldlY0CFhHcZFuQAk/Vv98BF9b+CXG8lrkpvqCHkkng==
X-Google-Smtp-Source: AB8JxZpp9QPNqstoH3d5WDMJwy/bMwWxQPBOJPvsDPNegvnJ2gxuASMAQTPKM3cGZWUjy9+U8xN4pvVXBe8=
MIME-Version: 1.0
X-Received: by 2002:a25:b59a:: with SMTP id q26-v6mr5130100ybj.0.1526335022156;
 Mon, 14 May 2018 14:57:02 -0700 (PDT)
Date:   Mon, 14 May 2018 14:56:01 -0700
In-Reply-To: <20180514215626.164960-1-bmwill@google.com>
Message-Id: <20180514215626.164960-11-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH 10/35] remote: convert match_push_refs to use struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert 'match_push_refs()' to use struct refspec.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 remote.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/remote.c b/remote.c
index 191855118..bce6e7ce4 100644
--- a/remote.c
+++ b/remote.c
@@ -1312,7 +1312,7 @@ int check_push_refs(struct ref *src, int nr_refspec, const char **refspec_names)
 int match_push_refs(struct ref *src, struct ref **dst,
 		    int nr_refspec, const char **refspec, int flags)
 {
-	struct refspec_item *rs;
+	struct refspec rs = REFSPEC_INIT_PUSH;
 	int send_all = flags & MATCH_REFS_ALL;
 	int send_mirror = flags & MATCH_REFS_MIRROR;
 	int send_prune = flags & MATCH_REFS_PRUNE;
@@ -1325,8 +1325,8 @@ int match_push_refs(struct ref *src, struct ref **dst,
 		nr_refspec = 1;
 		refspec = default_refspec;
 	}
-	rs = parse_push_refspec(nr_refspec, (const char **) refspec);
-	errs = match_explicit_refs(src, *dst, &dst_tail, rs, nr_refspec);
+	refspec_appendn(&rs, refspec, nr_refspec);
+	errs = match_explicit_refs(src, *dst, &dst_tail, rs.items, rs.nr);
 
 	/* pick the remainder */
 	for (ref = src; ref; ref = ref->next) {
@@ -1335,7 +1335,7 @@ int match_push_refs(struct ref *src, struct ref **dst,
 		const struct refspec_item *pat = NULL;
 		char *dst_name;
 
-		dst_name = get_ref_match(rs, nr_refspec, ref, send_mirror, FROM_SRC, &pat);
+		dst_name = get_ref_match(rs.items, rs.nr, ref, send_mirror, FROM_SRC, &pat);
 		if (!dst_name)
 			continue;
 
@@ -1384,7 +1384,7 @@ int match_push_refs(struct ref *src, struct ref **dst,
 				/* We're already sending something to this ref. */
 				continue;
 
-			src_name = get_ref_match(rs, nr_refspec, ref, send_mirror, FROM_DST, NULL);
+			src_name = get_ref_match(rs.items, rs.nr, ref, send_mirror, FROM_DST, NULL);
 			if (src_name) {
 				if (!src_ref_index.nr)
 					prepare_ref_index(&src_ref_index, src);
@@ -1396,6 +1396,9 @@ int match_push_refs(struct ref *src, struct ref **dst,
 		}
 		string_list_clear(&src_ref_index, 0);
 	}
+
+	refspec_clear(&rs);
+
 	if (errs)
 		return -1;
 	return 0;
-- 
2.17.0.441.gb46fe60e1d-goog

