Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA8A1D1F7C
	for <git@vger.kernel.org>; Tue, 27 Aug 2024 21:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724794057; cv=none; b=UDtN+jXeqBsHTZvEIt40rGYq6w5qayxIT2slzdw6I59a2v2Gn4VqXSk/EvcjRJKgwM8ZRrmMpmlKSWZhbDztmjPm1b5mfYkK2WMdby6g4EeUdunSPti4wqgjJr+qTYqJM2/q+pDwPAZeCbb+38frZv64uAc0EqAA0Co7P3Fuf44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724794057; c=relaxed/simple;
	bh=bMngD6mwgNiHh3gcgvWsjnzy6KE+sKQ6Uq1sVDBAZQ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=RGpZJUmyLwz9hqCk6qKpRPa34J1Qi83ySSlbNUx/IhMLF7gTIHYEmmnifxVPojtH5wn2XQACq1mnjL/SXnbQYZYxk8w9wjGpKn5DKdm8+a5feoGZ4+s+5AJqul87QV7s2R6NqGeqa/LkxYopGcFZIVpdhrNSQGGgk01yvAjPz74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HaZfdydW; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HaZfdydW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724794055; x=1756330055;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to;
  bh=bMngD6mwgNiHh3gcgvWsjnzy6KE+sKQ6Uq1sVDBAZQ0=;
  b=HaZfdydWnZYHnnB3DSICoEyz3TY83cFxey817QM1qbj6uB6I2SFhAOzR
   nNieNPHZwWPrxN4rp/MHKqgPKnuJLhanQ2TB9XDbnwG/3bbthmNAJnsyF
   rnkch1cVNVPMLSAWbr3zwhcVlZpR+nrrwYoVaL6QSUDiYs1El0ekvOeHP
   Qs9hPpPiynvqFZBbM6zJ7lC8EmRdYpX5sSL6RgvLOXRYoT3/D8U8sKVIk
   eOOWA8g14hwWIg4U+0urb/fbv+UrX7EEAciIhvBUxHmcAHXvdxAE3daaf
   VHpSYTChG0Sdk/NUsBmWu/RLxeuezg9SsrR3PzNvLS+vOtoMjEQlo/OZH
   w==;
X-CSE-ConnectionGUID: aWs8KpSTTOea+5G47H7MCQ==
X-CSE-MsgGUID: maCEPjPtTMKQ26mvQsaD3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="33959510"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="33959510"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 14:27:32 -0700
X-CSE-ConnectionGUID: M/a6aJvxRQKhBxgUyoPXVw==
X-CSE-MsgGUID: ozTRV9P9S8CSmoJzkm6iWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="63517536"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 14:27:32 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 27 Aug 2024 14:27:17 -0700
Subject: [PATCH v3 2/3] check-mailmap: add options for additional mailmap
 sources
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-jk-send-email-mailmap-support-v3-2-bec5ba9be391@gmail.com>
References: <20240827-jk-send-email-mailmap-support-v3-0-bec5ba9be391@gmail.com>
In-Reply-To: <20240827-jk-send-email-mailmap-support-v3-0-bec5ba9be391@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>, 
 Josh Steadmon <steadmon@google.com>, git@vger.kernel.org, 
 Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.0

From: Jacob Keller <jacob.keller@gmail.com>

The git check-mailmap command reads the mailmap from either the default
.mailmap location and then from the mailmap.blob and mailmap.file
configurations.

A following change to git send-email will want to support new
configuration options based on the configured identity. The
identity-based configuration and options only make sense in the context
of git send-email.

Expose the read_mailmap_file and read_mailmap_blob functions from
mailmap.c.  Teach git check-mailmap the --mailmap-file and
--mailmap-blob options which load the additional mailmap sources.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 mailmap.h                           |  7 +++++++
 builtin/check-mailmap.c             |  7 +++++++
 mailmap.c                           |  9 +++------
 Documentation/git-check-mailmap.txt | 10 ++++++++++
 4 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/mailmap.h b/mailmap.h
