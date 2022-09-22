Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB301C6FA8B
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 23:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiIVXaT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 19:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiIVXaO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 19:30:14 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F9E7D79B
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 16:30:12 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id oc9-20020a17090b1c0900b00202843f7057so4503281pjb.1
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 16:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=C+q7h6iJb0NO0lIo4rCwR8P70towVnR8fUfasaCiejE=;
        b=oAWLQf4Em08lRMCjAeiplcH8tQE6jSQVVB5TIdtnQ53xLcfP/tDH/8hpnzkKh4MaKO
         EzlPQfXQfO48S4uc+/QdWnIUd/5sVxnwUjNOF+tRfhqsktSpX6iuIsfDy0q09L0cWzIR
         kksajeYHbi+RGN98fxhj8aRLOmHYe+v8AwvHU9VM5rN5CHi2d7mLuZbl5Ut8pqtfX2t2
         NaOH4lkp9yPThnoaOoOFdgVqUPmIj3O/rpHwOcBzAfSh3FbtdPtStwZTX8WrdCQulduj
         f3j8MX2kWRA8wE6i2KB3pPvc3L2Cx1pdt21iHMJXpWfStrYGCAvPdzfq3xwcX3F4eFVG
         GRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=C+q7h6iJb0NO0lIo4rCwR8P70towVnR8fUfasaCiejE=;
        b=ZSOAHbsm20LZPZeS0J5zUnOaCSgtoPVmqc1F6f/5aJLFoRetV67nl59nMDLIMlH0A5
         aCBnpG8QWtVLOl1g7v8sSyDzm3MnfH9wf+LXgY89ecIE9lRe7K/AYn6DNjCH2zeyqX1/
         lAn+2nbBGfJzyr2Suk7UJlj7SbZpYc++ZLQfgUKOMvvWOqcOiY1njk0yG1NU/y0oqkJg
         aOJ7PNFAKAztgMtIlTdibfc3NmH3HnPlHdb3ocdHEXlWN0hq23aU7vPvKjtapWYOGtO5
         1nbzKxwO/xfjj+whCjqHw3iNwqrXSLQReazgCfADi+zOsrjnJHpIzTktsbCJscDj0FW8
         kX2g==
X-Gm-Message-State: ACrzQf1TNdLBMqUEHYo0v/gL59c0k8h18hbP0x15r1CGiMFT2fwpLEde
        CWxcBAYtr6kJbFEOuhe/IHgjxJLna3qjFB9/OcSQE8bhOZzlns6xAKkPj64ceWeUrUOrdZkGUVs
        DNLIdWh053+Cy209s3tPUdKDgrG1xtLy+YlBo1Ls5Iu6hnqGKsxuebPnT95zx8Aa5iQ==
X-Google-Smtp-Source: AMsMyM5sPd8XUtu71NdMHdlDa8WoSB9YJaPGBz8/NvPcWosKihUeuU0UaFcLUf/wdR1wQDz4lUncj1poVy7fLiU=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90b:10a:b0:200:2849:235f with SMTP
 id p10-20020a17090b010a00b002002849235fmr426801pjz.1.1663889411384; Thu, 22
 Sep 2022 16:30:11 -0700 (PDT)
Date:   Thu, 22 Sep 2022 23:29:45 +0000
In-Reply-To: <20220922232947.631309-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20220922232947.631309-1-calvinwan@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220922232947.631309-3-calvinwan@google.com>
Subject: [PATCH 2/4] submodule: move status parsing into function
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     emilyshaffer@google.com, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A future patch requires the ability to parse the output of git
status --porcelain=2. Move parsing code from is_submodule_modified to
parse_status_porcelain.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 submodule.c | 71 +++++++++++++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 32 deletions(-)

diff --git a/submodule.c b/submodule.c
index 3fa5db3ecd..91213ba83c 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1753,6 +1753,43 @@ static int commit_missing_in_sub(const struct object_id *oid, void *data)
 	return type != OBJ_COMMIT;
 }
 
+static int parse_status_porcelain(char *buf, unsigned *dirty_submodule, int ignore_untracked)
+{
+	/* regular untracked files */
+	if (buf[0] == '?')
+		*dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
+
+	if (buf[0] == 'u' ||
+		buf[0] == '1' ||
+		buf[0] == '2') {
+		/* T = line type, XY = status, SSSS = submodule state */
+		if (strlen(buf) < strlen("T XY SSSS"))
+			BUG("invalid status --porcelain=2 line %s",
+				buf);
+
+		if (buf[5] == 'S' && buf[8] == 'U')
+			/* nested untracked file */
+			*dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
+
+		if (buf[0] == 'u' ||
+			buf[0] == '2' ||
+			memcmp(buf + 5, "S..U", 4))
+			/* other change */
+			*dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
+	}
+
+	if ((*dirty_submodule & DIRTY_SUBMODULE_MODIFIED) &&
+		((*dirty_submodule & DIRTY_SUBMODULE_UNTRACKED) ||
+		ignore_untracked)) {
+		/*
+		* We're not interested in any further information from
+		* the child any more, neither output nor its exit code.
+		*/
+		return 1;
+	}
+	return 0;
+}
+
 static int fetch_finish(int retvalue, struct strbuf *err,
 			void *cb, void *task_cb)
 {
@@ -1893,39 +1930,9 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 
 	fp = xfdopen(cp.out, "r");
 	while (strbuf_getwholeline(&buf, fp, '\n') != EOF) {
-		/* regular untracked files */
-		if (buf.buf[0] == '?')
-			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
-
-		if (buf.buf[0] == 'u' ||
-		    buf.buf[0] == '1' ||
-		    buf.buf[0] == '2') {
-			/* T = line type, XY = status, SSSS = submodule state */
-			if (buf.len < strlen("T XY SSSS"))
-				BUG("invalid status --porcelain=2 line %s",
-				    buf.buf);
-
-			if (buf.buf[5] == 'S' && buf.buf[8] == 'U')
-				/* nested untracked file */
-				dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
-
-			if (buf.buf[0] == 'u' ||
-			    buf.buf[0] == '2' ||
-			    memcmp(buf.buf + 5, "S..U", 4))
-				/* other change */
-				dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
-		}
-
-		if ((dirty_submodule & DIRTY_SUBMODULE_MODIFIED) &&
-		    ((dirty_submodule & DIRTY_SUBMODULE_UNTRACKED) ||
-		     ignore_untracked)) {
-			/*
-			 * We're not interested in any further information from
-			 * the child any more, neither output nor its exit code.
-			 */
-			ignore_cp_exit_code = 1;
+		ignore_cp_exit_code = parse_status_porcelain(buf.buf, &dirty_submodule, ignore_untracked);
+		if (ignore_cp_exit_code)
 			break;
-		}
 	}
 	fclose(fp);
 
-- 
2.37.3.998.g577e59143f-goog

