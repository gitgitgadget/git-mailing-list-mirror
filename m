Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77172EBDF2
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 05:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111637; cv=pass; b=ctfZuELMKASBTJ82+mkiWdEPBU1Mz6bALcNOuLqWRdOVh2nXQzNpixzJC9ijfJApvPS87qTUAcnFOsK5V8zI5FTCFkV3Sa7U2TPOx8VBEBvXV1VgtbQDwnLSAWDhg6dHg2lfLbAWgyy1mBINTSwGe1C/8v8o8ADRJRoMywX8vgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111637; c=relaxed/simple;
	bh=OeHch5da8KEgBlAtFdnC+P+9mmsOQaK4Wqo5dsyrFrY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WLDQXSy6RhF7LfulC+HhqnxoFNdxRhctot4bc5sgWP8jfbu1yBrOWvp1220+jGGYlU+xyoTDkumiDvt0l7zF7jvT4BRZVxLg7jwlzL6vSwnY297s2ULyU5aownfk1I28oUUEosG9B00puniLcyg1jR0nkrDf63a8YSMU+Ghd978=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=EmiDnn5/; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="EmiDnn5/"
ARC-Seal: i=1; a=rsa-sha256; t=1761111603; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IzdEOkTAkkkQ+wEYYMyQ9hnLP/jPVUzbsd8DcKuJEbwzP9Y5LAN7e3VbMmIxmied6YlCouSWuDsAgi/KZ4AlyI3PfFyGrRNXhW4NTaUV9LIOtLjLknoaHhjKIYuoc97hKbE1zAtxgt466OMSp7oZmeMEYPaWUGse9daoRPi3Kag=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761111603; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=nTfMKgEm4zC72C2XM6Cx1asixJPH46HtUuUJ2v7Op0g=; 
	b=JjPNHaLVYF1EN426whZvf71QMqgDqLmc//v+VJP9VWl0fGTskkIhadJoiKtWprzvt2IEsDBQcBxt449syBSNOBy5sP1b1Ixi5E9PNR5oiH25oayIs2BjyqbJs5WUFj+RDjw5jaDh9/cpdEETIX0J3aoPk5k1jfQrnq9xs78+Is8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761111603;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=nTfMKgEm4zC72C2XM6Cx1asixJPH46HtUuUJ2v7Op0g=;
	b=EmiDnn5/75DAFl4pMr7TU7Xb6vM7movrFTMdOGnu1vgRgN7zXznlK2jVN0arWTvh
	GVxpYXg7XoqrnHInClYidwbrjsLn114KYfO4ochnECnkENUVnFQog01WxU79PJKOtEy
	v+qhfmcPiKzEL5tdN2slicwxd1a2140/tN+KQ1JY=
Received: by mx.zohomail.com with SMTPS id 1761111600954150.27738079242772;
	Tue, 21 Oct 2025 22:40:00 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v5 02/29] trailer: restore interpret_trailers helper
Date: Wed, 22 Oct 2025 13:39:22 +0800
Message-ID: <20251022053951.602605-3-me@linux.beauty>
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

The change factors the duplicated
read/process/write logic into a single
interpret_trailers() helper(which was removed
in previous commit) while preserving the
original error handling and output paths for
both in-place edits and stdout output.

cmd_interpret_trailers() now reuses the helper
for each filename and for the stdin path,
keeping the option parsing and safety checks intact.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 builtin/interpret-trailers.c | 50 +++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index be0fa83f79..2c8b6fc3b9 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -104,6 +104,30 @@ static void read_input_file(struct strbuf *sb, const char *file)
 	strbuf_complete_line(sb);
 }
 
+static void interpret_trailers(const struct process_trailer_options *opts,
+			       struct list_head *new_trailer_head,
+			       const char *file)
+{
+	struct strbuf in_buf = STRBUF_INIT;
+	struct strbuf out_buf = STRBUF_INIT;
+
+	read_input_file(&in_buf, file);
+	if (trailer_process(opts, in_buf.buf, new_trailer_head, &out_buf) < 0) {
+		if (file)
+			die(_("failed to process trailers for %s"), file);
+		else
+			die(_("failed to process trailers"));
+	}
+
+	if (opts->in_place)
+		write_file_buf(file, out_buf.buf, out_buf.len);
+	else
+		fwrite(out_buf.buf, 1, out_buf.len, stdout);
+
+	strbuf_release(&in_buf);
+	strbuf_release(&out_buf);
+}
+
 int cmd_interpret_trailers(int argc,
 			   const char **argv,
 			   const char *prefix,
@@ -149,33 +173,13 @@ int cmd_interpret_trailers(int argc,
 
 	if (argc) {
 		int i;
-		for (i = 0; i < argc; i++) {
-			struct strbuf in_buf = STRBUF_INIT;
-			struct strbuf out_buf = STRBUF_INIT;
-
-			read_input_file(&in_buf, argv[i]);
-			if (trailer_process(&opts, in_buf.buf, &trailers, &out_buf) < 0)
-				die(_("failed to process trailers for %s"), argv[i]);
-			if (opts.in_place)
-				write_file_buf(argv[i], out_buf.buf, out_buf.len);
-			else
-				fwrite(out_buf.buf, 1, out_buf.len, stdout);
-			strbuf_release(&in_buf);
-			strbuf_release(&out_buf);
-		}
+		for (i = 0; i < argc; i++)
+			interpret_trailers(&opts, &trailers, argv[i]);
 	} else {
-		struct strbuf in_buf = STRBUF_INIT;
-		struct strbuf out_buf = STRBUF_INIT;
-
 		if (opts.in_place)
 			die(_("no input file given for in-place editing"));
 
-		read_input_file(&in_buf, NULL);
-		if (trailer_process(&opts, in_buf.buf, &trailers, &out_buf) < 0)
-			die(_("failed to process trailers"));
-		fwrite(out_buf.buf, 1, out_buf.len, stdout);
-		strbuf_release(&in_buf);
-		strbuf_release(&out_buf);
+		interpret_trailers(&opts, &trailers, NULL);
 	}
 
 	new_trailers_clear(&trailers);
-- 
2.51.0

