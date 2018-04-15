Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F8FD1F404
	for <e@80x24.org>; Sun, 15 Apr 2018 20:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752902AbeDOU3W (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 16:29:22 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40507 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752896AbeDOU3T (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 16:29:19 -0400
Received: by mail-wr0-f196.google.com with SMTP id v60so16618730wrc.7
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 13:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pr0X0rHBLCNWoiiNwvaC10gOTupgCtWjOlqn3JkqrbU=;
        b=hjwPT3YTGAGsVdyxBGycANZPC+E2iaIU0pALS+u40taQWDKJbWG+Cf247UWuxwLB6f
         DsGCNoNW2npUt4RyETykOtG2oTDHYAVk5Lz2ExTM97+kbeZKaF7Fmqj+9FYieoqCQsvO
         chpPtw+4r7RpQ5HYAZEXyUFzn9KJuTk+bPjQ1nEDfQEGb7aZ7ZwYyrt4Y8wtYcKYLyqd
         gymVHDB0g9byR1Cfhzsc+507+RvmQrRFDHNWSNNzfkZ3VTS7Y/1dyOu0dY5ClIbO5MZz
         A7MNB/et1BlPRqBXq5APkMch3GMQqmhno/5Y3hyIcJNapNTUqG70yKP3qStxUQL3rxf4
         m+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pr0X0rHBLCNWoiiNwvaC10gOTupgCtWjOlqn3JkqrbU=;
        b=DcQAf5Qml2J3fDovVlI43aDU8mBjqP/Yznm8UJi0uhp4aV/VGHga/T691eck4+s4yF
         s/XaVsRvjDGRIjJRYMFJnSK1hLd0GePKypMHSdMMptg5kyNo5yNlXayKseY2I7SDp4iL
         Tn9ovBj8H906546Uqu9PKmfRGWCxpI2r8myuCV+xlwmQ0UusERg647j1zA3XADVHiYV5
         gtp8hYGeOZebR3in/5th0E2baysfBf8moJEIrUxR1SbjBdo4VnmdH7FzuKYydi1ULmnL
         hjv/JAIsTkv1dRwJIZEbafQfJ8voaKiQUfDse/4dwGdpCiH5dLCfPVUJuMwF0ir0k+Ok
         Qytg==
X-Gm-Message-State: ALQs6tDW2iBcnOnjCFdn2LE26F2ykl02sDaU693mSerpYgNhjPpH5WPP
        2eO+CoC05lvDS1M+1JPG7fUTf/B1
X-Google-Smtp-Source: AIpwx48hOHsMUa0CUUjEzkPmx/SxAuHOr3WH7uFITSy9rzfhbmHSYl44bISad7HQCSR7oTrwesRr+w==
X-Received: by 10.223.157.65 with SMTP id o1mr8531507wre.14.1523824157683;
        Sun, 15 Apr 2018 13:29:17 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id p4sm7463190wma.5.2018.04.15.13.29.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Apr 2018 13:29:16 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v7 3/4] worktree: factor out dwim_branch function
Date:   Sun, 15 Apr 2018 21:29:16 +0100
Message-Id: <20180415202917.4360-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.252.gfe0a9eaf31
In-Reply-To: <20180415202917.4360-1-t.gummerer@gmail.com>
References: <20180331151804.30380-1-t.gummerer@gmail.com>
 <20180415202917.4360-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Factor out a dwim_branch function, which takes care of the dwim'ery in
'git worktree add <path>'.  It's not too much code currently, but we're
adding a new kind of dwim in a subsequent patch, at which point it makes
more sense to have it as a separate function.

Factor it out now to reduce the patch noise in the next patch.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/worktree.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index a2667d74fb..893139629a 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -378,6 +378,20 @@ static void print_preparing_worktree_line(const char *branch,
 	}
 }
 
+static const char *dwim_branch(const char *path, const char **new_branch)
+{
+	int n;
+	const char *s = worktree_basename(path, &n);
+	*new_branch = xstrndup(s, n);
+	if (guess_remote) {
+		struct object_id oid;
+		const char *remote =
+			unique_tracking_name(*new_branch, &oid);
+		return remote;
+	}
+	return NULL;
+}
+
 static int add(int ac, const char **av, const char *prefix)
 {
 	struct add_opts opts;
@@ -430,16 +444,9 @@ static int add(int ac, const char **av, const char *prefix)
 	}
 
 	if (ac < 2 && !new_branch && !opts.detach) {
-		int n;
-		const char *s = worktree_basename(path, &n);
-		new_branch = xstrndup(s, n);
-		if (guess_remote) {
-			struct object_id oid;
-			const char *remote =
-				unique_tracking_name(new_branch, &oid);
-			if (remote)
-				branch = remote;
-		}
+		const char *s = dwim_branch(path, &new_branch);
+		if (s)
+			branch = s;
 	}
 
 	if (ac == 2 && !new_branch && !opts.detach) {
-- 
2.17.0.252.gfe0a9eaf31

