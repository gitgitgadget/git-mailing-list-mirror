Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4E211FF34
	for <e@80x24.org>; Thu, 11 May 2017 09:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932223AbdEKJla (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 05:41:30 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34570 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932215AbdEKJl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 05:41:29 -0400
Received: by mail-wm0-f65.google.com with SMTP id d127so5643216wmf.1
        for <git@vger.kernel.org>; Thu, 11 May 2017 02:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=N3VJCJ6suqL3r4carUoJ+YJkN2EGoPzmpu9leW7hHBk=;
        b=ViZf8pbccg9K4t5tP2W25miHwKpjSObHP2odzC1ceSYllcHBPzaMOdnBwh2aZT8ZGm
         5XmhuDYpBLgZM22kgc+E/og6Ma3hGu2xsARgWgeLI3CW6ZzC6gc4WKHTf2+ePE3L5mh2
         lbD/TJ6Ib18v3V3Tmis3shqvVjH5d/q8g0a7i2VkLI3EV0EdF1V6EqFXt4KoFLa99Flx
         OrpeMiOmsanWsq9ogpxzIg1bzBr6OrmhmWs1xoXLeVVnKBsiJq2pBawAOzLygGS2KXsF
         lIBWTz1Khr0iXSMETOs73npkyV6gkH/DoE4Cr5qR67rc2W5GJwxdP/6wiEy2VYvsw+Qx
         3G0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=N3VJCJ6suqL3r4carUoJ+YJkN2EGoPzmpu9leW7hHBk=;
        b=rNNh4JHLNwpFBzVE107FQlM8XOLi9eTNF0J/mz+0iUm78Y+R6wWdijEM7viT6b6NSc
         gIH00bhXMd+vD/9OXjKalGGfTLDNQpk9z2Bj1Eu1Pt/BJy5iLxPcXf/W7pGQWHPqLfTj
         Tvpv4FYClSomVZB2r9F5bAXLX4GE/Eci7zaGAUT7++eJx3CRJ/+vlnDPGAJ46Q0DRWaF
         5sAj9ufflaiKntL6ui0df4O3RD4D4I/8GW8Am9ccRv9ql9a8yYz6iRuIy6rPSUuH4DxH
         5tBy+rHT0Au56Tylr25EcoSjZoZoQ54KVNv5fhqnlig24A/NzddNTSENHqVt4B1Kny6t
         d/Ng==
X-Gm-Message-State: AODbwcB/DDwLjZdx5thYbEQp7dP3Cw/7BZQhfbyOkurtX3VCSbI5QDst
        /kuzZJNivsNaGg==
X-Received: by 10.80.211.7 with SMTP id g7mr128611edh.0.1494495687569;
        Thu, 11 May 2017 02:41:27 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id h46sm16386ede.56.2017.05.11.02.41.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 02:41:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 2/2] perf: add test showing exponential growth in path globbing
Date:   Thu, 11 May 2017 09:41:08 +0000
Message-Id: <20170511094108.8756-3-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170511094108.8756-1-avarab@gmail.com>
References: <20170511094108.8756-1-avarab@gmail.com>
In-Reply-To: <20170511074354.11336-1-avarab@gmail.com>
References: <20170511074354.11336-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test showing that runtimes of the wildmatch() function used for
globbing in git grow exponentially in the face of some pathological
globs.

This issue affects both globs matching filenames via e.g. ls-files,
and globs matching refnames via e.g. for-each-ref.

As noted in the test description this is a test to see whether Git
suffers from the issue noted in an article Russ Cox posted today about
common bugs in various glob implementations:
https://research.swtch.com/glob

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/perf/p0100-globbing.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100755 t/perf/p0100-globbing.sh

diff --git a/t/perf/p0100-globbing.sh b/t/perf/p0100-globbing.sh
new file mode 100755
index 0000000000..dd18a9ce2b
--- /dev/null
+++ b/t/perf/p0100-globbing.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+
+test_description="Tests pathological globbing performance
+
+Shows how Git's globbing performance performs when given the sort of
+pathological patterns described in at https://research.swtch.com/glob
+"
+
+. ./perf-lib.sh
+
+test_globs_big='10 25 50 75 100'
+test_globs_small='1 2 3 4 5 6'
+
+test_perf_fresh_repo
+
+test_expect_success 'setup' '
+	for i in $(test_seq 1 100)
+	do
+		printf "a" >>refname &&
+		for j in $(test_seq 1 $i)
+		do
+			printf "a*" >>refglob.$i
+		done &&
+		echo b >>refglob.$i
+	done &&
+	test_commit test $(cat refname).t "" $(cat refname).t
+'
+
+for i in $test_globs_small
+do
+	test_perf "refglob((a*)^nb) against tag (a^100).t; n = $i" '
+		git for-each-ref "refs/tags/$(cat refglob.'$i')b"
+	'
+done
+
+for i in $test_globs_small
+do
+	test_perf "fileglob((a*)^nb) against file (a^100).t; n = $i" '
+		git ls-files "$(cat refglob.'$i')b"
+	'
+done
+
+test_done
-- 
2.11.0

