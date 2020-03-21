Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF5EC4332E
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 09:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E2A20753
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 09:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ez97GZQ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgCUJWl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 05:22:41 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38461 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728114AbgCUJWl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 05:22:41 -0400
Received: by mail-qk1-f194.google.com with SMTP id h14so9831813qke.5
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 02:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0y3tn0AzmPDQf8g6L5zFVRjlj5YTOiz548oR2xGq2JQ=;
        b=Ez97GZQ1XDR9d1n1V6pg4MGjGo4y/0cb5EflkyBlygj9eV9iTC2VO8makpY+D3pKck
         oKdvm9LbKYZY9OkgqWE+xWSlG2k65wKjmU/C1qahtcGNCo11B19VqSDHnnigb8bWBmNA
         WovFhMmzDNWr4GavFBoEhexiUwKGuanyfTFPAm4F9bR36C5YFyAb9UJJKmqcKsaPtdbK
         VRKkHFaLmzxABRVjkWaDAhDyrK3YEYWdyNa2KgG9pIzxzXU1N++4cuVFyY5Dn8ASl68h
         FWZvGezUhZLAj0ZfDL03j+El8u03t5Fqus3tkKAl1BNOjuyS0OxExHQmoPSrsj1+HWBs
         Ar/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0y3tn0AzmPDQf8g6L5zFVRjlj5YTOiz548oR2xGq2JQ=;
        b=k5bWZdbFyCQ1E2cWkVmlggQE/jHbD451J+a7t/IpgbQ+uAoHPTbIogDJmO0jGIjNBd
         V7KWlDlgsgjYm1PElLCaHGMSLoJF2AA89jPHyEBy4KlTb0ejvb1+ec6J3zuwPB/zkHCI
         6nsqktUiy7oQMEhWde+OdjJmggZJ2S5TSSeq+yIMsCBiSoXT9KUcbYvp/e65hwtx6Aoz
         YQ8NFknvtZLq7JaaP3qM0KOD0OricSfmFDCLqN8C7n950x2+xVfHHvIuOjd2AcfUQSYa
         +Qwm2y2F/Z19F8W1WHTzMgc5fbcJDAo/3S/RS2ywxl/M4nsA4ybHteUd5wjqa2hoOr0s
         2kxw==
X-Gm-Message-State: ANhLgQ3elp7MSVLwrGP7H5Ox1pNpBOmspLew/QIFQqoDVnSMC5zu+m4X
        beyeSWkckOVQmuXb+1zJftMqDVoc
X-Google-Smtp-Source: ADFU+vtX4xg1oLwLmf6gxKIR2fXnIeDkkvCWxfpDVR+4Fp9xxloTEV+iNppIbus1XpYy36tbEbI24A==
X-Received: by 2002:a05:620a:14d:: with SMTP id e13mr12493518qkn.470.1584782560651;
        Sat, 21 Mar 2020 02:22:40 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id z23sm6579890qkg.21.2020.03.21.02.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 02:22:40 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 18/19] t5520: make test_pull_autostash() accept expect_parent_num
Date:   Sat, 21 Mar 2020 05:21:37 -0400
Message-Id: <72aa56516efaf4e58c271da362ff157bcb8a9550.1584782450.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.114.g5b0ca878e0
In-Reply-To: <cover.1584782450.git.liu.denton@gmail.com>
References: <cover.1577185374.git.liu.denton@gmail.com> <cover.1584782450.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, test_pull_autostash() was hardcoded to run
`test_cmp_rev HEAD^ copy` to test that a rebase happened. However, in a
future patch, we plan on testing merging as well. Make
test_pull_autostash() accept a parent number as an argument so that, in
the future, we can test if a merge happened in addition to a rebase.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 2f86fca042..f610dc14de 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -10,11 +10,13 @@ modify () {
 }
 
 test_pull_autostash () {
+	expect_parent_num="$1" &&
+	shift &&
 	git reset --hard before-rebase &&
 	echo dirty >new_file &&
 	git add new_file &&
 	git pull "$@" . copy &&
-	test_cmp_rev HEAD^ copy &&
+	test_cmp_rev HEAD^"$expect_parent_num" copy &&
 	echo dirty >expect &&
 	test_cmp expect new_file &&
 	echo "modified again" >expect &&
@@ -369,22 +371,22 @@ test_expect_success '--rebase fails with multiple branches' '
 
 test_expect_success 'pull --rebase succeeds with dirty working directory and rebase.autostash set' '
 	test_config rebase.autostash true &&
-	test_pull_autostash --rebase
+	test_pull_autostash 1 --rebase
 '
 
 test_expect_success 'pull --rebase --autostash & rebase.autostash=true' '
 	test_config rebase.autostash true &&
-	test_pull_autostash --rebase --autostash
+	test_pull_autostash 1 --rebase --autostash
 '
 
 test_expect_success 'pull --rebase --autostash & rebase.autostash=false' '
 	test_config rebase.autostash false &&
-	test_pull_autostash --rebase --autostash
+	test_pull_autostash 1 --rebase --autostash
 '
 
 test_expect_success 'pull --rebase --autostash & rebase.autostash unset' '
 	test_unconfig rebase.autostash &&
-	test_pull_autostash --rebase --autostash
+	test_pull_autostash 1 --rebase --autostash
 '
 
 test_expect_success 'pull --rebase --no-autostash & rebase.autostash=true' '
@@ -422,7 +424,7 @@ test_expect_success 'pull.rebase' '
 
 test_expect_success 'pull --autostash & pull.rebase=true' '
 	test_config pull.rebase true &&
-	test_pull_autostash --autostash
+	test_pull_autostash 1 --autostash
 '
 
 test_expect_success 'pull --no-autostash & pull.rebase=true' '
-- 
2.25.0.114.g5b0ca878e0

