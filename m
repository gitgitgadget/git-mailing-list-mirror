Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69601494C3
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 07:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771916822; cv=pass; b=RoUUQ+DBd5pPNTIswdUxff4VvNDbUotBmpLFZCPDkTkOaWA1Eg/3ev4MrJC62tSreti++DBkhhsJ168lx7TopZiH3CQRn1879mLDncwVKPELFifexJ4p3+H0QFFWcudlhtzbJgj8HlK5Kyt/sLPi8AtZsuoOf1dFC3yUrxVC3Qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771916822; c=relaxed/simple;
	bh=HaOO9lJx8OJ6Vq9/x2L8kcUBhP5zbAz0C8grVt84ahM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iXf9LEIOMZedswA9n8MJ6vRRarE6kcmjyJpFGuuzReO+5wh9yvU6cV5EM21iMxtjNN9X9pcNTJ7SUW/X+DvqDpSfl+aj1QYFguyfP6u0hfRyx1gIpxKmTp33LsQA7tWyi6efd4grTUGmmnQkt3dKNFIwAjR+bdhGR05jSDnGxls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=eOYRRjoa; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="eOYRRjoa"
ARC-Seal: i=1; a=rsa-sha256; t=1771916776; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=O1VtSOMVfToW0YvKHJdoMgmp76lnDUGvceYEbtxEZwhkfEBCxrtCvM+Ssr2sX0pr2abe7F3u3KCmoCzBgWZoG91Db0Wfv9xjJSvIBfF9VbobTyz1y54GXIZu+HIehBJL/XD+ClAEg7GkQg41WTR3XSPIUmIKRfH1Ts6sUek2Cj0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771916776; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PNXJgou9GTN9cKorAHaQdZ7KMlBxRFwr7OtNltdhBPU=; 
	b=F2xTudf5nw7G1GG+wycBws9/Rk8f1GD1LNhl+u/EOM4jExw2yQgePmIy3LpgrQ3q/60Ka57zRKo/jQUOgLM3LXsatxd2Q2raZMOG7ZIWiJYhrQwixBRtOX3HT7LM1Hf+QJtofI7jvsNvaZhwIPaEXja4VdNbPOHLN089Ac7KPls=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771916776;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=PNXJgou9GTN9cKorAHaQdZ7KMlBxRFwr7OtNltdhBPU=;
	b=eOYRRjoahzvJ8edapvA8oaws0AyRovd7mk3zA9gWNmmv3MoaR0Lazem8c2ETsZkZ
	Ww4+iPhapP1gcD+x1Rm9OH5l3nRmhdY491Hvsa34t8ERA8J+8RUk3r2GXFbo3Yy57Mp
	5YkjyG6kqU6xyGHMsEs6hZjRknsjHystqzOZ2GXQ=
Received: by mx.zohomail.com with SMTPS id 1771916774108430.7709100481577;
	Mon, 23 Feb 2026 23:06:14 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Li Chen <me@linux.beauty>
Subject: [PATCH v7 4/5] commit, tag: parse --trailer with OPT_STRVEC
Date: Tue, 24 Feb 2026 15:05:50 +0800
Message-ID: <20260224070552.148591-5-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260224070552.148591-1-me@linux.beauty>
References: <20260224070552.148591-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Now that amend_file_with_trailers() expects raw trailer lines, do not
store argv-style "--trailer=<trailer>" strings in git commit and git
tag.

Parse --trailer using OPT_STRVEC so trailer_args contains only the
trailer value, and drop the temporary prefix stripping in
amend_file_with_trailers().

