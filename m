Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE53C2367D0
	for <git@vger.kernel.org>; Thu,  8 May 2025 23:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746747913; cv=none; b=lEvx07dU117K3yhRp4Bw2AJB4RLC6vfqRxZqBmq6KiHVz0/eVpTa5g0kRredMb9W2UQW7ucH+xafPbCYApcWIrtzNZX9bKx+xgf7iH5Lqs/xwkfLMdGmqMAVmeiWdzmp3cNsvVbOJK8PR1d9nHczY5BFp6oJG/me+ftMxF7knPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746747913; c=relaxed/simple;
	bh=sixLeMQe4R+awExaX36Bik0LkfzmZfdscOB07EwQSNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B+ntob82KdqkQvOhNI0XKamF/lwMosTzO/7UqkJlxkXgJpGKpJ0K+pvhd3CvqB6jEXlR++63p/R+51GqP/rytpppgF0UOoFa5ChErntCClO9P2Z3tI5TbpXRsYyaO10UE4PNLO/jlC1B1gq6KyUiZPcGPZpCSypljPytk5L7W6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=RPe4iqE/; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="RPe4iqE/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1746747903;
	bh=sixLeMQe4R+awExaX36Bik0LkfzmZfdscOB07EwQSNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=RPe4iqE/klg4IHJojlgKxX1zeew0ZrAnFoCcntAp9XmeDrQJ3eZqt6yj8K7D0rF7M
	 rpYt4joIIg9LNyCC3u0TojKkySG4haYT7aLrojKwFBZYBewgAXJeSPFoLY7b02Ws0r
	 vZxToJJzByKcMu4eZO6XHCL5FxQ+ddii8MkwflQ9OOF4wKCuWV/fV8XwPXXf1Wm6+u
	 R70hpu3jHAZ6l2oGwkTdcwrBUx8kFLqOrs89BiWrtFn1ezFAPjf8JLar2Vg6t0JxdX
	 wfeBnohf/PYjygN9eCeEXt4Y4gY33W1j4gdJ3V3L8uBfFoo2fZ4eKq6sH7ea30EekS
	 B1sWd6rL8S+Dbw5crs0BCtnIyahKvTvpOqjMd0atKb5A0yVPnxBAbCSN4cIBIg/Yo1
	 V+Mn37XbawDBSHGD21Jd7A+OmUAC/UaN4KshicsqX6HdGfBiIt3P02nu+mv8una4zL
	 gaU5juAJEEUz0CbyQ+ERrllHzHpPrDRLHBvjmTaTBn2WbFPosO8
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:df25:78ac:1a43:dee8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id E6E832011F;
	Thu,  8 May 2025 23:45:03 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v5 1/4] object-name: make get_oid quietly return an error
Date: Thu,  8 May 2025 23:44:54 +0000
Message-ID: <20250508234458.3665894-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557c
In-Reply-To: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
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
index 2c751a5352..3138103343 100644
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
 
