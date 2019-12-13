Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D81DC2D0BF
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052F22465A
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYQp3235"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfLMIIX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 03:08:23 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52368 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfLMIIU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 03:08:20 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so5270821wmc.2
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 00:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Zagw8BugEWLxFwJ+vo56ycxQDxc0qcHDFD+dt8RRyrY=;
        b=VYQp3235vUhYDrGE6qRozmbEIWlOIDyLGGqldLNo/wFDIjdM3O3eXTdPYbBJZjNAF6
         HeUkysNE/R13xQZJbQg3WM3C/4qdLsBmSTZrgJixbyhaEaZ/24cWqRUt7k17aXTrxve/
         CVism6DyMBhwV3BIXCAWQXQ9+CTKHK2sltpXLgzZgM7DICvFW7B+oB2xqgnOa/tkrlqN
         XD9IUf8NaCe6ZmICcv2eJq26V+h64Yj+wSFtRLPr463XM8s1WamtJuZs/Lg3r9MNtM3d
         LGX6IcrA99x+Nd3SZLpgLT0PY1OP5HSRhBU2cqqMGa8TcycZu/ma9hBRX+7jy7a9MldG
         Syww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Zagw8BugEWLxFwJ+vo56ycxQDxc0qcHDFD+dt8RRyrY=;
        b=Ch2/3w+TT5W28sy1tP0zLUQfRjJwSue1cn+CxTep4elG7ZWENFokZX1Hgi+i7UUoII
         V0gldic1qfEgtzrIgwjRc9gBmuaEiTcacqlnmxG80CytfDN1RNXX0Gqt7i3y8nj7v8CT
         A4mGCdtnoHHB8mHWHTSX8WWhUerp1tZUogTaKWS65TDXQsMXQJXPqALnl+tIHeMe343N
         ZutWmfkISTYEyp51r2zclRK/OdeRvEN/MdOZ7DXralzBP4rhiK5wabq58PEaW8ErXcNV
         Zjw5Bqe46GeZWeI7Vuw+0Vg73y1j2aPDL22hBDWxgeqc52K/CgIJDDRi6Y26ouO39C4L
         HSRQ==
X-Gm-Message-State: APjAAAW9NkufEv14DDQo6KgmccxzqxH5paZa65HVbFJXe96nhUQcf3v0
        5Kj6IEjkFYYbwvg9H9Mu8SvrCvNN
X-Google-Smtp-Source: APXvYqyived3a4QEipkWYetWEQqibi+AdN7r+gPA98jxbMFsmRgywAX1CcDcFBQDq9VN/2EyzVYwAQ==
X-Received: by 2002:a1c:7e13:: with SMTP id z19mr11622114wmc.67.1576224497561;
        Fri, 13 Dec 2019 00:08:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o4sm8964344wrw.97.2019.12.13.00.08.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 00:08:16 -0800 (PST)
Message-Id: <da950fdfc5c3e15c59ee2f9cf301590b776e8dca.1576224486.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.173.git.1576224486.gitgitgadget@gmail.com>
References: <pull.173.git.1576224486.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Dec 2019 08:07:59 +0000
Subject: [PATCH 12/19] built-in add -p: coalesce hunks after splitting them
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This is considered "the right thing to do", according to 933e44d3a0
("add -p": work-around an old laziness that does not coalesce hunks,
2011-04-06).

Note: we cannot simply modify the hunks while merging them; Once we
implement hunk editing, we will call `reassemble_patch()` whenever a
hunk is edited, therefore we must not modify the hunks (because the user
might e.g. hit `K` and change their mind whether to stage the previous
hunk).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-patch.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/add-patch.c b/add-patch.c
index 2d34ddd7f4..c8d84aec68 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -433,6 +433,55 @@ static void render_diff_header(struct add_p_state *s,
 	}
 }
 
+/* Coalesce hunks again that were split */
+static int merge_hunks(struct add_p_state *s, struct file_diff *file_diff,
+		       size_t *hunk_index, struct hunk *merged)
+{
+	size_t i = *hunk_index;
+	struct hunk *hunk = file_diff->hunk + i;
+	/* `header` corresponds to the merged hunk */
+	struct hunk_header *header = &merged->header, *next;
+
+	if (hunk->use != USE_HUNK)
+		return 0;
+
+	*merged = *hunk;
+	/* We simply skip the colored part (if any) when merging hunks */
+	merged->colored_start = merged->colored_end = 0;
+
+	for (; i + 1 < file_diff->hunk_nr; i++) {
+		hunk++;
+		next = &hunk->header;
+
+		/*
+		 * Stop merging hunks when:
+		 *
+		 * - the hunk is not selected for use, or
+		 * - the hunk does not overlap with the already-merged hunk(s)
+		 */
+		if (hunk->use != USE_HUNK ||
+		    header->new_offset >= next->new_offset ||
+		    header->new_offset + header->new_count < next->new_offset ||
+		    merged->start >= hunk->start ||
+		    merged->end < hunk->start)
+			break;
+
+		merged->end = hunk->end;
+		merged->colored_end = hunk->colored_end;
+
+		header->old_count = next->old_offset + next->old_count
+			- header->old_offset;
+		header->new_count = next->new_offset + next->new_count
+			- header->new_offset;
+	}
+
+	if (i == *hunk_index)
+		return 0;
+
+	*hunk_index = i;
+	return 1;
+}
+
 static void reassemble_patch(struct add_p_state *s,
 			     struct file_diff *file_diff, struct strbuf *out)
 {
@@ -443,12 +492,19 @@ static void reassemble_patch(struct add_p_state *s,
 	render_diff_header(s, file_diff, 0, out);
 
 	for (i = file_diff->mode_change; i < file_diff->hunk_nr; i++) {
+		struct hunk merged = { 0 };
+
 		hunk = file_diff->hunk + i;
 		if (hunk->use != USE_HUNK)
 			delta += hunk->header.old_count
 				- hunk->header.new_count;
-		else
+		else {
+			/* merge overlapping hunks into a temporary hunk */
+			if (merge_hunks(s, file_diff, &i, &merged))
+				hunk = &merged;
+
 			render_hunk(s, hunk, delta, 0, out);
+		}
 	}
 }
 
-- 
gitgitgadget

