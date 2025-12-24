Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A19829DB86
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 20:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766608403; cv=none; b=bA13jyIWj/AghvBBNnHSbWfSo+tkBYGQoT4KjBfrhYfwLiiASWrmGCY4TnkeWL02D1+GXvgbcq331cjH1h6d0GvUL+2yz/+OAZ452j/oXKnjEiMKW0NUU5sTy/8YTWGwThV5fe18Ko9ZV2mqdQClHgO2LfXjU75WaY9szbo8Q8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766608403; c=relaxed/simple;
	bh=t/bXh/DDMsurJmDTvMQG2QP/FHHYwFckuiJ99JqM44Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bj956kiJaFf+kr/Inq2YdPVT8SaoHOuIW2GJYpqyP1cFBc8W1Aus4XvxKrbCNpFw4tOPGbOcrSg+kB/SJ3Cdz6bHi5jE5+lLHy6JYmRH4M4XtyfgJVj1wGXgb2WJ7Z24KRamRoccA2J9oa3OiGZ5Y4Ayif5pT93KofVcSsBzCXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=SIQbxg4B; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="SIQbxg4B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1766608399;
	bh=t/bXh/DDMsurJmDTvMQG2QP/FHHYwFckuiJ99JqM44Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=SIQbxg4BaD1Uy1uLONTrwyDXgJumuYMa8vFmd2Q4P22Ey8qGWwGE/Fnbjwkj1pSaK
	 ygduryAboaDWjEyLLfQeyH9SQUe8Ke/mwJHa4ieT99Jau914BsyfBf4k6+O0wQ8pll
	 9wUMv+ibQk2rKj7tdsDwzxtIzvvvD03pWnS/zIk50RSQ7k0Gc7BKnk4mYC2hulLLD8
	 y0tDZwa0bSIBDX2bfGiLv9ouSx8vPH5Y5VcTE//2QrQE80zKwY9uxNa0wd4D3BUAvj
	 bHnuoxb285FWDFU78XevFmb4J10pHjdePk8PjxrVZHlO0rt4bRwb3la/7B885tLdKY
	 sVjlxvcW3/oP6a0P0q8QpDoofu0EAMtVnsu2CE3QLmoonrmDSrcdoihgrkLw7gZz31
	 Jvs9lGjMPyt81Qoop+I8XjZENj0I2nFNHlQlSo3kE7txIoF2ysAxUww4oXAI3CJKGl
	 c5UHxwIVtOF6CVe3KJVl8HI8+yLtQe923m+Pjow4ivphHX9NONq
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:b928:cf9e:1e81:aac6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 9432320079;
	Wed, 24 Dec 2025 20:33:19 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Zhelyo Zhelev <zhelyo@gmail.com>
Subject: [PATCH] checkout: quote invalid treeish in error message
Date: Wed, 24 Dec 2025 20:32:53 +0000
Message-ID: <20251224203253.881129-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <xmqqbjjqslgq.fsf@gitster.g>
References: <xmqqbjjqslgq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We received a report that invoking "git restore -source my_base_branch"
resulted in the confusing error message "fatal: could not resolve
ource".  This looked like a typo in our error message, but it is
actually because "-source" is missing its second dash and is being
resolved as "-s ource".  However, due to the lack of the quoting
recommended in CodingGuidelines, this is confusing to the reader and
we can do better.

Add the necessary quoting to this message.  With this change, we now get
this less confusing message:

    fatal: could not resolve 'ource'

Reported-by: Zhelyo Zhelev <zhelyo@gmail.com>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/checkout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 66b69df6e6..261699e2f5 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1899,7 +1899,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 		struct object_id rev;
 
 		if (repo_get_oid_mb(the_repository, opts->from_treeish, &rev))
-			die(_("could not resolve %s"), opts->from_treeish);
+			die(_("could not resolve '%s'"), opts->from_treeish);
 
 		setup_new_branch_info_and_source_tree(&new_branch_info,
 						      opts, &rev,
