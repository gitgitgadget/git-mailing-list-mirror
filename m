Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17622264B0
	for <git@vger.kernel.org>; Tue, 17 Jun 2025 21:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750195857; cv=none; b=oGk9Wg0ptzh7zLBYqToHqzCk6hfY6E6hOutCUh6ZTSTprSjaDuGwKIqq/XXMT3Uxqpr9uZMvC2G8Ej1BZJcfH5UteFF6fDzLSOpqqGkMPUAlnzv7aLwaNxaqZvPnNtWsH32o4E5Ooprfk6R7PZvaDfBlzC7fcTTz4NbpGMpxrIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750195857; c=relaxed/simple;
	bh=mynLxKqTTgDGP3kLeqEFoSUvsERqeOfP2+rqMd8Ugfo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eoekdzAMLCwN73gNOVX/INJc1BelyHzAnp+BhS2t9doi/LVmbB7g3HohfosNtB4PlxOgK6dSaq2FvPV1DZi0sLc2W/1RNtxuYeTLtQU2mSrCD6b6IBJ3Vq6p6dcaZHMiDt+tUcipGhmDAEtKEennpmBsnNvGkAUhg2xmks5xuo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FMtA9Qyx; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FMtA9Qyx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750195855; x=1781731855;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=mynLxKqTTgDGP3kLeqEFoSUvsERqeOfP2+rqMd8Ugfo=;
  b=FMtA9QyxHz81vLjDzWDbGzbutXsJgERSEVPNtFFnO3eeqzIDQys2XQTN
   nO5HeB6x0sXJZ4aK/lR5P+kTH6qQ2H59gxu4L2UgBUr5Ya4JTM99Mf0To
   gUSs/mlNyohifxGiFWol8EvSoqzisZk9OMX1Fi+CTuW6a+gNCkFZqH8xt
   VRUz7vEalyTzs16xXkIn0vqCWtiZTxQQss2koHooMSp5jUDRMj37PZIEG
   p6XR+MN6O1O0tkqdDSiVA6hCArizqyNdwu/V3kV0k0wgQvzTsYafCNkMb
   hIEL346Zph6JK8oa+KZnRnxNAX8KBQGSM7JiEoPFUe7+S/OJcFuz2GDWZ
   Q==;
X-CSE-ConnectionGUID: gPSFRZjjTnmAOeABvpNnsw==
X-CSE-MsgGUID: vvEW21W5TIqWMBGVCqTs/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="56195375"
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="56195375"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 14:30:52 -0700
X-CSE-ConnectionGUID: SkLwS3KZS9+1XDE/pMmMDQ==
X-CSE-MsgGUID: QnAgmhlWTP6Rxi7J2n95Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="153856672"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 14:30:53 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 17 Jun 2025 14:30:41 -0700
Subject: [PATCH v2 1/6] remote: fix tear down of struct branch and struct
 remote
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-jk-submodule-helper-use-url-v2-1-04cbb003177d@gmail.com>
References: <20250617-jk-submodule-helper-use-url-v2-0-04cbb003177d@gmail.com>
In-Reply-To: <20250617-jk-submodule-helper-use-url-v2-0-04cbb003177d@gmail.com>
To: git@vger.kernel.org
Cc: Jacob Keller <jacob.keller@gmail.com>, 
 Lidong Yan <yldhome2d2@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

From: Jacob Keller <jacob.keller@gmail.com>

The branch_release() and remote_clear() functions fail to completely
release all of the memory they point to. This results in leaked memory
if you read the configuration for an arbitrary repository and then
release that repository.

This should be caught by the leak sanitizer. However, for callers which
use ``the_repository``, the values never go out of scope and the
sanitizer won't complain.

