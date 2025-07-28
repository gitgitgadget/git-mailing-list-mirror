Received: from mail4.tt-solutions.com (mail4.tt-solutions.com [83.229.82.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C39645
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 23:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.229.82.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753744672; cv=none; b=OhYB4F+2Mx/I4zBaWWaLpTPltygreFo8gRZYdMoXyHTsHvVORaTsOjJMFGjQuBBCL0pgwmWdWWz+5zS0rwUqJ21pvtJjz9ioiHeSBRZixNvwNGHiHv7XmO8ypSrIU68YZnOE7eAe4Fw8PyHNxAVWxiKnUQS5vYgi27P2Hvclnh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753744672; c=relaxed/simple;
	bh=yeWu4Z6ZTjXJhTMhKMF7nsHrrU+fmLaOJzmYnebBRQk=;
	h=Date:From:Subject:To:cc:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:References:In-Reply-To; b=hIoMsxExBSlY0Mzp4xkPy8DVK+K+h/QR+rCJEbzBAvbO9qNehBYe6Fk2EWZiAQmbUcNZGJgT5utI1foebXMB/JYND5T2W9GukoSPuoArq+JeBFQy2zWAUTVCJLwWJjX0bxdQbMk109Zp/1JFJGtngq7IK+tKhfdP4q8s27hImAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zeitlins.org; spf=pass smtp.mailfrom=zeitlins.org; dkim=pass (2048-bit key) header.d=zeitlins.org header.i=@zeitlins.org header.b=HuRF9hZq; arc=none smtp.client-ip=83.229.82.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zeitlins.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zeitlins.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zeitlins.org header.i=@zeitlins.org header.b="HuRF9hZq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=zeitlins.org; s=mlr; h=In-Reply-To:References:Content-Type:MIME-Version:
	Message-ID:cc:To:Subject:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=39ZSCA5HHtXISEcvSJj3SBjN3t9HUFHT0wxqxoxMJWc=; b=HuRF9hZqfjh4vfs18FASHSe3xY
	Y5PJVxngJrpdco5TBsJKVAVNIKJ170LkAGRKR7iTo37Ivu4IgtZPOsrpiUUPtBN276BjwP7XJwO2l
	Bq4h4DQbBbD8o5IBiNA6PRl4U2QT60vBehNGXB2WIZPfpcVoSbFQGjRO+3IRbmau+1rzua9BHedvm
	2x6WXCoBjVy+7L3eDaTwo/s+70vE50pj20Ymn0SpMKHQtVQZyavOUO/pJaGBdOp8SyfvHLfChUN+Q
	FnEOfC70wlLrFFvQclF04zKwZtmCidlVl9BY4g94yv/ut8ZOobG489wIgpQbZAbeWr7RehWuWqsJe
	+lz4Qumg==;
Received: from [192.168.17.23] (helo=dark)
	by smtp.tt-solutions.com with esmtp (Exim 4.96)
	(envelope-from <vadim@zeitlins.org>)
	id 1ugX1Y-001v0T-2e;
	Tue, 29 Jul 2025 01:12:52 +0200
Date: Tue, 29 Jul 2025 01:12:52 +0200
From: Vadim Zeitlin <vadim@zeitlins.org>
Subject: [PATCH] submodule: Add a config option to skip path validation
To: git@vger.kernel.org
cc: Junio C Hamano <gitster@pobox.com>, "brian m. carlson" <sandals@crustytoothpaste.net>
Message-ID: <Mahogany-0.68.0-3185915-20250729-011252.01@dark.tt-solutions.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE
References: <Mahogany-0.68.0-2854301-20250107-230058.01@dark.tt-solutions.com>
    <Z320RGb0tqNyvvxt@tapette.crustytoothpaste.net>
    <xmqq5xmqqk9j.fsf@gitster.g>
    <Mahogany-0.68.0-2854301-20250108-005035.01@dark.tt-solutions.com>
    <xmqqjzb5nvhd.fsf@gitster.g>
    <Mahogany-0.68.0-2854301-20250108-203000.01@dark.tt-solutions.com>
In-Reply-To: <Mahogany-0.68.0-2854301-20250108-203000.01@dark.tt-solutions.com>
X-Mailer: Mahogany 0.68.0 'Cynthia', compiled for Linux 6.12.20-amd64 x86_64

On Wed, 8 Jan 2025 20:30:00 +0100 I wrote:

Me> On Wed, 08 Jan 2025 08:03:42 -0800 Junio C Hamano <gitster@pobox.com> wrote:
[...]
Me> JCH> If the answers are no and/or yes, "submodule.validate=no" sounds like
Me> JCH> a reasonable choice, but I am not good at naming, so we may want to
Me> JCH> hear ideas from others.
Me> 
Me>  I'll wait for some time to hear if anybody else has any better suggestions.

 Hello again,

 I guess more than half a year can be considered "some time" but, anyhow,
better late than never, so here is a minimal patch implementing what I
suggested. I'm not sure if using submodule_from_path() with the global
the_repository is the right thing to do, it looks like there is an attempt
to move away from it, but I couldn't find another reasonable way to get the
config option -- using open_submodule() doesn't seem right and I don't know
what else to do. If you can propose a better way to do this, please do.

 I also couldn't find a simple way to add a test for it, I hoped to find an
existing test checking that using symlinks for submodules failed and amend
it, but either no such test exists or I've failed to find it. Again, if I
missed it, please point me to it. But for now I've just tested this
manually, with and without the option in gitconfig file.

 Please let me know if you have any other comments, thanks in advance!
VZ

--------------------------------- >8 --------------------------------------
From 071e8f1b47dfa22cbe99052810ab5123489731b0 Mon Sep 17 00:00:00 2001
From: Vadim Zeitlin <vadim@zeitlins.org>
Date: Tue, 29 Jul 2025 01:02:10 +0200
Subject: [PATCH] submodule: Add a config option to skip path validation

The changes of e8d0608944 (submodule: require the submodule path to
contain directories only, 2024-03-26) as part of "defense in depth"
strategy made it impossible to intentionally use symlinks instead of
actual submodule directories, which can be desirable when the same big
submodule is used by multiple projects.

Reintroduce the possibility to do it by adding a new
submodule.<name>.validate option which defaults to 1, but can be
explicitly set to 0 to disable the submodule path validation.

Signed-off-by: Vadim Zeitlin <vadim@zeitlins.org>
---
 Documentation/config/submodule.adoc |  8 ++++++++
 submodule.c                         | 19 ++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/submodule.adoc b/Documentation/config/submodule.adoc
index 0672d99117..92243458c2 100644
--- a/Documentation/config/submodule.adoc
+++ b/Documentation/config/submodule.adoc
@@ -106,3 +106,11 @@ submodule.alternateErrorStrategy::
 	`ignore`, `info`, `die`. Default is `die`. Note that if set to `ignore`
 	or `info`, and if there is an error with the computed alternate, the
 	clone proceeds as if no alternate was specified.
+
+submodule.validate::
+    A boolean value which can be set to false to disable validation of
+    submodule paths and notably checking that they don't contain any symlink
+    components. This can be useful when working with a trusted repository and
+    intentionally using symlinks to avoid checking out another copy of the same
+    submodule which already exists elsewhere on the same machine.
+    Defaults to true.
diff --git a/submodule.c b/submodule.c
index f8373a9ea7..01b852c673 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2299,11 +2299,28 @@ int validate_submodule_git_dir(char *git_dir, const char *submodule_name)
 
 int validate_submodule_path(const char *path)
 {
-	char *p = xstrdup(path);
+	char *key = NULL;
+	int validate = 1;
+
+	char *p = NULL;
 	struct stat st;
 	int i, ret = 0;
 	char sep;
 
+	const struct submodule *submodule;
+
+	submodule = submodule_from_path(the_repository, null_oid(the_hash_algo), path);
+	if (!submodule)
+		BUG("could not get submodule information for '%s'", path);
+
+	/* Check if submodule.<name>.validate is set to false to skip the check. */
+	key = xstrfmt("submodule.%s.validate", submodule->name);
+	repo_config_get_bool(the_repository, key, &validate);
+	free(key);
+	if (!validate)
+		return 0;
+
+	p = xstrdup(path);
 	for (i = 0; !ret && p[i]; i++) {
 		if (!is_dir_sep(p[i]))
 			continue;
-- 
2.47.2

