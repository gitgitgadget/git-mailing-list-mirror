Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 809F320A10
	for <e@80x24.org>; Sun,  1 Oct 2017 16:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751372AbdJAQTI (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 12:19:08 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:43430 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751345AbdJAQTF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 12:19:05 -0400
Received: by mail-pf0-f175.google.com with SMTP id y29so1856233pff.0
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 09:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=trSAXO7gghPjIKYxO2zJmdyMP4tBti/smmXjF+TE47k=;
        b=TsNNn56OJtB9WVNKTgEaOLeD5664yGKPc++gaBKzawhQA9lDTnLGrCZZzHJl8v/3+7
         ri8q33ask7xbsPWdDE2FrCLO15zXvUNYfA3By18WafH2EnTSNzCoA+gnuZPVfnzKLnQs
         o17m7hjKqSDnWyWyLny7BZ4dRERU0qxFDVkJOgOZtz4mYNevWeMYd6l81vkdl7oaem1g
         +hoQF+4tTvJzv0BjjUqn8dQvmN5CEw6F3QaCEIxIzl8kQS6gNGGoz8Hs0L7XenA6Uwti
         OAiTMbXigU6Q9Gyboe3xdZCQn5Z/fUUpM2/OJcYwAmYsJUGidE8lT8z26sCLFCJr/usf
         cvAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=trSAXO7gghPjIKYxO2zJmdyMP4tBti/smmXjF+TE47k=;
        b=KaC80jvUdGlovugJy8RkrPxibWMtu5rk0Nw4y3g06ERtLJvoEXIgHh2ollhgdBMjq2
         SgHopLSnA8qu55UKEAgPHI4roV0yUELTp/oKnQJ2hiJWFH3JasPBlBor52Qq65h52eZA
         wEdMzXlWpw6wDJFLoKnsKt4Kx+C85LIMsRSMrjRmtI7WBJ+R6u9aH4WtOsKYbu6NRoLQ
         cZMiQuCcBLzb/7wZpRhvutK2vaStVJ+TBg0/b6xQM5nzL0G0PLxyoBEcdpGRL1vAlF1J
         0iuKrqr6lRuAVNfIuqu7nRZbLBaRFr+Ay/2DJUHkTfcOH+KoB3YzsEdnV4w3VISyVjhe
         GOdA==
X-Gm-Message-State: AHPjjUjtgzVfSpDPW4YCvK2c6E41SDhLo73qVVLUMgF+bUYD6fyero5c
        GTwMAy48Ru/lW5BFu3pfFSVPIiQpgig=
X-Google-Smtp-Source: AOwi7QA3nSLFSHLAessIZaFlaHascaVZeKflqL1bqCGN201pSvTsnLtyxceORqeqZFJmE9dSTiIzlA==
X-Received: by 10.99.157.74 with SMTP id i71mr10703478pgd.238.1506874744229;
        Sun, 01 Oct 2017 09:19:04 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id l25sm13882002pfj.141.2017.10.01.09.19.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Oct 2017 09:19:03 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v4 5/6] ref-filter.c: use trailer_opts to format trailers
Date:   Sun,  1 Oct 2017 09:18:51 -0700
Message-Id: <20171001161852.84571-5-me@ttaylorr.com>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
In-Reply-To: <20171001161852.84571-1-me@ttaylorr.com>
References: <20171001161725.GA66172@D-10-157-251-166.dhcp4.washington.edu>
 <20171001161852.84571-1-me@ttaylorr.com>
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
index 39431908d..e4ce9c550 100755
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
+  test_must_fail git for-each-ref --format="%(trailers:unsupported)" 2>actual &&
+  test_cmp expect actual
+'
+
 test_expect_success 'basic atom: head contents:trailers' '
 	git for-each-ref --format="%(contents:trailers)" refs/heads/master >actual &&
 	sanitize_pgp <actual >actual.clean &&
-- 
2.14.1.145.gb3622a4ee

