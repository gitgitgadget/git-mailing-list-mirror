Received: from web23.osl1.nordkapp.net (web23.osl1.nordkapp.net [185.114.57.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6326F1C0DE0
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 23:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.114.57.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711840240; cv=none; b=oeOQTfX5AF+4spNuGWR2nAU6R4wbQRXuOLprEVVZxeeeizyBQps9rVhTNPPJgTeiy7HO9HGuahy+s34E9v6ekKFD2gZahUJc2gQle5lJWCHxfd0ovO9A6WQLbWhHb3kKJ3EV2HtZts4G06x8RRhbjzpqnDOsxIBK0QZnspOVqZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711840240; c=relaxed/simple;
	bh=9ZiFbDD32iCHoBBX0pVil7k5PzicuREQxo/vYjmle/A=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=GlndLVdq+P/5GMPjggAFzd1beXikR+j/JQChN7RG7KxvDU0t2ixlL9uyzxJgfneb5VAFZ+Y2hXkC4sT/K2xrxFyNednAzKxOxxfuOD8zA/uAl7Fjnixo66McS2s2oe+bjve3N9Ripw2soXisWUzIY2LGqNBk7qJy72jpuFzyohg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=softwolves.pp.se; spf=pass smtp.mailfrom=softwolves.pp.se; dkim=pass (2048-bit key) header.d=softwolves.pp.se header.i=@softwolves.pp.se header.b=VBtHHJWY; arc=none smtp.client-ip=185.114.57.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=softwolves.pp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=softwolves.pp.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softwolves.pp.se header.i=@softwolves.pp.se header.b="VBtHHJWY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=softwolves.pp.se; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:To:
	From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=boxxmc2LBBWtaRw9KxEpbAtThmW3h1/O1bNcT5zFiaE=; b=VBtHHJWYy1AR1ZeeUyhNq/8zEz
	GDU6IQrd/WJiwtQ3gsnHfVw8QG2oQm69gNNqXoAX/jYm7wL8WvxSbdnJGzMzX2WVtBR2PVFsSszvE
	FJVjfYFEolbhIEL3lVgBvJA80Ub9hKhnQ3D397LIUsvSutlVzR8/qeKSrc0NQZkoAruJ7jIy1JrLC
	RAvbJrJbBQI4kaPeH06DZQ93b923HnNbdpSn/iMaQR86ruGVS52w7iD2JQqWHiv+UNcyFH7Dkn9uH
	al9IrhPh7L0ZZU0nMEVkv0T/GA51Quj3GciRxfhCrmOqTKy4ql0k4COCi5bjhrTnrQTchaXDP8GVW
	QEPvQTyA==;
Received: from mail01.osl1.nordkapp.net ([185.114.57.50]:60142 helo=mail.nordhost.no)
	by web23.osl1.nordkapp.net with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <peter@softwolves.pp.se>)
	id 1rqhqC-00000006vLl-2JKZ;
	Sun, 31 Mar 2024 00:10:24 +0100
Date: Sun, 31 Mar 2024 00:10:24 +0100 (CET)
From: Peter Krefting <peter@softwolves.pp.se>
To: git@vger.kernel.org, 
    "Osipov, Michael (IN IT IN)" <michael.osipov@innomotics.com>
Subject: [PATCH v2] bisect: Honor log.date
Message-ID: <3ec4ec15-8889-913a-1184-72e55a1e0432@softwolves.pp.se>
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Organization: /universe/earth/europe/norway/oslo
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Relay-Host: 185.114.57.50
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus

When bisect finds the target commit to display, it calls git diff-tree
to do so. This is a plumbing command that is not affected by the user's
log.date setting. Switch to instead use "git show", which does honor
it.

Reported-by: Michael Osipov <michael.osipov@innomotics.com>
Signed-off-By: Peter Krefting <peter@softwolves.pp.se>
---
  bisect.c | 25 ++++++++++---------------
  1 file changed, 10 insertions(+), 15 deletions(-)

This version also uses "--stat" which produces an output more like the 
one from the diff-tree utility.

GitHub's test run reports a single failed test (7300), but this passes 
when I try it locally: 
https://github.com/nafmo/git-l10n-sv/commit/2f27ae64064edc5c2570f1c9ea121f3f1a7283d7

diff --git a/bisect.c b/bisect.c
index 8487f8cd1b..3d0100b165 100644
--- a/bisect.c
+++ b/bisect.c
@@ -959,23 +959,18 @@ static enum bisect_error check_good_are_ancestors_of_bad(struct repository *r,
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
+	strvec_pushl(&show.args, "show", "--pretty=medium", "--stat", "--no-abbrev-commit", "--no-patch",
+		     oid_to_hex(&commit->object.oid), NULL);
+	show.git_cmd = 1;
+	if (run_command(&show))
+		die(_("unable to start 'show' for object '%s'"),
+		    oid_to_hex(&commit->object.oid));
  }

  /*
@@ -1092,7 +1087,7 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
  		printf("%s is the first %s commit\n", oid_to_hex(bisect_rev),
  			term_bad);

-		show_diff_tree(r, prefix, revs.commits->item);
+		show_commit(revs.commits->item);
  		/*
  		 * This means the bisection process succeeded.
  		 * Using BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND (-10)
-- 
2.39.2

