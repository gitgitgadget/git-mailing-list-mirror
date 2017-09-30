Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 815012047F
	for <e@80x24.org>; Sat, 30 Sep 2017 18:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751482AbdI3Squ (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Sep 2017 14:46:50 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:47707 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbdI3Sqr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2017 14:46:47 -0400
Received: by mail-pg0-f48.google.com with SMTP id d8so1251770pgt.4
        for <git@vger.kernel.org>; Sat, 30 Sep 2017 11:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Unw2AIaNNb9AlGC3qWtwLrjoOiQaeoAXYJ/Cf4xehXA=;
        b=iKLQE+86JClv22+tWMWYxW/TT5Xs/Ba7R3Q7FUPjMPhiq8jJE7OFni/6LaM18lH6os
         WLV0bjqxdCjLbKWUNQaiHVbIwXoXziyL9tk1u3bR5PA6x/5IvRaOhOz9buygXKhkoFpL
         eUV5nM5dLmlYauzq1yn9BFKV1sRDGAgrYtZ4weLWSVOse0agPdeE7XXDDuLufUNGZSzC
         OHa4yzOHeZtlq1wEllF9/lxI00chBElp3OhRbvp0rP5AMd+SbjdL7AYM+aBzIE2QtrBM
         +qR7og88VeB+pGxeFdqUyaDS5rSpwlxcp5GDAsHLdagR6CJNDWL2cWLC6gV3hrO0qqoS
         rm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Unw2AIaNNb9AlGC3qWtwLrjoOiQaeoAXYJ/Cf4xehXA=;
        b=pL7ykjUvfOMKEIBjet9Ay9v4QjGV6yWU9yZhtl8RvbZxBKyhpKh5MiSvpsAjOIsUzi
         hWU3A3sa9LKeKOuk+sSs0NoQ6a37eT5fc9DcbDGXNJi5dZKdOHnk0T7dn4kw+jj5Ith8
         J1GhGGspSX0lI4WYHa6XVVjMV1D6X7o1cwy7zbidlA5KSmvoNkBemGd5KaMaUHSD5cZ2
         zH12KDtBxRxLat3lnEU6S7tLUoav6QSyZJHxByFx8q+z17+A713o5RnjiI44eNL0BTkN
         CrIZdMsteGBSz5vdG9mUcJYZ3g2eLmgVUPPE6F1YaBrJjgPIMsIOtehv16zO9oPrr3I5
         4B3A==
X-Gm-Message-State: AMCzsaUo75Ofaz2/pAR44bCmtkzfslbMFkUlEfqUyvZO/oIfVna5HE9N
        IPz2cwTXbru7tFJuG95hOxCcCY6E2PU=
X-Google-Smtp-Source: AOwi7QDKiLWeamCV9t1K5vEIhkH4z4M15MQHyJBXjciqy/5VJmFstxDqoV8YGpznJa5gXiQ5jNOltQ==
X-Received: by 10.98.31.4 with SMTP id f4mr1931787pff.282.1506797206600;
        Sat, 30 Sep 2017 11:46:46 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id d13sm10301622pgn.53.2017.09.30.11.46.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Sep 2017 11:46:45 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 5/6] ref-filter.c: use trailer_opts to format trailers
Date:   Sat, 30 Sep 2017 11:46:28 -0700
Message-Id: <20170930184629.75900-5-me@ttaylorr.com>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
In-Reply-To: <20170930184629.75900-1-me@ttaylorr.com>
References: <20170930184151.GB43975@D-10-157-251-166.dhcp4.washington.edu>
 <20170930184629.75900-1-me@ttaylorr.com>
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
index b6492820b..a1d964182 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -214,7 +214,10 @@ blank line.  The optional GPG signature is `contents:signature`.  The
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
index 467c0279c..8573acbed 100644
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
@@ -177,9 +178,23 @@ static void subject_atom_parser(struct used_atom *atom, const char *arg)
 
 static void trailers_atom_parser(struct used_atom *atom, const char *arg)
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
 
 static void contents_atom_parser(struct used_atom *atom, const char *arg)
@@ -1034,7 +1049,7 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 			name++;
 		if (strcmp(name, "subject") &&
 		    strcmp(name, "body") &&
-		    strcmp(name, "trailers") &&
+		    !starts_with(name, "trailers") &&
 		    !starts_with(name, "contents"))
 			continue;
 		if (!subpos)
@@ -1059,13 +1074,12 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
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
index 2a9fcf713..6538e7b90 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -597,6 +597,9 @@ Acked-by: A U Thor
   <author@example.com>
 EOF
 
+unfold () {
+	perl -0pe 's/\n\s+/ /'
+}
 
 test_expect_success 'set up trailers for next test' '
 	echo "Some contents" > two &&
@@ -610,6 +613,43 @@ test_expect_success 'set up trailers for next test' '
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

