Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3282EFD8A
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 05:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111659; cv=pass; b=WDDb+xwhZCzr7ldiz4M+sADhJyQSdZPNo5DleJhAwJglnfzYj2d/V1eeeSNrqnbj/aT1htWWiQ6B8z3IwCj5OMchUdpnPdmX8npCzwltlqH+2FHuZSSGIeYE+QALELZfhVKtY/eG4gTHwIozjJ75rjUIbRJtDj/DXc4EeUB/XGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111659; c=relaxed/simple;
	bh=5PFyHRINkhMAZhyBu2lw+SyKzWLVShfB+zHlrC0lYZQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxVIfcwF+5mbe1vL2xpsmXCLv2Rpw7WVWToJUQZAh4x1UUZIhtIuAx8AQ6OdANU5BkVTgUT/mgQvnhcGx7sspG7oIlzfD971/dwpM0yoMLFPGX0ggFHVOA6UBCncvZpKYWqyczVqEWE+KxTevVzcwqril6WBvyyrivUVgqJhV1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=J8NikMbt; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="J8NikMbt"
ARC-Seal: i=1; a=rsa-sha256; t=1761111607; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OCOSg3sbFEBxJ8F619YwSLySXOlKeaRSLB2bnYot6Osh0jRJ4gfYgodkOjsYwxdXrhrocgKViw1dfXLwoSOfXzBk3O5ac9J4TbTGJc7pr8yHTcJLo0a8SLuJo2xcMIG5Ieb6FEHk7ZBkFnixcuKtsfnKN65h2bpmHblubKRnVig=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761111607; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=KVMFXLJFEUABzyg93rh+JyHx5ouVP6+9ccWFzQBua+E=; 
	b=Rdr9bJnwTrGfBRhCBbBAVR268+jadjltgHY8JznloB2vgAcwDmV2yIBgA5ncMyWEzjss/GnNzy8nIxhVOaVcZNcxJd73VZX9LvTa45WEZGDy/FCQKQQmkX+uS4PdcL87CECbqqcaH2ii2zszmxGqsDaQQ66zA5ZUFtSvmEPNl1s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761111607;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=KVMFXLJFEUABzyg93rh+JyHx5ouVP6+9ccWFzQBua+E=;
	b=J8NikMbtifBw6gZGUeybeMntoeqMIdBOlfQwxAAAiJb7WRPYsDciNh6ziDvaTnjt
	J6YVAvu0SyRuZS/Ob+ZFY/WZuJ1L6zoEx1KV0Y6biy1m+sg4GItYPjWQxqz3jbNdFC+
	FtpQc1H6F4HeEcW06FJtRnUe1Y1ipNuf+HV1YqaM=
Received: by mx.zohomail.com with SMTPS id 1761111604743305.8181815174688;
	Tue, 21 Oct 2025 22:40:04 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v5 04/29] trailer: move config_head and arg_head to if storage
Date: Wed, 22 Oct 2025 13:39:24 +0800
Message-ID: <20251022053951.602605-5-me@linux.beauty>
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

From: Li Chen <chenl311@chinatelecom.cn>

Move LIST_HEAD(config_head) and LIST_HEAD(arg_head) into the
non-only_input branch so they are created only when needed.
No functional change.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 trailer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/trailer.c b/trailer.c
index b7b0029e05..9abb5a522a 100644
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

