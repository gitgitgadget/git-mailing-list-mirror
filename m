Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7462AD1C
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 01:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750382397; cv=none; b=L0QJpw6ywQ9Wti4RuCWLEEVkkrwoB4H0/nk0HHZn9qrvaNQ8PmdDVm0RRzMbzfYpWDHv8PDa9gPmgl8MlBf5egR01aOTq/E7dt1kOZzBjXsoUirnC/+yQTKHmXWUZ0YO7UwRxvlg2oXol3RjYqnMa99gcxCEYh+coerQfPUT9mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750382397; c=relaxed/simple;
	bh=+v9+oZZfE44wk2LefcbWzvPuTreo+w7xfV3y4plg8xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUhr610D8dnKuuFbxP57Fq65WOD+7s8cMdRNDe7cbYCra/waLzyB5K1dxYN3/TEqbFhkMgNzDg7wtmES9XWn4X5pPp2N75hO0wPACVnBgH3wZP+cZ5/whaFAxLggT206vJyU1FMGtd9batPSnfYiDR9ZwIr5nqh6MId6R295x6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=CKsZEqjs; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="CKsZEqjs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1750382394;
	bh=+v9+oZZfE44wk2LefcbWzvPuTreo+w7xfV3y4plg8xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=CKsZEqjsydw+7jamIZP/fwmhpjeZvo2E+xqqefiKKkuiLYKrbTEdnihO/akybnXpG
	 mi/hfwDvo8sN933D5tS7N9pW7etiKda3HQmuiKQk03OOjgcpph2s9rCEx+UxMKkUDp
	 mByjvitSv26CG5JPl2yhdZsD8QW3OlqUnKOJxBUp7A4YL3jJYIDp+YDdd3SKSOkS+u
	 nYeBz+yaogOKc7zwtc/UnJZ3DnRqiOtTfUh+WvqFFpPVEhUQrLOHfjEnTs6l7kYtNE
	 MxK29u/arS7/0KGQrW4v05pUmhjB6TL+CBEyPCcxPoFaI4H54/GuMRS0Op4dtlOoTb
	 zY4PeaJGDN41jiQ8u8Vxs6ICKmDuMS48AGm+NZilC3jIHbHt5bKG0splnj8bMQrZv9
	 x4qzI9XNmKOPBb6jJrD0QaCUESbynXcJ0cpTlHhwuBnW3IW/k74pWcRHvleHUAPJNr
	 QEXMimN6CPgJOrMVSVq6mIccBCFyuQ05FbSZEl4xhR5mfhqBiST
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:f445:674a:9eb4:f272])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B782C200AF;
	Fri, 20 Jun 2025 01:19:54 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 01/10] hash: add a constant for the default hash algorithm
Date: Fri, 20 Jun 2025 01:19:33 +0000
Message-ID: <20250620011943.586596-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422f
In-Reply-To: <20250620011943.586596-1-sandals@crustytoothpaste.net>
References: <20250620011943.586596-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Right now, SHA-1 is the default hash algorithm in Git.  However, this
may change in the future.

We have many places in our code that use the SHA-1 constant to indicate
the default hash if none is specified, but it will end up being more
practical to specify this explicitly and clearly using a constant for
whatever the default hash algorithm is.  Then, if we decide to change it
in the future, we can simply replace the constant representing the
default with a new value.

For these reasons, introduce GIT_HASH_DEFAULT to represent the default
hash algorithm.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 hash.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hash.h b/hash.h
index d6422ddf45..0d3d85e04c 100644
--- a/hash.h
+++ b/hash.h
@@ -174,6 +174,8 @@ static inline void git_SHA256_Clone(git_SHA256_CTX *dst, const git_SHA256_CTX *s
 #define GIT_HASH_SHA256 2
 /* Number of algorithms supported (including unknown). */
 #define GIT_HASH_NALGOS (GIT_HASH_SHA256 + 1)
+/* Default hash algorithm if unspecified. */
+#define GIT_HASH_DEFAULT GIT_HASH_SHA1
 
 /* "sha1", big-endian */
 #define GIT_SHA1_FORMAT_ID 0x73686131
