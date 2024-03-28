Received: from web23.osl1.nordkapp.net (web23.osl1.nordkapp.net [185.114.57.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9301512F38B
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 20:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.114.57.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711659237; cv=none; b=ZsiEa8AcuX2xftCk1++V6LS5p2PFY/5CBmesDj7fkGnqxikepnPvNmXUvaA3xvW8NURNPZfbEm3LYQRWiDnBVncqIaEJHQazOiNHBXr5ST6nZ5UoBf7oIWLmKIJrP7cJdoybLr3CFwQ1k+vKgu0toYpHGcpLClyitC+Y1X82/Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711659237; c=relaxed/simple;
	bh=WWJt3TN4rb/jlnBrZFEs4Z57X9FAhnMFdNFUglA750E=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GIbPDUyZbNZyUTTocaNOEb/gzEA0Iw+KZzcDV7Vut/I3zH8JCtlide+4H4nbiatrIljU+a978uM5Btxd4xw6vpOHoVO3ZF/cAqSJJ7+O2HGFbFPZp+vGRF3einOQi0huLAR9vcQeMt/LrxNp+lYljf6FkQNLeG0YEqytXqdXb5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=softwolves.pp.se; spf=pass smtp.mailfrom=softwolves.pp.se; dkim=pass (2048-bit key) header.d=softwolves.pp.se header.i=@softwolves.pp.se header.b=5GjP6U5o; arc=none smtp.client-ip=185.114.57.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=softwolves.pp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=softwolves.pp.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softwolves.pp.se header.i=@softwolves.pp.se header.b="5GjP6U5o"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=softwolves.pp.se; s=x; h=Content-Type:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uVxVt8oYubZ/BtbunlT1hn2XuK9jZuohkQElOWPwHeY=; b=5GjP6U5olAeu0NijbpqXDnZ1OZ
	zpgEj+n/imjgT5P82+fJ8cz5r0bwzeJcMpNbm6u+xgDAbgzWigAvmLyLLByy0lBQ/2wk3nYsw70qK
	qhpZmbN4KIzokzDH6HWxI8hf2SZC8vLhFzKV97fQ5l58tJ50MCjkP3eKjgNDQmkfuLtNEP9Fv58ap
	jDeY/8MigKsn0d5oYw2fG9vIyNDVSZmqRT3QPD7GPvKnaZouffjXgEFYqKfiDgpJiuNZRoxquakEQ
	NM33Vk9D0+10inzODmLodTaSrxeQR/OhYwziePYJgXyCpLg8FRJO/Ii1Je88/Y/K/swyo8vXOOVru
	xtsj/9Iw==;
Received: from mail01.osl1.nordkapp.net ([185.114.57.50]:42776 helo=mail.nordhost.no)
	by web23.osl1.nordkapp.net with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <peter@softwolves.pp.se>)
	id 1rpwkm-000000042Vm-3XGF;
	Thu, 28 Mar 2024 21:53:40 +0100
Date: Thu, 28 Mar 2024 21:53:40 +0100 (CET)
From: Peter Krefting <peter@softwolves.pp.se>
To: Junio C Hamano <gitster@pobox.com>
cc: "Osipov, Michael (IN IT IN)" <michael.osipov@innomotics.com>, 
    git@vger.kernel.org
Subject: [RFC PATCH] bisect: Honor log.date
In-Reply-To: <xmqq1q7ygex1.fsf@gitster.g>
Message-ID: <4727b78c-e45b-da7c-fa6e-85876b50dcde@softwolves.pp.se>
References: <645c8253-f1ef-410f-8284-7d6c8b6db601@siemens.com> <xmqq7ci6c7mn.fsf@gitster.g> <4e2b22fb-7496-4f67-a89f-9fcbffc73a1a@siemens.com> <25d716fa-bd32-4ff0-20f2-05ff51750911@softwolves.pp.se> <xmqq1q7ygex1.fsf@gitster.g>
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Organization: /universe/earth/europe/norway/oslo
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Relay-Host: 185.114.57.50
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus

When bisect finds the target commit to display, it calls git diff-tree
to do so. This is a plumbing command that is not affected by the user's
log.date setting. Switch to instead use "git show", which does honor
it.

Reported-by: Michael Osipov <michael.osipov@innomotics.com>
Signed-off-By: Peter Krefting <peter@softwolves.pp.se>
---
  bisect.c | 26 +++++++++++---------------
  1 file changed, 11 insertions(+), 15 deletions(-)

Junio C Hamano:

> Instead of focusing too narrowly on the log.date option, that would 
> only tweak the date format, it may be a more fruitful way to invest 
> brainwaves in to consider the feasibility of switching to use "git 
> show" there.

Indeed.

Here is a patch that does exactly that.

This is my first patch to the actual codebase in Git, so it might be 
bit rough; improvements are welcome. I might need to change something 
in the test suite as well?

With this patch applied, running with log.date=iso and 
log.decorate=short, I get this output:

  $ ./git-bisect start
  [...]
  $ ./git-bisect good v2.43.2
  [...]
  $ ./git-bisect bad v2.43.3
  [...]
  $ ./git-bisect good
  0d464a4e6a5a19bd8fbea1deae22d48d14dccb01 is the first bad commit
  commit 0d464a4e6a5a19bd8fbea1deae22d48d14dccb01 (tag: v2.43.3)
  Author: Junio C Hamano <gitster@pobox.com>
  Date:   2024-02-22 16:13:38 -0800

      Git 2.43.3

  Signed-off-by: Junio C Hamano <gitster@pobox.com>

which is the format I expect.

diff --git a/bisect.c b/bisect.c
index 8487f8cd1b..0f7126c32b 100644
--- a/bisect.c
+++ b/bisect.c
@@ -959,23 +959,19 @@ static enum bisect_error check_good_are_ancestors_of_bad(struct repository *r,
  }

  /*
- * This does "git diff-tree --pretty COMMIT" without one fork+exec.
+ * Runs "git show" to display a commit
   */
-static void show_diff_tree(struct repository *r,
-			   const char *prefix,
-			   struct commit *commit)
+static void show_commit(struct commit *commit)
  {
-	const char *argv[] = {
-		"diff-tree", "--pretty", "--stat", "--summary", "--cc", NULL
-	};
-	struct rev_info opt;
+	struct child_process show = CHILD_PROCESS_INIT;

-	git_config(git_diff_ui_config, NULL);
-	repo_init_revisions(r, &opt, prefix);
-
-	setup_revisions(ARRAY_SIZE(argv) - 1, argv, &opt, NULL);
-	log_tree_commit(&opt, commit);
-	release_revisions(&opt);
+	/* Invoke "git show --pretty=medium --shortstat --no-abbrev-commit --no-patch $object" */
+	strvec_pushl(&show.args, "show", "--pretty=medium", "--shortstat", "--no-abbrev-commit", "--no-patch",
+		     oid_to_hex(&commit->object.oid), NULL);
+	show.git_cmd = 1;
+	if (run_command(&show))
+		die(_("unable to start 'show' for object '%s'"),
+		    oid_to_hex(&commit->object.oid));
  }

  /*
@@ -1092,7 +1088,7 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
  		printf("%s is the first %s commit\n", oid_to_hex(bisect_rev),
  			term_bad);

-		show_diff_tree(r, prefix, revs.commits->item);
+		show_commit(revs.commits->item);
  		/*
  		 * This means the bisection process succeeded.
  		 * Using BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND (-10)
-- 
2.39.2

