Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264C6C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 19:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0932C20578
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 19:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qBYQALZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731909AbgHQTPi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387476AbgHQPkL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 11:40:11 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4C1C061345
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 08:40:03 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a14so15473894wra.5
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 08:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DbHPP7VjFo40T0L65snxz8HYHIIgo5mRU3/mMviV70o=;
        b=qBYQALZi6i/MNg15p9W3r7k/NgpmZoqtngsKP+yrSWEzJnQcwt3U9YqH667MzSn+rM
         QLYzq8wiSrqTdGWsZSD2ClKSJfg8YSwtARnLAQXhmhl359+E6Dkbw9Q/zTJQxvEF4M2N
         fYuGL0+9s8mMVlb3VdyCu6aAq4/TLwjB455xyhSTo0aRYG/H75C8hDrrHZCYkDiDi2vH
         XQGvtD/eDrjftNt061SW7Z40HGl1517Jb5oRan5LnYvvY1ugjWu4gWj/r4BFe7pjGm62
         6BQY6YleTng+3tdSdnPLCJ58cJveu2EGINIorITCiV7ATUYD254Nji3BfU+MqadN3JU+
         M25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DbHPP7VjFo40T0L65snxz8HYHIIgo5mRU3/mMviV70o=;
        b=VmOc8OqLnmL1THXeWqhA1FSKupa1slAeHhvoC4X42/G1TQsb9IgJEYi4YPDKachv+r
         ZB/lMCjUGzohs7BUkitDHmblRE6FeLc1WhZ5nMc3LKxbkOw23T0h86hFncHvpVp7JcUq
         gOWoItgRpJ3IE7N8Wtpy6DPq8u3DvMiVXbXSwlWPsv9t1GTd9eYoBkzEONab9mC5Dhct
         bEOAL7om3NOt+TTsmK9lekkEF+PMDcrQW3SJq7hhYHVMHSFZC6XnBh3YMfhpRZCTFQDJ
         MWGrZ62X7MRopBHMZWqDsCEkNQHbrwCQCwdH4bfYw8HZ+RimCqCWNDiiCJBaeS/xZLc+
         vA3g==
X-Gm-Message-State: AOAM530+R48/IyOHXQS/UDmtz375KIrq6++P/A7LC2KfZwQ8LGaljaj8
        g/HOZQ/zz0yGYS5Wbcwn7EzYjTc8ow4=
X-Google-Smtp-Source: ABdhPJywlmYhkF/ukP8m0pJ+Q1b5wAqfwSzmufgIkc1q3TPwekK2wdWM3w+cx7VkRxFWRXE4iJKxkA==
X-Received: by 2002:adf:ec04:: with SMTP id x4mr15265220wrn.28.1597678801502;
        Mon, 17 Aug 2020 08:40:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g16sm28273146wrs.88.2020.08.17.08.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 08:40:01 -0700 (PDT)
Message-Id: <d4e9c5f4996640e71ea47cb65867c4553bdf8f42.1597678796.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.705.git.1597678796.gitgitgadget@gmail.com>
References: <pull.705.git.1597678796.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Aug 2020 15:39:56 +0000
Subject: [PATCH 4/4] refs: read FETCH_HEAD generically
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The FETCH_HEAD ref must be stored in a file, regardless of the type of
ref backend. This is because it can hold more than just a single ref.

To accomodate FETCH_HEAD for alternate ref backends, read FETCH_HEAD
from a file generically in refs_read_raw_ref()

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 2dd851fe81..ab7d62e237 100644
--- a/refs.c
+++ b/refs.c
@@ -1634,11 +1634,36 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
 	return refs_for_each_rawref(get_main_ref_store(the_repository), fn, cb_data);
 }
 
+static int refs_read_fetch_head(struct ref_store *ref_store,
+				struct object_id *oid, struct strbuf *referent,
+				unsigned int *type)
+{
+	struct strbuf full_path = STRBUF_INIT;
+	struct strbuf content = STRBUF_INIT;
+	int result = -1;
+	strbuf_addf(&full_path, "%s/%s", ref_store->gitdir, "FETCH_HEAD");
+
+	if (strbuf_read_file(&content, full_path.buf, 0) < 0)
+		goto done;
+
+	result = parse_loose_ref_contents(content.buf, oid, referent, type);
+
+done:
+	strbuf_release(&full_path);
+	strbuf_release(&content);
+	return result;
+}
+
 int refs_read_raw_ref(struct ref_store *ref_store,
 		      const char *refname, struct object_id *oid,
 		      struct strbuf *referent, unsigned int *type)
 {
-	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent, type);
+	if (!strcmp(refname, "FETCH_HEAD")) {
+		return refs_read_fetch_head(ref_store, oid, referent, type);
+	}
+
+	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
+					   type);
 }
 
 /* This function needs to return a meaningful errno on failure */
-- 
gitgitgadget
