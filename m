Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6760FC433F5
	for <git@archiver.kernel.org>; Sun, 12 Dec 2021 20:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbhLLUOz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Dec 2021 15:14:55 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:52976 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhLLUOl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 15:14:41 -0500
Received: by mail-wm1-f52.google.com with SMTP id o29so10633641wms.2
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 12:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h84bsVppOGNt7OQqx8GNRftBehd+gcSRst7QDu/o09w=;
        b=h2K+/vV+gtttAtTVgQ+IGjcrixFzvyytaiB5wRhnFch/C+Ep4CZJSEHcdGOiOAED70
         q3sAyR/mHGpyKMlzBfHzb7v/lWtrvIdvoaqLLg+GVPw1zCnsYflQ8GbEHu1C7JyIRS+3
         o88HU9fDFVuwWHTIL0GvYmfhVCXNOewQZPLtSTFwll+HacR7cH7oEjqPTEvSC5K6otUw
         /TklYv4jCy1o7o1b7jjA9L3qsWxRNKzV12AaF4S6lF9LT7pRP2JiIXx1dvww9a2RWF9x
         QfJFrcCF1Pm+9TwBF2OylfYaautAOEphBLQ7L6Q6Kr010DPnvXq9I3OZPXTJ9kOfF3n3
         LrgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h84bsVppOGNt7OQqx8GNRftBehd+gcSRst7QDu/o09w=;
        b=yGlflF14IRSMUdgKBkALNMF6pgLjGS9whS1iRfj2hq4euFEsOWet3yF5GF55PnSGxw
         jSTRpK9J6d2XwqgDL9bI8A58IFrWXuHTroTwZk1ywCEIfb3BdXeeIY97krPf1LFmdmGO
         RhtP+Z5Gd08xz6NoXJYCuFOsq2bhpLYnhjIjxxS7ahkHlC27mnoi7Q3B0EyvjEEF++x2
         rNEqHK5aOHYWei3dLIxhWdhXVl+Dv57sisPCmn1rq/GPauGv3dI05gsmT2g2MxmVubU9
         yLYYdoz5bcOa4RjNCkE8mAdwFYQkZdO73430Od7BBCdbj97HTvugcQCypdb3EO2BY4ET
         XKVw==
X-Gm-Message-State: AOAM532Tb7oe9wBMGMvcIfBF2QfuuWjFrHcUSSHV36lv5ufcZJ0kJjr+
        +8nnqpp7g3PFASbppK4OHi6beCwEEqPeAg==
X-Google-Smtp-Source: ABdhPJx7C+K/tXi4tQ+XFBZcYGKJTgcx9ES/zKPn9MFZEnvMBPJtVpGvX8BtO9jrZp7ALm0GrBnI1w==
X-Received: by 2002:a05:600c:21cd:: with SMTP id x13mr33045737wmj.52.1639340020410;
        Sun, 12 Dec 2021 12:13:40 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay21sm4824336wmb.7.2021.12.12.12.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 12:13:39 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/13] tests: don't depend on template-created .git/branches
Date:   Sun, 12 Dec 2021 21:13:18 +0100
Message-Id: <patch-08.13-0c9b953dd43-20211212T201308Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1020.gb1392dd1877
In-Reply-To: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in c8a58ac5a52 (Revert "Don't create the $GIT_DIR/branches
directory on init", 2009-10-31) there was an attempt long ago in
0cc5691a8b0 (Don't create the $GIT_DIR/branches directory on init,
2009-10-30) to get rid of the legacy "branches" directory.

We should probably get rid of its creation by removing the
"templates/branches--" file, but whatever we do with that we don't
need to be creating it in the templates that drive our own tests.

By removing this dependency it'll be more obvious what tests depend on
the existence of ".git/branches", and we can remove the first of the
three special-cases added to copy_template() in a preceding commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/init-db.c     | 1 -
 t/t5505-remote.sh     | 2 ++
 t/t5516-fetch-push.sh | 3 +++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 8dddb47bdc4..3700a6b854e 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -193,7 +193,6 @@ static void copy_templates(int no_template, const char *template_dir,
 	len = path.len;
 
 	lazy_mkdir_strbuf_or_die_setlen(&path, len, "hooks");
-	lazy_mkdir_strbuf_or_die_setlen(&path, len, "branches");
 
 	strbuf_release(&path);
 }
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index e6e3c8f552c..3bd8ec05802 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -929,6 +929,7 @@ test_expect_success 'migrate a remote from named file in $GIT_DIR/branches' '
 	(
 		cd six &&
 		git remote rm origin &&
+		mkdir .git/branches &&
 		echo "$origin_url#main" >.git/branches/origin &&
 		git remote rename origin origin &&
 		test_path_is_missing .git/branches/origin &&
@@ -943,6 +944,7 @@ test_expect_success 'migrate a remote from named file in $GIT_DIR/branches (2)'
 	(
 		cd seven &&
 		git remote rm origin &&
+		mkdir .git/branches &&
 		echo "quux#foom" > .git/branches/origin &&
 		git remote rename origin origin &&
 		test_path_is_missing .git/branches/origin &&
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 7831a38ddef..eea191d042f 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -921,6 +921,7 @@ test_expect_success 'fetch with branches' '
 	mk_empty testrepo &&
 	git branch second $the_first_commit &&
 	git checkout second &&
+	mkdir testrepo/.git/branches &&
 	echo ".." > testrepo/.git/branches/branch1 &&
 	(
 		cd testrepo &&
@@ -934,6 +935,7 @@ test_expect_success 'fetch with branches' '
 
 test_expect_success 'fetch with branches containing #' '
 	mk_empty testrepo &&
+	mkdir testrepo/.git/branches &&
 	echo "..#second" > testrepo/.git/branches/branch2 &&
 	(
 		cd testrepo &&
@@ -948,6 +950,7 @@ test_expect_success 'fetch with branches containing #' '
 test_expect_success 'push with branches' '
 	mk_empty testrepo &&
 	git checkout second &&
+	mkdir .git/branches &&
 	echo "testrepo" > .git/branches/branch1 &&
 	git push branch1 &&
 	(
-- 
2.34.1.1020.gb1392dd1877

