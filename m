Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B650B2047F
	for <e@80x24.org>; Sat, 30 Sep 2017 18:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751518AbdI3Sqz (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Sep 2017 14:46:55 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:49534 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751320AbdI3Sqt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2017 14:46:49 -0400
Received: by mail-pg0-f41.google.com with SMTP id v13so1249487pgq.6
        for <git@vger.kernel.org>; Sat, 30 Sep 2017 11:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x+XxdprZFD+sVIx/eLpA3iXjpwjtLhfNJEtDPo09J2Q=;
        b=Ip94N29Us8R6I/nxLHlFbqWGgOZaMxw/CKHmO5Hg/yf7oAq4HUDHAjqyT9L3KrL31A
         luvs3f5umyD2HjOVBtEokwGXANcmpK/8ItOTcSpMZO2LCVbwtnNa/jRJMv8/mUmMCB3m
         C3Mrp3rxy1ASm1AFR9xRkvaEsyYZaJK0WmFEpSrtUrV/KTZxEOLAhGGDQRykN3G9PUlN
         B45LET1v2wAuuDoYGl4t/LFHN3I1G7YvLVqeb5ESuLzEdfSXzTj4usUCVadlEOMzycMC
         706ffqlLonAymI2gSEXTm0epsEpVAoMHAiK08n+rv1bpEs159bdWMo6zHJgJmcP6Dawh
         As5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x+XxdprZFD+sVIx/eLpA3iXjpwjtLhfNJEtDPo09J2Q=;
        b=ClJV6IaovopxrUlEMndVuoXJffpfXoXjFCc32DbubpefL0FWY/c/GBuww1oo+8hLTF
         Cz4orSUxjzXRJj8q7u827dTbottmsh/lpX/1HfT5UHmV/bhe/eJ3f64ilUv5xpC7p+o8
         e1G+oggRqLKBiiZSJRvw53MBEyDtmzXrEIUBoCER52DTdQbOqF5CyQR0fVVsSwRYd9zx
         7v9xFhQje4o54kpe89zuXK0sMQ+HOFk5o3t0F8TXVUYK+Hl3k6e9hrcHR7s+1+iv8tFT
         eUSO2ZpJMz3mIvXiyhAKTdq+pS21NKuIUBknIfhvVuhwJIiQJs0tv35+dWE5omvKIO1Y
         v+gQ==
X-Gm-Message-State: AHPjjUhTzvUcRmCgrG2Qxj6XipIxq2tzbPSL5UeLOk/fkj0im0bGWNFv
        7ts/A9S+AZSpUtIE1Cy5g/ryArOow68=
X-Google-Smtp-Source: AOwi7QDmYOu17k4dvo5OxnPz4FYD50QcDExqts4ciFAzAsDRK+fH64kVqZa67tce2VUdcJnVeGNYgw==
X-Received: by 10.84.191.131 with SMTP id a3mr10260599pld.255.1506797208534;
        Sat, 30 Sep 2017 11:46:48 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id y7sm11092748pfy.35.2017.09.30.11.46.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Sep 2017 11:46:47 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 6/6] ref-filter.c: parse trailers arguments with %(contents) atom
Date:   Sat, 30 Sep 2017 11:46:29 -0700
Message-Id: <20170930184629.75900-6-me@ttaylorr.com>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
In-Reply-To: <20170930184629.75900-1-me@ttaylorr.com>
References: <20170930184151.GB43975@D-10-157-251-166.dhcp4.washington.edu>
 <20170930184629.75900-1-me@ttaylorr.com>
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
index 8573acbed..f5bde79f3 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -207,8 +207,10 @@ static void contents_atom_parser(struct used_atom *atom, const char *arg)
 		atom->u.contents.option = C_SIG;
 	else if (!strcmp(arg, "subject"))
 		atom->u.contents.option = C_SUB;
-	else if (!strcmp(arg, "trailers"))
-		atom->u.contents.option = C_TRAILERS;
+	else if (skip_prefix(arg, "trailers", &arg)) {
+		skip_prefix(arg, ":", &arg);
+		trailers_atom_parser(atom, arg);
+	}
 	else if (skip_prefix(arg, "lines=", &arg)) {
 		atom->u.contents.option = C_LINES;
 		if (strtoul_ui(arg, 10, &atom->u.contents.nlines))
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 6538e7b90..8c960ec24 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -642,6 +642,35 @@ test_expect_success '%(trailers:only) and %(trailers:unfold) work together' '
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
@@ -650,6 +679,14 @@ test_expect_success '%(trailers) rejects unknown trailers arguments' '
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

