Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 111CB20A10
	for <e@80x24.org>; Mon,  2 Oct 2017 00:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbdJBAdY (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 20:33:24 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:51812 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751641AbdJBAdV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 20:33:21 -0400
Received: by mail-pf0-f180.google.com with SMTP id n14so243341pfh.8
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 17:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JPidrjYx10D7zrT2T5114ASefnra/3lNc3Cbszsg0vM=;
        b=yFmkrC6PTyVc1els2jvyFiXt4dv4+2ODbxa847cseWp43AWKCSnoV0Xs6ktJZpz6Lm
         7j1OvLW5MP0LXwuJAZTueGUS29DuDdDqMf2If4ZvawJt3LmcuMvRJaTRuhAes/ltivt5
         dSN9tshmkv+nU3rVsXg9/UjeqVZRC4PR4YXAXBLNc4E2cfii1uBlL0HhiolcEk16ZtUI
         WWeV4PZ4wx3oN2Q5zh5fn3KyCyZQMQ5Ztb3huzVlMw05SAaXZJXYtScgIbyWspC5DroQ
         xAA5MDxxr6/aHsIcdCWw7gV7SjDMbrEBwy2A6vrent5lwSDLXsiFc/xmRXAGyFvRojvc
         rdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JPidrjYx10D7zrT2T5114ASefnra/3lNc3Cbszsg0vM=;
        b=nRnUshbdH+pgRY7Sq5R+lCgA6XOO5Eowatwd2i3uYIXIMx5fzrSyeuAgYYIPjtuEUh
         asGyTzGHsBV897t2KD60OoSHdg6okKTsw11e8Gu1VOgh2LkFo2d/lo1Ft0RFtp8JG9yJ
         AwGGk1EAF0WB/B8QuYXoWcnSptAoQapXFp+q8DRV/ovW4qhDc7txOJKhW6JnkyZco0dX
         YperNEqEneP8AvbLRD1x6bKweW407V8KFcYpwfvo7jXW9C3J1c7KDKMoR38Qcm/ToiEl
         dEsf1pLABMq+D8coVjGWSoJhAtYVE3fZc3DVYmNeioi2pag2dty9gHSuARJurLwftZUl
         62Zw==
X-Gm-Message-State: AHPjjUgCOmcoeXSYJVgl3IRU5viVK5D2ohQgw6NZdI/rV8RbAoKNdhDH
        ehQGV+xvr8ctPb1VdiRoiKbOOsAI+Eg=
X-Google-Smtp-Source: AOwi7QDkBGajziqLhwfywoDvnMyRTOlZix95Gr5QUHU4DLJ+NIq4WQ0Z2kTrZDlf4WLo6sR98++tGA==
X-Received: by 10.98.11.19 with SMTP id t19mr13217763pfi.212.1506904400474;
        Sun, 01 Oct 2017 17:33:20 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id g16sm8808960pgn.43.2017.10.01.17.33.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Oct 2017 17:33:18 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v5 6/6] ref-filter.c: parse trailers arguments with %(contents) atom
Date:   Sun,  1 Oct 2017 17:33:04 -0700
Message-Id: <20171002003304.77514-6-me@ttaylorr.com>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
In-Reply-To: <20171002003304.77514-1-me@ttaylorr.com>
References: <20171002003116.GA69902@D-10-157-251-166.dhcp4.washington.edu>
 <20171002003304.77514-1-me@ttaylorr.com>
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
index 43ed10a5e..5b64de6ea 100644
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
+		trailers_atom_parser(atom, *arg ? NULL : arg);
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

