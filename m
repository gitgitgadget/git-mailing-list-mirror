Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEE054FAB
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 11:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710847467; cv=none; b=tvipIqHcAhNemw4CJHdRX2tkgqAYkcM8KlWk/al51iKSxmeP6Xdd7/8Rj/Fr82qZdWzHxkrRWCeVFqkml0KbdfDAYlRfPhwK6M45m5cwk+YOYBHzfYRpKZNtUbFfo5m1glkLLons7ham22GmZ48HDMJEbjaSxodhYunBVc1W0kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710847467; c=relaxed/simple;
	bh=XdMD5DKc7jJ4GfF5e10B85b7q6Nt51gJ091asD8uqVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0MpRuiCTR4mgeCy34daqJwzgA4PPo219SNXbbRmGzCLqeewbww7JsA4swLAtUuHHBcxnR1qRIli44LH12waLOzNS78pkyH5Xu4hSEszc33gMi7enBkpyUGIBer5/bIrcgzqh/hs1lnfS6pCtM3ydbi3JuV6JUfNA9YTWC6igxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=XrAFL8Ga; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="XrAFL8Ga"
Received: from localhost ([193.175.198.193])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42JBOIRi017030
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 19 Mar 2024 12:24:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1710847459; bh=XdMD5DKc7jJ4GfF5e10B85b7q6Nt51gJ091asD8uqVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XrAFL8Ga/4ZZAC3k6ML1LfOnNLh0nHZKSpednQWszRQPE8OXOOnEk6lXfyGnNqS1o
	 Eqa+a8NHuNjE1l3AtlhJ7r6Zxsf8D+TeX8wCLWFadRbDtH4kZnt84l2g4Uhr/xGrtN
	 dkqdLPaHn/przjP0GMlJQ1sxaDTNMiHWO3ixsoi4=
From: Dirk Gouders <dirk@gouders.net>
To: git@vger.kernel.org
Cc: Dirk Gouders <dirk@gouders.net>, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: [PATCH v2 4/5] MyFirstObjectWalk: fix description for counting omitted objects
Date: Tue, 19 Mar 2024 12:23:14 +0100
Message-ID: <33a18458891259565e553ab39301108ce642d02f.1710840596.git.dirk@gouders.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1710840596.git.dirk@gouders.net>
References: <cover.1710840596.git.dirk@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before the changes to count omitted objects, the function
traverse_commit_list() was used and its call cannot be changed to pass
a pointer to an oidset to record omitted objects.

Fix the text to clarify that we now use another traversal function to
be able to pass the pointer to the introduced oidset.

Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 Documentation/MyFirstObjectWalk.txt | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
index a06c712e46..981dbf917b 100644
--- a/Documentation/MyFirstObjectWalk.txt
+++ b/Documentation/MyFirstObjectWalk.txt
@@ -754,10 +754,11 @@ points to the same tree object as its grandparent.)
 === Counting Omitted Objects
 
 We also have the capability to enumerate all objects which were omitted by a
-filter, like with `git log --filter=<spec> --filter-print-omitted`. Asking
-`traverse_commit_list_filtered()` to populate the `omitted` list means that our
-object walk does not perform any better than an unfiltered object walk; all
-reachable objects are walked in order to populate the list.
+filter, like with `git log --filter=<spec> --filter-print-omitted`. We
+can ask `traverse_commit_list_filtered()` to populate the `omitted`
+list which means that our object walk does not perform any better than
+an unfiltered object walk; all reachable objects are walked in order
+to populate the list.
 
 First, add the `struct oidset` and related items we will use to iterate it:
 
@@ -778,8 +779,9 @@ static void walken_object_walk(
 	...
 ----
 
-Modify the call to `traverse_commit_list_filtered()` to include your `omitted`
-object:
+You need to replace the call to `traverse_commit_list()` to
+`traverse_commit_list_filtered()` to be able to pass a pointer to the
+oidset defined and initialized above:
 
 ----
 	...
-- 
2.43.0

