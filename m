Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936535EE64
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 11:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711538598; cv=none; b=ZZpdGvaTWxbZ6+WuNx+k01ZEXCj5hrEK/KZUFPuPXFnxErrx61MeVJvqMigPtGBt5OLdEzvhcHU7qvFo9ymZeFqSn+C8sQ/BJ8+N6yijb1FbQCYzNpyFEB3Hi7Cc2Sal6u7C/B7PPN9o4/mAeh/nuC3gWiY17bZzFpta5dXDOQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711538598; c=relaxed/simple;
	bh=f4Djj4f0AJMe22bSDVodPVpgugRTrnmC7VVyAz7RBqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sAlNwa2xYatJBiQ4JJ+YgWyyrkr/2ChnXBS1oVwXy3oPVVqy5gzAIeHppoV9B39y8ThGQVzwQXRCuoYr/WMTjFkg4xpPtT+e2lRy/2/hPLht9cXj0/FVo31+qfky1Yib+0GXSVYJ9yW/lZrl4eHwoDDmjbzM6owR6dp4eSobM3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=SO/e6cCX; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="SO/e6cCX"
Received: from localhost ([193.175.198.193])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42RBN8Zj003326
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 27 Mar 2024 12:23:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1711538588; bh=f4Djj4f0AJMe22bSDVodPVpgugRTrnmC7VVyAz7RBqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SO/e6cCXfvzyU19Lgm3QAwSD40UTpRFzIe9AVh/IxFQFBUv0m3O1vJeVRONsEluCn
	 rU9B2sxtQfglYUKpPlLpMYtVITvkcrUrg4Xb+ZC41W52pCvmekElWDKGkSO86YI2EO
	 Bzh7Icjz9rpvUDMV5vKiZOM+OAxlVzopTAQnL7OE=
From: Dirk Gouders <dirk@gouders.net>
To: git@vger.kernel.org
Cc: Dirk Gouders <dirk@gouders.net>, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Kyle Lippincott <spectral@google.com>
Subject: [PATCH v5 5/5] MyFirstObjectWalk: add stderr to pipe processing
Date: Wed, 27 Mar 2024 12:22:16 +0100
Message-ID: <0a3dbd14525ba9784ed8d5c329e757d5068e8b36.1711537370.git.dirk@gouders.net>
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
index e969a3a68a..dec8afe5b1 100644
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

