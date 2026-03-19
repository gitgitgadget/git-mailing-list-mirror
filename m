Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0003F0AAB
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 22:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959928; cv=none; b=GCvWbSvnmlZ5y9q86XJPljPa/HQhtmBmAm7k13DXC+ETunvg3dx5QGsu3qnXpMeOotybiIDShvRGo7PlZBYwJE8B/BbbAiPpZM8Wp2UYm4bjVx6HkYzz7+6MMej0UWrLH4FDOUrREbs0oRewlZYFdkt+3xfWF7P/3z6smawaGzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959928; c=relaxed/simple;
	bh=hPa9oeDKPDB7KFhku+t5inGBGiz6izbJJhhiY+XlhHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dISX6vdxPSicRqd+Y+32N3LHFypAi1O3mj4ZOLRFdLnJ7RFwnIiGKb8e15lEyg9yBPHPT6VfxKsnjDqiAbXERF7UUtB7mXY/AP7MzNlR46JVebPHuWJOxr6YUi4AIX1UZNg7BWLtvibbX8KkAeI2GRW9kISRvFhCBEM1Q4cfNgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=Z0uHsrz6; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="Z0uHsrz6"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773959919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bnDfwUum1q7yRo01WBY+JCXWNI8YbrmlxnDW+CwDL2c=;
	b=Z0uHsrz6xs+vF7/KcS3qbkcOv0+KjmRt2zYWwUuA3BhB/87O/Gl1cD7Oe9KHf+SYoQiye6
	FZOJoK0Cgb94V2mA0M4nwpcLGkb9NnaeaB/Gb/Y/EwXuFnCFpVtYRBbEW5sQjnU7D1+cmt
	LEcjdxfsijA5ikyH52AqQ03POUkQZWVcIQTJbA6y1n+Tbu5qXmZjPGDCRJ6OnIlaxE6Ric
	v1qH9Jb+ahhFy/IXEqKttHmG/qkuF2wjy187IfOD0UM6Xus6F9R1uzekQRyFCCvA+p+V3S
	JDH4sjAbi7S7n94QhZSrt4KtjsY5yzpeYDqgZUGfTj0rMYV5cHV9Wa8BbLa+cA==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v2 4/8] docs/pretty-formats: add %(count) and %(total)
Date: Thu, 19 Mar 2026 23:38:14 +0100
Message-ID: <7b1e5cbb243cf3421a4affd77bb45d31f3e7146c.1773959395.git.mroik@delayed.space>
In-Reply-To: <cover.1773959395.git.mroik@delayed.space>
References: <cover.1773530191.git.mroik@delayed.space> <cover.1773959395.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

When --commit-list-format has been introduced to format-patch, two new
placeholders have been added to the PRETTY FORMATS code without being
documented. Do so now.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 Documentation/pretty-formats.adoc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/pretty-formats.adoc b/Documentation/pretty-formats.adoc
index 5405e57a60..67dc0f2a82 100644
--- a/Documentation/pretty-formats.adoc
+++ b/Documentation/pretty-formats.adoc
@@ -253,6 +253,10 @@ The placeholders are:
 	linkgit:git-rev-list[1])
 +%d+:: ref names, like the --decorate option of linkgit:git-log[1]
 +%D+:: ref names without the " (", ")" wrapping.
++%(count)+:: the number of a patch within a patch series. Used only in
+	`--commit-list-format` in `format-patch`
++%(total)+:: the number of tatal patches in a patch series. Used only in
+	`--commit-list-format` in `format-patch`
 ++%(decorate++`[:<option>,...]`++)++::
 ref names with custom decorations. The `decorate` string may be followed by a
 colon and zero or more comma-separated options. Option values may contain
-- 
2.53.0.1018.g2bb0e51243

