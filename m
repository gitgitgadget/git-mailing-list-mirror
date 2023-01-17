Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D425C54E76
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 21:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjAQVGg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 16:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjAQVFP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 16:05:15 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB7C43926
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 11:31:23 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-4dedc46e2d5so126836567b3.21
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 11:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DwwyDRcEc/QahaSm8IQ8wFaNXRSbSZzT+SIlbiS7D3Q=;
        b=W/NlxobfO9eXaE1SjmxL9k3w13xnKd7BKMn5/MwMR9fBoN8mhjUqjNnrWZv04sGlYE
         xthvgpfRunfo/WJqaqAzrk8qN57uNOKIlAgeEBsMCgVO98ScDCWF9a9loxL8Wq+raFeN
         7PHnB/1HGzsRxQCTBZmNTGlvAJc92I0HWFduSUHqhHLt7dCVheciitK8dp/RS3tRLaFz
         YfqLSEMDCGFo6KA4XedyWKSK1f+uJwZMcHgcDGdwzaU6rE5R9/t1o4JZMrnmitpIyGig
         +01LqCRsHuvrgGEu2Op+3OM0Dh9Da4nukiu8zv8IPoEkMC1Cqzn3sn7WbrzHhLgbXECt
         xBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DwwyDRcEc/QahaSm8IQ8wFaNXRSbSZzT+SIlbiS7D3Q=;
        b=6WG3ZXXEpyfAX+HkmN/h2i0irJ3QMuPPuCQulkD5k9B5R5XNNmDz2khmcESKdtfo+H
         lIgbxT3L5X2s6tQqwngFTlW0NZQIB4MhiTgArGWfdkMLGuzHH1ekYcdjh+L9JPMkumvj
         WyvU8G0aAEI7te1VGQIqF+ZDiRkIEZ2VoCnPCqbevpAEPet1FaB5qZ0var/vJR6X96hH
         4q5MOKjFn3ScbkrXd0gOY4aSjmJEoUF2B7xLwMNQJ3X2uNs30Asch4qAIIAfwgH9H1mH
         aKn5+iK5hm1bMxrE9Dx3iZ1WlxZAwGjapl9wIGJBjWdRF4A/oXn9ypUx8MP1BfQ4T7lW
         6uoA==
X-Gm-Message-State: AFqh2kqyK5fGKH2O8PBty0qtMlIbIOO7SNLSElCYNjKzO6VtAvNRmg/F
        vZT11A6cJ1+KW1BbfVsrRN1lcFF5cdASiOljVlLE0FNnh2enw7SuFJvQ/tUvd9wLnselEv3Zdpi
        +RsxjAlTJROZr2z2EHMA8gkyR7vesW1PY7HSoStUqneumYR4s9yYGges0TvRE4mBmxA==
X-Google-Smtp-Source: AMrXdXtklQ1GCBkEVTzm7pKEtExQnQV9D+pbcMp4EW89GAAxDH2zSilpv/bskCqtxfrIvCPCLJN8MAmS7ti9tHM=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a0d:f282:0:b0:4ed:c96d:1b89 with SMTP id
 b124-20020a0df282000000b004edc96d1b89mr616430ywf.130.1673983882139; Tue, 17
 Jan 2023 11:31:22 -0800 (PST)
Date:   Tue, 17 Jan 2023 19:30:37 +0000
In-Reply-To: <20230104215415.1083526-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230104215415.1083526-1-calvinwan@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230117193041.708692-3-calvinwan@google.com>
Subject: [PATCH v6 2/6] submodule: strbuf variable rename
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, emilyshaffer@google.com,
        avarab@gmail.com, phillip.wood123@gmail.com, chooglen@google.com,
        newren@gmail.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A prepatory change for a future patch that moves the status parsing
logic to a separate function.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 submodule.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/submodule.c b/submodule.c
index fae24ef34a..faf37c1101 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1906,25 +1906,28 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 
 	fp = xfdopen(cp.out, "r");
 	while (strbuf_getwholeline(&buf, fp, '\n') != EOF) {
+		char *str = buf.buf;
+		const size_t len = buf.len;
+
 		/* regular untracked files */
-		if (buf.buf[0] == '?')
+		if (str[0] == '?')
 			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
 
-		if (buf.buf[0] == 'u' ||
-		    buf.buf[0] == '1' ||
-		    buf.buf[0] == '2') {
+		if (str[0] == 'u' ||
+		    str[0] == '1' ||
+		    str[0] == '2') {
 			/* T = line type, XY = status, SSSS = submodule state */
-			if (buf.len < strlen("T XY SSSS"))
+			if (len < strlen("T XY SSSS"))
 				BUG("invalid status --porcelain=2 line %s",
-				    buf.buf);
+				    str);
 
-			if (buf.buf[5] == 'S' && buf.buf[8] == 'U')
+			if (str[5] == 'S' && str[8] == 'U')
 				/* nested untracked file */
 				dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
 
-			if (buf.buf[0] == 'u' ||
-			    buf.buf[0] == '2' ||
-			    memcmp(buf.buf + 5, "S..U", 4))
+			if (str[0] == 'u' ||
+			    str[0] == '2' ||
+			    memcmp(str + 5, "S..U", 4))
 				/* other change */
 				dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
 		}
-- 
2.39.0.314.g84b9a713c41-goog

