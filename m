Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF592E9729
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 05:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111733; cv=pass; b=VtFYqynp8UH8+yyXeydOS5c4p1EsSZaA33sWvYuPUX64krZUzw5sgyjjPvdLJUOO3CMsluHi5mtPobxcOuIsnJXtdnSZSTjIA4COmozTryI4PAbij2p06Ih9FtFZ11eiOq1bLcPRwBcfClT2Iwwt3IqUafDKSjmEIOc2luA5jH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111733; c=relaxed/simple;
	bh=5Ma6OpSzaXsmdtEcY2JkOrU26fqiDEkL6CVLRvYsqV0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DjZPlgMM+/0dJjoifJHxzAWBef1f7Gds+9Q955+nBJ+HC8BJHuGYktBu02jwBARx5tV+m4eDGkpHrXxKtyVTVuFzgOQqv7AANOdRmBENApsI6Je5oi1iNj5yD+OiMJyNFH1WDza0b2FoL34g+4bbyRJeCDeNSTBUf/w+BQPZ9dA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=p1yBt22h; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="p1yBt22h"
ARC-Seal: i=1; a=rsa-sha256; t=1761111621; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fFnoPKr0h4a13y6VQaa7nuS1JQhSj8fmEMaKtTMvFwp4esBuTAstcte9m5FroVPY6+C6qhkctPqJhmCj0VaJJSDEEF749GhxgQPXV7JBYzMuFFK38kAk7oGV2H5Vdg1KawZhJNE2Lpgkc9Wsf4BrqlgWpu+96SU1C1TamK/8y6Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761111621; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=N0AmyDyGU8UElDKTxA30MtdhYEHOdxG8RO7woVlOGv8=; 
	b=MJ2exfL3KvdUYKQQGfgf9Fv5QJcfwGfbc+QffqQBppSwkwpglLG9ja1GliV0hxRK9kSPt2NLJMbuIdmEZq3ejDST1f0g8vy5+1BmNcbEMADpWtttRhI6Wdlc21LnDi/ZLnrEB0d3oApXB6+FP3dwbrLehXyG2OrdJoUGQ2j5GaM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761111621;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=N0AmyDyGU8UElDKTxA30MtdhYEHOdxG8RO7woVlOGv8=;
	b=p1yBt22h4fZKs8UCBSU06z+/k6dZaPZ/y5nIJX9wererc/Ap+lhzV4Z2kYS5P0dg
	tcfPSetj8Gmcl5pnzb7X0mM65GNd/rrrVnqqR4HCfRAEPDpSNqqzHZzEjN6Nv0Ac7z/
	V+TxfGmKJwoEqL9NJWEhmZQQPWc5sBNFMV8V0Oac=
Received: by mx.zohomail.com with SMTPS id 1761111618309338.38692310696297;
	Tue, 21 Oct 2025 22:40:18 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v5 11/29] rebase: reuse buffer for trailer args
Date: Wed, 22 Oct 2025 13:39:31 +0800
Message-ID: <20251022053951.602605-12-me@linux.beauty>
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

Reset the reusable buffer before reading trailer
arguments in read_basic_state() so the existing
allocation can be reused.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 builtin/rebase.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index b0f547ef2b..89ecb84a31 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -508,7 +508,7 @@ static int read_basic_state(struct rebase_options *opts)
 		opts->gpg_sign_opt = xstrdup(buf.buf);
 	}
 
-	strbuf_release(&buf);
+	strbuf_reset(&buf);
 
 	if (strbuf_read_file(&buf, state_dir_path("trailer", opts), 0) >= 0) {
 		const char *p = buf.buf, *end = buf.buf + buf.len;
-- 
2.51.0

