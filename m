Received: from smtp.roethke.info (smtp.roethke.info [46.232.251.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AD04EB55
	for <git@vger.kernel.org>; Sun, 18 Feb 2024 12:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.232.251.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708257915; cv=none; b=iB2KQvO9EkmoC/j/MWsI90zHNFZQWExRxy2mIRkv3AFFeDaUQGfkY52DQxEx3p0RDBNex4FjXOYGqWfHJDlmDrKMr2g2vlfdwuxDwnLqnsFkK+cT5uGsGZ3HzY9L5TAlnSv8XroCBE8915RbVREdwSApQ4oPML798419rbG2MuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708257915; c=relaxed/simple;
	bh=lulFLmkhtUFkvGC4gwqOLSGwaV+Yqg3U6INMYW+1jy0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UeUO6PZBWWxF8qyWZ4AFKIBEhYGcL8gHjPkAe6bfAHZfs5JgJlDiCeiXFNhnVd6bcReyR9WchlZhUTOJ6Wwj7ivEaddXx5u4yzgVc7Qf0xg/rAcjbDVYfz9ePQUvMzx+m+Y3Ln6M2G+PcS0acp9fd6I6wHvNI+uV7vPh3kxjb2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=roethke.info; spf=pass smtp.mailfrom=roethke.info; dkim=pass (4096-bit key) header.d=roethke.info header.i=@roethke.info header.b=ODU+oWBL; arc=none smtp.client-ip=46.232.251.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=roethke.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=roethke.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=roethke.info header.i=@roethke.info header.b="ODU+oWBL"
Received: from localhost (unknown [IPv6:2a01:41e1:283b:1000:bb91:34f7:c1e1:8a6d])
	by smtp.roethke.info (Postfix) with ESMTPA id 5E32C1E0004A;
	Sun, 18 Feb 2024 11:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=roethke.info;
	s=20200807; t=1708257445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hMhjzd+5Py9IhZDCwodhxXZ6q5GgbN4b0z4pr+8tOJI=;
	b=ODU+oWBLYWSJa+4weBZ14uM1pMeB//5Usc5/CVu8lTKqTZqz5Y6HFkUGtuFccWYx7fSdsi
	hiRRsDwZgU4qVhC46KLE87EtGMMA1DTdxGSY4M0zAYfEJ9ptpwH4BnCqBDPmATnE132SqO
	DVbBdVGsH6BsBsYFMbPy9XhMONGcQtnxJCUy5dn2d3nk4JvEWGHQ0yERTLb9wir4GujNID
	CsrvZlE81IxuE63HwWsifJA1fDI3k+GBNUytpfD0rsaTj4TUyw9tdWmQEzHfEpae208kd4
	XRsUfi+2EA74X7dUpbQJarFeQz/4kSQ09D2D9iiu923LZh1raEIiIJzx+KkgLkQCqAWSkI
	tTqneiOw7tMUsvCMywgswgwqva6phwWvgHl+jK37v9cO+AScOQLsEjEYH/y3rGrlp+np1Y
	LYGuyyTYWN0f7oUW+0N/cQl21+dg91QbuoTFJRBK6vax5/fVf5cs1Cu9Z+JqON9eA7378X
	4jqiLGyqtH39XLpieSGnj3o7d7ZC1hEo/4bxpda2aX8IYfBLpXpKuT15sqxfEQlI3m8Krl
	tAzQJkaSbX2dWDg+nVAMYCg98WbvYHM4GhcTK0Wjci2uDrBAuCOYPrhQ8sda1MGiav74jA
	pz9JXq4wFoXDZPRgq+XntmzdbhmDpN8g+HdbAFtAhs2RoP7efy8+g=
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=marcel@roethke.info smtp.mailfrom=marcel@roethke.info
From: =?UTF-8?q?Marcel=20R=C3=B6thke?= <marcel@roethke.info>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Marcel=20R=C3=B6thke?= <marcel@roethke.info>
Subject: [PATCH] rerere: fix crash in during clear
Date: Sun, 18 Feb 2024 12:49:36 +0100
Message-ID: <20240218114936.1121077-1-marcel@roethke.info>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When rerere_clear is called, for instance when aborting a rebase, and
the current conflict does not have a pre or postimage recorded git
crashes with a SEGFAULT in has_rerere_resolution when accessing the
status member of struct rerere_dir. This happens because scan_rerere_dir
only allocates the status field in struct rerere_dir when a post or
preimage was found. In some cases a segfault may happen even if a post
or preimage was recorded if it was not for the variant of interest and
the number of the variant that is present is lower than the variant of
interest.

This patch solves this by making sure the status field is large enough
to accommodate for the variant of interest so it can be accesses without
checking if it is large enough.

An alternative solution would be to always check before accessing the
status field, but I think the chosen solution aligns better with the
assumptions made elsewhere in the code.

Signed-off-by: Marcel Röthke <marcel@roethke.info>
---
 rerere.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/rerere.c b/rerere.c
index ca7e77ba68..3973ccce37 100644
--- a/rerere.c
+++ b/rerere.c
@@ -219,6 +219,9 @@ static void read_rr(struct repository *r, struct string_list *rr)
 		buf.buf[hexsz] = '\0';
 		id = new_rerere_id_hex(buf.buf);
 		id->variant = variant;
+		/* make sure id->collection->status has enough space
+		 * for the variant we are interested in */
+		fit_variant(id->collection, variant);
 		string_list_insert(rr, path)->util = id;
 	}
 	strbuf_release(&buf);
-- 
2.43.2

