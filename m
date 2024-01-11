Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3245A0E0
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 23:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEE/Vtxo"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e66315d93so264745e9.2
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 15:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705016026; x=1705620826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=F0NJkB/4LwK8+S7iZ9TQ2wMnUj+DbK39hLorKAkurrE=;
        b=XEE/VtxoQxPjXRv3jIL8gkEFaaeN69MvyvQFvUT7KpEqwECgEMiSi5IUFyOYGWeTCb
         m6/1gi5MbjhqvMap2lWJkiktAknKxKFXAQZR0m486dsRYw4InmkeYcinIi7lcHK0jOmo
         BdMAcqEjqH+EVEXMc3LnbI8XErUGk5+pNH606YSOaGhIjqF0cbLRtAAwzKtCCgD37k3a
         v9/i+/WLDFRyq5DKxcsVfo8aIVcrEpnomICKc9ECCHeI7C3qN+Yrx6n64lPGUfj0s3eA
         PxsO+d5G44ei5q68E0qa3ci4104GzgId01sQlPLbhU+92o4rHA7uhjTxSaLqqduk+b9Q
         ra/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705016026; x=1705620826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0NJkB/4LwK8+S7iZ9TQ2wMnUj+DbK39hLorKAkurrE=;
        b=p6lrzBTOgcNdRfDkHc9Ya8IXeE0owymwoH+Ef7zHe+XHtASiVXOuRMrvl/t7o4I9I6
         3nu0LuF3NB0Kgt95riGwXKhsfrHW7RdwX8q1eTNDhNj/NYDfpCDm1M68VNNwPFOktefY
         VezlaOMqLjbnc5EEZBt1qubiZE26SPgJ1g4xOoMydWyHdlGReXDsPYSm1LQt8/5V2mZf
         w49616yCcQF9w3Wt9etN/oxRyMNZKKVpFFpXQ+2jzgfUmr1VjcS4qvV/aV6i76IPcKVE
         CJSy61mpqpF8cKuHVksKqZPf0KPS43DlGwjRQHyHkKUOwWz5y/adv+dR8Q9KPUchN3dS
         lWWg==
X-Gm-Message-State: AOJu0YwfsfcMniFsV4CVRWGOYNU6gQ3QCTQ/b2EFzTgb+ZmVtmmKK1tV
	v0NPmq88JcQmX9uvfFpPmUiBPcA9DdF3CQ==
X-Google-Smtp-Source: AGHT+IHT98JzfMLRn6W56NlfTIBfiovwBPddU1S9Ofnp1nCbHwQS6h+y53ZXN4NwOxalrjpRbwH8XQ==
X-Received: by 2002:a1c:6a0b:0:b0:40e:5a18:7fe3 with SMTP id f11-20020a1c6a0b000000b0040e5a187fe3mr324439wmc.63.1705016025687;
        Thu, 11 Jan 2024 15:33:45 -0800 (PST)
Received: from Michaels-MBP.fritz.box (2001-4dd4-c452-0-6835-a146-250e-421c.ipv6dyn.netcologne.de. [2001:4dd4:c452:0:6835:a146:250e:421c])
        by smtp.gmail.com with ESMTPSA id v4-20020a05600c470400b0040e5945307esm3659027wmo.40.2024.01.11.15.33.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Jan 2024 15:33:45 -0800 (PST)
Sender: Michael L <mial.lohmann@gmail.com>
From: Michael Lohmann <mi.al.lohmann@gmail.com>
To: git@vger.kernel.org
Cc: Michael Lohmann <mi.al.lohmann@gmail.com>,
	phillip.wood123@gmail.com
Subject: [RFC PATCH] `log --merge` also for rebase/cherry pick/revert
Date: Fri, 12 Jan 2024 00:33:11 +0100
Message-Id: <20240111233311.64734-1-mi.al.lohmann@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This extends the functionality of `git log --merge` to also work with
conflicts for rebase, cherry pick and revert.

Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
---
Hi everybody!

When Phillip Wood gave me some nice hints on his workflow concerning
conflicts [1] (we discussed if `--show-current-patch` would make sense
for cherry pick/revert). When I learned about `git log --merge` I was a
bit sad to discover that those do not exist for rebase/revert/cherry
pick since they look really valuable for getting an understanding on
what was changed. It is basically the counterpart to
`git show ${ACTION}_HEAD` for understanding the source of the conflict.

I am curious if also other people would be interested in having an easy
way to get a log of only the relevant commits touching conflicting files
for said actions.

With this patch I think the functionality is there, just hijacking the
`--merge` code - maybe an alias like `git log --conflict` or similar
might be more descriptive now?

What do you think about this idea? (Or am I maybe missing an easy way to
achieve it with the existing code as well?)

Michael


[1] https://lore.kernel.org/git/cfba7098-3c23-4a81-933c-b7fefdedec8a@gmail.com/

 revision.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/revision.c b/revision.c
index 2424c9bd67..2e5c00dabd 100644
--- a/revision.c
+++ b/revision.c
@@ -1961,23 +1961,37 @@ static void add_pending_commit_list(struct rev_info *revs,
 	}
 }
 
+static char* get_action_head_name(struct object_id* oid)
+{
+	if (!repo_get_oid(the_repository, "MERGE_HEAD", oid)) {
+		return "MERGE_HEAD";
+	} else if (!repo_get_oid(the_repository, "REBASE_HEAD", oid)) {
+		return "REBASE_HEAD";
+	} else if (!repo_get_oid(the_repository, "CHERRY_PICK_HEAD", oid)) {
+		return "CHERRY_PICK_HEAD";
+	} else if (!repo_get_oid(the_repository, "REVERT_HEAD", oid)) {
+		return "REVERT_HEAD";
+	} else
+		die("--merge without MERGE_HEAD, REBASE_HEAD, CHERRY_PICK_HEAD or REVERT_HEAD?");
+}
+
 static void prepare_show_merge(struct rev_info *revs)
 {
 	struct commit_list *bases;
 	struct commit *head, *other;
 	struct object_id oid;
 	const char **prune = NULL;
+	const char *action_head_name;
 	int i, prune_num = 1; /* counting terminating NULL */
 	struct index_state *istate = revs->repo->index;
 
 	if (repo_get_oid(the_repository, "HEAD", &oid))
 		die("--merge without HEAD?");
 	head = lookup_commit_or_die(&oid, "HEAD");
-	if (repo_get_oid(the_repository, "MERGE_HEAD", &oid))
-		die("--merge without MERGE_HEAD?");
-	other = lookup_commit_or_die(&oid, "MERGE_HEAD");
+	action_head_name = get_action_head_name(&oid);
+	other = lookup_commit_or_die(&oid, action_head_name);
 	add_pending_object(revs, &head->object, "HEAD");
-	add_pending_object(revs, &other->object, "MERGE_HEAD");
+	add_pending_object(revs, &other->object, action_head_name);
 	bases = repo_get_merge_bases(the_repository, head, other);
 	add_rev_cmdline_list(revs, bases, REV_CMD_MERGE_BASE, UNINTERESTING | BOTTOM);
 	add_pending_commit_list(revs, bases, UNINTERESTING | BOTTOM);
-- 
2.39.3 (Apple Git-145)

