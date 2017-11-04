Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B552420450
	for <e@80x24.org>; Sat,  4 Nov 2017 00:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756385AbdKDAmp (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 20:42:45 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51338 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756007AbdKDAml (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 20:42:41 -0400
Received: by mail-wm0-f67.google.com with SMTP id b9so4601109wmh.0
        for <git@vger.kernel.org>; Fri, 03 Nov 2017 17:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dr0fYC9iOB5h49CV2ylFGT9MnI16QdTDmpK4Sx28Qvo=;
        b=lNhJ0QI4c4oqIFULd92GwZafESL2naIejIdo9+HcuS13wJF0miH4ZU7Y2dFGY5C/2z
         LLCF2wdHsHrqFnPFTbbO0OHrclmU7qYoJYK1JIWSCI9ZQAD8BWinR1iYdhlppoBI2uzg
         lZtE+iihTSB+s9abNWMF5DqHY+/ciz/i+PPgelfIdFOawg9x4EIyU6dGnlfzaYOxRTg7
         +9mDoDPogStOPtsOdr6IirrZvq3aCEAQKV2FcF+RuavryD53b/hxbLhFEwXWIWG2r3s1
         lMNyfKBxt/Wb6ocidk7LpQmHOqoY+KidAhHnPal663Cl8xDqirYTxk6o6Y3PBHpX2u7X
         xOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dr0fYC9iOB5h49CV2ylFGT9MnI16QdTDmpK4Sx28Qvo=;
        b=E+mhfwRI2Q8vvIBAITNDpqFs109LH5DLC1Z5kGWYDMDFB3V86vUSxMRsKLFnNNR3+0
         pmOe+5wi2cfs9GCNSVEpouFT2nBparADx2nE6aTrsIeeDMSXaUYoTRYqZ3OwwZAS/hWO
         7/QPzKBIfP2u7234t7cJ0LW12P+YNBswkPG7oy+GkVEfqzhTYlCZORxzKB0lh3Rt0ZJ8
         PAuuMEUeZHiKoV7f4yS5StTFE2puJ4c41OF7NNOIAJTVOYYCM1XcphO4h+eE7+iGsvG1
         uvkcux6/W8YnSt4gaOSy028yeFpwFSy4M8ePUorsYCNSDK5drgYRMurAzUjtBih2Eol6
         k8wA==
X-Gm-Message-State: AJaThX4Vk/xW2RYbkJec19koSFRY8sx21b71QJNWgfk4YP8i4M815enO
        TEhePOCV+rb3RL0TUabiuik1IcXyPu4=
X-Google-Smtp-Source: ABhQp+S4qNjX/58/ZT48lPiWz/myMAtJb+SoAjv8WZGizvlh0PlAEYygT6NlEgDbBYpDFRHANGguUQ==
X-Received: by 10.28.174.78 with SMTP id x75mr479980wme.27.1509756159988;
        Fri, 03 Nov 2017 17:42:39 -0700 (PDT)
Received: from rigel.lan (101.154.108.93.rev.vodafone.pt. [93.108.154.101])
        by smtp.gmail.com with ESMTPSA id o8sm11956418wrc.10.2017.11.03.17.42.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Nov 2017 17:42:39 -0700 (PDT)
From:   =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        me@ikke.info, gitster@pobox.com, hjemli@gmail.com,
        mhagger@alum.mit.edu, pclouds@gmail.com,
        ilari.liusvaara@elisanet.fi
Subject: [PATCH v1 1/2] refs: extract function to normalize partial refs
Date:   Sat,  4 Nov 2017 00:41:43 +0000
Message-Id: <20171104004144.5975-2-rafa.almas@gmail.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171104004144.5975-1-rafa.almas@gmail.com>
References: <20171104004144.5975-1-rafa.almas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`for_each_glob_ref_in` has some code built into it that converts
partial refs like 'heads/master' to their full qualified form
'refs/heads/master'. It also assume a trailing '/*' if no glob
characters are present in the pattern.

Extract that logic to its own function which can be reused elsewhere
where the same behaviour is needed, and add an ENSURE_GLOB flag
to toggle if a trailing '/*' is to be appended to the result.

Signed-off-by: Kevin Daudt <me@ikke.info>
Signed-off-by: Rafael Ascensão <rafa.almas@gmail.com>
---
 refs.c | 34 ++++++++++++++++++++--------------
 refs.h | 16 ++++++++++++++++
 2 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/refs.c b/refs.c
index c590a992f..1e74b48e6 100644
--- a/refs.c
+++ b/refs.c
@@ -369,32 +369,38 @@ int head_ref_namespaced(each_ref_fn fn, void *cb_data)
 	return ret;
 }
 
-int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
-	const char *prefix, void *cb_data)
+void normalize_glob_ref(struct strbuf *normalized_pattern, const char *prefix,
+		const char *pattern, int flags)
 {
-	struct strbuf real_pattern = STRBUF_INIT;
-	struct ref_filter filter;
-	int ret;
-
 	if (!prefix && !starts_with(pattern, "refs/"))
-		strbuf_addstr(&real_pattern, "refs/");
+		strbuf_addstr(normalized_pattern, "refs/");
 	else if (prefix)
-		strbuf_addstr(&real_pattern, prefix);
-	strbuf_addstr(&real_pattern, pattern);
+		strbuf_addstr(normalized_pattern, prefix);
+	strbuf_addstr(normalized_pattern, pattern);
 
-	if (!has_glob_specials(pattern)) {
+	if (!has_glob_specials(pattern) && (flags & ENSURE_GLOB)) {
 		/* Append implied '/' '*' if not present. */
-		strbuf_complete(&real_pattern, '/');
+		strbuf_complete(normalized_pattern, '/');
 		/* No need to check for '*', there is none. */
-		strbuf_addch(&real_pattern, '*');
+		strbuf_addch(normalized_pattern, '*');
 	}
+}
+
+int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
+	const char *prefix, void *cb_data)
+{
+	struct strbuf normalized_pattern = STRBUF_INIT;
+	struct ref_filter filter;
+	int ret;
+
+	normalize_glob_ref(&normalized_pattern, prefix, pattern, ENSURE_GLOB);
 
-	filter.pattern = real_pattern.buf;
+	filter.pattern = normalized_pattern.buf;
 	filter.fn = fn;
 	filter.cb_data = cb_data;
 	ret = for_each_ref(filter_refs, &filter);
 
-	strbuf_release(&real_pattern);
+	strbuf_release(&normalized_pattern);
 	return ret;
 }
 
diff --git a/refs.h b/refs.h
index a02b628c8..9f9a8bb27 100644
--- a/refs.h
+++ b/refs.h
@@ -312,6 +312,22 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data);
 int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data);
 int for_each_rawref(each_ref_fn fn, void *cb_data);
 
+/*
+ * Normalizes partial refs to their full qualified form.
+ * If prefix is NULL, will prepend 'refs/' to the pattern if it doesn't start
+ * with 'refs/'. Results in refs/<pattern>
+ *
+ * If prefix is not NULL will result in <prefix>/<pattern>
+ *
+ * If ENSURE_GLOB is set and no glob characters are found in the
+ * pattern, a trailing </><*> will be appended to the result.
+ * (<> characters to avoid breaking C comment syntax)
+ */
+
+#define ENSURE_GLOB 1
+void normalize_glob_ref (struct strbuf *normalized_pattern, const char *prefix,
+				const char *pattern, int flags);
+
 static inline const char *has_glob_specials(const char *pattern)
 {
 	return strpbrk(pattern, "?*[");
-- 
2.15.0

