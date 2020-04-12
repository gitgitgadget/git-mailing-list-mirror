Return-Path: <SRS0=e9fP=54=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0551C352B6
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 13:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99AA1206B8
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 13:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sWcIsQGE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgDLNac (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Apr 2020 09:30:32 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43159 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgDLNab (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Apr 2020 09:30:31 -0400
Received: by mail-pf1-f196.google.com with SMTP id l1so3366363pff.10
        for <git@vger.kernel.org>; Sun, 12 Apr 2020 06:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k0TTErNib/oVDKYqMrFH1TE4YX/C72t6kSBmdz23lsc=;
        b=sWcIsQGEJTACxrqu8Ghdt87kM3Tr9gjHT2/YmWRevNJIiiCGctjnc7w6oDH9xLXyeq
         jpPJsdqP5NPEFgvUqKmxzs4hjCyE/SOJIgE2QxQyLqQ8vx7y5UnO5B48xOHnKjQ74Rss
         Q7vI24zvQgcrTMTL73HHVnK5KICG/kw5Wwd/FGyOA/45IsjhWh5itrm7Ij4APpXwYPfZ
         bBZF59HjNp4dkzabCWA2EFKANK0TkPXcJo3+R6oTLJk6UOVQ7tCtekdQpLHe2PVxK1Hb
         WRu2cogr0CArkMv7ICV0IJ2dmqgkUZXLxc+ahNBj54rYGs1wmLTFNHkWKqz/5aEEmZjn
         9t7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k0TTErNib/oVDKYqMrFH1TE4YX/C72t6kSBmdz23lsc=;
        b=SICzjkeXHAC5CbYWNPymiuZFr32g0//7QGVsze64sHagsXv+s5G/p11G37cWTQLVJg
         xC/QaDSQrq2ckSFzDi9rnY9Wt6EgrHhWH8fHki+0xHyvXbpZ8vFxd4jgKfvD7xRVkIwo
         /wICQO4RuTouRRa1cayW3CFabt6Y6BrK0lJNp7DvQoEkKF0JlrxuaJ3LXgiaAkcBRGb0
         gBlvOtizt9o98r48Q3XRzTqJYv89mivUSeXUH4dc9qXJCuptW1cxr2vPukK2JSZmZJUA
         49ARoTWMA82j9w2ojYyoPgtrN/Qi+dt4ca0w/sBoPIf3AQyzZysyXfbWKKOX0sF6aOCx
         +kyg==
X-Gm-Message-State: AGi0PuZf6QfhuKk2LCejzfd/OTNGZrfmyJ0hJbfBjpGkQSa2Rjj+u8v8
        LdWMVVtyG60LcTbF/PcPhVA=
X-Google-Smtp-Source: APiQypLW0oPysZeb2FOiWLTG4bsz6ook/wF7F0MW46vTkjR2hz43+eQ6ej2s/H3WMhjJpK3OHettyg==
X-Received: by 2002:a63:1961:: with SMTP id 33mr660074pgz.282.1586698231182;
        Sun, 12 Apr 2020 06:30:31 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id 139sm6093363pfv.0.2020.04.12.06.30.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Apr 2020 06:30:30 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v10 3/8] refs.c: refactor to reuse ref_is_hidden()
Date:   Sun, 12 Apr 2020 09:30:17 -0400
Message-Id: <20200412133022.17590-4-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200407120813.25025-1-worldhello.net@gmail.com>
References: <20200407120813.25025-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

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
2.24.1.15.g448c31058d.agit.4.5

