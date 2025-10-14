Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B57313559
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 12:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444845; cv=pass; b=cTmZnkBgaWrMsk7+BWemhMKj4R1i3bTd8OCPNjxc1uqHBeSRd8q4L3W0E4AW1n/VXDBmkFUyZeWWT/nxcg3SikMXNAEfpLyUqf1IZL535B/1YeSh+t/5B1fU1rDzIIPuVZeeHAQGIm5dde/uo57qH45GuvowHv2g7EczGy255zU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444845; c=relaxed/simple;
	bh=19XgR12kBprkcZt9KgQ1g53e3NZSnzh6Afeehtj3+hQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z6ZTj1CQ4GjjxgmC4dRwWowiKIOUjkdQSfcNs3Eb7lg7JksQ0u5A8p1/vGuTvWWvcCHl7Q/jXtMFmjnU1WeBLK2SrMBCJ2nAXNqTfMHXJQvAS4ULIZkeSsdCEPBQagIRypr7bNVWBfixxhmolKtEXWI5trs8CFYgx+Vzb0/ctJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=OqepwKQ8; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="OqepwKQ8"
ARC-Seal: i=1; a=rsa-sha256; t=1760444744; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Zrq+6X0cXmUVzm3pwF7kv/xhtbK56EcqTxKlL0HF6Q0sacgTu72eNRn+c82OQnLFUze4sZP0r1IRRdBbXBvxwwkPipRvDn74U5gQFIE2zg01QjcfU05C2ly0U2ntBsV9WbFMR4wViF7LoVvRF8DfYpgjiVQddBSjRWWVXpGF1VI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760444744; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=/VjuvOXjLi+eLrgbzPXKo3d2IBW3QFPBrk84SuOoVx4=; 
	b=Q3FPAsz4D8VrW0t/DHU8oqnx8ErzAmAI8jcnr4L+rOTjIauPoOwlXNd5SD6BRkhCbiRessRGN33/LWjMTJTOfi8JNj+H2F7CXqiQlQ0a9tdtAVwia188bhgFYfs+JuyhkVtVY8LLnuD7ulOv0Gx++ULebgQFp0IagDmjGfA8xB4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760444744;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=/VjuvOXjLi+eLrgbzPXKo3d2IBW3QFPBrk84SuOoVx4=;
	b=OqepwKQ8lM2fTI1EuOYpBbC1TmnBi6hSh9Gql5QoeIw3Eleya4ciSyCyhPRimhMA
	ve8zktxtbU8D01KXdSs+vYJVRBEcWXjXTteR5/y2nURnV6mS5dS8M3I8UeszwvBk6ik
	chKNSk2HiWGCDlvBmgbZPV+rNaCn9AKPAIeFt9lg=
Received: by mx.zohomail.com with SMTPS id 1760444742944348.0780578363774;
	Tue, 14 Oct 2025 05:25:42 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
Subject: [PATCH v4 14/29] rebase: die on invalid trailer args
Date: Tue, 14 Oct 2025 20:24:27 +0800
Message-ID: <20251014122452.1851103-15-me@linux.beauty>
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

This can simplify the error handle in
validate_trailer_args_after_config and
its caller.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 builtin/rebase.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index cc90980d7d..872945a897 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1124,29 +1124,22 @@ static int check_exec_cmd(const char *cmd)
 	return 0;
 }
 
-static int validate_trailer_args_after_config(const struct strvec *cli_args,
-				       struct strbuf *err)
+static void validate_trailer_args_after_config(const struct strvec *cli_args)
 {
 	for (size_t i = 0; i < cli_args->nr; i++) {
 		const char *txt = cli_args->v[i]; // Key[:=]Val
 		const char *sep;
 
-		if (!*txt) {
-			strbuf_addstr(err, _("empty --trailer argument"));
-			return -1;
-		}
+		if (!*txt)
+			die(_("empty --trailer argument"));
 
 		sep = strpbrk(txt, ":=");
 
 		/* there must be key bfore seperator */
-		if (sep && sep == txt) {
-			strbuf_addf(err,
-				    _("invalid trailer '%s': missing key before separator"),
-				    txt);
-			return -1;
-		}
+		if (sep && sep == txt)
+			die(_("invalid trailer '%s': missing key before separator"),
+			    txt);
 	}
-	return 0;
 }
 
 int cmd_rebase(int argc,
@@ -1353,13 +1346,8 @@ int cmd_rebase(int argc,
 			     builtin_rebase_usage, 0);
 
 	if (options.trailer_args.nr) {
-		struct strbuf err = STRBUF_INIT;
-
-		if (validate_trailer_args_after_config(&options.trailer_args, &err))
-			die("%s", err.buf);
-
+		validate_trailer_args_after_config(&options.trailer_args);
 		options.flags |= REBASE_FORCE;
-		strbuf_release(&err);
 	}
 
 	if (preserve_merges_selected)
-- 
2.51.0

