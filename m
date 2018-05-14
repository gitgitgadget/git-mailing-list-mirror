Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AB771F406
	for <e@80x24.org>; Mon, 14 May 2018 21:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752451AbeENV50 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 17:57:26 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:35000 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752077AbeENV5Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 17:57:25 -0400
Received: by mail-ua0-f202.google.com with SMTP id x8-v6so18293324uaj.2
        for <git@vger.kernel.org>; Mon, 14 May 2018 14:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=T8SQgyt8wnzadlFZ/5ALkubdPw1z+5Pt4irqv118gzQ=;
        b=Xq5dDWBwJmEoPT62PAftBcASLduKSRIMuDmOEx7nVYZG+2JmHjP/Owx0DoRzNHhdpU
         rleEdukdRryKpLzPR8N4ySlzilEbTwG/U09PDLbsQ3VWjaMkDFskC3qwVkM2T+a3Op/4
         S1BWvq+kseEtsCAA+k/KSxPZD/Fb+rsud1GbdqN9gGS9lL+VTFt1M69y6v+BknCiSo19
         Df6kZC6I2tEJuFM7Lq9sCO3hm39uxqSOeMj5RJpSSo2EtkWXipL12AR8gq8jjcmOBsZC
         +b4UDf9KfLBzRCs3DyBAJSGCLFI5ZK5CgxwDcaCpZGKNX8MYTPa3FTb3vK4bIEJaSdxh
         WIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=T8SQgyt8wnzadlFZ/5ALkubdPw1z+5Pt4irqv118gzQ=;
        b=L35zQUBnayZESreHh1inVf7hnAG+8y9pckum3TvZOP/jH8rnib7nj8FBCg61j0k8MA
         HR/o93sIznun4/sLFwFLkBYz4h0omBzGTy1+uabhCbDOy/CSmcez8z3BsFwaJ4c67wVg
         QFYb5HDzuffBpqsc4q4UKBeqaSWvp/6c7KOMUTTnh9woacfGSOnh6S+1GgvauusUDhDI
         lEAQls/Zy1ZdQOxhWuKzTqUmA/X0Fc0Zrk9QQxSIxhZsjXHnKRG8u9YDA5AC5I4fVyst
         YyC0805EUE2QJIUlMKVCMNt+rTrekTddreXnoUydEc4gJqaZoCk6Fu7c6LUsKMbsrBtP
         jkdw==
X-Gm-Message-State: ALKqPwdWuYKBeCa0JNSnuWLeruIlJYnoU6fxi+1xFu595kfqNzBDLu1H
        b2L1AgtAsWdWn+KXI1OZvT947n0vXfQV4NtbV5jbcD8/g143Ngagz5q3nf7I+KFnyadUpQpk2lA
        MqHcUSy21/t8rhdlbmv5RQUMlvoHrNUGVSJ5C8yOMLYqXu3gg79HhCN3CvQ==
X-Google-Smtp-Source: AB8JxZpuizoZAptWxrk6/NAOs42fPE1wfxC/z5DBIXMiBW49AvF4UQVAQfSZSTuqPGYgtyR8jzYTPwoUQdI=
MIME-Version: 1.0
X-Received: by 2002:a9f:3226:: with SMTP id x35-v6mr13150787uad.30.1526335044643;
 Mon, 14 May 2018 14:57:24 -0700 (PDT)
Date:   Mon, 14 May 2018 14:56:10 -0700
In-Reply-To: <20180514215626.164960-1-bmwill@google.com>
Message-Id: <20180514215626.164960-20-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH 19/35] fetch: convert do_fetch to take a struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert 'do_fetch()' to take a 'struct refspec' as a parameter instead
of a list of 'struct refspec_item'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fetch.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e2f2f290e..733feb19c 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1112,7 +1112,7 @@ static void backfill_tags(struct transport *transport, struct ref *ref_map)
 }
 
 static int do_fetch(struct transport *transport,
-		    struct refspec_item *refs, int ref_count)
+		    struct refspec *rs)
 {
 	struct string_list existing_refs = STRING_LIST_INIT_DUP;
 	struct ref *ref_map;
@@ -1136,7 +1136,7 @@ static int do_fetch(struct transport *transport,
 			goto cleanup;
 	}
 
-	ref_map = get_ref_map(transport, refs, ref_count, tags, &autotags);
+	ref_map = get_ref_map(transport, rs->items, rs->nr, tags, &autotags);
 	if (!update_head_ok)
 		check_not_current_branch(ref_map);
 
@@ -1160,8 +1160,8 @@ static int do_fetch(struct transport *transport,
 		 * explicitly (via command line or configuration); we
 		 * don't care whether --tags was specified.
 		 */
-		if (ref_count) {
-			prune_refs(refs, ref_count, ref_map, transport->url);
+		if (rs->nr) {
+			prune_refs(rs->items, rs->nr, ref_map, transport->url);
 		} else {
 			prune_refs(transport->remote->fetch.items,
 				   transport->remote->fetch.nr,
@@ -1410,7 +1410,7 @@ static int fetch_one(struct remote *remote, int argc, const char **argv, int pru
 
 	sigchain_push_common(unlock_pack_on_signal);
 	atexit(unlock_pack);
-	exit_code = do_fetch(gtransport, rs.items, rs.nr);
+	exit_code = do_fetch(gtransport, &rs);
 	refspec_clear(&rs);
 	transport_disconnect(gtransport);
 	gtransport = NULL;
-- 
2.17.0.441.gb46fe60e1d-goog

