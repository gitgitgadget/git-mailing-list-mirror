Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA6924A046
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 06:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764137418; cv=none; b=IGbhI3dxIbkcG6h3Frdh361XHm+XUHDAHcb9vZ2x/+hUpLQvVIFNz6EMVxEn8FmaqEiMqnvWrHc9AW6sGL0FlINcKUCHtq+YHc07zLa6bvPUgfxDSuGvDCvjViAc4+OKQbP2nK54aaJ9r1fO6uL3fGJqdbQ5nYbO1H00KOqSgQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764137418; c=relaxed/simple;
	bh=D+HDLeGvK2SMbm4MgR0+ifnEHEwSQoddrKCNEk/Dpig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uD3aPnMs4kU+t+prmVfYD6+EDmEKtrRqaX7zd2YWvP38IsMIv0gU34O1LH7XZLgqzEb75eVdsWiGwGFICIZ+/NS04Sfx+p5+hXfDJ2/yQaBOXgN9ur87U7+w3bm5djFvZkFXb1nVB+zrpYLgYLtXQoJrzwqpNrys5hhzQIi0KL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=heFrWAZ1; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="heFrWAZ1"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1764137412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=33YyOxXCBuHjh6P7vxRr2hLQMmSfSFxxLA5p0olUAVo=;
	b=heFrWAZ1GqssaW9fDvhQIX6oMVOnkwYGkgzZwnN2aVghvZDNk8ajJDWFM5iFjQfS03HRd8
	9SpTsoenRshl51zxuyN8OEvEg8msV3eisXewMwKVNnhDY79rau/fowFNFv3P9GFINF2pXs
	gC/Yxs+YDWXtbL3jmFrSIm9fdOdDE1s=
From: Toon Claes <toon@iotcl.com>
Date: Wed, 26 Nov 2025 07:09:45 +0100
Subject: [PATCH 3/3] last-modified: better document how depth in handled
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-toon-last-modified-zzzz-v1-3-608350df0caa@iotcl.com>
References: <20251126-toon-last-modified-zzzz-v1-0-608350df0caa@iotcl.com>
In-Reply-To: <20251126-toon-last-modified-zzzz-v1-0-608350df0caa@iotcl.com>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

By default git-last-modified(1) only shows information about paths at
the root level. This can be confusing. Clarify the command's behavior in
the documentation.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 Documentation/git-last-modified.adoc | 43 ++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/Documentation/git-last-modified.adoc b/Documentation/git-last-modified.adoc
index 8409daebe9..36f72954a5 100644
--- a/Documentation/git-last-modified.adoc
+++ b/Documentation/git-last-modified.adoc
@@ -27,6 +27,7 @@ OPTIONS
 `--recursive`::
 	Instead of showing tree entries, step into subtrees and show all entries
 	inside them recursively.
+	See the section "NOTES ABOUT DEPTH" below for more details.
 
 `-t`::
 `--show-trees`::
@@ -38,6 +39,7 @@ OPTIONS
 	levels of directories. A negative value means no limit.
 	Setting a positive value implies `--recursive`.
 	Cannot be combined with wildcards in the pathspec.
+	See the section "NOTES ABOUT DEPTH" below for more details.
 
 `-z`::
 	Terminate each line with a _NUL_ rather than a newline.
@@ -70,6 +72,47 @@ avoid quoting, pass option `-z` to terminate each line with a NUL.
  <oid> TAB <path> NUL
 ------------
 
+NOTES ABOUT DEPTH
+-----------------
+
+By default this command only shows information about paths at the root level.
+When a path that lives in a subtree is provided, information about the top-level
+subtree is printed. For example:
+
+------------
+$ git last-modified -- sub/file
+
+abcd1234abcd1234abcd1234abcd1234abcd1234 sub
+------------
+
+To get details about the exact path in a subtree, add option `--recursive`:
+
+------------
+$ git last-modified --recursive -- sub/file
+
+5678abca5678abca5678abca5678abca5678abca sub/file
+------------
+
+This comes with a downside. When the path provided is a tree itself, with
+option `--recursive` all paths in that subtree are printed too:
+
+------------
+$ git last-modified --recursive -- sub/subsub
+
+1234cdef1234cdef1234cdef1234cdef1234cdef sub/subsub/a
+3456cdef3456cdef3456cdef3456cdef3456cdef sub/subsub/b
+5678abcd5678abcd5678abcd5678abcd5678abcd sub/subsub/c
+------------
+
+To stop this command from traversing deeper into trees, add option
+`--max-depth=0`:
+
+------------
+$ git last-modified --recursive --max-depth=0 -- sub/subsub
+
+3456def3456def3456def3456def3456def3456b sub/subsub
+------------
+
 SEE ALSO
 --------
 linkgit:git-blame[1],

-- 
2.51.2

