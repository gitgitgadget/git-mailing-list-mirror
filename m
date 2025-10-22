Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6328C2EFDAF
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 05:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111763; cv=pass; b=B6TXLonEAukyqXmpj2DOIwGLr0x4HFcPFX+3s5+SAWonw9MlWjYumMZUOlIPmwZwd/HspP617x+BD3Qn4PCtXzs9v4sOyUQRiRp6PVEuZ+reVF6gH+pc9ncvwf8nDEYj+zuo+Y8PeETY1CYn/h1yujQe10abMOVPQExR6WD2WWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111763; c=relaxed/simple;
	bh=DgiWtiEh6+BHmAO4bCSB5O6QDnHGn6hT8+yTf0H7nI0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJYU6Y9M4dYcDsFQn3e49F3aBIUmhLc4F04b6OGSZNx2alUYp7nZNE/KQxAlZkXLhh8jkjlpzoqNbseoW6sWvmShH0xFSVYc6iLHcL9s4Xjqu7KIsUU/GA8MfesoVUPoIhu5OArlU20d+9EWbYfP+iQqRFKlYTCZ3lvfOYcE9Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=DRgGNLuI; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="DRgGNLuI"
ARC-Seal: i=1; a=rsa-sha256; t=1761111627; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bUX0MIhQSNi3yb3auK3mSS0cgMBdVgOq+/qiozWq+d2jbgvK9BnlnO6sytCsNAHtd2W44D2rSxl6KW1e3kKY2MCXiXciOYS0g8lgx/UqLYqksR+7hwM/OZ4pLCoFagmuJUiGYe+ckJkqwA8sE5jFiNoSCRYfEGmNR6dp1Ve7T9k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761111627; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=vKbijYWeIcDGzCclMIJ//PWukIrey/02ZlhcShseUQs=; 
	b=JN5y1jdEW+7XtxMAFWH9IwnTPxmSRr+1DsqvFORtDaXH/O9y7QC5E+LI1q2alyhk01HaDXLTUtOdK18QYJzs00dj2nSAcNl6ZXtTT0PUWcrfan1OCudRgKbzzoMBcv6N5+ac/+UTrz9GGRiemGkOmSqcp3aWo+JJgiHkA79SVGU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761111627;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=vKbijYWeIcDGzCclMIJ//PWukIrey/02ZlhcShseUQs=;
	b=DRgGNLuIgHq6Ir7Za/7v0a9Wlc3PEOIf7KZ52EQOvswXJdYe7YoXgbAHnUlukMla
	G4W9mZ0AJpauuZdzKI2I6i2Wg3tuypdb7N46daKg0yu7g10orSmCCyX3fxQbxsKw18t
	jd9YTIqFRuRT+TFVZLoe1C/pkXMvyDIcpyc8E3r8=
Received: by mx.zohomail.com with SMTPS id 1761111623923322.1635581617767;
	Tue, 21 Oct 2025 22:40:23 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v5 14/29] rebase: die on invalid trailer args
Date: Wed, 22 Oct 2025 13:39:34 +0800
Message-ID: <20251022053951.602605-15-me@linux.beauty>
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

This can simplify the error handle in
validate_trailer_args_after_config and
its caller.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 builtin/rebase.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 3ac1eda61b..872945a897 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1124,29 +1124,22 @@ static int check_exec_cmd(const char *cmd)
 	return 0;
 }
 
-static int validate_trailer_args_after_config(const struct strvec *cli_args,
-					      struct strbuf *err)
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

