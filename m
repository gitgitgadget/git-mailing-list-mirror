Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B9516FF3A
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 21:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709240764; cv=none; b=ZcMIBVIN0Py0Ajq+6pHhI8boCbc7w7j+M9YjkEwDTI46XbIVvxzYdKQoyrUApIAmeYD9fQFAGapxHdDdBLh9SrnrxuT0FYTcwfBJcxZc+rv/l8Z8ljh4WzadXN0l2AIsnGURxVCc8WWrajmov/znrm8PFjA4IvaTLcx/lLDrdHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709240764; c=relaxed/simple;
	bh=Yp+Aadrak8/fcFkfma6f2HJfcwPwEMwYcyY9LFdeaKM=;
	h=From:To:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=P2UUYRRmZD8DQxqJqUzG3XMN6yvfgJ3N73fSvMB6TCUC9rcO4Sl5l5KOt+0ZixwnP1LeEzUMUfbaUoFx4eOzoLwvQ++9yi8GgDFIt3x7nZxg99HzY1+2iRPDE1lzxA9hcJi44G2RIIdCYb57D4i+5SgMCdP+DLyOKLbuUCkpXFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=kBDD24lb; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="kBDD24lb"
Received: from localhost (ip-109-42-177-171.web.vodafone.de [109.42.177.171])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 41TL5w0L019866
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 22:05:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1709240759; bh=Yp+Aadrak8/fcFkfma6f2HJfcwPwEMwYcyY9LFdeaKM=;
	h=From:To:Subject:In-Reply-To:Date:References;
	b=kBDD24lb9t/jylFgBFM2o7Nk9fg6iYY3kZI4I90BWpwuDoX3mY+NwF/Dom8X6zWY/
	 lGvd7SU0+5OV9ftQf6uIxPqh2KXGU3aUAeGmP3AR9CcJkUFrLiQ6gg+XLdGYAid3hX
	 inJEEWkZ5BNiMIp4ZnOvfq/9dZRV+P6bWb0QIuFU=
From: Dirk Gouders <dirk@gouders.net>
To: git list <git@vger.kernel.org>
Subject: [PATCH 1/1] Documentation/user-manual.txt: example for generating
 object hashes
In-Reply-To: <cover.1709240261.git.dirk@gouders.net>
Date: Thu, 29 Feb 2024 14:05:07 +0100
Message-ID: <a3902dad424983a4f0dfcda68e0b8bf64a0b2113.1709240261.git.dirk@gouders.net>
References: <cover.1709240261.git.dirk@gouders.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

If someone spends the time to work through the documentation, the
subject "hashes" can lead to contradictions:

The README of the initial commit states hashes are generated from
compressed data (which changed very soon), whereas
Documentation/user-manual.txt says they are generated from original
data.

Don't give doubts a chance: clarify this and present a simple example
on how object hashes can be generated manually.

Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 Documentation/user-manual.txt | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 6433903491..8dfb81e045 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -4095,6 +4095,39 @@ that is used to name the object is the hash of the original data
 plus this header, so `sha1sum` 'file' does not match the object name
 for 'file'.
 
+Starting with the initial commit, hashing was done on the compressed
+data and the file README of that commit explicitely states this:
+
+"The SHA1 hash is always the hash of the _compressed_ object, not the
+original one."
+
+This changed soon after that with commit
+d98b46f8d9a3 (Do SHA1 hash _before_ compression.).  Unfortunately, the
+commit message doesn't provide the detailed reasoning.
+
+The following is a short example that demonstrates how hashes can be
+generated manually:
+
+Let's asume a small text file with the content "Hello git.\n"
+-------------------------------------------------
+$ cat > hello.txt <<EOF
+Hello git.
+EOF
+-------------------------------------------------
+
+We can now manually generate the hash `git` would use for this file:
+
+- The object we want the hash for is of type "blob" and its size is
+  11 bytes.
+
+- Prepend the object header to the file content and feed this to
+  sha1sum(1):
+
+-------------------------------------------------
+$ printf "blob 11\0" | cat - hello.txt | sha1sum
+7217614ba6e5f4e7db2edaa2cdf5fb5ee4358b57 .
+-------------------------------------------------
+
 As a result, the general consistency of an object can always be tested
 independently of the contents or the type of the object: all objects can
 be validated by verifying that (a) their hashes match the content of the
-- 
2.43.0

