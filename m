Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C67D20A10
	for <e@80x24.org>; Sun,  1 Oct 2017 16:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751383AbdJAQT0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 12:19:26 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:47903 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751128AbdJAQSz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 12:18:55 -0400
Received: by mail-pf0-f182.google.com with SMTP id u12so1853623pfl.4
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 09:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rf8K71O/mPM3NUvDIaJfHsy63UXuMyo3Aamu4HS+Xug=;
        b=Qh7axX/9OeKj7h8oWc4ik2SUAKIXMgzb8iNjRqLSkL9qLzByL8pNARil9/fCZyGcWK
         K55dXTJWLXiD+9v70e7JLvgeEKLslWzRUCSyqrVP1C7IS3I1l1DF5h44A0NKHf7VbQQG
         pUDDMhxwHS5VIGj2IH5TTKoFA2Hm3r+RyvhzNztWVOsp+OvSiSRhIVlX3f4Cw3L4wehj
         VUcPXs0BLUU0u/bproduTyq7uLqL/7/GbxweDbD7XpivzyVSPUi2WQr+Gv6BL8hiXl/o
         qiY/oqT15JIVa8qJla+ePxxEqR6v06CPV+KBvoDoiNqPL2/LcSsOoO6nhIis22mEQLFX
         JxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rf8K71O/mPM3NUvDIaJfHsy63UXuMyo3Aamu4HS+Xug=;
        b=F332ei/sd52wp+HEErLLSMCDueIwChzpIk2jCB4FeJkhSJ3+MwGr6EH4Mywo2g8zxQ
         DpyLP0p3UtWK5MhoT2Alrq2S0r6qwpS+LKV1GTPcPe1iqF/8bLIgDSyULEQruAw3az0s
         UKDtgfMBj3eeRcWbekkGZH9woW5BojTvM2ofsxgWFZ/vMmB1kVBplz4I5Ijt7mkE54wD
         kCabjZ42B5L31I5gJs6zb4NjObu/Akb6P3X1e2htOGVMIuQ9aY2g2wyqgn65urfeSe9Y
         ijWf668bZpQ941yj0nxu/I46WTOd5JSNs97C8n15SBRfbLl8a53HIBi2lBI3/FO+Nphc
         DwLQ==
X-Gm-Message-State: AMCzsaVIQsEoBygavyL08sNBZfWyeiKRTvG9cVsK5aRTd/kYOQv46GMg
        zk2AtVj6REdeJS1ac73jcBljIBJf2Bo=
X-Google-Smtp-Source: AOwi7QBn5OTVqoafXwm67p3IVSR/v7LCP1/yJPhMcTuroX3MYT9ejNbzS4U3shhMXXwNv8aYL1P6vw==
X-Received: by 10.98.218.86 with SMTP id w22mr35946pfl.84.1506874734826;
        Sun, 01 Oct 2017 09:18:54 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id t17sm14607808pfi.31.2017.10.01.09.18.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Oct 2017 09:18:53 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v4 1/6] pretty.c: delimit "%(trailers)" arguments with ","
Date:   Sun,  1 Oct 2017 09:18:47 -0700
Message-Id: <20171001161852.84571-1-me@ttaylorr.com>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
In-Reply-To: <20171001161725.GA66172@D-10-157-251-166.dhcp4.washington.edu>
References: <20171001161725.GA66172@D-10-157-251-166.dhcp4.washington.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for adding consistent "%(trailers)" atom options to
`git-for-each-ref(1)`'s "--format" argument, change "%(trailers)" in
pretty.c to separate sub-arguments with a ",", instead of a ":".

Multiple sub-arguments are given either as "%(trailers:unfold,only)" or
"%(trailers:only,unfold)".

This change disambiguates between "top-level" arguments, and arguments
given to the trailers atom itself. It is consistent with the behavior of
"%(upstream)" and "%(push)" atoms.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pretty.c                      | 34 +++++++++++++++++++++++++++++-----
 t/t4205-log-pretty-formats.sh |  4 ++--
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/pretty.c b/pretty.c
index 94eab5c89..eec128bc1 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1056,6 +1056,25 @@ static size_t parse_padding_placeholder(struct strbuf *sb,
 	return 0;
 }
 
+static int match_placeholder_arg(const char *to_parse,
+				const char *candidate,
+				const char **end)
+{
+	const char *p;
+	if (!(skip_prefix(to_parse, candidate, &p)))
+		return 0;
+	if (*p == ',') {
+		*end = p + 1;
+		return 1;
+	}
+	if (*p == ')') {
+		*end = p;
+		return 1;
+	}
+	return 0;
+}
+
+
 static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 				const char *placeholder,
 				void *context)
@@ -1285,11 +1304,16 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 
 	if (skip_prefix(placeholder, "(trailers", &arg)) {
 		struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
-		while (*arg == ':') {
-			if (skip_prefix(arg, ":only", &arg))
-				opts.only_trailers = 1;
-			else if (skip_prefix(arg, ":unfold", &arg))
-				opts.unfold = 1;
+		if (*arg == ':') {
+			arg++;
+			for (;;) {
+				if (match_placeholder_arg(arg, "only", &arg))
+					opts.only_trailers = 1;
+				else if (match_placeholder_arg(arg, "unfold", &arg))
+					opts.unfold = 1;
+				else
+					break;
+			}
 		}
 		if (*arg == ')') {
 			format_trailers_from_commit(sb, msg + c->subject_off, &opts);
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index ec5f53010..977472f53 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -588,8 +588,8 @@ test_expect_success '%(trailers:unfold) unfolds trailers' '
 '
 
 test_expect_success ':only and :unfold work together' '
-	git log --no-walk --pretty="%(trailers:only:unfold)" >actual &&
-	git log --no-walk --pretty="%(trailers:unfold:only)" >reverse &&
+	git log --no-walk --pretty="%(trailers:only,unfold)" >actual &&
+	git log --no-walk --pretty="%(trailers:unfold,only)" >reverse &&
 	test_cmp actual reverse &&
 	{
 		grep -v patch.description <trailers | unfold &&
-- 
2.14.1.145.gb3622a4ee

