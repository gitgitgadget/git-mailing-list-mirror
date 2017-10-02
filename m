Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45DFB202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 05:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751067AbdJBFZm (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 01:25:42 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:47203 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbdJBFZk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 01:25:40 -0400
Received: by mail-pg0-f42.google.com with SMTP id r25so58134pgn.4
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 22:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0YheSUvqsyXheOF8SAc2tFSce4ImKICVcCXRifT19HY=;
        b=ERF+B39SanL5kdLMMMwIBNjceQZBvB20Qfn8/DIng9y4mVZlLETVtNix6joAmDCdJA
         AxCJwDqgcUrm9QNBsVkgdMkvS/4ifaxxklBKvxsTlaIvZDnq+UmOLxZgQ+KavbhVcXap
         mS4Ghh9NtLFo278ybN8RsgETSnXEdNER8j5a5Vlxe654vURcLaZa/IqYX6Poe2Pxj1rQ
         594hYO5UOUeKkq/mVDoxecNUkUH4qxE/1/Gg05DQRDPKAx/2/aGR+p96oqkbtMb1wAdz
         /2OXcq+cY5CA85hM0l4rkPqO7tZBb04winGcichHmN0wRwqEjPfecQ6MEsJArH/re+xZ
         7t3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0YheSUvqsyXheOF8SAc2tFSce4ImKICVcCXRifT19HY=;
        b=WhM1y72Vd0u26f+l8MqZ+AtnspAM7VN49FxBd9nl0A7Q/IWN4vlk4xlcSuaitCZfQl
         niyZmNYVXIQmKJLX68VRjOU7/baD6r6xub1itaCG5rrx3copj1WgknYryjO4r14qAgOT
         EtIYhM5iMRcsNDeddLWxp+wUbpMsfrVWiF7ExRfxuoXxhMF7F7cUSwk6otqgBxV2bman
         PXML25a0+PqL5/UL1NkgqrR3KbbYyVSshs4auJxzhubjUIJFfB4/H1qGu4uLebcM1HkD
         DNvmuFazcXkrXi1s815XAMMZyAAMUrCd/ko2gKrU4bQFdoEQFPqcLvxmuWau/muG0xvg
         bi2Q==
X-Gm-Message-State: AHPjjUgHpB0RULaMIpIGGQUxs+k1BthLlx+H2XgX9Rnv/eer0X7JKpD2
        Hqs/PBG2aRNwGCrDsAVH0MnN2KGxi08=
X-Google-Smtp-Source: AOwi7QCbfJckvlce3qd2V94QAxz/HJ6TDE0JqMaRcHqONZUasJLOx4Vib3wrarEUNPZhxxpho1lF8A==
X-Received: by 10.101.64.72 with SMTP id h8mr11698796pgp.110.1506921939455;
        Sun, 01 Oct 2017 22:25:39 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id d13sm14054322pgn.53.2017.10.01.22.25.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Oct 2017 22:25:38 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v6 6/7] ref-filter.c: use trailer_opts to format trailers
Date:   Sun,  1 Oct 2017 22:25:23 -0700
Message-Id: <20171002052524.12627-6-me@ttaylorr.com>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
In-Reply-To: <20171002052524.12627-1-me@ttaylorr.com>
References: <20171002052326.GA10729@D-10-157-251-166.dhcp4.washington.edu>
 <20171002052524.12627-1-me@ttaylorr.com>
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