A future change is going to add a caller of read_config() for a
submodule repository structure. Doing so reveals one immediate issue due
to a bad NULL pointer access, as well as the mentioned leaks.

 * The branch->merge array is accessed without checking if its NULL.
   Since this array is only setup by calling set_merge, it may in fact
   not be initialized even though merge_nr is non-zero.

 * The remote->push and remote->fetch refspecs are never cleared.

 * The branch->merge_name array is never cleared.

 * The individual elements of branch->merge are not released.

Add a check against branch->merge before accessing it and calling
refspec_item_clear. Update remote_clear() with calls to refspec_clear()
for both the push and fetch refspecs. Add a release of the merge_name
items as well as a final release of the merge_name array.

Freeing merge_name elements results in a warning because we discard the
const qualifier on the parameter name. These values come from a call to
add_merge() in handle_config(), which always copies the names with
xstrdup. This makes ownership of the memory difficult to track in the
code.

Move the call to xstrdup inside add_merge() so that its clear that the
memory is duplicated here and must be released when the merge_name array
is released. Drop the const qualifier on the branch structure to allow
calling free without an explicit cast.

These changes make it safe to call read_config() on a submodule
repository without crashing or leaking any of the memory when the
submodule repository is released.

There is still some confusion with the difference between branch->merge
and branch->merge_name, and the confusion of using branch->merge_nr for
both. That could probably use some future cleanup.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 remote.h |  2 +-
 remote.c | 18 ++++++++++++++----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/remote.h b/remote.h
index 7e4943ae3a70ecefa3332d211084762ca30b59b6..0fca14348fd3d0734c599b13278afef2e00107b9 100644
--- a/remote.h
+++ b/remote.h
@@ -316,7 +316,7 @@ struct branch {
 	char *pushremote_name;
 
 	/* An array of the "merge" lines in the configuration. */
-	const char **merge_name;
+	char **merge_name;
 
 	/**
 	 * An array of the struct refspecs used for the merge lines. That is,
diff --git a/remote.c b/remote.c
index 4099183cacdc8a607a8b5eaec86e456b2ef46b48..538d0d24c832ffeb1cc14684eb166c62c42d719d 100644
--- a/remote.c
+++ b/remote.c
@@ -165,6 +165,9 @@ static void remote_clear(struct remote *remote)
 	strvec_clear(&remote->url);
 	strvec_clear(&remote->pushurl);
 
+	refspec_clear(&remote->push);
+	refspec_clear(&remote->fetch);
+
 	free((char *)remote->receivepack);
 	free((char *)remote->uploadpack);
 	FREE_AND_NULL(remote->http_proxy);
@@ -176,7 +179,7 @@ static void add_merge(struct branch *branch, const char *name)
 {
 	ALLOC_GROW(branch->merge_name, branch->merge_nr + 1,
 		   branch->merge_alloc);
-	branch->merge_name[branch->merge_nr++] = name;
+	branch->merge_name[branch->merge_nr++] = xstrdup(name);
 }
 
 struct branches_hash_key {
@@ -253,9 +256,16 @@ static void branch_release(struct branch *branch)
 	free((char *)branch->refname);
 	free(branch->remote_name);
 	free(branch->pushremote_name);
-	for (int i = 0; i < branch->merge_nr; i++)
-		refspec_item_clear(branch->merge[i]);
+	for (int i = 0; i < branch->merge_nr; i++) {
+		if (branch->merge) {
+			refspec_item_clear(branch->merge[i]);
+			free(branch->merge[i]);
+		}
+		if (branch->merge_name)
+			free(branch->merge_name[i]);
+	}
 	free(branch->merge);
+	free(branch->merge_name);
 }
 
 static struct rewrite *make_rewrite(struct rewrites *r,
@@ -429,7 +439,7 @@ static int handle_config(const char *key, const char *value,
 		} else if (!strcmp(subkey, "merge")) {
 			if (!value)
 				return config_error_nonbool(key);
-			add_merge(branch, xstrdup(value));
+			add_merge(branch, value);
 		}
 		return 0;
 	}

-- 
2.48.1.397.gec9d649cc640

