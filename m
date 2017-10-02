Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8092220A10
	for <e@80x24.org>; Mon,  2 Oct 2017 00:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751604AbdJBAdU (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 20:33:20 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:46216 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751641AbdJBAdT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 20:33:19 -0400
Received: by mail-pg0-f48.google.com with SMTP id v3so2186898pgv.3
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 17:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0YheSUvqsyXheOF8SAc2tFSce4ImKICVcCXRifT19HY=;
        b=SW0JBnGW9vkvuOsUDh47oakNJOlDTD8FVMNJ+T9IQofX9wU0PXbJ0qqKXl+N9Qo3yH
         zwMixKocEjTFMMcNBskTRq09K+udKrUSvDPgObyFduuH4BRUBDnHOW1yrcVznFoT/iAT
         kni+l+GVpvhucd+Q2S/iGQ3LJiToehmbzBtIQ/WPbz8OhnN55EUhjuCUFjjTYlyCexDB
         CT8M/bp9B8fBAidBowVsuw9tEvnrgTwB3dpO9UIDI9j1k+Th6CSIkkiI0jpKXkUyOWXj
         lPwMQGCJiQJYMPizqGboHsEdFJKRxpJQ/ON8opRHgY+ZKx1JYyzBXVZPVTl3BsUGr1Ig
         2Ghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0YheSUvqsyXheOF8SAc2tFSce4ImKICVcCXRifT19HY=;
        b=pc3vhVteOsIAx5RvviPEEbVJj/YR/pX4WwgZ2hhwuC/GQ12VwWPxgbH/ha5PgLLvIJ
         UJmvTn1N1RP9se2QDi1JJwYDMGjmrvlXQ/hX7qWnnJNJ3pe6YlqB6XMNi7TP0G6QMeYH
         LIzNTi0LQaLJ7F2v8Wts1TlOhlpZmL4OEXLIiPlBjiWb49+e2eqL7C3P13yAF3vtyHjX
         AApt+5stuI2vd/RWbTgSdCFH0SSca0x5UGqZsjFpGXL32bvIikSHyyptNVj+4YBslhFN
         ddv+izoY5wCWbxnGrNe9KktS0cRAnEXQxdJZb1uwTUbmuuTYMAszQOQhtw8Rs1ovARjC
         CE5g==
X-Gm-Message-State: AHPjjUgrvaqNKazqryj4zbGE1esOmIHpDSIR2za/oWw8ThvF/SluSLBW
        60C07/TiumRtPHBxDTuAMMCFsN6uoMY=
X-Google-Smtp-Source: AOwi7QAzmea5PL5bZF/mgd47mLtm3KQFFXxF/kNmjR0h7/5ETCKRS4F5HLmhbv0JBGGQ2PeWGNP/rw==
X-Received: by 10.98.82.71 with SMTP id g68mr13083641pfb.125.1506904398125;
        Sun, 01 Oct 2017 17:33:18 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id b66sm14814394pfe.165.2017.10.01.17.33.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Oct 2017 17:33:16 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v5 5/6] ref-filter.c: use trailer_opts to format trailers
Date:   Sun,  1 Oct 2017 17:33:03 -0700
Message-Id: <20171002003304.77514-5-me@ttaylorr.com>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
In-Reply-To: <20171002003304.77514-1-me@ttaylorr.com>
References: <20171002003116.GA69902@D-10-157-251-166.dhcp4.washington.edu>
 <20171002003304.77514-1-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fill trailer_opts with "unfold" and "only" to match the sub-arguments
given to the "%(trailers)" atom. Then, let's use the filled trailer_opts
instance with 'format_trailers_from_commit' in order to format trailers
in the desired manner.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-for-each-ref.txt |  5 ++++-
 ref-filter.c                       | 32 +++++++++++++++++++++---------
 t/t6300-for-each-ref.sh            | 40 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 1279b9733..4a2c851e6 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -218,7 +218,10 @@ blank line.  The optional GPG signature is `contents:signature`.  The
 first `N` lines of the message is obtained using `contents:lines=N`.
 Additionally, the trailers as interpreted by linkgit:git-interpret-trailers[1]
 are obtained as `trailers` (or by using the historical alias
-`contents:trailers`).
+`contents:trailers`).  Non-trailer lines from the trailer block can be omitted
+with `trailers:only`. Whitespace-continuations can be removed from trailers so
+that each trailer appears on a line by itself with its full content with
+`trailers:unfold`. Both can be used together as `trailers:unfold,only`.
 
 For sorting purposes, fields with numeric values sort in numeric order
 (`objectsize`, `authordate`, `committerdate`, `creatordate`, `taggerdate`).
