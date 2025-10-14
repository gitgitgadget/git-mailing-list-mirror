Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9614831353D
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 12:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444761; cv=pass; b=N7NohL//vAbBB4PGw0fuJJQrUdrW7Z4uMEk9aeIJxz0K2hhDy/Ook18wph52plgQmyHklO+hLNIapdEZ2+QJVFIU3JauiAdsOp1jPe42BTRxb9WfbcjJXBzJ4Ly3RCV4A8/v+fH8HoZGPSrSgUfiy+Kr748OExGxCqKdNUZXdZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444761; c=relaxed/simple;
	bh=YSVzgeJSQVKoWhA086jaI8DZFuvhqeVijOhOz+lysxY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhfctxrv/isrq8Dl8FYvN3QDQ4CPVDrVUVWQXNvyFKUl7x7sJG7VR3MquyAvV1OslTPlqiItj9v2MNq0VsIB4t/dpc/WxkEulq0xVF8I7RzMnK2SfW3Rgq+bjrqj+WcsBP1i6bHcC4CAVNrTv04cexcYn9EdmHa+zEwziksnBVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=pLQtpqQG; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="pLQtpqQG"
ARC-Seal: i=1; a=rsa-sha256; t=1760444722; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=T/WzXflvciY2WnvGxZIgTSneALFZgGDYu22JP8QiJS/2HtpVExl36UCpCHzlciPm7Hk35Wd6oNKoWaVeWAllxTDfr4IeNwxyav3pQ7H5PlQu34YmXP4AqGUca4UjsynQdr+bhkkPw1IfV83NVF6bshiXbCmtz1KDfAPB9jO28x8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760444722; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=xnNMd0OUyV/2Bc4t8u9RAIPGlPA9F1lNnyvLv2f+jMk=; 
	b=jydLOHXrS4bbY5nzGlDRIHUQLje5VnW0Gvmi4Oe5z9XrAEd3TXmmI8b/yC+oxeOKNmgNlB0m8ZFyCYwcb/Cz8egzWfUhEQE3hsQdXG0En9Z7gsoiSMxPS6aXNZCCu/q+yp6goxKvU71pi7c+9LhjblCNu4jDyjUBFKz38scQzSk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760444722;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=xnNMd0OUyV/2Bc4t8u9RAIPGlPA9F1lNnyvLv2f+jMk=;
	b=pLQtpqQGvn9dYOozYZaGb9qXapMJ5QXng4F1z/6yIdTZmxxecit9P9r/dqQXaBJQ
	giR4WJBTVSHuHAxSk1KPtqlS9Pqtqhkah1khAM34qE/phPqPUATGgwIrmC94vw6m0Qb
	KH58LFk8IvWKJpwYzfzOreeza3xsaSyWJW+x9QlU=
Received: by mx.zohomail.com with SMTPS id 176044471906570.69668509413918;
	Tue, 14 Oct 2025 05:25:19 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
Subject: [PATCH v4 04/29] trailer: move config_head and arg_head to if storage
Date: Tue, 14 Oct 2025 20:24:17 +0800
Message-ID: <20251014122452.1851103-5-me@linux.beauty>
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

From: Li Chen <chenl311@chinatelecom.cn>

Move LIST_HEAD(config_head) and LIST_HEAD(arg_head) into the
non-only_input branch so they are created only when needed.
No functional change.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 trailer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/trailer.c b/trailer.c
index 42ac6f58a2..3169e315c0 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1265,14 +1265,15 @@ int trailer_process(const struct process_trailer_options *opts,
 {
 	struct trailer_block *blk;
 	LIST_HEAD(orig_head);
-	LIST_HEAD(config_head);
-	LIST_HEAD(arg_head);
 	struct strbuf trailers_sb = STRBUF_INIT;
 	int had_trailer_before;
 
 	blk = parse_trailers(opts, msg, &orig_head);
 	had_trailer_before = !list_empty(&orig_head);
 	if (!opts->only_input) {
+		LIST_HEAD(config_head);
+		LIST_HEAD(arg_head);
+
 		parse_trailers_from_config(&config_head);
 		parse_trailers_from_command_line_args(&arg_head, new_trailer_head);
 		list_splice(&config_head, &arg_head);
-- 
2.51.0

