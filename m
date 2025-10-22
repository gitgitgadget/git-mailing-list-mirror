Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572902F12A0
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 05:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111681; cv=pass; b=mJRW8jyyU6EsC/OjyGd7KSL04Pyf6Jk1qsJOPYfGcMUa/1dOmGMSpoT0xK80u/O0K7sMX7gUEuvMFfNvcdyfAmuhLPNbin0zLxr1Cdim4Fapgv7uWUpUmtZ8Ts91ZcPFQbR4ZvOX4oaqGJJwo0n7KcATgKLOXw4wEcD1e2uC7Ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111681; c=relaxed/simple;
	bh=GbfUgghimiAErWClwqbn3zw8PZ+aR/s73LbqHj7JBFk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMiKD4mNCuntdJkU1CI43M/nD42DAp8j5BHK2KBtCKSU4vCswJQ6xAb+coH+8n5xhvTt7TctrgsdagG7vLufyTRrgizG0SHoLoGquwYP/eFHO7SRlOY26rUDpxc62tGTkofVFI4VWUamJ8/vB1msTpIkw2W+yFd5ymIppltVIDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=QgLn+ru7; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="QgLn+ru7"
ARC-Seal: i=1; a=rsa-sha256; t=1761111611; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WvK5VCZoCSQi6u6WEkjfPiRv0rHq52H7VB8V9yARlfAVH6GwAtkcgyKfkPcanEVlz328m/ACxPQu4s5DRAGVPQ7iURmm3B9BfK2SES0iR7YGG7sIhwU3YGPKD64eRkH9xxsZz7d39+8YIRYPEtSmMl0fP16qaEdjxdFIzZIRO6c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761111611; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=tGa8lUUXMD+83ipZxvOdWEwQsijOxKapzqRcUOTsXN8=; 
	b=OATF6WcUemJmV9ZoE8sEHmyK+lz6KK81XKgFVTP75nwPta8g4HIt8BPnCJOBtXSN2LHDImr4EzTOJsO6W+nfOGNc3tzctk5uDs2GCWQQvb9bCFyRKuRpJsXshCct9kvW5+2zy4Vc10cELvADAmcDAs+XMZNL/1C3kvLtPwqphvs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761111611;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=tGa8lUUXMD+83ipZxvOdWEwQsijOxKapzqRcUOTsXN8=;
	b=QgLn+ru7RyicvN7mmtdtzCjWVLSE+05p5vluESLDPTRYPEK1ixczUkG1x8In909F
	iCe+LWTWcCi1O7N26NC1sljMiG8Q8vJFlvFaiKVG9WG5eRm1wiCI2kD4oFgi9Vzyd1X
	rA4fl4Fuehrc4q7liORANbl2vnTyVU9va2HpBUEc=
Received: by mx.zohomail.com with SMTPS id 176111160877753.18633393364678;
	Tue, 21 Oct 2025 22:40:08 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v5 06/29] interpret-trailers: buffer stdout output
Date: Wed, 22 Oct 2025 13:39:26 +0800
Message-ID: <20251022053951.602605-7-me@linux.beauty>
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

Simplified the non-in-place path in interpret_trailers
by writing the existing output strbuf directly to
stdout without creating a redundant temporary buffer.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 builtin/interpret-trailers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 2c8b6fc3b9..cdf39dbca8 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -122,7 +122,7 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 	if (opts->in_place)
 		write_file_buf(file, out_buf.buf, out_buf.len);
 	else
-		fwrite(out_buf.buf, 1, out_buf.len, stdout);
+		strbuf_write(&out_buf, stdout);
 
 	strbuf_release(&in_buf);
 	strbuf_release(&out_buf);
-- 
2.51.0

