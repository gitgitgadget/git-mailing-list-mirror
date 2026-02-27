Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84EF3F23A6
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 22:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772232532; cv=none; b=f/xrgLFpU9Fd/yNb0VHFpUZODxh72m2qTWqhNrr2VEiyGmNdfA5fy9k63BkJJIpwBOfO6qy81Xn3a40Vu23qZF42v4OeIB5rpLuQ6TllpwQ9afyJEY0ro1U3eyZCRyV5o6kxO6UCBMaKxkP50uUxImsDqjJEjKdVfXXF/jejPzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772232532; c=relaxed/simple;
	bh=2M3dO0/NtCZTdhApKgodTTx28vR1mJN3C1qy8YDk/90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cnjkxaLvwj7b8lcaJ3kIQJYGWuKXqXpmHOjH0q/Iqj/xlHintmvbXdagk5dm87e2HmgswAvyJOD/Xy6UvzKFAapr+LmpRcGE0hTjdZQXfHtaBQ2zykbkZFoxai99m92MH64bNCgc6Kmq5c8PIl7RXCHkR/WlOwdMckZxCSbFwwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=KGHMGAyE; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="KGHMGAyE"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1772232528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WgFApfdQSXDzTKkS4UQTo7DYlEB3wexFOWgvAwqt+XM=;
	b=KGHMGAyEQ+3Fh64RME6K0F7pjeMNhft2IsSa1e2UAzRAfde5XWHLEJgsl6orhWjsYEss8f
	kApWQIdV93sEkm5FKIrXyzQ9npdM917m3odEX4rlFx/ieUH9jjPCjMgMtI3YplnW88a4S9
	tSJ0ss364AbX38jc4y6W6NPYFLI18WOzxWGnlRE7X0BPd7p+Ec+c6IrS5KIcp3dCI3eXpP
	Hnen7BnGWwjtReqNlPr6fqpgIYQyqb2pLtLtYyHIBaKhejsqpkrNISlu86pwyAOHbm8hUG
	XZHhkMWdoe4TGgTHriMU34xt6U2xLeaWsbwuPgCtZ/X4b5ZCEmAo4tnPgU/5ig==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v5 5/5] docs: add usage for the cover-letter fmt feature
Date: Fri, 27 Feb 2026 23:48:15 +0100
Message-ID: <a2160693709ff6867ea5db9a944d13091f03bc5d.1772232373.git.mroik@delayed.space>
In-Reply-To: <cover.1772232373.git.mroik@delayed.space>
References: <cover.1772196510.git.mroik@delayed.space> <cover.1772232373.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

Document the new "--cover-letter-format" feature in format-patch and its
related config variable "format.commitListFormat".

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 Documentation/config/format.adoc    |  7 +++++++
 Documentation/git-format-patch.adoc | 11 +++++++++++
 2 files changed, 18 insertions(+)

diff --git a/Documentation/config/format.adoc b/Documentation/config/format.adoc
index ab0710e86a..771e84af98 100644
--- a/Documentation/config/format.adoc
+++ b/Documentation/config/format.adoc
@@ -101,6 +101,13 @@ format.coverLetter::
 	generate a cover-letter only when there's more than one patch.
 	Default is false.
 
+format.commitListFormat::
+	A format string that specifies how to generate the commit list
+	of a cover-letter when format-patch is invoked. This is the
+	config coupled with `--cover-letter-format` in the format-patch
+	command and they both accept the same values.
+	Default is shortlog.
+
 format.outputDirectory::
 	Set a custom directory to store the resulting files instead of the
 	current working directory. All directory components will be created.
diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
index 9a7807ca71..bdcb5f989c 100644
--- a/Documentation/git-format-patch.adoc
+++ b/Documentation/git-format-patch.adoc
@@ -24,6 +24,7 @@ SYNOPSIS
 		   [(--reroll-count|-v) <n>]
 		   [--to=<email>] [--cc=<email>]
 		   [--[no-]cover-letter] [--quiet]
+		   [--cover-letter-format=<format-spec>]
 		   [--[no-]encode-email-headers]
 		   [--no-notes | --notes[=<ref>]]
 		   [--interdiff=<previous>]
@@ -321,6 +322,15 @@ feeding the result to `git send-email`.
 	containing the branch description, shortlog and the overall diffstat.  You can
 	fill in a description in the file before sending it out.
 
+--cover-letter-format=<format-spec>::
+	Specify the format in which to generate the commit list of the
+	patch series. This option is available if the user wants to use
+	an alternative to the default shortlog format. The accepted
+	values for format-spec are "shortlog" or a format string
+	prefixed with `log:`.  
+	e.g. `log: %s (%an)`  
+	This option is relevant only if a cover letter is generated.
+
 --encode-email-headers::
 --no-encode-email-headers::
 	Encode email headers that have non-ASCII characters with
@@ -452,6 +462,7 @@ with configuration variables.
 	signOff = true
 	outputDirectory = <directory>
 	coverLetter = auto
+	commitListFormat = shortlog
 	coverFromDescription = auto
 ------------
 
-- 
2.53.0.5.ga216069370

