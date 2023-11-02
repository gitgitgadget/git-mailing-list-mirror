Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753761CA9E
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 13:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kz3NgtJe"
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637F8D7
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 06:52:28 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32df66c691dso534456f8f.3
        for <git@vger.kernel.org>; Thu, 02 Nov 2023 06:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698933146; x=1699537946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HVKElQnp5QISPgiw5b1/Q1oYASFzWRSD0hx9Q9yCEM=;
        b=kz3NgtJeVANXavAob6+iAp1hJOUWY1puo4myDmonsKR3pLUR1Sy6dQ7CcVOKwxsvzn
         2icGA9x53EFsNzc7Jo9UnxsQ1xD+VJcORvEWfKwgefjDBdne1/lV5j4AhAsBCE1YVQbu
         EVjLTc7OXg0ae2CZVehsSu3KUfBeoMLUEY7O0O9CM0Q9KVmqcb/2wVovdQQlNiz/eGRJ
         gPcwh3WB/L86cCqn/cUnIA3ZTw7G1VoYffuedP4ahcsdA97Woo/L5lGShIATFtvreRfc
         TjYvZYP2ax6YCEv+R3TyzgeROKSkjzloAjMN2ezwt/D66iRtBxccINt2HN5xDJ81elcm
         V0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698933146; x=1699537946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HVKElQnp5QISPgiw5b1/Q1oYASFzWRSD0hx9Q9yCEM=;
        b=cQPUSlzSJaWjD/6GQ6Ztbw3fmlzRt5wEv8AG0QWsaV6DWGzihRyCVYxIzbym+D64AD
         8sQqqA9l1cPNfuB22nZsZY5PfYGiG1I/bYt9oQ+QghjhaKCmAr7lLZPpvA2UIAl47sb6
         tiZVexR/qorKevRdYa7ZDCgFCE3AhD1EodZAyLpvdjr00EgrfUQjJMTnKXL5iDIo1bhE
         7qZgU2MzsDzi4yUEIZEwSm28To+zvhHjiYa0fn81M/Bd9riuyo3TgXVnsUqL+IzZbj7Z
         WsEL2LhEegQJ+632oMid3pX5+BhA2kR3xdtDalvaT2JstdZejWhyNx9yXY0X8kyvPfFU
         ScLw==
X-Gm-Message-State: AOJu0Yzd7wZ+blz/yYI1V+/RVxo7aRIt/RxWwdzV3zoqST2d2l5DYt1V
	YD420g1gTgnhztzSoelp7xLRDqjV54A=
X-Google-Smtp-Source: AGHT+IH19ipY1rApbE7rBJHSajIPIIEUFtR/GNOzziQB3s4Oiy2l2TzjTkQEs/FLvw+2W6A3l+GGOg==
X-Received: by 2002:a5d:6645:0:b0:32f:79b7:cc9a with SMTP id f5-20020a5d6645000000b0032f79b7cc9amr10337830wrw.31.1698933146206;
        Thu, 02 Nov 2023 06:52:26 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:116d:4e46:313c:1f52:4963:91b6])
        by smtp.gmail.com with ESMTPSA id e6-20020adffc46000000b0030647449730sm2514996wrs.74.2023.11.02.06.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 06:52:24 -0700 (PDT)
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
Subject: [PATCH v6 09/14] replay: remove HEAD related sanity check
Date: Thu,  2 Nov 2023 14:51:46 +0100
Message-ID: <20231102135151.843758-10-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.496.g529a7fda40
In-Reply-To: <20231102135151.843758-1-christian.couder@gmail.com>
References: <20231010123847.2777056-1-christian.couder@gmail.com>
 <20231102135151.843758-1-christian.couder@gmail.com>
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
index 74680b0c8f..9331f5c6ec 100644
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
@@ -251,7 +245,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
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
2.42.0.496.g529a7fda40

