Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7A62F0671
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 05:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111773; cv=pass; b=mbwlXdl1AhAf8teSzB3JyA7aXShr95QghutAxVH7UqryC8NKEiQPLzk/QW8/jx7Z2aVzDFhBpgdUKxi+8Kljt3m1BNsma5d/6m/FYSeiUzAblRDuKR7U1uJ0uZsstIqMizl3mh+/doxOq1IiiE7ho7spx9TeKJPkqC0JvYQfL04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111773; c=relaxed/simple;
	bh=PDUr8tRenQNO0gAwbfUqo6FeMvBYsG8AyPyzVfsrjMs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FE/uxhY+ArFUTaImd4hwKftUHDaMf1ARTpbOu+16HEwwXGNR/7a23YdpqYeid7HQMChnIUQ+eYeLrhW3ye5Rp8w0hZG8iADVCvdDweoezLVMCMjh2WE56xkf782TTkQme4mYpV9RPgGWLYqPpXlHwpuAtkrEFdq7iEbxB0DWIZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=PZIcEC6a; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="PZIcEC6a"
ARC-Seal: i=1; a=rsa-sha256; t=1761111629; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kTn3x9/RcZoVoH4GMZR0tgBKQ8a0TzPxigc9+pDQNVQqfNZ5SMln8T1X6P+llarG7lgXrQ84HosHPvJsj53ZhDIpopUvRk8vDBy0DE3kmsBr8584zC4XRN1MrNaiPqL1uZwhVuRKqQy9HHhpjTV4V6W1rCuCTLMrWZeWWwxS0iM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761111629; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=5Ug4EaJ/jejRBCvhMgusbw5S1Ci9FnLXk6VH5M4luwk=; 
	b=MYrLRu3sijb7iUkw54jPqC+D5pBd3nClrQyiVBNEQtSlqRoP9t/fYbd5Numsnf6+00n4xWlnDIicY/PGYqN4KUSN801R8fpfKNovNLTEdtH0OEPCYWa1s5OWgAM8Fla/Gf8splaULBdf4R9N6bc3P7kY2pzN8OEXfajMbTdYiSc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761111629;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=5Ug4EaJ/jejRBCvhMgusbw5S1Ci9FnLXk6VH5M4luwk=;
	b=PZIcEC6aIIv4hMIKTyG+Gko9cX6V0bxUe829hvRRWbLeu7P3c50xUS31rff5BJnm
	2bx2EpHekiGTZxhbWVxzeH+N42LvenMaGTXIJM+4qFlZr8pGsVxJYXqqooXDpkNCtER
	TnR68MMt1WlCrp/+ixt6ZTrfGIVDSqxLJx6kIc7k=
Received: by mx.zohomail.com with SMTPS id 1761111625845868.8140469898073;
	Tue, 21 Oct 2025 22:40:25 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v5 15/29] rebase: validate trailers with configured separators
Date: Wed, 22 Oct 2025 13:39:35 +0800
Message-ID: <20251022053951.602605-16-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022053951.602605-1-me@linux.beauty>
References: <20251022053951.602605-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Moved validate_trailer_args_after_config() into
trailer.c so trailer argument validation reuses
find_separator() and respects configured separators.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 builtin/rebase.c | 18 ------------------
 trailer.c        | 25 +++++++++++++++++++++++++
 trailer.h        |  2 ++
 3 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 872945a897..a88abe08b4 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1124,24 +1124,6 @@ static int check_exec_cmd(const char *cmd)
 	return 0;
 }
 
-static void validate_trailer_args_after_config(const struct strvec *cli_args)
-{
-	for (size_t i = 0; i < cli_args->nr; i++) {
-		const char *txt = cli_args->v[i]; // Key[:=]Val
-		const char *sep;
-
-		if (!*txt)
-			die(_("empty --trailer argument"));
-
-		sep = strpbrk(txt, ":=");
-
-		/* there must be key bfore seperator */
-		if (sep && sep == txt)
-			die(_("invalid trailer '%s': missing key before separator"),
-			    txt);
-	}
-}
-
 int cmd_rebase(int argc,
 	       const char **argv,
 	       const char *prefix,
diff --git a/trailer.c b/trailer.c
index 1f317f4d37..85e42859ca 100644
--- a/trailer.c
+++ b/trailer.c
@@ -7,6 +7,7 @@
 #include "string-list.h"
 #include "run-command.h"
 #include "commit.h"
+#include "strvec.h"
 #include "trailer.h"
 #include "list.h"
 #include "wrapper.h"
@@ -773,6 +774,30 @@ void parse_trailers_from_command_line_args(struct list_head *arg_head,
 	free(cl_separators);
 }
 
+void validate_trailer_args_after_config(const struct strvec *cli_args)
+{
+	char *cl_separators;
+
+	trailer_config_init();
+
+	cl_separators = xstrfmt("=%s", separators);
+
+	for (size_t i = 0; i < cli_args->nr; i++) {
+		const char *txt = cli_args->v[i];
+		ssize_t separator_pos;
+
+		if (!*txt)
+			die(_("empty --trailer argument"));
+
+		separator_pos = find_separator(txt, cl_separators);
+		if (separator_pos == 0)
+			die(_("invalid trailer '%s': missing key before separator"),
+		    txt);
+	}
+
+	free(cl_separators);
+}
+
 static const char *next_line(const char *str)
 {
 	const char *nl = strchrnul(str, '\n');
diff --git a/trailer.h b/trailer.h
index b4f28bfd65..4654ff9c96 100644
--- a/trailer.h
+++ b/trailer.h
@@ -68,6 +68,8 @@ void parse_trailers_from_config(struct list_head *config_head);
 void parse_trailers_from_command_line_args(struct list_head *arg_head,
 					   struct list_head *new_trailer_head);
 
+void validate_trailer_args_after_config(const struct strvec *cli_args);
+
 void process_trailers_lists(struct list_head *head,
 			    struct list_head *arg_head);
 
-- 
2.51.0

