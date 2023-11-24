Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="II4FWOA5"
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6F410E6
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 03:11:14 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-409299277bbso12113265e9.2
        for <git@vger.kernel.org>; Fri, 24 Nov 2023 03:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700824273; x=1701429073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqfHuRQQ9XSxFZP+uJl6/bkl3lDcR45k7PH3OT3D4OQ=;
        b=II4FWOA5GMOiRzmVrScKQ3coWV3q9fTcRWaVoSCKldmlcU87Jg5vw4gODm83qqFMfu
         z9Y6RJIjxYml1uusZig5RCFAn9oYy6AnDH5NosK6WN72+r8BxwxCOb0c8+e4HP8p37hP
         v8MryfE+kJVOOhx+ts7rbiT5nvUIjFi2ygVVhnaSiJ+uIbO6TmhnGAqRzcd3gTh9FCvJ
         KfV3TV9BcYOD7K7gbpFIN2vXtxlrnqh88zPIAMhCtiZ2pJUYyI+8GGH+VjFRtJcGZqH6
         1Uj77rQzyDeh4nhv9Xhd0eaJ6Pyg47vDNaSjmP8inAz9wo/uPAZNkRWlomrxgfgtnqQa
         HmHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700824273; x=1701429073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqfHuRQQ9XSxFZP+uJl6/bkl3lDcR45k7PH3OT3D4OQ=;
        b=RT2U+gorJ9wKQrN2Yjiy6Kb1NtG+tyK8PYcfvT/KhNg5jGjSohtsYGc7EwYndpdku1
         OS6NSgWDp4vQ+ZGj0E+KoSmhYKR6fdqwSn2//CBCOH49yQ1Ikzlju0DHtFnWx4Sq15pi
         7RsoNl0+NhNiowq6vjcpFLH0lAFq+MUdUr4wZmWCUoMmyXPLGha/FexYR5xtWtertqKx
         07IaS/rBpftaF3xImkt2e2Y9sL9OgtKB3ytNdL2axa8JleKU+4v5K4qrEexe5/tq57/X
         dAuCx0RuQpicP0Xa2c0kOC2nnTcFmbJ2vZo95X7XCxV1w9zqESaMYNGXHBCz++ZN0fEi
         t5cA==
X-Gm-Message-State: AOJu0YwfGE48CzHif5gycmSuhETAQU9TydK4rrJ7IU9XLAJwDdDUl/rK
	comdA3rI53B+0/5FTBvzqTisGsMwbL8=
X-Google-Smtp-Source: AGHT+IGYtYAILPCFF4NEpVln3J1DSOimlu+no6tUe9/c8YvOwz6sFTukawrL9Ks+ea7+K9vGUzZ4JA==
X-Received: by 2002:a05:600c:a49:b0:401:daf2:2735 with SMTP id c9-20020a05600c0a4900b00401daf22735mr2009070wmq.31.1700824272963;
        Fri, 24 Nov 2023 03:11:12 -0800 (PST)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:c06d:3245:2b4d:9ec5])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c458400b0040648217f4fsm5390295wmo.39.2023.11.24.03.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 03:11:11 -0800 (PST)
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
Subject: [PATCH v8 08/14] replay: remove progress and info output
Date: Fri, 24 Nov 2023 12:10:37 +0100
Message-ID: <20231124111044.3426007-9-christian.couder@gmail.com>
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

The replay command will be changed in a follow up commit, so that it
will not update refs directly, but instead it will print on stdout a
list of commands that can be consumed by `git update-ref --stdin`.

We don't want this output to be polluted by its current low value
output, so let's just remove the latter.

In the future, when the command gets an option to update refs by
itself, it will make a lot of sense to display a progress meter, but
we are not there yet.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replay.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 384bb4ddd3..ca3867dc57 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -232,7 +232,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 
 	init_merge_options(&merge_opt, the_repository);
 	memset(&result, 0, sizeof(result));
-	merge_opt.show_rename_progress = 1;
+	merge_opt.show_rename_progress = 0;
 	merge_opt.branch1 = "HEAD";
 	head_tree = repo_get_commit_tree(the_repository, onto);
 	result.tree = head_tree;
@@ -240,9 +240,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	while ((commit = get_revision(&revs))) {
 		struct commit *pick;
 
-		fprintf(stderr, "Rebasing %s...\r",
-			oid_to_hex(&commit->object.oid));
-
 		if (!commit->parents)
 			die(_("replaying down to root commit is not supported yet!"));
 		if (commit->parents->next)
@@ -261,7 +258,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		exit(128);
 
 	if (result.clean) {
-		fprintf(stderr, "\nDone.\n");
 		strbuf_addf(&reflog_msg, "finish rebase %s onto %s",
 			    oid_to_hex(&last_picked_commit->object.oid),
 			    oid_to_hex(&last_commit->object.oid));
@@ -275,7 +271,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		if (create_symref("HEAD", branch_name.buf, reflog_msg.buf) < 0)
 			die(_("unable to update HEAD"));
 	} else {
-		fprintf(stderr, "\nAborting: Hit a conflict.\n");
 		strbuf_addf(&reflog_msg, "rebase progress up to %s",
 			    oid_to_hex(&last_picked_commit->object.oid));
 		if (update_ref(reflog_msg.buf, "HEAD",
-- 
2.43.0.14.g93e034faee