diff --git a/ref-filter.c b/ref-filter.c
index bc591f4f3..43ed10a5e 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -82,6 +82,7 @@ static struct used_atom {
 		} remote_ref;
 		struct {
 			enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB, C_TRAILERS } option;
+			struct process_trailer_options trailer_opts;
 			unsigned int nlines;
 		} contents;
 		struct {
@@ -182,9 +183,23 @@ static void subject_atom_parser(const struct ref_format *format, struct used_ato
 
 static void trailers_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *arg)
 {
-	if (arg)
-		die(_("%%(trailers) does not take arguments"));
+	struct string_list params = STRING_LIST_INIT_DUP;
+	int i;
+
+	if (arg) {
+		string_list_split(&params, arg, ',', -1);
+		for (i = 0; i < params.nr; i++) {
+			const char *s = params.items[i].string;
+			if (!strcmp(s, "unfold"))
+				atom->u.contents.trailer_opts.unfold = 1;
+			else if (!strcmp(s, "only"))
+				atom->u.contents.trailer_opts.only_trailers = 1;
+			else
+				die(_("unknown %%(trailers) argument: %s"), s);
+		}
+	}
 	atom->u.contents.option = C_TRAILERS;
+	string_list_clear(&params, 0);
 }
 
 static void contents_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *arg)
@@ -1042,7 +1057,7 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 			name++;
 		if (strcmp(name, "subject") &&
 		    strcmp(name, "body") &&
-		    strcmp(name, "trailers") &&
+		    !starts_with(name, "trailers") &&
 		    !starts_with(name, "contents"))
 			continue;
 		if (!subpos)
@@ -1067,13 +1082,12 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 			append_lines(&s, subpos, contents_end - subpos, atom->u.contents.nlines);
 			v->s = strbuf_detach(&s, NULL);
 		} else if (atom->u.contents.option == C_TRAILERS) {
-			struct trailer_info info;
+			struct strbuf s = STRBUF_INIT;
 
-			/* Search for trailer info */
-			trailer_info_get(&info, subpos);
-			v->s = xmemdupz(info.trailer_start,
-					info.trailer_end - info.trailer_start);
-			trailer_info_release(&info);
+			/* Format the trailer info according to the trailer_opts given */
+			format_trailers_from_commit(&s, subpos, &atom->u.contents.trailer_opts);
+
+			v->s = strbuf_detach(&s, NULL);
 		} else if (atom->u.contents.option == C_BARE)
 			v->s = xstrdup(subpos);
 	}
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 39431908d..54e52d4e9 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -610,6 +610,9 @@ Acked-by: A U Thor
   <author@example.com>
 EOF
 
+unfold () {
+	perl -0pe 's/\n\s+/ /g'
+}
 
 test_expect_success 'set up trailers for next test' '
 	echo "Some contents" > two &&
@@ -623,6 +626,43 @@ test_expect_success 'set up trailers for next test' '
 	EOF
 '
 
+test_expect_success '%(trailers:unfold) unfolds trailers' '
+	git for-each-ref --format="%(trailers:unfold)" refs/heads/master >actual &&
+	{
+		unfold <trailers
+		echo
+	} >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '%(trailers:only) shows only "key: value" trailers' '
+	git for-each-ref --format="%(trailers:only)" refs/heads/master >actual &&
+	{
+		grep -v patch.description <trailers &&
+		echo
+	} >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '%(trailers:only) and %(trailers:unfold) work together' '
+	git for-each-ref --format="%(trailers:only,unfold)" refs/heads/master >actual &&
+	git for-each-ref --format="%(trailers:unfold,only)" refs/heads/master >reverse &&
+	test_cmp actual reverse &&
+	{
+		grep -v patch.description <trailers | unfold &&
+		echo
+	} >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '%(trailers) rejects unknown trailers arguments' '
+	cat >expect <<-EOF &&
+	fatal: unknown %(trailers) argument: unsupported
+	EOF
+	test_must_fail git for-each-ref --format="%(trailers:unsupported)" 2>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'basic atom: head contents:trailers' '
 	git for-each-ref --format="%(contents:trailers)" refs/heads/master >actual &&
 	sanitize_pgp <actual >actual.clean &&
-- 
2.14.1.145.gb3622a4ee

