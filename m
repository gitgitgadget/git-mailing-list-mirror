Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504C756B6A
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 21:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710193661; cv=none; b=MLMqLZ2r9AUq+vUwA7Xl6f6zKB2GHE+w+qxzbFM2aCE3MFnvBsf/DuSMxH14AYpxPH/ngjdRO+RSIBzgXukg4ofV9M4cAnU6gdKOBSTYkUZGmBkx+ujQKq1B2rFbobUGxLi6/O5hGEL+WJgw9GMvX9S4RHz8nDvmD0Fvu7AZXAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710193661; c=relaxed/simple;
	bh=xEYWllW8G7d5UN1yoUMjwr/zGo8fXarZt4ba3/BxP+0=;
	h=From:To:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=EdkKSF2CaN7MLVw88Vk1zHtm7/MRyU7iT73GIMgD8rTnrIJteckmW+UUgbODdruafZK1VtGw6NpgKIkCHwARww+7GaDS+G2zyXE7j+p90b5+6iOZJpaL7M2ZDx2HRHjvvmyz+1TCM62ZikNKu8JHEQFipbZQlmnpwKsWz+/cTuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=O5Ca48Yk; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="O5Ca48Yk"
Received: from localhost (ip-109-42-178-223.web.vodafone.de [109.42.178.223])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42BLlarV032209
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 22:47:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1710193657; bh=xEYWllW8G7d5UN1yoUMjwr/zGo8fXarZt4ba3/BxP+0=;
	h=From:To:Subject:In-Reply-To:Date:References;
	b=O5Ca48YkO3H+nhVxSlSESdIscNGukqH8Rr4OJfp4KIVkdEk0232fsgFiTt0vuR6ET
	 2IoZlkmloWIBKJrzHYV7MkXUxGc/Ei5+rEi62wzCmiclwQVFS8KNwjjGpq9bPFVdqj
	 Lnk4YnGU+WL2u7NB1KLkRwvJ3MQ/3Rsb+pxeuSgM=
From: Dirk Gouders <dirk@gouders.net>
To: git@vger.kernel.org
Subject: [PATCH 5/5] MyFirstObjectWalk: add stderr to pipe processing
In-Reply-To: <cover.1710192973.git.dirk@gouders.net>
Date: Mon, 11 Mar 2024 22:00:12 +0100
Message-ID: <a2d30eff217e560873c49fe45116c784dc12fd32.1710192973.git.dirk@gouders.net>
References: <cover.1710192973.git.dirk@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

In the last chapter of this document, pipes are used in commands to
filter out the first/last trace messages.  But according to git(1),
trace messages are sent to stderr if GIT_TRACE is set to '1', so those
commands do not produce the described results.

Fix this by using the operator '|&' to additionally connect stderr to
stdin of the latter command.

Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 Documentation/MyFirstObjectWalk.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
index 981dbf917b..b96724c4d7 100644
--- a/Documentation/MyFirstObjectWalk.txt
+++ b/Documentation/MyFirstObjectWalk.txt
@@ -847,7 +847,7 @@ those lines without having to recompile.
 With only that change, run again (but save yourself some scrollback):
 
 ----
-$ GIT_TRACE=1 ./bin-wrappers/git walken | head -n 10
+$ GIT_TRACE=1 ./bin-wrappers/git walken |& head -n 10
 ----
 
 Take a look at the top commit with `git show` and the object ID you printed; it
@@ -875,7 +875,7 @@ of the first handful:
 
 ----
 $ make
-$ GIT_TRACE=1 ./bin-wrappers git walken | tail -n 10
+$ GIT_TRACE=1 ./bin-wrappers git walken |& tail -n 10
 ----
 
 The last commit object given should have the same OID as the one we saw at the
-- 
2.43.0

