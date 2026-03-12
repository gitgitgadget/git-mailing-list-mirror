Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F1C3F20EB
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 16:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773332427; cv=none; b=U2XAiYXcrYWymU2cmsLUE1YGp3fQNRraufsshaRHSL/qYq6LYDxmxVOe34Y2I+mhl9w8qT1oMw0bLKr+/XtooeAYQJ4WyF+tRH17IEeK35FzB8sjyfJWnjfzEfi74aTZMYblb5bHFoaV7bmRxjL6+qxdMi5bApH1yTMsXxbl9Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773332427; c=relaxed/simple;
	bh=iw7S92bjC8IwaVtwfzJMywGAtXr8PXxkrQhU1Ptnel0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/bzSJbjL8IdPPLx38ADt4RXzwHGC8sq1OJNIHSmbik1Le7WZXA0A7V6lEqg74ELbnsq5Ad7V73kKGCo+aUBFcQkzLZBeVayCv8qgQKY5vN0IottAmG8Kzu9r3DmgxBN5OST/roPjaeaCDpYFXha/zT7YuLZJ6WUGHyl+F7QMMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=fBkbg8if; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="fBkbg8if"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773332418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BkM/SHfKKKZbE7Ih8FwwWlidsxWPt50sw5EOTYMotBs=;
	b=fBkbg8ifa75U2pTh5geZB8p1eJJUsv3uH6xdUMz6aiVmOBiZaGaeCTPeyo1MA2K1k0cI1W
	V2qra+B6Jlh4tGEccoRk0KIyy/B1bDFhgfk5CA9MFfOXs++//0ORa5zdq1A05GvHCJWXGL
	Fs4J3ZXbJFUe7oKbUnljV0XITnCQVfCxQeGSZtnJp9cD11XJZdPaE9q7tV9vdB8HRDOcK+
	nZTfQ1DFDVzvaulQM+pLRMdkblOPZYOqzvvk1Od1At7fSiPPPIEisvtsSfCycOVR2GWa6v
	kwM17m0izoyTzzm+DFt4zHsVBu7420qF4OXb7u1rEk8JMXRz56abQlutV49Hmg==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH v8 3/4] format-patch: add "chronological" format for cover
Date: Thu, 12 Mar 2026 17:20:10 +0100
Message-ID: <b67f1c9603bac9ea464357c77743e71c27003bd2.1773331753.git.mroik@delayed.space>
In-Reply-To: <cover.1773331753.git.mroik@delayed.space>
References: <cover.1772839973.git.mroik@delayed.space> <cover.1773331753.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ----

Having a user craft a custom format spec everytime might be a hassle,
and having a common format that seems reasonable might make reviews
easier. This patch introduces a new simple preset called "chronological".

Teach make_cover_letter() the "chronological" format.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 Documentation/git-format-patch.adoc |  2 +-
 builtin/log.c                       |  3 +++
 t/t4014-format-patch.sh             | 11 +++++++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
index de36b87a85..6364fd1f5a 100644
--- a/Documentation/git-format-patch.adoc
+++ b/Documentation/git-format-patch.adoc
@@ -326,7 +326,7 @@ feeding the result to `git send-email`.
 	Specify the format in which to generate the commit list of the patch
 	series. This option is available if the user wants to use an
 	alternative to the default `shortlog` format. The accepted values for
-	format-spec are "shortlog" or a format string.
+	format-spec are "shortlog", "chronological" or a format string.
 	e.g. `%s (%an)`
 	If defined, defaults to the `format.commitListFormat` configuration
 	variable.
diff --git a/builtin/log.c b/builtin/log.c
index 4f22012395..12877a0ac2 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -50,6 +50,7 @@
 #define MAIL_DEFAULT_WRAP 72
 #define COVER_FROM_AUTO_MAX_SUBJECT_LEN 100
 #define FORMAT_PATCH_NAME_MAX_DEFAULT 64
+#define CHRONOLOGICAL "[%(count)/%(total)] %s"
 
 static unsigned int force_in_body_from;
 static int stdout_mboxrd;
@@ -1420,6 +1421,8 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 
 	if (format == NULL || !strcmp(format, "shortlog"))
 		generate_shortlog_cover_letter(&log, rev, list, nr);
+	else if (!strcmp(format, "chronological"))
+		generate_commit_list_cover(rev->diffopt.file, CHRONOLOGICAL, list, nr);
 	else
 		generate_commit_list_cover(rev->diffopt.file, format, list, nr);
 
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 631669c159..5ec527bce9 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -392,6 +392,17 @@ test_expect_success 'cover letter with subject, author and count' '
 	test_grep "^\[1/1\] This is a subject (A U Thor)$" patches/0000-cover-letter.patch
 '
 
+test_expect_success 'cover letter chronological' '
+	test_when_finished "git reset --hard HEAD~1" &&
+	test_when_finished "rm -rf patches result test_file" &&
+	touch test_file &&
+	git add test_file &&
+	git commit -m "This is a subject" &&
+	git format-patch --cover-letter \
+	--cover-letter-format="chronological" -o patches HEAD~1 &&
+	test_grep "^\[1/1\] This is a subject$" patches/0000-cover-letter.patch
+'
+
 cat > expected <<EOF
 
 
-- 
2.53.0.904.g2727be2e99

