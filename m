Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C02E2EFD86
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 05:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111743; cv=pass; b=qOON+QiG97Mk9Vj0hM7asFXEbGF/87Y5oQ42zh7LU/+9CJ9xTvAHhEeI/iv4uqC4Yp+jdWmeTjlijvZEbPkSV6z0cH8aSmufa3XVCYsuDXiU8LvQW+NgfpjUTfjec0KwRvA0tRDx/DSi9ffI3L1plrfpjEbjAU7tlzicNTn0bk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111743; c=relaxed/simple;
	bh=o7yefHT5hSWSwJZ+g14nEuUpwZiy2ZaMAnsU/kMj514=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xs12CPozqLrjjJU3gobUheMMxtBbExvgO85QtFGxlYsWptIaueuB+GLM1SAJ7z03VgdpYH4iGVl4oCAzJC7QVKXS4KCQm0Q1T27lLTmfNto/lvtZkRP6HFnp3RqBnLa7Ah3rFb1ijR8Nl7wk5PEF4hFGr4roj6kRyebtFoYCj0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=jQjtO85Y; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="jQjtO85Y"
ARC-Seal: i=1; a=rsa-sha256; t=1761111623; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Yz+MEFpKhae/Ndy15XUyGOPb4CpmKMF+2TSW4wOmKAnk6fxIkvBVhDIybrPJt9xsmEzpVclaYRwYD+birm3t3mU8aMsDlgz5kVRc789rZC7h++JxZmRnxf13uGLYYbKAj7VidCemAbaCPP41+pqKZNjq0FN9+9LeQiH72/wIvQ4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761111623; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=frJ9+v73jijGjOqTVZBvsj9vsUyD6PjRTnQZf26ro4s=; 
	b=K4hbcj7hr9Vu2TPzrAE4vZfaBSHzO1+pPcqEb2Z2XdohjOAB4KhMy0OoNzadUjS3iz5J3OXcUx13QGs9W6UWpF4nuqVdiA7yVMHBBhYt50P8hVsuZvyLa2BQE2YnAdDOCjfRVDLCldkLZ11/HVI2ky3/krrF96j+wZeW74Vxba8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761111623;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=frJ9+v73jijGjOqTVZBvsj9vsUyD6PjRTnQZf26ro4s=;
	b=jQjtO85Y2lvCRSWU+fm7KIaVOP2E+2pVgbxeo8BibpGlNgf52IvFzZoNh39Zt/oy
	7+4pFIh3+vSg2yr7nGreqoxUoofUWWMSS548jALJjeAq/Cbgkd5TF+eSHBSzXbJ5DSe
	ze4SG5gCx41jqV3bMogzFfvylNt296ZlTFXV50OU=
Received: by mx.zohomail.com with SMTPS id 1761111620223830.2143450278191;
	Tue, 21 Oct 2025 22:40:20 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v5 12/29] rebase: drop redundant strbuf_release call
Date: Wed, 22 Oct 2025 13:39:32 +0800
Message-ID: <20251022053951.602605-13-me@linux.beauty>
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

Removed the redundant strbuf_release() call in
read_basic_state() so the buffer is released once
even if strbuf_read_file() fails.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 builtin/rebase.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 89ecb84a31..a950005dfc 100644
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

