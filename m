Received: from web23.osl1.nordkapp.net (web23.osl1.nordkapp.net [185.114.57.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180021DFEB
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 20:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.114.57.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713213738; cv=none; b=khCtkFSZBynrd2AhzB9xLOZ8xif7IXMYI3tcLhjRBTmoPY2IRQOz5PnjbQaItv7EUkiEbsl/E996CImFhXUJpC6/X/845aqWiOiltbosm8ctAbA1ZEquYyXoEWcGsfXMZupUV5xkAivBmP4PJx1MecKkk5ingL6JTS/iYLomj9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713213738; c=relaxed/simple;
	bh=afi3ad8dNIBl19PCxjt18crCLPln/XTawEUCw7qSWN0=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=gSFySrmxowm5R01b9D07YmPAwi2TZCduFVGeV3MZd7Gm6vnboyvIM0d6LF6K9eEtx0hm3e4KQGDxAUNHO4pwqTTyqafX2MdtwcG9bve2YaeI6qYQ//cZhaWaKIDMPgkLtx85QfkaJPEBfabknJ4qd+onp+hKv0EQFIinL+jc2LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=softwolves.pp.se; spf=pass smtp.mailfrom=softwolves.pp.se; dkim=pass (2048-bit key) header.d=softwolves.pp.se header.i=@softwolves.pp.se header.b=AMfTGLLl; arc=none smtp.client-ip=185.114.57.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=softwolves.pp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=softwolves.pp.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softwolves.pp.se header.i=@softwolves.pp.se header.b="AMfTGLLl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=softwolves.pp.se; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:cc:To
	:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kVqwuOsmy8wMji7VL2J9KJcfWNd3MWQYudfcG/4eU/g=; b=AMfTGLLlHkg+5NgygM/vjROnU9
	aXsR4Apapy58BsT0y38tKfWrRPJz7OJSvwdQsIbi/HSUwQl0+ha9XQYKknS/tUZwFjz+vh7ggCBz7
	zG2Zm+OSIvL6pLe3Xia1Y7UkRL/UbU1wsRObBMLkUWaGj0zsJ3Cuu3JFlOiAh3KVGYCnTihqqW3lJ
	1fW9rOV4L6pGKTp6ysXYjT93ScKqKa6UekiBMUlIoGuxhnjqmCRIYGvLrFWSghjyAjYsn4SPOVInn
	3RTLcYLvfKJBi1SJtsbdziyCybMkKsKpD05hDOcRukB+0NPSYTULIy9qLq+2xo5IZEtABuY2WL3hQ
	dN90gjLQ==;
Received: from mail01.osl1.nordkapp.net ([185.114.57.50]:36428 helo=mail.nordhost.no)
	by web23.osl1.nordkapp.net with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <peter@softwolves.pp.se>)
	id 1rwT9M-0000000BqUF-1w4l;
	Mon, 15 Apr 2024 22:42:00 +0200
Date: Mon, 15 Apr 2024 21:42:00 +0100 (CET)
From: Peter Krefting <peter@softwolves.pp.se>
To: git@vger.kernel.org
cc: Junio C Hamano <gitster@pobox.com>, 
    Michael Osipov <michael.osipov@innomotics.com>, Jeff King <peff@peff.net>, 
    Christian Couder <christian.couder@gmail.com>, 
    Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4] bisect: report the found commit with "show"
Message-ID: <234e8039-0000-d2c9-f3d7-9b5c3202f878@softwolves.pp.se>
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

When "git bisect" finds the first bad commit and shows it to the user,
it calls "git diff-tree" to do so, whose output is meant to be stable
and deliberately ignores end-user customizations.

As the output is supposed to be consumed by humans, replace this with
a call to "git show". This command honors configuration options (such
as "log.date" and "log.mailmap") and other UI improvements (renames
are detected).

Pass some hard-coded options to "git show" to make the output similar
to the one we are replacing, such as showing a patch summary only.

Reported-by: Michael Osipov <michael.osipov@innomotics.com>
Signed-off-By: Peter Krefting <peter@softwolves.pp.se>
Cc: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>
Cc: Christian Couder <christian.couder@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>
---
  bisect.c | 40 +++++++++++++++++++++++++---------------
  1 file changed, 25 insertions(+), 15 deletions(-)

This version code style issues in v3.

diff --git a/bisect.c b/bisect.c
index 8487f8cd1b..dd768ce3f0 100644
--- a/bisect.c
+++ b/bisect.c
@@ -959,23 +959,33 @@ static enum bisect_error check_good_are_ancestors_of_bad(struct repository *r,
  }

  /*
- * This does "git diff-tree --pretty COMMIT" without one fork+exec.
+ * Display a commit summary to the user.
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
+	/*
+	 * Call git show with --no-pager, as it would otherwise
+	 * paginate the "git show" output only, not the output
+	 * from bisect_next_all(); this can be fixed by moving
+	 * it into a --format parameter, but that would override
+	 * the user's default options for "git show", which we
+	 * are trying to honour.
+	 */
+	strvec_pushl(&show.args,
+	             "--no-pager",
+	             "show",
+	             "--stat",
+	             "--summary",
+	             "--no-abbrev-commit",
+	             "--diff-merges=first-parent",
+	             oid_to_hex(&commit->object.oid),
+	             NULL);
+	show.git_cmd = 1;
+	if (run_command(&show))
+		die(_("unable to start 'show' for object '%s'"),
+		    oid_to_hex(&commit->object.oid));
  }

  /*
@@ -1092,7 +1102,7 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
  		printf("%s is the first %s commit\n", oid_to_hex(bisect_rev),
  			term_bad);

-		show_diff_tree(r, prefix, revs.commits->item);
+		show_commit(revs.commits->item);
  		/*
  		 * This means the bisection process succeeded.
  		 * Using BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND (-10)
-- 
2.39.2