index cbda9bc5e0c1..908365e1bffa 100644
--- a/mailmap.h
+++ b/mailmap.h
@@ -6,6 +6,13 @@ struct string_list;
 extern char *git_mailmap_file;
 extern char *git_mailmap_blob;
 
+/* Flags for read_mailmap_file() */
+#define MAILMAP_NOFOLLOW (1<<0)
+
+int read_mailmap_file(struct string_list *map, const char *filename,
+		      unsigned flags);
+int read_mailmap_blob(struct string_list *map, const char *name);
+
 int read_mailmap(struct string_list *map);
 void clear_mailmap(struct string_list *map);
 
diff --git a/builtin/check-mailmap.c b/builtin/check-mailmap.c
index 6b7fb53494f0..2334b5722275 100644
--- a/builtin/check-mailmap.c
+++ b/builtin/check-mailmap.c
@@ -9,6 +9,7 @@
 #include "write-or-die.h"
 
 static int use_stdin;
+static const char *mailmap_file, *mailmap_blob;
 static const char * const check_mailmap_usage[] = {
 N_("git check-mailmap [<options>] <contact>..."),
 NULL
@@ -16,6 +17,8 @@ NULL
 
 static const struct option check_mailmap_options[] = {
 	OPT_BOOL(0, "stdin", &use_stdin, N_("also read contacts from stdin")),
+	OPT_FILENAME(0, "mailmap-file", &mailmap_file, N_("read additional mailmap entries from file")),
+	OPT_STRING(0, "mailmap-blob", &mailmap_blob, N_("blob"), N_("read additional mailmap entries from blob")),
 	OPT_END()
 };
 
@@ -56,6 +59,10 @@ int cmd_check_mailmap(int argc, const char **argv, const char *prefix)
 		die(_("no contacts specified"));
 
 	read_mailmap(&mailmap);
+	if (mailmap_blob)
+		read_mailmap_blob(&mailmap, mailmap_blob);
+	if (mailmap_file)
+		read_mailmap_file(&mailmap, mailmap_file, 0);
 
 	for (i = 0; i < argc; ++i)
 		check_mailmap(&mailmap, argv[i]);
diff --git a/mailmap.c b/mailmap.c
index 2acf97f30760..9f9fa3199a85 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -142,11 +142,8 @@ static void read_mailmap_line(struct string_list *map, char *buffer)
 		add_mapping(map, name1, email1, name2, email2);
 }
 
-/* Flags for read_mailmap_file() */
-#define MAILMAP_NOFOLLOW (1<<0)
-
-static int read_mailmap_file(struct string_list *map, const char *filename,
-			     unsigned flags)
+int read_mailmap_file(struct string_list *map, const char *filename,
+		      unsigned flags)
 {
 	char buffer[1024];
 	FILE *f;
@@ -186,7 +183,7 @@ static void read_mailmap_string(struct string_list *map, char *buf)
 	}
 }
 
-static int read_mailmap_blob(struct string_list *map, const char *name)
+int read_mailmap_blob(struct string_list *map, const char *name)
 {
 	struct object_id oid;
 	char *buf;
diff --git a/Documentation/git-check-mailmap.txt b/Documentation/git-check-mailmap.txt
index 7747e38e25e3..966c91c46af7 100644
--- a/Documentation/git-check-mailmap.txt
+++ b/Documentation/git-check-mailmap.txt
@@ -27,6 +27,16 @@ OPTIONS
 	Read contacts, one per line, from the standard input after exhausting
 	contacts provided on the command-line.
 
+--mailmap-file=<file>::
+	In addition to any configured mailmap files, read the specified
+	mailmap file. Entries in this file take precedence over entries in
+	either the default mailmap file or any configured mailmap file.
+
+--mailmap-blob=<blob>::
+	Like `--mailmap-file`, but consider the value as a reference to a
+	blob in the repository. If both `--mailmap-file` and
+	`--mailmap-blob` are specified, entries in `--mailmap-file` will
+	take precedence.
 
 OUTPUT
 ------

-- 
2.46.0.124.g2dc1a81c8933

