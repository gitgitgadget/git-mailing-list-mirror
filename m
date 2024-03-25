Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3629B174970
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 13:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372801; cv=none; b=cWQaLoBq9GtbvzCaByWPHLyiijkG1HfAIa+EqeOPiWFTU12yCFjDCtR4km7SSu5T2Iah//V1I4lvo+L5KKxWdHt6jKcA6Yh3eDHl7Tjh6KjK4hc188VHq+2jXTnsS0HeLWkEiegi48jKKuoJ4q0JLvkj+oYiYyv0Q6cZuJF1oOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372801; c=relaxed/simple;
	bh=LhrhyYN2aG5AX2pcBpKXUA5jSGvny8BN3UUFZR8c9oY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXMMfUx7/7ADnsPoqnebWLj1Z3eZkXkg+zQ/ENmbUXq10psDPYvWiNVLsW/i2Kii/NxI+7JoOzYAO/tOeVidkVB7QNHzT8B09ufq1VbuSbM+E+cK4tuAbFbVJtcYnDAgB6VRR/LxQ5R7kdc41GG8dsVlp2MiXGxv+jSldB6bzxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=GVQIDvfO; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="GVQIDvfO"
Received: from localhost (ip-109-42-177-242.web.vodafone.de [109.42.177.242])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42PDJmCx003647
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 25 Mar 2024 14:19:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1711372789; bh=LhrhyYN2aG5AX2pcBpKXUA5jSGvny8BN3UUFZR8c9oY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GVQIDvfOnQUq5UiOMAwnGwvGGKQedywBEEhs0IY6DW2CFGYS3C5P6ht7XgY17plEn
	 G92Jmu858Y8F8YwvQZ3QsSx9yVJiTnE5Oka1QuPcKDWZG/vQh90rs/MAxXgAG8bpPM
	 ccfDt1GBvU4UZUF5Gm/2vVyOrVccncdaheQOqshU=
From: Dirk Gouders <dirk@gouders.net>
To: git@vger.kernel.org
Cc: Dirk Gouders <dirk@gouders.net>, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Kyle Lippincott <spectral@google.com>
Subject: [PATCH v3 5/5] MyFirstObjectWalk: add stderr to pipe processing
Date: Mon, 25 Mar 2024 13:33:36 +0100
Message-ID: <c571abb49dc3c03d86434deeaddf91c477bb3ce1.1711368499.git.dirk@gouders.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1711368498.git.dirk@gouders.net>
References: <cover.1710840596.git.dirk@gouders.net> <cover.1711368498.git.dirk@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the last chapter of this document, pipes are used in commands to
filter out the first/last trace messages.  But according to git(1),
trace messages are sent to stderr if GIT_TRACE is set to '1', so those
commands do not produce the described results.

Fix this by redirecting stderr to stdout prior to the pipe operator
to additionally connect stderr to stdin of the latter command.

Further, while reviewing the above fix, Kyle Lippincott noticed
a second issue with the second of the examples: a missing slash in the
executable path "./bin-wrappers git".

Add the missing slash.

Helped-by: Kyle Lippincott <spectral@google.com>
Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 Documentation/MyFirstObjectWalk.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
index 811175837c..3d78403c4a 100644
--- a/Documentation/MyFirstObjectWalk.txt
+++ b/Documentation/MyFirstObjectWalk.txt
@@ -847,7 +847,7 @@ those lines without having to recompile.
 With only that change, run again (but save yourself some scrollback):
 
 ----
-$ GIT_TRACE=1 ./bin-wrappers/git walken | head -n 10
+$ GIT_TRACE=1 ./bin-wrappers/git walken 2>&1 | head -n 10
 ----
 
 Take a look at the top commit with `git show` and the object ID you printed; it
@@ -875,7 +875,7 @@ of the first handful:
 
 ----
 $ make
-$ GIT_TRACE=1 ./bin-wrappers git walken | tail -n 10
+$ GIT_TRACE=1 ./bin-wrappers/git walken 2>&1 | tail -n 10
 ----
 
 The last commit object given should have the same OID as the one we saw at the
-- 
2.43.0

