Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EC331352D
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 12:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444854; cv=pass; b=G7zBql6UmUy3mq0vPAVmocj1mZhvN/xPa2F62dVD5htSRJpZ7W1i2HaGYyhrfjRTqj6nX4LYXvP0MvQFZ1fgtug2FFQAqZPz2hN1qnPDlGFUsM4iuJKtLbPJ8VCeGzwGahCBfJd0XWcnRxY7Haj6fHI4M+ELD/i6fX8S5jy+Ulw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444854; c=relaxed/simple;
	bh=vV93F+hjVL3L4bA9xuqZR8OfBA55uDIM28Suz67eSR4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fd8kUAGkwG9qD9LKWFG2813GJ4QdKSS8WdIv//Zlg9cggaoJk0+7zwM6vFDl27YBc6RVShj0jSeyMGKZI1IBZnFZMv2NXYES17gLba9dHSPG5svIAjYCXoOkqLWViCHZhKBXLRftXPt6UKAjr6WJnjBBzKKQjdsCcKvioAm90Wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=tQz6jU7Q; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="tQz6jU7Q"
ARC-Seal: i=1; a=rsa-sha256; t=1760444746; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IIbkBHsWzdVaxMIJZQIiNPQSfWgKCybjwaL/45hWkEIR/0S7jIUhEZlhwUPJgJ/y32pIFeF4u+gYRviw65m6Bk/jFNEnthIY+ICbOzLaVMP3oFjdAUB6YAHz+nTFBgmnlZKHFQSZQdX+AALCMu/Lx1Av524JYDcNH32ena+bIaY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760444746; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=L97s+M+PiqJZuJ7mb99/sNgr76R2rdguDABpTLX97QA=; 
	b=DuhIV0LIwt4yasRKAiK//7+7MBUozzvSTFJGHg6GkSppKvn+G2iEdaqY+aD+cLs+6C7Hv7BsLe/T/7K9MTHa85fo8m3gB6rJGyXI1wmrNbjN8QjRCgSF/SG7/VFiSuRQfccKdGlzNqHpkEer9ZND+WPSHhozbH4mtg8qgfto4Cs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760444746;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=L97s+M+PiqJZuJ7mb99/sNgr76R2rdguDABpTLX97QA=;
	b=tQz6jU7QEpfvY65DfLSKfzlS8/0wW2gUJ7aSw8yIgRxJuijV2jfjsMguLd8Mjah1
	7A/NUZdfO95+ORE212uA1Y+stokbiMdrwSpILJXQ05AubI/dIvqEFaF0MIm6+XdqN3U
	0tcUxCwOtxRSiHyAY4HWecSR2grL3jFBJjvz3jag=
Received: by mx.zohomail.com with SMTPS id 1760444745156800.7415282709043;
	Tue, 14 Oct 2025 05:25:45 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
Subject: [PATCH v4 15/29] rebase: validate trailers with configured separators
Date: Tue, 14 Oct 2025 20:24:28 +0800
Message-ID: <20251014122452.1851103-16-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014122452.1851103-1-me@linux.beauty>
References: <20251014122452.1851103-1-me@linux.beauty>
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
index b0ad7dc5c3..5ff518b436 100644
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
index 01f711fb13..28719aa480 100644
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

