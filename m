Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E095B1F6BD
	for <e@80x24.org>; Thu,  2 Feb 2017 08:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751114AbdBBIum (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 03:50:42 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34819 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751108AbdBBIuk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 03:50:40 -0500
Received: by mail-pf0-f195.google.com with SMTP id f144so1017223pfa.2
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 00:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J9zdWBUpQSc5MtiYoM/sJTjWh0LLXKp9nWezyxa7PiY=;
        b=nGX2y7Q8xuU3MqFPuKRLtjj5OIcaw3QCzns2lr4eA5GW7nn8UhxavicCUZu1yh5K06
         iZXJa2AouiYrD21/+5PigkGxtM8w8PO/1WgK/rbDOGYl1GMCG0M9zmHtMTZtLO4oTqTX
         8ZFmJvKwtIBlzcHhkQFbliCIOn8SGJ7EtUPF6rwB9WA/Ctd0ZOhi4wInZsVbKPedOMSj
         MN5KAXX/32x8gkTwwNbGlV7RkgqNw4lER8ipQiCyqm/vSShSJj6QtZrN350FjOwLKU/P
         4wrIBGTwjHPnrYI4qWDccMrhVxHWk/3R+9qmR1Lr/AES9e43mmqf6ebdSvXTs3Cv8Dih
         jbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J9zdWBUpQSc5MtiYoM/sJTjWh0LLXKp9nWezyxa7PiY=;
        b=f8qrKnLyPlIv5DNfQvqFxO1QMmM5m/VZdZksbeuxhHR+8bW4E74tisoNZJx/TMVWQT
         keM3UMsnkuP4i4oWWt9UZa86199Xq0zCaFuu8M71/F0P6dl68gwY2BhulgNLspP20bO0
         spILHXkBbNvRGEbv/+DGMLeC4WriMl5zg026HsXD2Kl5zPIVPyHnt96nxdszv3OICtqG
         0VdiIAp+DT8BlqwsKuGKvdvJczhW8lqiDjGfPadTkZsLNlVZ/Ot40uZwEAp9uMXLahR5
         a0ENq/zqvFMt3VRqc1D3H8QxIVFcr34a2C8gq0XbiEACToN6NJTrVB+SwCKV8yT7EskQ
         0O9g==
X-Gm-Message-State: AIkVDXKBiiIovjjZZbr8/swcB/k3/eeAYt/r4clDPPBP7SHAW/Zx8g69CrQ7GnfBSK7Pqw==
X-Received: by 10.99.47.199 with SMTP id v190mr9269655pgv.26.1486025440068;
        Thu, 02 Feb 2017 00:50:40 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id d68sm56060929pfj.92.2017.02.02.00.50.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Feb 2017 00:50:39 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 02 Feb 2017 15:50:34 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 05/11] worktree list: keep the list sorted
Date:   Thu,  2 Feb 2017 15:50:01 +0700
Message-Id: <20170202085007.21418-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170202085007.21418-1-pclouds@gmail.com>
References: <20170202085007.21418-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It makes it easier to write tests for. But it should also be good for
the user since locating a worktree by eye would be easier once they
notice this.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/worktree.c       |  2 +-
 t/t2027-worktree-list.sh | 19 +++++++++++++++++++
 worktree.c               | 14 ++++++++++++++
 worktree.h               |  2 ++
 4 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index d7d195cd95..9a97e37a3f 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -447,7 +447,7 @@ static int list(int ac, const char **av, const char *prefix)
 	if (ac)
 		usage_with_options(worktree_usage, options);
 	else {
-		struct worktree **worktrees = get_worktrees(0);
+		struct worktree **worktrees = get_worktrees(GWT_SORT_LINKED);
 		int path_maxlen = 0, abbrev = DEFAULT_ABBREV, i;
 
 		if (!porcelain)
diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
index 98b5f340e5..465eeeacd3 100755
--- a/t/t2027-worktree-list.sh
+++ b/t/t2027-worktree-list.sh
@@ -117,4 +117,23 @@ test_expect_success 'broken main worktree still at the top' '
 	)
 '
 
+test_expect_success 'linked worktrees are sorted' '
+	mkdir sorted &&
+	git init sorted/main &&
+	(
+		cd sorted/main &&
+		test_tick &&
+		test_commit new &&
+		git worktree add ../first &&
+		git worktree add ../second &&
+		git worktree list --porcelain | grep ^worktree >actual
+	) &&
+	cat >expected <<-EOF &&
+	worktree $(pwd)/sorted/main
+	worktree $(pwd)/sorted/first
+	worktree $(pwd)/sorted/second
+	EOF
+	test_cmp expected sorted/main/actual
+'
+
 test_done
diff --git a/worktree.c b/worktree.c
index ead088e43c..eb6121263b 100644
--- a/worktree.c
+++ b/worktree.c
@@ -160,6 +160,13 @@ static void mark_current_worktree(struct worktree **worktrees)
 	free(git_dir);
 }
 
+static int compare_worktree(const void *a_, const void *b_)
+{
+	const struct worktree *const *a = a_;
+	const struct worktree *const *b = b_;
+	return fspathcmp((*a)->path, (*b)->path);
+}
+
 struct worktree **get_worktrees(unsigned flags)
 {
 	struct worktree **list = NULL;
@@ -191,6 +198,13 @@ struct worktree **get_worktrees(unsigned flags)
 	ALLOC_GROW(list, counter + 1, alloc);
 	list[counter] = NULL;
 
+	if (flags & GWT_SORT_LINKED)
+		/*
+		 * don't sort the first item (main worktree), which will
+		 * always be the first
+		 */
+		QSORT(list + 1, counter - 1, compare_worktree);
+
 	mark_current_worktree(list);
 	return list;
 }
diff --git a/worktree.h b/worktree.h
index 2e68d4ad86..d59ce1fee8 100644
--- a/worktree.h
+++ b/worktree.h
@@ -15,6 +15,8 @@ struct worktree {
 
 /* Functions for acting on the information about worktrees. */
 
+#define GWT_SORT_LINKED (1 << 0) /* keeps linked worktrees sorted */
+
 /*
  * Get the worktrees.  The primary worktree will always be the first returned,
  * and linked worktrees will be pointed to by 'next' in each subsequent
-- 
2.11.0.157.gd943d85

