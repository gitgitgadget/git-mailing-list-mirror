Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88EA71F461
	for <e@80x24.org>; Mon, 24 Jun 2019 18:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731903AbfFXSN3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 14:13:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43584 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731826AbfFXSN2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 14:13:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id p13so14897753wru.10
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 11:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BGcojx7+3HUj12ltHR1P2b7XaEPWcyBj+x8DgkICdzI=;
        b=J5iLihZZUkeYGJtPNNKTM4OuiQkik3KGqTiIYSLgKiOtkGaodoDD4+no0flaNKw+ry
         H6DNu7FDPIy8iG8AkCMPNSP4cYLOQ8uzQQl0klsuP995VCR2on65XKKAQ/cnKjb71bhg
         a4zsaiRCZLix224nLgJgy9eNQhrrUs4txzdrd/kHwVUZNaw4mi6vbrF6HFi035x6FbKR
         uQoD8tmFaxT8RMSsftu5DrEgSrdyxCuvVni69+dy+zS3SgbqzJePEgYIzKqq4zxB4MDg
         EDbAeNgGbMFhCosVRaj4pbLl4WJvpoSyWE+97DEsWNug2Zy3OdX+Se6PswFtgrQLzr7A
         atGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BGcojx7+3HUj12ltHR1P2b7XaEPWcyBj+x8DgkICdzI=;
        b=J4/lPFfCIJ6HX7PiMiYoZygSutQ+m1JJhffzL3Hc5PIC74jRlLdRtbckg+FyXAWuiN
         s4Qx4AwZ3q0A+vYENfNI8KLxB+Fzp8/qt8nCiPySGha10yVEHoX6uoFRw5ApAPkGmZwl
         vNk3l/riTFhINz9reGJuIJkFAoj27Zto3TEyHQyU2MuLQPJbvp4i8UI7dpaq6di39Psv
         G6feCf+u+Q9FpaVAhesY7LreRZ6GEh2vkLSp/Zk5/Pc3/UolDG/KWVJ3c9xBI83cVs+C
         C+EZGjZADn5MvqdZ5xiJLT9EZ3I70jOWH8bG9MEmNNq40vkaZci0ffaYELg6OOM0J+gs
         3+IQ==
X-Gm-Message-State: APjAAAXEun2+nbiXbmnOeOuidZPKi8fmBIGWaJ4dGasOVB5ibHahle9w
        gF8sdmW2xy8quBcVTxG534TMnibs
X-Google-Smtp-Source: APXvYqxH2EDYvr5nqhnT0asHr+///s2GodiOCV905I7Jg/kmMJAoHWeDfq7CCHkWuEWVmYvlSNG7nw==
X-Received: by 2002:adf:f246:: with SMTP id b6mr52559305wrp.92.1561400007193;
        Mon, 24 Jun 2019 11:13:27 -0700 (PDT)
Received: from localhost.localdomain (x4db9a89d.dyn.telefonica.de. [77.185.168.157])
        by smtp.gmail.com with ESMTPSA id v65sm401349wme.31.2019.06.24.11.13.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Jun 2019 11:13:26 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 2/5] t3404: make the 'rebase.missingCommitsCheck=ignore' test more focused
Date:   Mon, 24 Jun 2019 20:13:15 +0200
Message-Id: <20190624181318.17388-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.22.0.589.g5bd7971b91
In-Reply-To: <20190624181318.17388-1-szeder.dev@gmail.com>
References: <20190611130320.18499-1-szeder.dev@gmail.com>
 <20190624181318.17388-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test 'rebase -i respects rebase.missingCommitsCheck = warn' is
mainly interested in the warning about the dropped commits, but it
checks the whole output of 'git rebase', including progress lines and
what not that are not at all relevant to 'rebase.missingCommitsCheck',
but make it necessary to update this test whenever e.g. the way we
show progress is updated (as it will happen in one of the later
patches of this series).

Modify the test to verify only the first four lines of 'git rebase's
output that contain all the important lines, notably the line
containing the "Warning:" itself and the oneline log of the dropped
commit.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t3404-rebase-interactive.sh | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 9146f9d47b..0b8267c97c 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1299,32 +1299,19 @@ test_expect_success 'rebase -i respects rebase.missingCommitsCheck = ignore' '
 		actual
 '
 
-cr_to_nl () {
-	tr '\015' '\012'
-}
-
 test_expect_success 'rebase -i respects rebase.missingCommitsCheck = warn' '
 	cat >expect <<-EOF &&
 	Warning: some commits may have been dropped accidentally.
 	Dropped commits (newer to older):
 	 - $(git rev-list --pretty=oneline --abbrev-commit -1 master)
 	To avoid this message, use "drop" to explicitly remove a commit.
-
-	Use '\''git config rebase.missingCommitsCheck'\'' to change the level of warnings.
-	The possible behaviours are: ignore, warn, error.
-
-	Rebasing (1/4)
-	Rebasing (2/4)
-	Rebasing (3/4)
-	Rebasing (4/4)
-	Successfully rebased and updated refs/heads/missing-commit.
 	EOF
 	test_config rebase.missingCommitsCheck warn &&
 	rebase_setup_and_clean missing-commit &&
 	set_fake_editor &&
 	FAKE_LINES="1 2 3 4" \
 		git rebase -i --root 2>actual.2 &&
-	cr_to_nl <actual.2 >actual &&
+	head -n4 actual.2 >actual &&
 	test_i18ncmp expect actual &&
 	test D = $(git cat-file commit HEAD | sed -ne \$p)
 '
-- 
2.22.0.589.g5bd7971b91

