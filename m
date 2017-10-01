Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44E4D20A2C
	for <e@80x24.org>; Sun,  1 Oct 2017 00:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752628AbdJAAK6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Sep 2017 20:10:58 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:51836 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752366AbdJAAK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2017 20:10:56 -0400
Received: by mail-pf0-f182.google.com with SMTP id b70so1372943pfl.8
        for <git@vger.kernel.org>; Sat, 30 Sep 2017 17:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w/gwKbMlGtGPjjQNMNrJg0n4j+5L5+j9Y3uziqYgU6g=;
        b=qpLQypaxMFrkC9W3S55B4ggQAv2BEbJ0SBrqOKpPKj6GdLgwLfLXel99W39kt5WvTX
         hAkjqtecMnMYy/7hmAM+WiU1/rqQy4HFOmz+nTONyfeiPlyHBGDXzUCM0FGhm9DBLZWb
         Ke29hcAM9gKd3ZZa4wvcHRBUaguxxl5yv/CYhmrgmrN+RA9bQJtzgkvG+qeZnTK2aILz
         0FILMP/eboCQuFvyb3dH6T5An1hKrfU21Eq4cD4c1PqgZ7Zv76kP6Ac83uLUHWXsM/pu
         +NerRcqtL0QpXYvYSteRwyMtnZlZGQC0/OoQzeZsLq6VrZRVwp22sKp9qQ2hObOHgP3O
         zZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w/gwKbMlGtGPjjQNMNrJg0n4j+5L5+j9Y3uziqYgU6g=;
        b=FjWYH/0Hhgu/ibuqTg7F+tFz3nwIbjKIqjdxtdtNf28P3I9wFpLzr0pJhF+4Aw1+U7
         cTDWPcXf+HcoeSRY/l07Ytv2kNNnbOEl6LLJaVrUK0XRe/tgpWrHISdkq7OZHSd5naqi
         n2tRZkfOzaDUehETdwDq19dbn9KNaLN3VI/bA6RqKzbxeXxZB/KRodBUk44Sb/ULt7EM
         1gDF4M2tQGSS6xa7geVtsQZo08/tkSUXrOmRa/vwxO1SJrcJb+MHi758ijstPLZMczlj
         FWeN7pZK8WbYc+fX5GKyIvohk74y8TuBq/zTyHy9KQIb6vVHUK9BesSDG/T2PBTnf2dP
         HyRA==
X-Gm-Message-State: AHPjjUglsFGS7jwglEjQ76OyTtJda7JRFrv4bvJMjf13QpKFuXqbhjoY
        uEapMB7/kazsMLLkX9MFeBhxGkmXyWI=
X-Google-Smtp-Source: AOwi7QAXtWsBZ0oxF15uRkKIYoygIAz2rDwtndR3yyc+PqJNovBzfz+mF1IsZ1FVjPcS2GJDTJSTBg==
X-Received: by 10.99.151.2 with SMTP id n2mr9494598pge.315.1506816654933;
        Sat, 30 Sep 2017 17:10:54 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id y72sm12090108pfa.129.2017.09.30.17.10.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Sep 2017 17:10:53 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 6/6] ref-filter.c: parse trailers arguments with %(contents) atom
Date:   Sat, 30 Sep 2017 17:10:37 -0700
Message-Id: <20171001001037.23361-6-me@ttaylorr.com>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
In-Reply-To: <20171001001037.23361-1-me@ttaylorr.com>
References: <20171001000647.GA20767@D-10-157-251-166.dhcp4.washington.edu>
 <20171001001037.23361-1-me@ttaylorr.com>
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
index 8573acbed..b5747e969 100644
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
+		trailers_atom_parser(atom, *arg ? NULL : arg);
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

