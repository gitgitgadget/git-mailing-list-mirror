Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2950620259
	for <e@80x24.org>; Wed,  7 Dec 2016 16:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753389AbcLGQKT (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 11:10:19 -0500
Received: from mail-wj0-f194.google.com ([209.85.210.194]:35899 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752323AbcLGQKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 11:10:16 -0500
Received: by mail-wj0-f194.google.com with SMTP id j10so23272683wjb.3
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 08:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WHrwWHMAJUgaEc0tzU+qlPs468huMtGw9pnuhED+aw0=;
        b=DlPN1zMcMj/tsjSoslpUEGYNK3si8DDNt9iX9FnrLzcymbEvNHVAU1rsXc3wWgTTwm
         nLnBzRlawvhKZenB2qVZVjzshH620uusukrjVE8TKdHGKi/ocmSFZHjQXwKc0z9I3IzI
         fNnxBZds0mdSiNqEsqS5j6JKZTzw1FNndTM7uykIgQlcE3JqCbRr1K58q8zHcv8S/NoF
         Y73cFLhmyFjbMZWW1TIzCmR22Rl60Vd7PIeqhdGl5WnZhokV0cL4h+ZVEPPZOqVEhfOU
         6etuFefeWF287GbgOTJvmtzdd64J0xrCehcTHBIhoHBE2jXNHGBTPVj2MKDI0m9VJ8Ya
         +u8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WHrwWHMAJUgaEc0tzU+qlPs468huMtGw9pnuhED+aw0=;
        b=RucO50sehJ1NXgwO2uPuxQAKqSPrnPOuWU71l4Jfdu0S0UUOy890LFtPcXrh4qNlKD
         VStJwyOT0WrgtGrhl4rsXIZVQUm25I200MNZQiArty5t3YPWnixmxt8Do/BTE2zTTIHx
         urrN0NBM6Mt1PrjxkXh7w+EBTZGgYOAleEnVvXl2CL4TheaO2apY0s5eLj74ZTIC8dSd
         THaFpTrKVFta2HiCYWq6ZzYUEeH3qxBFxCSiNpPnqR7M+P5GEtCvwKONvNN36dBS9xpx
         zoUsvQQLKHhoSfd+hi5wHLEUmqna2J/SwiDnbdQW3f4sjfJYv49+5+AF/+1nXaACqv3z
         2lqA==
X-Gm-Message-State: AKaTC01mNUfdxBfB6WLKzXTBZhvaNgB0kgKPbuIkEnlO8DBthOB9bO6/r/IsP+XCNQMeuw==
X-Received: by 10.194.19.101 with SMTP id d5mr56977308wje.18.1481127015073;
        Wed, 07 Dec 2016 08:10:15 -0800 (PST)
Received: from localhost.localdomain (x590e0b3d.dyn.telefonica.de. [89.14.11.61])
        by smtp.gmail.com with ESMTPSA id 6sm32140379wjt.5.2016.12.07.08.10.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Dec 2016 08:10:14 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/2] ref-filter: add function to parse atoms from a nul-terminated string
Date:   Wed,  7 Dec 2016 17:09:23 +0100
Message-Id: <20161207160923.7028-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.78.g5a2d011
In-Reply-To: <20161207160923.7028-1-szeder.dev@gmail.com>
References: <20161207160923.7028-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ref-filter's parse_ref_filter_atom() function parses an atom between
the start and end pointers it gets as arguments.  This is fine for two
of its callers, which process '%(atom)' format specifiers and the end
pointer comes directly from strchr() looking for the closing ')'.
However, it's not quite so straightforward for its other two callers,
which process sort specifiers given as plain nul-terminated strings.
Especially not for ref_default_sorting(), which has the default
hard-coded as a string literal, but can't use it directly, because a
pointer to the end of that string literal is needed as well.
The next patch will add yet another caller using a string literal.

Add a helper function around parse_ref_filter_atom() to parse an atom
up to the terminating nul, and call this helper in those two callers.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ref-filter.c | 8 ++------
 ref-filter.h | 4 ++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index dfadf577c..3c6fd4ba7 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1658,19 +1658,16 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 /*  If no sorting option is given, use refname to sort as default */
 struct ref_sorting *ref_default_sorting(void)
 {
-	static const char cstr_name[] = "refname";
-
 	struct ref_sorting *sorting = xcalloc(1, sizeof(*sorting));
 
 	sorting->next = NULL;
-	sorting->atom = parse_ref_filter_atom(cstr_name, cstr_name + strlen(cstr_name));
+	sorting->atom = parse_ref_filter_atom_from_string("refname");
 	return sorting;
 }
 
 void parse_sorting_string(const char *arg, struct ref_sorting **sorting_tail)
 {
 	struct ref_sorting *s;
-	int len;
 
 	s = xcalloc(1, sizeof(*s));
 	s->next = *sorting_tail;
@@ -1683,8 +1680,7 @@ void parse_sorting_string(const char *arg, struct ref_sorting **sorting_tail)
 	if (skip_prefix(arg, "version:", &arg) ||
 	    skip_prefix(arg, "v:", &arg))
 		s->version = 1;
-	len = strlen(arg);
-	s->atom = parse_ref_filter_atom(arg, arg+len);
+	s->atom = parse_ref_filter_atom_from_string(arg);
 }
 
 int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset)
diff --git a/ref-filter.h b/ref-filter.h
index 49466a17d..1250537cf 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -94,6 +94,10 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 void ref_array_clear(struct ref_array *array);
 /*  Parse format string and sort specifiers */
 int parse_ref_filter_atom(const char *atom, const char *ep);
+static inline int parse_ref_filter_atom_from_string(const char *atom)
+{
+	return parse_ref_filter_atom(atom, atom+strlen(atom));
+}
 /*  Used to verify if the given format is correct and to parse out the used atoms */
 int verify_ref_format(const char *format);
 /*  Sort the given ref_array as per the ref_sorting provided */
-- 
2.11.0.78.g5a2d011

