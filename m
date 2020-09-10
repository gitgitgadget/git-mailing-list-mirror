Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9512C07548
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 19:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62D3C21556
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 19:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u4Zhh1zt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgIJTGQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgIJTEC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 15:04:02 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108F5C061756
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 12:04:02 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id y2so4164001lfy.10
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 12:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Is63qXrgEioUL+Hsy1MzTxoyErJDjmHx/ZVlOmLE17w=;
        b=u4Zhh1ztXtELIQBq93kJ6DYj/K2n2sq0qKgcLXjt2rpXe2hPNEjj3zSQiJMYiKyMqX
         g3QVALetEKj8C9Ikan87Nm3GYE1xhs209skxnEcE6+a3TeSC+dj+7GTUoSnJmfksqcGV
         3ikc90NWNTJGiHJTheCUnoaMkeVp2tOF1VzJfcvUxtSjpl4v+MBDyJjgm5IOQqrN991/
         qbliE2EHvToR6SxR9DNy0ZiR03hgm0EeUdA1UBego1UIeHwy2cV4isU4if/HddfPeEHZ
         k7q047sHlXrmzq+kXFv4CqZn6dAdjOLeNurkp1BY7VOzmwd42J0s0Jchr6SUFu/owVLu
         P7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Is63qXrgEioUL+Hsy1MzTxoyErJDjmHx/ZVlOmLE17w=;
        b=pxxevNDTYYEoS2EWCxXgpyZ+zCw+2nK+hC37uO6UTbLkdQcUhHEonhwqcjtBFnalTY
         JHgFFaC0K4XCuzqYwbQI9TZusY2Me1M4QtvqNcLhvZVAhj2rx09moSxVMbArIQ1q7tqc
         f9doha+CIZdfIdrpZ+9gCtZ9yo6GCYO3ugNV545bNxYsFXBirWpeohFPhyS+BUp2veA5
         uRBqmAX0umv1zlK9bFISTsTvuZwb2dmGcX4ZDogxpuNFvuL9GNtDT3XXBSLfdqyIhGtC
         rnYSgch66UDuyTpMn6Fe8xooyl7hSjRUSrxKwOFaLvKW3jBs/3TaxvQ5loEis6GWEjip
         Po7g==
X-Gm-Message-State: AOAM5313CU5QtXLnIk/pq9o+YK0nl+sEPtJoHOKd2l+vW1KbNkV63h2L
        pkEQ7IjYfWM9lXUSFASc3hMeN/Vxlmc=
X-Google-Smtp-Source: ABdhPJwQJFLG/AtI7gw56WAMcYZsuKzka4ksCjGTRkBqO48OBRlw7Q/wJFlwCeL82xbpxACRDNttAg==
X-Received: by 2002:a05:6512:5cd:: with SMTP id o13mr4800653lfo.171.1599764640154;
        Thu, 10 Sep 2020 12:04:00 -0700 (PDT)
Received: from localhost.localdomain (92-33-153-30.customers.ownit.se. [92.33.153.30])
        by smtp.gmail.com with ESMTPSA id v11sm1549815lfg.39.2020.09.10.12.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 12:03:59 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/8] wt-status: replace sha1 mentions with oid
Date:   Thu, 10 Sep 2020 21:03:35 +0200
Message-Id: <734ea28effdcb8650ab5e6ac2aa5398400faf1c5.1599762679.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.277.g9b3c35fffd
In-Reply-To: <cover.1599762679.git.martin.agren@gmail.com>
References: <cover.1599762679.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`abbrev_sha1_in_line()` uses a `struct object_id oid` and should be
fully prepared to handle non-SHA1 object ids. Rename it to
`abbrev_oid_in_line()`.

A few comments in `wt_status_get_detached_from()` mention "sha1". The
variable they refer to was renamed in e86ab2c1cd ("wt-status: convert to
struct object_id", 2017-02-21). Update the comments to reference "oid"
instead.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 wt-status.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index c560cbe860..59be457015 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1232,7 +1232,7 @@ static int split_commit_in_progress(struct wt_status *s)
  * The function assumes that the line does not contain useless spaces
  * before or after the command.
  */
-static void abbrev_sha1_in_line(struct strbuf *line)
+static void abbrev_oid_in_line(struct strbuf *line)
 {
 	struct strbuf **split;
 	int i;
@@ -1282,7 +1282,7 @@ static int read_rebase_todolist(const char *fname, struct string_list *lines)
 		strbuf_trim(&line);
 		if (!line.len)
 			continue;
-		abbrev_sha1_in_line(&line);
+		abbrev_oid_in_line(&line);
 		string_list_append(lines, line.buf);
 	}
 	fclose(f);
@@ -1575,9 +1575,9 @@ static void wt_status_get_detached_from(struct repository *r,
 	}
 
 	if (dwim_ref(cb.buf.buf, cb.buf.len, &oid, &ref) == 1 &&
-	    /* sha1 is a commit? match without further lookup */
+	    /* oid is a commit? match without further lookup */
 	    (oideq(&cb.noid, &oid) ||
-	     /* perhaps sha1 is a tag, try to dereference to a commit */
+	     /* perhaps oid is a tag, try to dereference to a commit */
 	     ((commit = lookup_commit_reference_gently(r, &oid, 1)) != NULL &&
 	      oideq(&cb.noid, &commit->object.oid)))) {
 		const char *from = ref;
-- 
2.28.0.277.g9b3c35fffd

