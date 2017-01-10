Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32D39205C9
	for <e@80x24.org>; Tue, 10 Jan 2017 08:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760656AbdAJIth (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 03:49:37 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33192 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932940AbdAJIt0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 03:49:26 -0500
Received: by mail-pf0-f196.google.com with SMTP id 127so27983127pfg.0
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 00:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NdSn2SqhYOId6z75GJhH3ZvF/VmYcBMrj8M3iux3ixY=;
        b=nQ9F8RXeu2PXwkOC+1nLakUwNW+uwmvbmf2JXN7b91D73AR5HNW1J2YBmUbQ03QFME
         Yt0yq97uDXsCCNEeTO1J0x+aUzipfapq008Kc02acPvCSxj3rmank0986baqYI+Dbtj6
         04S7b/auYMwlisyOxoiDXPqSczjDv8RYImAbGga5Qupzjfk2qHjxo5WRikn10NOYw9Zw
         497zDfxgszM5seG95N7IWCgVaoiz02O5Vhfb2zg2AZWqPiq1ygz/cA2XG6X+3xPoF/fp
         GKc+0oNWNnZPB5YZJGJJoHlN8Jbt9YFcJNxrf3q15rg06/Um6/THlHMJfuiKVoIVaGyZ
         DJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NdSn2SqhYOId6z75GJhH3ZvF/VmYcBMrj8M3iux3ixY=;
        b=VdVQqgwmQQ27UyPLf2RSP7Sb6guYKgWW5Vq73KmOanVz0NIR08xdrcyX8QC+BnHijf
         /dDf/pPHjYnEaZiXlnfYc/VzhMokIAGadpM681Eqd7+IyJ9+xvRLwnXGPdnuH/tC3zMo
         dykfd1F9IkB4MdWY9kf/A/6Z2GGacHQCvGWf4A/QVzoSopvI5BGWnrn3ni0KLMnQmkuv
         FomCzAbl0EMUiov+wIjq5+EgS9SgjDA2ZoTk7m7b/nKkbFs+xDTm55HKaRn4wW4XodKe
         Fqofh+TGlbaoOYesDgukBkP4ssNSdig4B+KCgs0NRGviRYymGvv7MSjSgjZeGzWDaKP6
         jjgg==
X-Gm-Message-State: AIkVDXJzxEhDzhrWf9kq08MBAec7P1n06y/0ZUgQZwCnZjEZGXS99dADE/GXEbgO8jIgsw==
X-Received: by 10.99.60.76 with SMTP id i12mr2730366pgn.170.1484038165373;
        Tue, 10 Jan 2017 00:49:25 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([115.110.127.198])
        by smtp.gmail.com with ESMTPSA id m12sm3411983pfg.92.2017.01.10.00.49.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 00:49:24 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com,
        Karthik Nayak <Karthik.188@gmail.com>
Subject: [PATCH v10 14/20] ref-filter: Do not abruptly die when using the 'lstrip=<N>' option
Date:   Tue, 10 Jan 2017 14:19:47 +0530
Message-Id: <20170110084953.15890-15-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170110084953.15890-1-Karthik.188@gmail.com>
References: <20170110084953.15890-1-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently when we use the 'lstrip=<N>' option, if 'N' is greater than
the number of components available in the refname, we abruptly end
program execution by calling die().

This behavior is undesired since a single refname with few components
could end program execution. To avoid this, return an empty string
whenever the value 'N' is greater than the number of components
available, instead of calling die().

Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt | 3 +--
 ref-filter.c                       | 3 +--
 t/t6300-for-each-ref.sh            | 4 ----
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index b0d94deea..04ffc3552 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -98,8 +98,7 @@ refname::
 	abbreviation mode. If `lstrip=<N>` is appended, strips `<N>`
 	slash-separated path components from the front of the refname
 	(e.g., `%(refname:lstrip=2)` turns `refs/tags/foo` into `foo`.
-	`<N>` must be a positive integer.  If a displayed ref has fewer
-	components than `<N>`, the command aborts with an error.
+	`<N>` must be a positive integer.
 
 objecttype::
 	The type of the object (`blob`, `tree`, `commit`, `tag`).
diff --git a/ref-filter.c b/ref-filter.c
index e0015c60f..76553ebc4 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1099,8 +1099,7 @@ static const char *lstrip_ref_components(const char *refname, unsigned int len)
 	while (remaining) {
 		switch (*start++) {
 		case '\0':
-			die(_("ref '%s' does not have %ud components to :lstrip"),
-			    refname, len);
+			return "";
 		case '/':
 			remaining--;
 			break;
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 5eb013ca2..d3d1a97db 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -147,10 +147,6 @@ test_expect_success 'arguments to :lstrip must be positive integers' '
 	test_must_fail git for-each-ref --format="%(refname:lstrip=foo)"
 '
 
-test_expect_success 'stripping refnames too far gives an error' '
-	test_must_fail git for-each-ref --format="%(refname:lstrip=3)"
-'
-
 test_expect_success 'Check format specifiers are ignored in naming date atoms' '
 	git for-each-ref --format="%(authordate)" refs/heads &&
 	git for-each-ref --format="%(authordate:default) %(authordate)" refs/heads &&
-- 
2.11.0