Signed-off-by: Li Chen <me@linux.beauty>
---
v7:
New patch.

 builtin/commit.c |  3 ++-
 builtin/tag.c    |  4 ++--
 trailer.c        | 21 +--------------------
 trailer.h        |  4 ++--
 4 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 9e3a09d532..d9983230de 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1720,7 +1720,8 @@ int cmd_commit(int argc,
 		OPT_STRING(0, "fixup", &fixup_message, N_("[(amend|reword):]commit"), N_("use autosquash formatted message to fixup or amend/reword specified commit")),
 		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
 		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
-		OPT_PASSTHRU_ARGV(0, "trailer", &trailer_args, N_("trailer"), N_("add custom trailer(s)"), PARSE_OPT_NONEG),
+		OPT_STRVEC(0, "trailer", &trailer_args, N_("trailer"),
+			   N_("add custom trailer(s)")),
 		OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-by trailer")),
 		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
diff --git a/builtin/tag.c b/builtin/tag.c
index aeb04c487f..15aee1b03a 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -499,8 +499,8 @@ int cmd_tag(int argc,
 		OPT_CALLBACK_F('m', "message", &msg, N_("message"),
 			       N_("tag message"), PARSE_OPT_NONEG, parse_msg_arg),
 		OPT_FILENAME('F', "file", &msgfile, N_("read message from file")),
-		OPT_PASSTHRU_ARGV(0, "trailer", &trailer_args, N_("trailer"),
-				  N_("add custom trailer(s)"), PARSE_OPT_NONEG),
+		OPT_STRVEC(0, "trailer", &trailer_args, N_("trailer"),
+			   N_("add custom trailer(s)")),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of tag message")),
 		OPT_BOOL('s', "sign", &opt.sign, N_("annotated and GPG-signed tag")),
 		OPT_CLEANUP(&cleanup_arg),
diff --git a/trailer.c b/trailer.c
index 8e87d185d9..e85c6c9fbe 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1342,40 +1342,21 @@ int amend_file_with_trailers(const char *path,
 			     const struct strvec *trailer_args)
 {
 	struct strbuf buf = STRBUF_INIT;
-	struct strvec stripped_trailer_args = STRVEC_INIT;
 	int ret = 0;
-	size_t i;
 
 	if (!trailer_args)
 		BUG("amend_file_with_trailers called with NULL trailer_args");
 	if (!trailer_args->nr)
 		return 0;
 
-	for (i = 0; i < trailer_args->nr; i++) {
-		const char *txt = trailer_args->v[i];
-
-		/*
-		 * Historically amend_file_with_trailers() passed its arguments
-		 * to "git interpret-trailers", which expected argv entries in
-		 * "--trailer=<trailer>" form. Continue to accept those for
-		 * existing callers, but pass only the value portion to the
-		 * in-process implementation.
-		 */
-		skip_prefix(txt, "--trailer=", &txt);
-		if (!*txt)
-			die(_("empty --trailer argument"));
-		strvec_push(&stripped_trailer_args, txt);
-	}
-
 	if (strbuf_read_file(&buf, path, 0) < 0)
 		ret = error_errno(_("could not read '%s'"), path);
 	else
-		amend_strbuf_with_trailers(&buf, &stripped_trailer_args);
+		amend_strbuf_with_trailers(&buf, trailer_args);
 
 	if (!ret)
 		ret = write_file_in_place(path, &buf);
 
-	strvec_clear(&stripped_trailer_args);
 	strbuf_release(&buf);
 	return ret;
 }
diff --git a/trailer.h b/trailer.h
index d05dab050b..e5bd355aad 100644
--- a/trailer.h
+++ b/trailer.h
@@ -209,8 +209,8 @@ void amend_strbuf_with_trailers(struct strbuf *buf,
 /*
  * Augment a file by appending trailers specified in trailer_args.
  *
- * Each element of trailer_args should be an argv-style --trailer=<trailer>
- * option (i.e., including the --trailer= prefix).
+ * Each element of trailer_args should be in the same format as the value
+ * accepted by --trailer=<trailer> (i.e., without the --trailer= prefix).
  *
  * Returns 0 on success or a non-zero error code on failure.
  */
-- 
2.52.0
