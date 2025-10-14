Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099ED3126B5
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 12:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444828; cv=pass; b=vERRviC/kWXz8jbmVkxmhks21BuQcL2CIhdT4qQt9p4MXz9SuRfCHhVd5mKWe/tZLAoI7vtmnIYqLxxB262uz8TDnxAr9wAkPgykPh50RJppIRWUeOVDf7gAqHMKGRGW+U7idDqRNk+JREHv8Mj4tRHSpExEipeq8r0zVXbQeDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444828; c=relaxed/simple;
	bh=KZkAsr6zbtP0Lba03hwinyVYy2XoSgHGP5TUx2tTe0k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a8s3l2/KVRkAMbmUOXkzRjWWTEGx+a6zmmBt2PMeu1zUoMRGT52Yz8X41eZPprFNyrC0wwBTKn6kkUKzqwzIEBeB8P2eyE8WJI30Zax6EQHxxE6El5npjomuDSD8nZ1xqrX12RZecyepwu6kPrcHsxyfIl1JiytnRpEfDA+qwtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=mgInn7sY; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="mgInn7sY"
ARC-Seal: i=1; a=rsa-sha256; t=1760444740; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hDcY2uLoAV3D+vSIcv1edv6Z1VCoeY/zB8hvWbdIMPHScSvaJmv+HprTYhCprQuowMYItpoVgyC42fEc9anLCBU+bT5g3GGuMg7HShUzmjx+y2hUypZvoYQ3wpLTYtpcse/kgQMqESxseRB0XkCytbuwkHT4qcwPguu0mDIha9g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760444740; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=zhIrn211fWq5dL9FQSsrQshFa87+MCTwng62sc4H26o=; 
	b=iRZ9lEmYoCxL9TKpT55GXQvkFgSaXIySrrE/BZu+A1T//lPHG1ti2dPQTtTN8N6D8PQWnQkqaAP73NTvYRPYy7hCXaLdZSxYDX8Rq8Ukg66NYxQwE//KxpUgpzuesyjZx2EmIvfO3oBy2vU6O/xqSPcBXqIaA/sg5DGXVEkAZK8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760444740;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=zhIrn211fWq5dL9FQSsrQshFa87+MCTwng62sc4H26o=;
	b=mgInn7sYFodvPYRm86Sru4V+Rm0q9GxvG1QBMkn9hJTYl+RtczuGa9QSg5mKqdyn
	8N0zSxgORCPVGKqi3V4HMJZUOmYYOPqx87tg7rNI9ZCcgurLt/IUP/BMYIt1mClzyNr
	r/kMu2voGwt2ggqmGLd2+DdEJ9KwO1+22XTy+B+g=
Received: by mx.zohomail.com with SMTPS id 1760444738503454.5929986542476;
	Tue, 14 Oct 2025 05:25:38 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
Subject: [PATCH v4 12/29] rebase: drop redundant strbuf_release call
Date: Tue, 14 Oct 2025 20:24:25 +0800
Message-ID: <20251014122452.1851103-13-me@linux.beauty>
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

Removed the redundant strbuf_release() call in
read_basic_state() so the buffer is released once
even if strbuf_read_file() fails.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 builtin/rebase.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index ff8dd9ec90..51fb9388c7 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -524,7 +524,6 @@ static int read_basic_state(struct rebase_options *opts)
 
 			p = nl + 1;
 		}
-		strbuf_release(&buf);
 	}
 	strbuf_release(&buf);
 
-- 
2.51.0

