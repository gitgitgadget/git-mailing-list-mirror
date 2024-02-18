Received: from smtp.roethke.info (smtp.roethke.info [46.232.251.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7061E86E
	for <git@vger.kernel.org>; Sun, 18 Feb 2024 19:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.232.251.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708285575; cv=none; b=XlgQ7yIulBy2OUwBh13sO3t9aHuwRPgpkpqhlZu9VLTBAH/9aA7J6uuHtBSLQQlQGo/ShJ6ZF4O1GCuG0+l0AOOscyVCiMD1YIx0O61FYsJl9J0JeymgoSvqd+3V9Nsoqg1PNEurp0qj1lYtiNLUmw2tSK7H9QoThsvcMw6Tjqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708285575; c=relaxed/simple;
	bh=zSON0zpX92sN/aKytPMrUQU6B34WEf+46rzC6z82zzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r9Sn/xZO2UmFNdCBTwxeygaPHbGiGAnzDUfMWuxjZAtJSMHDlVT1aWsIGRCbNZQifPXHlzXPkiN2b8AukMQcZmWbPP2ex7mPssDcqMcQZ+oqdur0qeNGhj+56RuTXJu0DIbVDQfGIJs1+OEAd912LQxEx0paKpDe+7uJIzK9+1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=roethke.info; spf=pass smtp.mailfrom=roethke.info; dkim=pass (4096-bit key) header.d=roethke.info header.i=@roethke.info header.b=cFoQIpfr; arc=none smtp.client-ip=46.232.251.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=roethke.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=roethke.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=roethke.info header.i=@roethke.info header.b="cFoQIpfr"
Received: from localhost (unknown [IPv6:2a01:41e1:283b:1000:bb91:34f7:c1e1:8a6d])
	by smtp.roethke.info (Postfix) with ESMTPA id 9328B1E0004A;
	Sun, 18 Feb 2024 19:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=roethke.info;
	s=20200807; t=1708285571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pQ1DjjC7k70vP8adyqUNAVkMl9mmlFy66qcTKe6cEpI=;
	b=cFoQIpfrxK28kvNZTFJlM6g/zkU4ohcexWFIaJB6zIQqftmKiT2kuVNuEX9BSfZ8gTpXoB
	Q9uHqzZuUlWW5+onKSN6ip+2ZiW5PzCdFv4EPLMZTCMZ41Ebm1WD9k1UBW3QNuw/tiUpSp
	1RUH0JmWPVQGTRAoB30aM9QXZ90IdDfgN8o4h3xLifqlqu/F4LFoq2Mi+Rf0kCpbiJOz2s
	Jew4gPBn3ZGCPnIBuBx2Zt982moTnbzhwkOJXa1uIUAd+FBvzQ90tP93gSmFGgs3v9ttGp
	mmdY4Mz9XtrfioOBB0SaH63g3R5ivDTr8NEIPygowzUI/H+y9iVn3ZB20fy7bly3H7vQtR
	Z/Z+/W8hxOj0q8ayw/PHravBM7BkSplQd/oWlqTtCMpuZiRhE/8rxP4vvPBACfTgnZhEBA
	0VgX96KXvfe9gOSkVpxpXzQzHQLycnokmy7vfdmb+c12SpNjLoHZCIjm5Ru9o57hCgnq5R
	0mVZgOM3y71o9UrPggDcN/Sc1Whj8g9Z1GVWg+E5+mmEOnOmfw31sjQXklRxWtAef4otPF
	QgO8OHmV+va+lTvzkXNT8urlLxWxXQojjRS5OFM+R3RJdHYQq04GQf4jekF3+2X/FKDCa7
	KwSaB0cQw8NDIzXIQ4ixQH1JloT++a9WKr926Cdr0W2QP3Q0fekco=
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=marcel@roethke.info smtp.mailfrom=marcel@roethke.info
From: =?UTF-8?q?Marcel=20R=C3=B6thke?= <marcel@roethke.info>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Marcel=20R=C3=B6thke?= <marcel@roethke.info>
Subject: [PATCH v2] rerere: fix crash during clear
Date: Sun, 18 Feb 2024 20:46:03 +0100
Message-ID: <20240218194603.1210895-1-marcel@roethke.info>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240218114936.1121077-1-marcel@roethke.info>
References: <20240218114936.1121077-1-marcel@roethke.info>
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

Solve this by making sure the status field is large enough to
accommodate for the variant of interest so it can be accessed without
checking if it is large enough.

An alternative solution would be to always check before accessing the
status field, but I think the chosen solution aligns better with the
assumptions made elsewhere in the code.

Signed-off-by: Marcel Röthke <marcel@roethke.info>
---
Range-diff against v1:
1:  93f982d170 ! 1:  68178298fe rerere: fix crash in during clear
    @@ Metadata
     Author: Marcel Röthke <marcel@roethke.info>
     
      ## Commit message ##
    -    rerere: fix crash in during clear
    +    rerere: fix crash during clear
     
         When rerere_clear is called, for instance when aborting a rebase, and
         the current conflict does not have a pre or postimage recorded git
    @@ Commit message
         the number of the variant that is present is lower than the variant of
         interest.
     
    -    This patch solves this by making sure the status field is large enough
    -    to accommodate for the variant of interest so it can be accesses without
    +    Solve this by making sure the status field is large enough to
    +    accommodate for the variant of interest so it can be accessed without
         checking if it is large enough.
     
         An alternative solution would be to always check before accessing the
    @@ rerere.c: static void read_rr(struct repository *r, struct string_list *rr)
      		buf.buf[hexsz] = '\0';
      		id = new_rerere_id_hex(buf.buf);
      		id->variant = variant;
    -+		/* make sure id->collection->status has enough space
    -+		 * for the variant we are interested in */
    ++		/*
    ++		 * make sure id->collection->status has enough space
    ++		 * for the variant we are interested in
    ++		 */
     +		fit_variant(id->collection, variant);
      		string_list_insert(rr, path)->util = id;
      	}

 rerere.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/rerere.c b/rerere.c
index ca7e77ba68..4683d6cbb1 100644
--- a/rerere.c
+++ b/rerere.c
@@ -219,6 +219,11 @@ static void read_rr(struct repository *r, struct string_list *rr)
 		buf.buf[hexsz] = '\0';
 		id = new_rerere_id_hex(buf.buf);
 		id->variant = variant;
+		/*
+		 * make sure id->collection->status has enough space
+		 * for the variant we are interested in
+		 */
+		fit_variant(id->collection, variant);
 		string_list_insert(rr, path)->util = id;
 	}
 	strbuf_release(&buf);
-- 
2.43.2

