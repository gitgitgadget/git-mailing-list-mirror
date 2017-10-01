Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE9E220A10
	for <e@80x24.org>; Sun,  1 Oct 2017 16:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751379AbdJAQTP (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 12:19:15 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:53854 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751311AbdJAQTH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 12:19:07 -0400
Received: by mail-pg0-f41.google.com with SMTP id j70so1885116pgc.10
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 09:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ATKeWJrg2p2oRVm4S1xeZLy0HtMiahh6FkFONzFjn1M=;
        b=Ho2AzYDOe+zudKfa2j6Lr5EcUp9Y4JuRR8MXif1MOHRurU48izByNfHaF+PkzFbXfs
         jgO4TTOD3gnQ4KjMgg6xJ/b4t18bratYZqv6eWnCICoCnpfdRMb3zRG8csWc0NRttXnm
         e2FKpPucqRCavFynEB4ipBO7MUxCkAI6aMP5kedVWOP24XYM+4sesNZfgALoZK7+O01N
         je54G8sn4qXwGl7fq1oHv0kDzcxo+kBE5ST3xZO0gHLLSo+fgmw5mI6gGmuIt1AtSjGH
         f0goRk5p++ya7dloYk+iLP20wDHaenu+gV15iZJ88lCuoOFrNsQrzZ5kPRPtHneTdd+D
         fysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ATKeWJrg2p2oRVm4S1xeZLy0HtMiahh6FkFONzFjn1M=;
        b=BGTeTUVppWatZCH6oqbAnY6PQDYQcr8z4LFhUOFTC/muJ/V7jrLX2us37tZZOjCFCi
         tRmxodI2P7lBnyFvEmZ4+OrFApeQQX83vbtYJ8ZorMd3xDGN+/hdUsAFDoeVT4zX2tI9
         kGiLZw79szJRyFFGcaqRevXAOaMQC3cBoDlbV5CVkj5Ph5tfSOFqojbzuyY0GrE9C9Vu
         NEnpne/nRrloK1r21XLJMF155PInW0yvRo1pgmdgwL3H3k4y/x8rTbLmpFI0k1xsrT2P
         BaI6qKvqhZMDzvO7wSeNYjkZ1uwmvfQlJdbOWBKeD4i/0arAL29oopTMpyfOFunt5JtY
         oYzQ==
X-Gm-Message-State: AMCzsaXdk67KVUTiunb05UsQXkKoamP9ApOFxhpbKhrj1UbK3e7WVirS
        9EcYsePyXjohCBT/rAZjsJHCYlHlLI0=
X-Google-Smtp-Source: AOwi7QB/R5mhNIJNp4QmOmIEigZLwatf9pCzqPmnz+Sxpc3YsTLHbZS/Kza1+A04uaCgakXiRJ37YQ==
X-Received: by 10.99.165.73 with SMTP id r9mr3589893pgu.437.1506874746326;
        Sun, 01 Oct 2017 09:19:06 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id n76sm5316095pfk.96.2017.10.01.09.19.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Oct 2017 09:19:05 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v4 6/6] ref-filter.c: parse trailers arguments with %(contents) atom
Date:   Sun,  1 Oct 2017 09:18:52 -0700
Message-Id: <20171001161852.84571-6-me@ttaylorr.com>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
In-Reply-To: <20171001161852.84571-1-me@ttaylorr.com>
References: <20171001161725.GA66172@D-10-157-251-166.dhcp4.washington.edu>
 <20171001161852.84571-1-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The %(contents) atom takes a contents "field" as its argument. Since
"trailers" is one of those fields, extend contents_atom_parser to parse
"trailers"'s arguments when used through "%(contents)", like:

  %(contents:trailers:unfold,only)

A caveat: trailers_atom_parser expects NULL when no arguments are given
(see: `parse_ref_filter_atom`). To simulate this behavior without
teaching trailers_atom_parser to accept strings with length zero,
conditionally pass NULL to trailers_atom_parser if the arguments portion
of the argument to %(contents) is empty.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ref-filter.c            |  6 ++++--
 t/t6300-for-each-ref.sh | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 43ed10a5e..2c03c2bf5 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -212,8 +212,10 @@ static void contents_atom_parser(const struct ref_format *format, struct used_at
 		atom->u.contents.option = C_SIG;
 	else if (!strcmp(arg, "subject"))
 		atom->u.contents.option = C_SUB;
-	else if (!strcmp(arg, "trailers"))
-		atom->u.contents.option = C_TRAILERS;
+	else if (skip_prefix(arg, "trailers", &arg)) {
+		skip_prefix(arg, ":", &arg);
+		trailers_atom_parser(atom, *arg ? NULL : arg);
+	}
 	else if (skip_prefix(arg, "lines=", &arg)) {
 		atom->u.contents.option = C_LINES;
 		if (strtoul_ui(arg, 10, &atom->u.contents.nlines))
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index e4ce9c550..ab95fe427 100755
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
+  test_must_fail git for-each-ref --format="%(contents:trailers:unsupported)" 2>actual &&
+  test_cmp expect actual
+'
+
 test_expect_success 'basic atom: head contents:trailers' '
 	git for-each-ref --format="%(contents:trailers)" refs/heads/master >actual &&
 	sanitize_pgp <actual >actual.clean &&
-- 
2.14.1.145.gb3622a4ee

