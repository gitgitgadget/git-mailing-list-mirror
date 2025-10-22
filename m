Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACB12EC0B3
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 05:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111670; cv=pass; b=r2BroeFnH2E5rAOLqvYkD2AAHbzXhJOQMCf3wbKswX+UFZ4yCCP+3L9db0EGFxap0kNZGb/hUtVj2laPsESbZPDXgWsTCa4lvN12ed4a2wHeE8ZjhNjWxMgL3Blcnsp2q9HWzd84at+iuJRPe4ud2dAmTMSSkH4O77ezYSD0QwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111670; c=relaxed/simple;
	bh=7pG52yTG8zdiIfGGx3BghHENvblUdkXOB7G1l4mkXKs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtbzGxpZ2YX9DRJ62GuVgxWNGKK+o2u1rB7rgvJwrUDXE8Ubpz/4cSw1y0vLOMbZ+C/1N9jZ3wkqAacD4gCiGR5J+ZXLrZxYIgsR1M2j8UAYcR5vyYNp8UyKO3iPg9VmqKJUG+4x6WkEEEQSAgj0xnQERizQU37Z4v8DYttggtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=QNmHICSL; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="QNmHICSL"
ARC-Seal: i=1; a=rsa-sha256; t=1761111609; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=E+6LFLEtCd4wjy9C5DtMP43jNMfMBMGl/F0Bf8rDB6QeY4zMJui6D5o/zg2btMhSZw8Qi6tj5LTcBpZWpwdhI5wG+nVyLniChYC1KhgA/VDI4Dlt7M7Y4rwzCFxHHoOqjX0tunRw6MwSgGzoXIPM+LwKKgAJV94EBVMu8Fv1Xx0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761111609; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=zTL6U+iWgVl8a5SxPvcExD0S6UTD44LYBg06GMVqSyM=; 
	b=kwmWoLmyx+cw1WyjNNdu5gQhaG9NOh+WDExSbgr6pERpgnSsQH4wKnL6HGMD4RmbC0NCOzTvoP7cxoZ15WIKRrTO65ijvt886mhgH4lSaNMRoyZD8kxMaHcjeZOmbf3kKl7AmCABGMIBGZuJKGKLEN7ion5t5+1362+0HAlrjYo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761111609;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=zTL6U+iWgVl8a5SxPvcExD0S6UTD44LYBg06GMVqSyM=;
	b=QNmHICSLT92vP7U8sXzAKDcUx0pebSiETeKHSwO02gyfx1mlULXlalr8dACjUtBt
	kJgrUewDlCm3K4LUmWMajxk7WgNd3B9HmxuYjVjJ5KsAR4R62BGlqfJBBcreqVljX5E
	a451T0+L9sUl/qmrU4ekHjyQvrjI1z7x1J6jcROU=
Received: by mx.zohomail.com with SMTPS id 176111160673561.66260150116261;
	Tue, 21 Oct 2025 22:40:06 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v5 05/29] trailer: use bool for had_trailer_before
Date: Wed, 22 Oct 2025 13:39:25 +0800
Message-ID: <20251022053951.602605-6-me@linux.beauty>
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

Switch had_trailer_before from int to bool
to match its logical use. No functional change.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 trailer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/trailer.c b/trailer.c
index 9abb5a522a..a448380327 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1266,7 +1266,7 @@ int trailer_process(const struct process_trailer_options *opts,
 	struct trailer_block *blk;
 	LIST_HEAD(orig_head);
 	struct strbuf trailers_sb = STRBUF_INIT;
-	int had_trailer_before;
+	bool had_trailer_before;
 
 	blk = parse_trailers(opts, msg, &orig_head);
 	had_trailer_before = !list_empty(&orig_head);
-- 
2.51.0

