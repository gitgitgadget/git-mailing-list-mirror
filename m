Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95FF51F731
	for <e@80x24.org>; Thu,  1 Aug 2019 15:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732004AbfHAPx2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 11:53:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37276 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730541AbfHAPx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 11:53:26 -0400
Received: by mail-wm1-f65.google.com with SMTP id f17so63638860wme.2
        for <git@vger.kernel.org>; Thu, 01 Aug 2019 08:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6XZWqNe23BNdaGrEkB80ojuU5o+2UTNTM6wOSPJMGVc=;
        b=QF3LNSz74TtHtJwbvg0F3nQar2l2F4AB2H+TUe1tn+FrEZUM8N7F4RJF91YdxSitK2
         M+RiF8+0qS/bpd4Jb+5J0PGiUJYSlEh/qPVfNF30evN92TgdqdSm9dH3mPS/OgHQMxil
         Zdi7AXcx0b6GBREcL1TVdWxDj/5EdcLl2rQzQZIATAxpvnlvmHPTE/wNDo8WqmfNo6WT
         Wr+VNpmMndeV4+GOAKQIVBS7k0QDvqN52qaIFw4yCjIApawgdvjIUMEeqqmfACYvIz6w
         xazbPfRZbA0ZBegXVz+Om73C432lxclQbPRxna7guxjS14S5r/BPfX6RFY9CkbaY3zFB
         /eEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6XZWqNe23BNdaGrEkB80ojuU5o+2UTNTM6wOSPJMGVc=;
        b=DmgFOgMFYoxnsVlQKb92ZBTj9n9ira9eRqX+yU3Etj1TBjIi2zi185TSzweCBOnIxO
         JBOxX1I1k/091M941fPu37d7BOvT4pjxn2zmGFV36EuwTiiVEX0/WkNl71R+ovJetwYy
         JvNTzKAlEh03d97crfH3lMrnf2UQGRnP05AgMj2pv3UwA41+C1vmlbuJ0Yk3yX44Y5MG
         LdQ2oGoLVQQ41tdXjMjd95A9NN087S4/zB7xatZ+4hANG78AKw606Dkiut/MIG4wr+bW
         HbJzEqAHJW/QTwATrmthDzvOPUSIjzaCRNkCTbDf6vGKrBZIpvHCSNgtr1yKVvM/8Dyt
         d6Ow==
X-Gm-Message-State: APjAAAWQ7P8dyidm5Ph7qVA772xy97bcs+391J/BugH0aCBsox7PQHVz
        tGNiXe99iQ41j1zTT5cvioY=
X-Google-Smtp-Source: APXvYqyIrzUUkIrlfI6ewEHkQB7JqxwGdDmMg/m4ltR68ia7XxT5nAwaOkh0Wcz3bNTgtyR1YwtbrA==
X-Received: by 2002:a1c:f409:: with SMTP id z9mr46839642wma.176.1564674804775;
        Thu, 01 Aug 2019 08:53:24 -0700 (PDT)
Received: from localhost.localdomain (x4dbd0ed1.dyn.telefonica.de. [77.189.14.209])
        by smtp.gmail.com with ESMTPSA id g17sm55434473wrm.7.2019.08.01.08.53.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Aug 2019 08:53:24 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/3] t5510-fetch: run non-httpd-specific test before sourcing 'lib-httpd.sh'
Date:   Thu,  1 Aug 2019 17:53:07 +0200
Message-Id: <20190801155309.15276-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.22.0.926.g602b9a0287
In-Reply-To: <20190801155309.15276-1-szeder.dev@gmail.com>
References: <20190730214000.GT20404@szeder.dev>
 <20190801155309.15276-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

't5510-fetch.sh' sources 'lib-httpd.sh' near the end to run a
httpd-specific test, but 'lib-httpd.sh' skips all the rest of the test
script if the dependencies for running httpd tests are not fulfilled.
Alas, recently cdbd70c437 (fetch: add --[no-]show-forced-updates
argument, 2019-06-18) appended a non-httpd-specific test at the end,
and this test is then skipped as well when httpd tests can't be run.

Move this new test earlier in the test script, before 'lib-httpd.sh'
is sourced, so it will be run even when httpd tests aren't.

Also add a comment at the end of this test script to warn against
adding non-httpd-specific tests at the end, in the hope that it will
help prevent similar issues in the future.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t5510-fetch.sh | 47 +++++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index f2481de577..34b486f1a4 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -902,6 +902,29 @@ test_expect_success C_LOCALE_OUTPUT 'fetch compact output' '
 	test_cmp expect actual
 '
 
+test_expect_success '--no-show-forced-updates' '
+	mkdir forced-updates &&
+	(
+		cd forced-updates &&
+		git init &&
+		test_commit 1 &&
+		test_commit 2
+	) &&
+	git clone forced-updates forced-update-clone &&
+	git clone forced-updates no-forced-update-clone &&
+	git -C forced-updates reset --hard HEAD~1 &&
+	(
+		cd forced-update-clone &&
+		git fetch --show-forced-updates origin 2>output &&
+		test_i18ngrep "(forced update)" output
+	) &&
+	(
+		cd no-forced-update-clone &&
+		git fetch --no-show-forced-updates origin 2>output &&
+		test_i18ngrep ! "(forced update)" output
+	)
+'
+
 setup_negotiation_tip () {
 	SERVER="$1"
 	URL="$2"
@@ -978,27 +1001,7 @@ test_expect_success '--negotiation-tip limits "have" lines sent with HTTP protoc
 	check_negotiation_tip
 '
 
-test_expect_success '--no-show-forced-updates' '
-	mkdir forced-updates &&
-	(
-		cd forced-updates &&
-		git init &&
-		test_commit 1 &&
-		test_commit 2
-	) &&
-	git clone forced-updates forced-update-clone &&
-	git clone forced-updates no-forced-update-clone &&
-	git -C forced-updates reset --hard HEAD~1 &&
-	(
-		cd forced-update-clone &&
-		git fetch --show-forced-updates origin 2>output &&
-		test_i18ngrep "(forced update)" output
-	) &&
-	(
-		cd no-forced-update-clone &&
-		git fetch --no-show-forced-updates origin 2>output &&
-		test_i18ngrep ! "(forced update)" output
-	)
-'
+# DO NOT add non-httpd-specific tests here, because the last part of this
+# test script is only executed when httpd is available and enabled.
 
 test_done
-- 
2.22.0.926.g602b9a0287

