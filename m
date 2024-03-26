Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A5474BE8
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 13:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711458588; cv=none; b=gtKWUk+VXS4WQ75z4QXiI5CPe+2LSYKq5bcKykWMXjThWVo7e/PsPya30uL3mNFAXoGpBxhhDDOxpF0TWG+bfmuUDcEgnpuGVSh6wvkyWYqF91/bvnOVlX8+seZc0sNemAqnnZrPxxVyttjaolgmhYai8bwxKToYdVrtxvPDN1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711458588; c=relaxed/simple;
	bh=wghaP0s2MnPKElJKstvS5+NKe1NTbmB/eOL39kddtn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hzV7HpkyAr3EhdJYf0MdZxSfG+yRflsMW9VXwK7nM8EACXIlEAOXLIyPlIyCsV/swh4YGqmaMjterGlKWyldy8djos/SUgMgMgYPzmv3xKdKWkMmBB3DuohEkt9hK1owGJWSDvyijMG/FS7QHZrUUruT9nxSsyj7fuYmqm7i47w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=t7dK5bz8; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="t7dK5bz8"
Received: from localhost ([193.175.198.193])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42QD9bZK006405
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 26 Mar 2024 14:09:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1711458577; bh=wghaP0s2MnPKElJKstvS5+NKe1NTbmB/eOL39kddtn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=t7dK5bz8iYnpMLPPnATq2lv02z1wP5CTyxsENPFejNjtH42X7iAlkNOd+TSE21yO+
	 z0i5TAHtacwzv6Y+ccVHzCKG+wS3m26349FkFChKPraseyNPJl0LSGjG2pnaW7rqz/
	 etmfqYneE3Ho7Z1aJ7RYXMVxgwwG31sOSuSLeL0I=
From: Dirk Gouders <dirk@gouders.net>
To: git@vger.kernel.org
Cc: Dirk Gouders <dirk@gouders.net>, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Kyle Lippincott <spectral@google.com>
Subject: [PATCH v4 5/5] MyFirstObjectWalk: add stderr to pipe processing
Date: Tue, 26 Mar 2024 14:08:40 +0100
Message-ID: <20240326130902.7111-6-dirk@gouders.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1711368498.git.dirk@gouders.net>
References: <cover.1711368498.git.dirk@gouders.net>
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
index 6901561263..90446c30a4 100644
--- a/Documentation/MyFirstObjectWalk.txt
+++ b/Documentation/MyFirstObjectWalk.txt
@@ -848,7 +848,7 @@ those lines without having to recompile.
 With only that change, run again (but save yourself some scrollback):
 
 ----
-$ GIT_TRACE=1 ./bin-wrappers/git walken | head -n 10
+$ GIT_TRACE=1 ./bin-wrappers/git walken 2>&1 | head -n 10
 ----
 
 Take a look at the top commit with `git show` and the object ID you printed; it
@@ -876,7 +876,7 @@ of the first handful:
 
 ----
 $ make
-$ GIT_TRACE=1 ./bin-wrappers git walken | tail -n 10
+$ GIT_TRACE=1 ./bin-wrappers/git walken 2>&1 | tail -n 10
 ----
 
 The last commit object given should have the same OID as the one we saw at the
-- 
2.43.0

