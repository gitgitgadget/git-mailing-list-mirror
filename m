Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C20D7202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 05:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751081AbdJBFZo (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 01:25:44 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:51140 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbdJBFZm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 01:25:42 -0400
Received: by mail-pg0-f45.google.com with SMTP id p5so2448055pgn.7
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 22:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xz6EOYw6xPjKeiQCvnUUti0eHzqquIDHhuYkO+jRPMw=;
        b=SUtWRUVES1Lm4GF+w8KW86xt/VDYETj6DUWDAWsyfnQ8nc3gh96SJr04F/B3ZNWuTC
         D0sjhPrXj88cXP8JcN40waX0SeXE8RqchI1l3i3+GjjH71LEzF2dklKT67dXbgwrgPXY
         6/k3BbttyZS1p0d5oQcoqwV5CjeDOp4xSw1SXOJhmRbPQteWa9x4YV+9f3OvG5iP3jpU
         yX72QwrqzSYkXP86Pxc9pS+7fjeWeh+FqfUgHuxHDmqsgWPaQDJl/13BGvkTTGfYPoF7
         aAR5T00VWOqobymyO62UCT2vowtNgVz+jfv0SFNsSvbh/+qHgWQwqupiufj5aIFKud6f
         rz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xz6EOYw6xPjKeiQCvnUUti0eHzqquIDHhuYkO+jRPMw=;
        b=nDKYq7FkwytDRUknXaGOwYrJcj7zFjm3Rv+3TLeAIw8hNaE01KTVkAsXAtOl4PVyiF
         HabKYJG8XnN8Ts8D3FIgvOBnxgI3ZNvaLAH97/gmV2af/sAb+CiS/8988xFfxsy+u+21
         P05SHtCOciY+R/4OiYGirqpudkV6/a5189+yLVs9RCcCGc2y5g5uJ6JTXJrb1c2k9tIP
         satNKNratDVTed7BXBFfaa1LT0+FO/SyuzrmdHTZntjhIL9olBg6+ukU/4X4xnJ3881L
         VuD7sG2xmPUN6SEA7f+QWWLuagkq9BrobQFMpu2L549uyZ0NLw8ha0Wukg/45lQdFJ4X
         oGzA==
X-Gm-Message-State: AHPjjUhPSz3JLCQ+n4Nqequ+ROXS9I5JWbzmjqQN5CFoL+/3ZDoMxbfi
        g34OVGowHtsfxsSoAUJ70V/8j0zGh5k=
X-Google-Smtp-Source: AOwi7QAg18VI21qNjWFHzC2GJ9trRY9tYmb0jMuNsU9y4gsKIxGNxTHXXuK2KtywaRniMqoumsNcuw==
X-Received: by 10.84.143.195 with SMTP id 61mr13180623plz.251.1506921941394;
        Sun, 01 Oct 2017 22:25:41 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id l85sm15292008pfg.155.2017.10.01.22.25.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Oct 2017 22:25:40 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v6 7/7] ref-filter.c: parse trailers arguments with %(contents) atom
Date:   Sun,  1 Oct 2017 22:25:24 -0700
Message-Id: <20171002052524.12627-7-me@ttaylorr.com>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
In-Reply-To: <20171002052524.12627-1-me@ttaylorr.com>
References: <20171002052326.GA10729@D-10-157-251-166.dhcp4.washington.edu>
 <20171002052524.12627-1-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The %(contents) atom takes a contents "field" as its argument. Since
"trailers" is one of those fields, extend contents_atom_parser to parse
"trailers"'s arguments when used through "%(contents)", like:

  %(contents:trailers:unfold,only)

A caveat: trailers_atom_parser expects NULL when no arguments are given
(see: `parse_ref_filter_atom`). This is because string_list_split (given
a maxsplit of -1) returns a 1-ary string_list* containing the given
string if the delimiter could not be found using `strchr`.

To simulate this behavior without teaching trailers_atom_parser to
accept strings with length zero, conditionally pass NULL to
trailers_atom_parser if the arguments portion of the argument to
%(contents) is empty.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ref-filter.c            |  7 ++++---
 t/t6300-for-each-ref.sh | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 43ed10a5e..6c26b4733 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -212,9 +212,10 @@ static void contents_atom_parser(const struct ref_format *format, struct used_at
 		atom->u.contents.option = C_SIG;
 	else if (!strcmp(arg, "subject"))
 		atom->u.contents.option = C_SUB;
-	else if (!strcmp(arg, "trailers"))
-		atom->u.contents.option = C_TRAILERS;
-	else if (skip_prefix(arg, "lines=", &arg)) {
+	else if (skip_prefix(arg, "trailers", &arg)) {
+		skip_prefix(arg, ":", &arg);
+		trailers_atom_parser(format, atom, *arg ? NULL : arg);
+	} else if (skip_prefix(arg, "lines=", &arg)) {
 		atom->u.contents.option = C_LINES;
 		if (strtoul_ui(arg, 10, &atom->u.contents.nlines))
 			die(_("positive value expected contents:lines=%s"), arg);
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 54e52d4e9..872973b95 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -655,6 +655,35 @@ test_expect_success '%(trailers:only) and %(trailers:unfold) work together' '
 	test_cmp expect actual
 '
 
+test_expect_success '%(contents:trailers:unfold) unfolds trailers' '
+	git for-each-ref --format="%(contents:trailers:unfold)" refs/heads/master >actual &&
+	{
+		unfold <trailers
+		echo
+	} >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '%(contents:trailers:only) shows only "key: value" trailers' '
+	git for-each-ref --format="%(contents:trailers:only)" refs/heads/master >actual &&
+	{
+		grep -v patch.description <trailers &&
+		echo
+	} >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '%(contents:trailers:only) and %(contents:trailers:unfold) work together' '
+	git for-each-ref --format="%(contents:trailers:only,unfold)" refs/heads/master >actual &&
+	git for-each-ref --format="%(contents:trailers:unfold,only)" refs/heads/master >reverse &&
+	test_cmp actual reverse &&
+	{
+		grep -v patch.description <trailers | unfold &&
+		echo
+	} >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success '%(trailers) rejects unknown trailers arguments' '
 	cat >expect <<-EOF &&
 	fatal: unknown %(trailers) argument: unsupported
@@ -663,6 +692,14 @@ test_expect_success '%(trailers) rejects unknown trailers arguments' '
 	test_cmp expect actual
 '
 
+test_expect_success '%(contents:trailers) rejects unknown trailers arguments' '
+	cat >expect <<-EOF &&
+	fatal: unknown %(trailers) argument: unsupported
+	EOF
+	test_must_fail git for-each-ref --format="%(contents:trailers:unsupported)" 2>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'basic atom: head contents:trailers' '
 	git for-each-ref --format="%(contents:trailers)" refs/heads/master >actual &&
 	sanitize_pgp <actual >actual.clean &&
-- 
2.14.1.145.gb3622a4ee

