Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEA456B6A
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 21:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710193620; cv=none; b=trSphzG/yVN1Uso2fybEdqSOeNM9dnt6JXrnFcAB6WbH0Wob98UxnD/XPcmBQx5ss30G9qKJdxdKEVakBTVk8xwrLd0w4tswUC92P6OZQQiigjHi+1/ocDJl7X8HrJk/1XAa4SpNvWIhqWT0AvNU+UvM6677I0qD0/aX9USuomo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710193620; c=relaxed/simple;
	bh=XdMD5DKc7jJ4GfF5e10B85b7q6Nt51gJ091asD8uqVk=;
	h=From:To:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=Na6C2/SRswodU0l748SU+AdpYUqfMRZRpeqHaSAVVzux5zaOIQi2WpWuDustXV3IYR1hEDLU9I2ekXvKYuaya8PDitoZJJRPDyrJY7A7Vr+uV5UGP6uEDGHKQ4+5jATl15ZnKywajKbWyHsvaBEzwMiQtevff5f9dniuTOZMZh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=m3mPYbbP; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="m3mPYbbP"
Received: from localhost (ip-109-42-178-223.web.vodafone.de [109.42.178.223])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42BLks9J032159
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 22:46:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1710193615; bh=XdMD5DKc7jJ4GfF5e10B85b7q6Nt51gJ091asD8uqVk=;
	h=From:To:Subject:In-Reply-To:Date:References;
	b=m3mPYbbPu820KRXamW3SrM05tSlol1TsG4JgMYr3rhghqwaHQhQOatmHquFsm+pgx
	 5wqjucK9EbwU7NIVJZVcFyKifgtsod2tvvI8nTKHBaNuuwdOqANNuVf9skTay2Y2Eu
	 n3mznGf96ae+awc0F90UvdehpEt5ZLVwvOIYScIg=
From: Dirk Gouders <dirk@gouders.net>
To: git@vger.kernel.org
Subject: [PATCH 4/5] MyFirstObjectWalk: fix description for counting omitted
 objects
In-Reply-To: <cover.1710192973.git.dirk@gouders.net>
Date: Mon, 11 Mar 2024 14:29:24 +0100
Message-ID: <637070dd48ceefc5c2b7a902dd5eb3ecde503894.1710192973.git.dirk@gouders.net>
References: <cover.1710192973.git.dirk@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

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

