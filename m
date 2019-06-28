Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41CB11F461
	for <e@80x24.org>; Fri, 28 Jun 2019 09:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfF1Jfm (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 05:35:42 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44236 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfF1Jfl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 05:35:41 -0400
Received: by mail-pl1-f193.google.com with SMTP id t7so2924310plr.11
        for <git@vger.kernel.org>; Fri, 28 Jun 2019 02:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N9Q9Lyaxn7ChY0AtUsYW0seN+iI+097fx5FGr1neUv8=;
        b=n9YA3xibX6OAOeGOaPBAQGyjQrMn8j1ycfdDcLazg8V/cgRU71frlcjCU4w8ivdoCI
         yVPJNRbhh+HijKgcBKoEFm8ZG51mD0DhYlu5MQlDepXYo4vjCmQX+F38yzvFuWcHdIks
         mPvKFbNYgaP/ouAfcFTsc+ixaYdh8d9F29TyLy7lE+MK+9S1R5p2EllBuDwpzjjvCum8
         N+Eqn1aWwDexJ19QNJ3Pmnc9RIWshf0SN7jpRH9VDlMoeAY31z3WUYs0DzJdfgq6wM5m
         RCanvtArytzE7wyHbat0UwtdoRnXJ90qAEb1+5WXe6znubR7F4mKM8SHdUfvFxsL5Yht
         626A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N9Q9Lyaxn7ChY0AtUsYW0seN+iI+097fx5FGr1neUv8=;
        b=FFJKf2R/FUwGPS1CfhhG6QVV9HVpaPJU3hd8Owvt1P7+oaTH8e/BjwfXSGJCQw1Zxb
         YJNpz+KvtMtrZOd1L/RnjjRvW0135N3YEVjmGcz7zFRoODBuA7EzcWRBiT36gZGHJF72
         1QbimuCPH4jVbOIZIt1VtHNIOKHSnsFNCK2q2Did1kQXA7q/TZeCmRIJWP+06vLO1F4n
         LwKlHF7dAD5TTx8t3zJpvYHRpjtLnLyq5izmlBfd4rtrB4WKLowREPYzXlReJhRhYbLi
         H2D+YtSoZDAcLkZDEFq9f05A7N4DFldh1PNeiWrkjig/T5UHD/MfcqgKdEcA3H7FjQQB
         I9Xg==
X-Gm-Message-State: APjAAAWu+ThFk4ptbF1KHKoWHvSqIYC06cAnmeuLCbIaKTuzi0AcYVCe
        1y0NE/5m4UnvBGAfvJY7/bU=
X-Google-Smtp-Source: APXvYqxZhwQA0q9Nuq+SL4PHYvX7oIyg17O1Lj6yDglcZ0LYgI3HitD2N9tMpICap4xpIqqPjUgqQw==
X-Received: by 2002:a17:902:26c:: with SMTP id 99mr10763874plc.215.1561714540750;
        Fri, 28 Jun 2019 02:35:40 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id t70sm1107406pgc.13.2019.06.28.02.35.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 02:35:39 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 28 Jun 2019 16:35:35 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        stolee@gmail.com
Subject: [PATCH v2 7/6] t7814: do not generate same commits in different repos
Date:   Fri, 28 Jun 2019 16:35:28 +0700
Message-Id: <20190628093528.20372-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190627092852.11326-1-pclouds@gmail.com>
References: <20190627092852.11326-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

t7814 has repo tree like this

  initial-repo
    submodule
      sub

In each repo 'submodule' and 'sub', a commit is made to add the same
initial file 'a' with the same message 'add a'. If tests run fast
enough, the two commits are made in the same second, resulting
identical commits.

There is nothing wrong with that per-se. But it could make the test
flaky. Currently all submodule odbs are merged back in the main
one (because we can't, or couldn't, access separate submodule repos
otherwise). But eventually we need to access objects from the right
repo.

Because the same commit could sometimes be present in both 'submodule'
and 'sub', if there is a bug looking up objects in the wrong repo,
sometimes it will go unnoticed because it finds the needed object in the
wrong repo anyway.

Fix this by changing commit time after every commit. This makes all
commits unique. Of course there are still identical blobs in different
repos, but because we often lookup commit first, then tree and blob,
unique commits are already quite safe.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 > And I can't quite understand how t7814 sometimes passed.

 I do now. This patch makes it fail consistently for me.
 
 This patch technically has nothing to do with this series, but I'll
 try to sneak it in because it was started from there.

 t/t7814-grep-recurse-submodules.sh | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index 134a694516..a11366b4ce 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -14,12 +14,14 @@ test_expect_success 'setup directory structure and submodule' '
 	echo "(3|4)" >b/b &&
 	git add a b &&
 	git commit -m "add a and b" &&
+	test_tick &&
 	git init submodule &&
 	echo "(1|2)d(3|4)" >submodule/a &&
 	git -C submodule add a &&
 	git -C submodule commit -m "add a" &&
 	git submodule add ./submodule &&
-	git commit -m "added submodule"
+	git commit -m "added submodule" &&
+	test_tick
 '
 
 test_expect_success 'grep correctly finds patterns in a submodule' '
@@ -65,11 +67,14 @@ test_expect_success 'grep and nested submodules' '
 	echo "(1|2)d(3|4)" >submodule/sub/a &&
 	git -C submodule/sub add a &&
 	git -C submodule/sub commit -m "add a" &&
+	test_tick &&
 	git -C submodule submodule add ./sub &&
 	git -C submodule add sub &&
 	git -C submodule commit -m "added sub" &&
+	test_tick &&
 	git add submodule &&
 	git commit -m "updated submodule" &&
+	test_tick &&
 
 	cat >expect <<-\EOF &&
 	a:(1|2)d(3|4)
@@ -179,15 +184,18 @@ test_expect_success !MINGW 'grep recurse submodule colon in name' '
 	echo "(1|2)d(3|4)" >"parent/fi:le" &&
 	git -C parent add "fi:le" &&
 	git -C parent commit -m "add fi:le" &&
+	test_tick &&
 
 	git init "su:b" &&
 	test_when_finished "rm -rf su:b" &&
 	echo "(1|2)d(3|4)" >"su:b/fi:le" &&
 	git -C "su:b" add "fi:le" &&
 	git -C "su:b" commit -m "add fi:le" &&
+	test_tick &&
 
 	git -C parent submodule add "../su:b" "su:b" &&
 	git -C parent commit -m "add submodule" &&
+	test_tick &&
 
 	cat >expect <<-\EOF &&
 	fi:le:(1|2)d(3|4)
@@ -210,15 +218,18 @@ test_expect_success 'grep history with moved submoules' '
 	echo "(1|2)d(3|4)" >parent/file &&
 	git -C parent add file &&
 	git -C parent commit -m "add file" &&
+	test_tick &&
 
 	git init sub &&
 	test_when_finished "rm -rf sub" &&
 	echo "(1|2)d(3|4)" >sub/file &&
 	git -C sub add file &&
 	git -C sub commit -m "add file" &&
+	test_tick &&
 
 	git -C parent submodule add ../sub dir/sub &&
 	git -C parent commit -m "add submodule" &&
+	test_tick &&
 
 	cat >expect <<-\EOF &&
 	dir/sub/file:(1|2)d(3|4)
@@ -229,6 +240,7 @@ test_expect_success 'grep history with moved submoules' '
 
 	git -C parent mv dir/sub sub-moved &&
 	git -C parent commit -m "moved submodule" &&
+	test_tick &&
 
 	cat >expect <<-\EOF &&
 	file:(1|2)d(3|4)
@@ -251,6 +263,7 @@ test_expect_success 'grep using relative path' '
 	echo "(1|2)d(3|4)" >sub/file &&
 	git -C sub add file &&
 	git -C sub commit -m "add file" &&
+	test_tick &&
 
 	git init parent &&
 	echo "(1|2)d(3|4)" >parent/file &&
@@ -260,6 +273,7 @@ test_expect_success 'grep using relative path' '
 	git -C parent add src/file2 &&
 	git -C parent submodule add ../sub &&
 	git -C parent commit -m "add files and submodule" &&
+	test_tick &&
 
 	# From top works
 	cat >expect <<-\EOF &&
@@ -293,6 +307,7 @@ test_expect_success 'grep from a subdir' '
 	echo "(1|2)d(3|4)" >sub/file &&
 	git -C sub add file &&
 	git -C sub commit -m "add file" &&
+	test_tick &&
 
 	git init parent &&
 	mkdir parent/src &&
@@ -301,6 +316,7 @@ test_expect_success 'grep from a subdir' '
 	git -C parent submodule add ../sub src/sub &&
 	git -C parent submodule add ../sub sub &&
 	git -C parent commit -m "add files and submodules" &&
+	test_tick &&
 
 	# Verify grep from root works
 	cat >expect <<-\EOF &&
-- 
2.22.0.rc0.322.g2b0371e29a

