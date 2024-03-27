Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1FB4F1FB
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 11:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711538595; cv=none; b=nQ0Do8wG2IYkjEda+aHfmSlYY8/0NkjUyPu8zztAv4hobX67h7pm7TD+cqwAT1WOurlXZcuOaqHXLNDMRwwQOS3R3Uq6Dgo8Vp0bZMtbcZ0u3aWnoNDBymWimLzGox9deK3RXVwfzQvvOCsklVsz5OG9ZgTtMGgieylHHXS7bNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711538595; c=relaxed/simple;
	bh=gec2sNstkboCxx2/BhYtIebS0mK+21ErEFXRShlJo1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WIW6zjD6DSlilqq1Ax4eEHmQQ1Q3VRiwUjrN6JpkrAOEuoQa9HQix6wp6P2LY9R+Vv6KdAzCtm9qz9Ma4DmkqOKh6A7OFKgD+HPeu1PFGUVJUT+1KwyGQwLg+oso/4gO73yKBQ3tP+G/oWoYgtvD3oN25rrDfpE5494NQI3wpsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=t4GGkkjU; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="t4GGkkjU"
Received: from localhost ([193.175.198.193])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42RBN3W7003317
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 27 Mar 2024 12:23:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1711538583; bh=gec2sNstkboCxx2/BhYtIebS0mK+21ErEFXRShlJo1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=t4GGkkjUsldpKVAR//zjjmExCfwO0fkiLhM1HX2WRb4hx3QXzZf50zp6np7wP6MQo
	 g+rcJYMyvWkkKW/+qZbQCKw2QiEG+OMbFExLg8KUZa7hSWM11kOcIpD8RVIHeAFNEi
	 zVV0hcwbJvoGz/asuT+RgcIf92E5jyydno1MAcbk=
From: Dirk Gouders <dirk@gouders.net>
To: git@vger.kernel.org
Cc: Dirk Gouders <dirk@gouders.net>, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Kyle Lippincott <spectral@google.com>
Subject: [PATCH v5 4/5] MyFirstObjectWalk: fix description for counting omitted objects
Date: Wed, 27 Mar 2024 12:22:15 +0100
Message-ID: <e6030f1c0a918deae6f7d9a6353cb8cc3df1ef80.1711537370.git.dirk@gouders.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1711537370.git.dirk@gouders.net>
References: <20240326130902.7111-1-dirk@gouders.net> <cover.1711537370.git.dirk@gouders.net>
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

Helped-by: Kyle Lippincott <spectral@google.com>
Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 Documentation/MyFirstObjectWalk.txt | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
index a06c712e46..e969a3a68a 100644
--- a/Documentation/MyFirstObjectWalk.txt
+++ b/Documentation/MyFirstObjectWalk.txt
@@ -754,10 +754,12 @@ points to the same tree object as its grandparent.)
 === Counting Omitted Objects
 
 We also have the capability to enumerate all objects which were omitted by a
-filter, like with `git log --filter=<spec> --filter-print-omitted`. Asking
-`traverse_commit_list_filtered()` to populate the `omitted` list means that our
-object walk does not perform any better than an unfiltered object walk; all
-reachable objects are walked in order to populate the list.
+filter, like with `git log --filter=<spec> --filter-print-omitted`. To do this,
+change `traverse_commit_list()` to `traverse_commit_list_filtered()`, which is
+able to populate an `omitted` list.  Asking for this list of filtered objects
+may cause performance degradations, however, because in this case, despite
+filtering objects, the possibly much larger set of all reachable objects must
+be processed in order to populate that list.
 
 First, add the `struct oidset` and related items we will use to iterate it:
 
@@ -778,8 +780,9 @@ static void walken_object_walk(
 	...
 ----
 
-Modify the call to `traverse_commit_list_filtered()` to include your `omitted`
-object:
+Replace the call to `traverse_commit_list()` with
+`traverse_commit_list_filtered()` and pass a pointer to the `omitted` oidset
+defined and initialized above:
 
 ----
 	...
-- 
2.43.0

