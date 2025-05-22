Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEE4189F57
	for <git@vger.kernel.org>; Thu, 22 May 2025 18:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747940178; cv=none; b=ojV3mzMwRwbyPTnzXqfCXowl5fQ/AhU/dOrOnhCbvsGRx1CInWGQ25Q6cbjFMLjH9CXrZ5o5ZEHXWizcmbuQ9YcEdV42bZTIwKVGqDDYbOf/hcGU5U1WEsDt+7y/yiYzYj3odL75dmnSmPEKFiFBtoOM687TQKb9FKcb8sU4nGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747940178; c=relaxed/simple;
	bh=Kghlil9lbNsFCXsXfvCqERDFnF8N2V/O58mKM8p/aQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oL1y+IBDI0wEimToyXKrl9Q3HbCS548ssJaORMALdi5MQ6R6nFi+LKIChnyM2OMr/2lsSSWXVSo7qis3uIufjPAQ6G94yc8mWzmbaB03tbl5C5XylrWxqAajhtVYX5+Z2DLSaaQMdOVMwnieG6S2+EyFQS44XPMlfhNg/SAySW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=qu/AvaK6; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="qu/AvaK6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1747940174;
	bh=Kghlil9lbNsFCXsXfvCqERDFnF8N2V/O58mKM8p/aQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=qu/AvaK6ujcagEQ4nWqan1iLgAQCj4ca5Kd5hhOK5CM4hvcsc7wxebKMxlpWNXgft
	 s1VRXg0ukV99CKpEswalARqy1W7h2LebKXJl6edEEn3+mKp1VyACynZgxhFF+yZtjU
	 fxD0y/Nm09q5PkOQTYfT0GEVPOakUOpMdUxLZJzK0pyYI0NIuBdt2guc8S+jvWJonE
	 IUE+Z+Aj6LY0T19k+2QRL6umORIKI6jOR493CnPMU/xg8L3OyO0lS2HvbGL1mWoJ1g
	 CTnxH1rDlPB2LZfKaZ1UqstMSKKtMDFhQdO64jyhMEP06J2CuMtcEXpItgP8Dp3d2V
	 qtqj3aTJXZDmpafGdO+4zUfgv3mOX1UO0+/LjmXpJjwFu2qwikBNovZ0+v3EDYlCrw
	 MV2NerdyfWCi7C8Zze7EhofixbYe9csuju9G9dxrjV6oChq4FVCNuHpLxNt7M1yRFd
	 8iFcRIrine32joQccp56BkvfPiXFImdLykHslT4bx2cIdjKcZmB
Received: from tapette.. (unknown [104.129.158.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 8C79E2018C;
	Thu, 22 May 2025 18:56:14 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	pwodd,
	"D. Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v6 1/5] object-name: make get_oid quietly return an error
Date: Thu, 22 May 2025 18:55:20 +0000
Message-ID: <20250522185524.18398-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557c
In-Reply-To: <20250522185524.18398-1-sandals@crustytoothpaste.net>
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
 <20250522185524.18398-1-sandals@crustytoothpaste.net>
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
 
