Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46325C10DCE
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 12:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF4E20746
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 12:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jK297KcA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgCMMXr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:23:47 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46605 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgCMMXr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 08:23:47 -0400
Received: by mail-pl1-f195.google.com with SMTP id w12so4178557pll.13
        for <git@vger.kernel.org>; Fri, 13 Mar 2020 05:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4SJjKPjsE9uSOROLgo/QFhP14LqTGd/44sUbiJeiTPE=;
        b=jK297KcAWEhgOhqHTV1TppkraSCpVsCVcwqwwWepaBKZ2RGF78N1btAitlDsrwz2ay
         z/abojtjUKyAeZ2ww5yxr6THWscuvXgBogSKbgdRNXer4ZSdY8zHs6hCoaV2qDH4Pz6V
         jznNkxvSwZsTbWWtgNJav8sK7e+WIbPnEXa8cHMLlIk/vZk8iZQ5zG1ZCdUgyDP6rNvF
         C3izEeSvMBgZw12Eo7JoMvaXHDHO6REWcSpWiKpPTT4TBbVVg/e6QyfwuaWySmk8NQlx
         amylGlXplE72nNWfMMJDGspMLevqPNty72ObekMphb0HmEQPcMvHKlYHRik2sBJAXd2h
         tnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4SJjKPjsE9uSOROLgo/QFhP14LqTGd/44sUbiJeiTPE=;
        b=DZg+wNEsOLhvxRvI7OGB2a8B10S0z6OwlrInmpts/B05BF5QSGNr763HQqMpCExzX2
         3jFjwhbZHqdoko/wBWA/m5SoxTBzgf3Le02iTzKmDstEDiA0h3SccUJzfAbVldGpfMH+
         qiiHdr8LHgKVcfH9WBp07uXqWY86aa6wttyKIjx+cdm1Q5NWWtfiQZz/Ce2PvoZPwbJ1
         wN0mEi2M872IMWes/hfuUe1avS/NxmhxbBVfofHZE+gFyXcilmOO4IunpOSdwNtjWhjq
         0tYWjKlo3iKJ6PMiiRtkHQqpGsnFWPbHkaqMZPYXDyzNX1XpQCdu+1IgpXDB98bkFpq/
         xgNw==
X-Gm-Message-State: ANhLgQ00lnK095ll1xUTAjGrtRnTjLofFQZhwBam0OcC75Pt+iHTGbIz
        5rGpILtV4CEsah6jOnW3FSs=
X-Google-Smtp-Source: ADFU+vuMzBv9ozugaaKcSJXQ7nPM7XO+DvNUjElzwKBFy28qPEIReSNfgE/bYjJ3/goz6Dg5rhDC7g==
X-Received: by 2002:a17:90a:ec0f:: with SMTP id l15mr9403863pjy.133.1584102224019;
        Fri, 13 Mar 2020 05:23:44 -0700 (PDT)
Received: from localhost.localdomain ([47.89.83.4])
        by smtp.gmail.com with ESMTPSA id 134sm5346690pfy.27.2020.03.13.05.23.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2020 05:23:43 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v3 3/4] refs.c: refactor to reuse ref_is_hidden()
Date:   Fri, 13 Mar 2020 20:23:17 +0800
Message-Id: <20200313122318.78000-4-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.26.0.rc1.5.gca1e965b06
In-Reply-To: <CANYiYbHvqLX_OozgAXJ8MbuLipqUdj4CpbExe0oiCcyUyb=Osw@mail.gmail.com>
References: <CANYiYbHvqLX_OozgAXJ8MbuLipqUdj4CpbExe0oiCcyUyb=Osw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add new function `ref_is_matched()` to reuse `ref_is_hidden()`. Will use
this function for `receive-pack` to check commands with specific
prefixes.

Test case t5512 covered this change.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 refs.c | 11 ++++++++---
 refs.h |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 1ab0bb54d3..229159ea1a 100644
--- a/refs.c
+++ b/refs.c
@@ -1389,13 +1389,18 @@ int parse_hide_refs_config(const char *var, const char *value, const char *secti
 }
 
 int ref_is_hidden(const char *refname, const char *refname_full)
+{
+	return ref_is_matched(hide_refs, refname, refname_full);
+}
+
+int ref_is_matched(struct string_list *match_refs, const char *refname, const char *refname_full)
 {
 	int i;
 
-	if (!hide_refs)
+	if (!match_refs)
 		return 0;
-	for (i = hide_refs->nr - 1; i >= 0; i--) {
-		const char *match = hide_refs->items[i].string;
+	for (i = match_refs->nr - 1; i >= 0; i--) {
+		const char *match = match_refs->items[i].string;
 		const char *subject;
 		int neg = 0;
 		const char *p;
diff --git a/refs.h b/refs.h
index 545029c6d8..a2ea043f7f 100644
--- a/refs.h
+++ b/refs.h
@@ -739,6 +739,7 @@ int parse_hide_refs_config(const char *var, const char *value, const char *);
  * parameter always points to the full ref name.
  */
 int ref_is_hidden(const char *, const char *);
+int ref_is_matched(struct string_list *, const char *, const char *);
 
 enum ref_type {
 	REF_TYPE_PER_WORKTREE,	  /* refs inside refs/ but not shared       */
-- 
2.26.0.rc1.5.gca1e965b06

