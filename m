Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7BED20A60
	for <e@80x24.org>; Sat, 30 Sep 2017 06:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752178AbdI3GXD (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Sep 2017 02:23:03 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:48994 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751801AbdI3GW7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2017 02:22:59 -0400
Received: by mail-pg0-f44.google.com with SMTP id v23so821046pgc.5
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 23:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aT1ZgXlkW1zX5mPVDNpDWxtdMo7gs8k5CRy+oFPjWPA=;
        b=p0iSpCgUteMvHtmdjKaFVqo+fZLdB0jLCns9iDWXIEMiBiBf464HPlU1+YYoMs4NnE
         PmdJW4ifyeUp5Uoz2X6CkqPd5FSXAPFuXjjVV9TH2+O4f9ajQS5qaxOC4tF91hxZDTfH
         R6OTCHmOYnXYvEdkEPlLwMj2sQ4zqlGgYwP5MekKOt7NfHV5dc5KeFvvIOQyzBiLL6/L
         yMXa+yoraK2fnCltMBpn7cPIlv+rdCu7MpcYVOUsGZZPMaSM7nn1CQiqMEGo+Ul9GCVO
         VVyT0ncu/mFfdNM2/nx2Zwn9f17KZThetmOjX8tza3ek60D1UvyB/yEQFgCHN2+WedZE
         WcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aT1ZgXlkW1zX5mPVDNpDWxtdMo7gs8k5CRy+oFPjWPA=;
        b=LmV69ZA3rtqUaXuEdKWbJHmw4FHwC7o26KhOVslrbzkmcUpraMhrHSWX/6WS1pXFLe
         mD/uZVDScp35Q/rmlFyn3RrX/d43nlF4TQ3Wym3UEHbPwid8lrS8W9Nod6UsqdmXkKw+
         05fQWb9HgZrZLrPKrXEv+2u0F6c+BaFwvNvhodEkq/6CQHGIQN/WIxPMaEpL9eTYHDEv
         PHkVB5tluzYJiGk4DAOFJZitbhyLn/QuwcrXSyu7l1IphnjXPzSpxMM3KugsywFN8kE9
         617a6HbXLWfn+sa/vyxGDX0jxw1D83MEwUJUx0dXAEWir54HUPFOqUAvBC4X2CpSFJVH
         VZQA==
X-Gm-Message-State: AHPjjUjZfLwr8TEji+EXmc42mjgDasj4YaY2apKcnpHqHUjvxy3ZG0Yl
        HFlDiJoZbdGLVfao2/WRKYL05+tCjuU=
X-Google-Smtp-Source: AOwi7QAKOH85dWjir+iHrGgb7V4WmMy1m3LmDkP3saNSBrWLlH0sL/xysHhVbjRrUJ/6IQbdXL7OBw==
X-Received: by 10.98.67.134 with SMTP id l6mr9957243pfi.165.1506752577173;
        Fri, 29 Sep 2017 23:22:57 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id z26sm9853297pfa.49.2017.09.29.23.22.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Sep 2017 23:22:55 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 5/5] ref-filter.c: parse trailers arguments with %(contents) atom
Date:   Fri, 29 Sep 2017 23:22:38 -0700
Message-Id: <20170930062238.87077-6-me@ttaylorr.com>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
In-Reply-To: <20170930062238.87077-1-me@ttaylorr.com>
References: <20170930062238.87077-1-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The %(contents) atom takes a contents "field" as its argument. Since "trailers"
is one of those fields, extend contents_atom_parser to parse "trailers"'s
arguments when used through "%(contents)", like:

  %(contents:trailers:unfold,only)

A caveat: trailers_atom_parser expects NULL when no arguments are given (see:
`parse_ref_filter_atom`). To simulate this behavior without teaching
trailers_atom_parser to accept strings with length zero, conditionally pass
NULL to trailers_atom_parser if the arguments portion of the argument to
%(contents) is empty.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-for-each-ref.txt |  9 +++++----
 ref-filter.c                       |  6 ++++--
 t/t6300-for-each-ref.sh            | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index b7325a25d..0aaac8af9 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -214,10 +214,11 @@ blank line.  The optional GPG signature is `contents:signature`.  The
 first `N` lines of the message is obtained using `contents:lines=N`.
 Additionally, the trailers as interpreted by linkgit:git-interpret-trailers[1]
 are obtained as 'contents:trailers'. Non-trailer lines from the trailer block
-can be omitted with 'trailers:only'. Whitespace-continuations can be removed
-from trailers so that each trailer appears on a line by itself with its full
-content with 'trailers:unfold'. Both can be used together as
-'trailers:unfold,only'.
+can be omitted with 'trailers:only', or 'contents:trailers:only'.
+Whitespace-continuations can be removed from trailers so that each trailer
+appears on a line by itself with its full content with 'trailers:unfold' or
+'contents:trailers:unfold'. Both can be used together as 'trailers:unfold,only',
+or 'contents:trailers:unfold,only'.
 
 For sorting purposes, fields with numeric values sort in numeric order
 (`objectsize`, `authordate`, `committerdate`, `creatordate`, `taggerdate`).
diff --git a/ref-filter.c b/ref-filter.c
index 8573acbed..a8d4a52bd 100644
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
+		trailers_atom_parser(atom, strlen(arg) ? arg : NULL);
+	}
 	else if (skip_prefix(arg, "lines=", &arg)) {
 		atom->u.contents.option = C_LINES;
 		if (strtoul_ui(arg, 10, &atom->u.contents.nlines))
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 2bd0c5da7..d9b71589f 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -642,6 +642,35 @@ test_expect_success '%(trailers:only) and %(trailers:unfold) work together' '
 	test_cmp expect actual
 '
 
+test_expect_success '%(contents:trailers:unfold) unfolds trailers' '
+  git for-each-ref --format="%(contents:trailers:unfold)" refs/heads/master >actual &&
+  {
+    unfold <trailers
+    echo
+  } >expect &&
+  test_cmp expect actual
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

