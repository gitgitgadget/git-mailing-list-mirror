Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDCB43AA8
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 01:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749690746; cv=none; b=SP0hUxRNT5SwbmnC624wMc9t5WO6kftLRYLR5v06sO4Gua+iznn7e8xaeSvNpzKmMsLDIw9KqlaLQa5DRttxn9MM9ClXik97vcRBz4gBHGvabIzgcHQR+QH2Wz5bQhcZflOEbI9wYXeZvEzRZ0UxVzY+EBPwAS2fmr0IeGOPn2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749690746; c=relaxed/simple;
	bh=Kghlil9lbNsFCXsXfvCqERDFnF8N2V/O58mKM8p/aQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7ePaEEL7xTsZKW0EiYqupMeMa3Q7kjVHWL+RPjCtw7gj1fKA8dwescFEhNkNtJNm9HKgdjmyI+cfhhvvDERzBTUyGuI/bgo06mjppDvgoj5Y2sEBeZy2X7mkMdE5Vj9fokEAVlrvfuwKgBit/z6cTdBadDvx9D3MzTn6lU5Lu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=ELOdymtq; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ELOdymtq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1749690743;
	bh=Kghlil9lbNsFCXsXfvCqERDFnF8N2V/O58mKM8p/aQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=ELOdymtqiuCTMMeaODBLjSdi+rxqxRUazRy+rm4bFKGFFd6BCHqjTJchGW4ojRSRg
	 L+kbBsFU/naUgSw6rnMAg4PcFhh7IFQb10lRKTAqE89s7q0UguAvNIVpsrlxs9H4SP
	 3uJEQL7a7DEW5KvnAVB8zz1YPFXMPDEkS7TDvQjYtTxrWar994FXOrWu3730FfoUz0
	 SlP9ctcNvzh7gf2w0pWSFKO3ZX9it4f6/RY52zFytW8lAXwM4XLpv6ElJXm0vEiHRd
	 iDyAWQLj3mHwZGozPogCzOijZpxwq4JoU+asal/GcLiEdaxRHXavp2fJrq1KvwCWW/
	 7TSWQjJO7OKh5GGsos29cJFM7mx2NCQ6T9BsLOens72l3CG6VD7ejdK66oJBBWMvnE
	 hmRQ9RvyyKXGiFGgl+0VRH74ojGq1fTwbCpKix+YKGZorBT5Uk51ot+fwqTzXJOfrd
	 8jI+M2HVLWoKCi7/k8Tq3TWffzuKZiBZyZGqh3siBWFH2zvjyAQ
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:828b:3227:a916:b7f5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id DE9E72011E;
	Thu, 12 Jun 2025 01:12:23 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v8 1/4] object-name: make get_oid quietly return an error
Date: Thu, 12 Jun 2025 01:12:17 +0000
Message-ID: <20250612011221.4158484-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.50.0.rc0.567.gd817f1499f4
In-Reply-To: <20250612011221.4158484-1-sandals@crustytoothpaste.net>
References: <20250601223225.464076-1-sandals@crustytoothpaste.net>
 <20250612011221.4158484-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A reasonable person looking at the signature and usage of get_oid and
friends might conclude that in the event of an error, it always returns
-1.  However, this is not the case.  Instead, get_oid_basic dies if we
go too far back into the history of a reflog (or, when quiet, simply
exits).

This is not especially useful, since in many cases, we might want to
handle this error differently.  Let's add a flag here to make it just
return -1 like elsewhere in these code paths.

Note that we cannot make this behavior the default, since we have many
other codepaths that rely on the existing behavior, including in tests.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 hash.h        | 1 +
 object-name.c | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hash.h b/hash.h
index d6422ddf45..ec594c63a6 100644
--- a/hash.h
+++ b/hash.h
@@ -216,6 +216,7 @@ struct object_id {
 #define GET_OID_REQUIRE_PATH         010000
 #define GET_OID_HASH_ANY             020000
 #define GET_OID_SKIP_AMBIGUITY_CHECK 040000
+#define GET_OID_GENTLY              0100000
 
 #define GET_OID_DISAMBIGUATORS \
 	(GET_OID_COMMIT | GET_OID_COMMITTISH | \
diff --git a/object-name.c b/object-name.c
index 9288b2dd24..851858975f 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1081,13 +1081,17 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 				 * still fill in the oid with the "old" value,
 				 * which we can use.
 				 */
-			} else {
+			} else if (!(flags & GET_OID_GENTLY)) {
 				if (flags & GET_OID_QUIETLY) {
 					exit(128);
 				}
 				die(_("log for '%.*s' only has %d entries"),
 				    len, str, co_cnt);
 			}
+			if (flags & GET_OID_GENTLY) {
+				free(real_ref);
+				return -1;
+			}
 		}
 	}
 
