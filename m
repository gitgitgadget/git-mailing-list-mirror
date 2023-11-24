Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8YUk11x"
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC15A10F5
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 03:11:16 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40859dee28cso14055295e9.0
        for <git@vger.kernel.org>; Fri, 24 Nov 2023 03:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700824275; x=1701429075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d56W4LTu8T/f8wrkGZU/GQXCEBm4Di2aR9F4V6M/74c=;
        b=T8YUk11x8xGH3Q6hoA/xN4m6jd1pXf52mD804O7OZIQwB+Bj+v4d+rRni+jR2K+oJ7
         75RaT6d71P10Im8monLBP7SQ9o11fdqUnZh33yNT7de7hl6aaLlQFKKk9gEg/ZDNsls4
         mlfyQYuhUBTNvdsnF7vlag4IacgvjW5VMNMPimrq3ZZ42dQUdtl9CDV//WuM5FoWujRk
         O6gp9pUS8+kyfBIkp6peQv5+6Pe4fE2/wYedbDGV3soTIe7zZ9kU9w8Frk5cJDIKd/lD
         RiY5zZQyGqGyZRV3oHhbBF9K/301MjwccPYkeqRSZRP5egcIcvxa+MatSg363j4fPaoz
         eMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700824275; x=1701429075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d56W4LTu8T/f8wrkGZU/GQXCEBm4Di2aR9F4V6M/74c=;
        b=gYo77xHexruHNkpEJTP7ND3SY1R6bVJ0BfsLhD5zgdjGDGZDKkUB9XbA/qssq4wYdz
         5FqqwE0+cgmL1EBTqN9RceU63YpcqahnqSlMPtwmYPG7l82pOI/gydy9gYwlYetQvYJY
         0eHHCVibtBCyhlzhuNP3BlJp5BhSN+b55kPPtCS3vaXvcovBZm+6CFOttNb7MKFcx6d0
         atmWFG+Wqhq6/elNTXtI15XPeIUKhTS+38xfSLIVSmX81D5rVEu6NvAR+5YiNIb4bXh/
         9fFzUaqYCzjD1e1KLmHrUZkRJ3qxBW1tkdAUrzXDsZWsJPm2DeT1qBakOFNzaARIATMM
         BuRQ==
X-Gm-Message-State: AOJu0Yy2eOcBRIY2uS25KEs9qqCdxCPTZH560eQGsXVQB1SGEe2N46jF
	7QDeloO2vKUw6zMO+D4bqozTu0VNwm0=
X-Google-Smtp-Source: AGHT+IHZwUt90lAjEMcOh2uneUQCZBy6rG4wYorBpYWBY45p71OumBbq8kDsIsLv0vfQgRh/zpLuYA==
X-Received: by 2002:a05:600c:19ca:b0:408:4978:b6ef with SMTP id u10-20020a05600c19ca00b004084978b6efmr1879190wmq.29.1700824274435;
        Fri, 24 Nov 2023 03:11:14 -0800 (PST)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:c06d:3245:2b4d:9ec5])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c458400b0040648217f4fsm5390295wmo.39.2023.11.24.03.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 03:11:13 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	John Cai <johncai86@gmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Calvin Wan <calvinwan@google.com>,
	Toon Claes <toon@iotcl.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Linus Arver <linusa@google.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v8 09/14] replay: remove HEAD related sanity check
Date: Fri, 24 Nov 2023 12:10:38 +0100
Message-ID: <20231124111044.3426007-10-christian.couder@gmail.com>
X-Mailer: git-send-email 2.43.0.14.g93e034faee
In-Reply-To: <20231124111044.3426007-1-christian.couder@gmail.com>
References: <20231115143327.2441397-1-christian.couder@gmail.com>
 <20231124111044.3426007-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Elijah Newren <newren@gmail.com>

We want replay to be a command that can be used on the server side on
any branch, not just the current one, so we are going to stop updating
HEAD in a future commit.

A "sanity check" that makes sure we are replaying the current branch
doesn't make sense anymore. Let's remove it.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replay.c         | 8 +-------
 t/t3650-replay-basics.sh | 2 --
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index ca3867dc57..bdec2f2b97 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -123,7 +123,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	struct commit *onto;
 	const char *onto_name = NULL;
 	struct commit *last_commit = NULL, *last_picked_commit = NULL;
-	struct object_id head;
 	struct lock_file lock = LOCK_INIT;
 	struct strvec rev_walk_args = STRVEC_INIT;
 	struct rev_info revs;
@@ -162,11 +161,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	onto = peel_committish(onto_name);
 	strbuf_addf(&branch_name, "refs/heads/%s", argv[2]);
 
-	/* Sanity check */
-	if (repo_get_oid(the_repository, "HEAD", &head))
-		die(_("Cannot read HEAD"));
-	assert(oideq(&onto->object.oid, &head));
-
 	repo_hold_locked_index(the_repository, &lock, LOCK_DIE_ON_ERROR);
 	if (repo_read_index(the_repository) < 0)
 		BUG("Could not read index");
@@ -275,7 +269,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 			    oid_to_hex(&last_picked_commit->object.oid));
 		if (update_ref(reflog_msg.buf, "HEAD",
 			       &last_commit->object.oid,
-			       &head,
+			       &onto->object.oid,
 			       REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR)) {
 			error(_("could not update %s"), argv[2]);
 			die("Failed to update %s", argv[2]);
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index 36c1b5082a..b5b9f9ade2 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -48,8 +48,6 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'using replay to rebase two branches, one on top of other' '
-	git switch main &&
-
 	git replay --onto main topic1 topic2 >result &&
 
 	git log --format=%s $(cut -f 3 -d " " result) >actual &&
-- 
2.43.0.14.g93e034faee

