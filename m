Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1974A1DC994
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 00:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759280305; cv=none; b=KSPkJsZ9w4tl4oHowmgdpuLT1htyE3vhJq195m3p8Bg2FYFWRvLISkw+XOlcyIvABrFdAdmpQcNO+y+Z5FqRbuFHNMcFdDLKg1sFq34eU62Yg7i09J3K75uS5sEACNemSmVaj2czRKyfdTKAJVnpIvBBZksL6y7Ns3FQwHIKwpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759280305; c=relaxed/simple;
	bh=tBQHyLui0Q6qs6bD3FOXPwKHgOXK9fuUmk6Au/KrmMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mRPNX5AC9/oKvxzvf1gTJJvzobuPH3fxe+zLHTkz2e7t1NtZBpyjQdBwJjr0lLwQN4W45lLokTie5twCtCFLjRKCDVuUNf2XYAfn2ooYBvWSFG4KrvQjuzpZhDCF6bBmvZoI1N9BzEBooBXVse1Do1e1agHtf3ooNq7dDDhzuqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=hO8O8tGs; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="hO8O8tGs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1759280300;
	bh=tBQHyLui0Q6qs6bD3FOXPwKHgOXK9fuUmk6Au/KrmMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=hO8O8tGsW+UdLba5wJ+KzpTnQXr9Gxq1gJpANvoVC+UZbOwz7PsRVrGEMbFMDV9UA
	 0WJDI6dVXA15ohTL2vHUpLckJQOW8Pqh/TCllaoJ1AAVmpPHGKcHMcF8n1du7heN8e
	 pTEtQqaSxtFs2AgkivazTtCLM/+QEUtSuONqCwUC/AJT0ZogssXh2dHZMqYYmhN/aS
	 rbJLB1VpDB/RHPBoQirt6no82/mhb1VRS+XoiSfs3EOgm+zdM5qCqre8zUt5YAV0XJ
	 UBLz5c9qxGlcpw/MMGUWeMFhanxv5l96Pk0u3nlUYBJv7WhhdYQjtgzCjUs7d19QUk
	 3n1r4BlqfnxNeFJfSl57hsQBOX5xnLE8J8giLgI/RFRQD9zNttfKKIahjF2hkwR6k7
	 5mbxbKmieTJOmigPHgszk4v0ZFgBATSghNLcVIXSq2EtVmfBB7+BV3Mr0wdv0Jirr7
	 1DLFF7M7CmnY5RdLykLVTZM2217fclZGNldjptiCNt8eXNyRbNv
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:3c0c:de88:5b0d:9364])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id D578920119;
	Wed,  1 Oct 2025 00:58:20 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Jeff King <peff@peff.net>
Subject: [RFC PATCH 1/1] Define an extended tree format
Date: Wed,  1 Oct 2025 00:58:14 +0000
Message-ID: <20251001005814.846992-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20251001005814.846992-1-sandals@crustytoothpaste.net>
References: <20251001005814.846992-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some cases in which we want to encode additional information
in a tree but there is currently no possible way to do so.  Define a
format for extended trees that uses mode 130000 plus some additional
nonzero bytes in the file name to encode additional data in a mostly
backwards compatible way.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/Makefile                     |  1 +
 Documentation/gitformat-extended-tree.adoc | 77 ++++++++++++++++++++++
 Documentation/meson.build                  |  1 +
 3 files changed, 79 insertions(+)
 create mode 100644 Documentation/gitformat-extended-tree.adoc

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 6fb83d0c6e..6d8ad220ed 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -33,6 +33,7 @@ MAN5_TXT += gitattributes.adoc
 MAN5_TXT += gitformat-bundle.adoc
 MAN5_TXT += gitformat-chunk.adoc
 MAN5_TXT += gitformat-commit-graph.adoc
+MAN5_TXT += gitformat-extended-tree.adoc
 MAN5_TXT += gitformat-index.adoc
 MAN5_TXT += gitformat-pack.adoc
 MAN5_TXT += gitformat-signature.adoc
diff --git a/Documentation/gitformat-extended-tree.adoc b/Documentation/gitformat-extended-tree.adoc
new file mode 100644
index 0000000000..fc28bb16c9
--- /dev/null
+++ b/Documentation/gitformat-extended-tree.adoc
@@ -0,0 +1,77 @@
+Extended Tree Format
+====================
+
+Rationale
+---------
+
+Git needs to store some additional types of data in repositories that we had
+previously not considered.  Unfortunately, we lack a good way to extend tree
+formats in a backwards compatible way.
+
+This document proposes an approach that adds an extended tree format that is
+backwards compatible with earlier versions of Git except that it will appear
+that the tree is improperly sorted.  This is done by encoding additional bytes
+that are guaranteed to be nonzero and that earlier versions of Git will
+consider part of the file name.
+
+Format
+------
+:ber: footnote:[This is the format used by the `w` pack format in Perl and Ruby.]
+
+An extended tree format consists of an entry that has mode 130000.
+
+A modified BER-encoded integer is a BER-encoded integer{ber} with the top bits
+of each byte flipped.  That is, values 0x00 through 0x7f are encoded as 0x80
+through 0xff, and larger values are encoded such that the bottom 7 bits of each
+byte include the value and the top bit is 0 if there is a subsequent byte of
+data and 1 if this is the last byte.  The shortest possible encoding must be
+used.  Note that the byte 0x00 is not valid in the encoded value.
+
+The first part of what is traditionally the file name consists of a modified
+BER-encoded integer representing the number of bytes in the extended
+information section not including this length itself; that is, the number of
+bytes which must be skipped to reach the file name.  This allows parsing
+unknown values in a graceful way.
+
+Following that is a modified BER-encoded integer representing the type of
+object and a modified BER-encoded integer consisting of flags.
+
+The object type is one of the following:
+
+0:: invalid
+1:: conflict tree (only valid at top level)
+2:: extended submodule
+
+The following flags are defined:
+
+1 (bit 0):: This entry is critical and failure to handle this object should be fatal.
+2 (bit 1):: Flags in this entry are critical and failure to understand them should be fatal.
+
+A conflict tree then has a modified BER-encoded integer representing the stage.
+
+Conflict trees are used to store a conflicted state.  The top-level tree
+contains only entries called stageN, where N is a decimal representation of the
+stage integer.  Resolved entries are always stored as stage 0.  The contents of
+each tree are those of the root tree at that stage.
+
+An extended submodule then has a 32-bit format ID representing the algorithm in
+question, followed by a nonzero byte called an offset.  If the object ID for
+the selected algorithm is longer than the algorithm for the tree, the remaining
+bytes of the object ID are encoded such that each one is XORed with the offset.
+The offset must be the smallest nonzero byte value such that all of the encoded
+bytes are also nonzero; an entry is malformed if this value is incorrect.
+
+If the object ID for the selected algorithm is shorter than the algorithm for
+the tree, the main object ID field is padded with zeros.
+
+Examples
+--------
+
+An extended submodule of a SHA-256 submodule in a SHA-1 repository might look
+like this if the submodule object name is
+deadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeef and the name
+is `submodule`:
+
+----
+130000 \x91\x82\x80s256\x01\xdf\xac\xbf\xee\xdf\xac\xbf\xee\xdf\xac\xbf\xeesubmodule\x00\xde\xad\xbe\xef\xde\xad\xbe\xef\xde\xad\xbe\xef\xde\xad\xbe\xef\xde\xad\xbe\xef
+----
diff --git a/Documentation/meson.build b/Documentation/meson.build
index e34965c5b0..e2257050e8 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -172,6 +172,7 @@ manpages = {
   'gitformat-bundle.adoc' : 5,
   'gitformat-chunk.adoc' : 5,
   'gitformat-commit-graph.adoc' : 5,
+  'gitformat-extended-tree.adoc' : 5,
   'gitformat-index.adoc' : 5,
   'gitformat-pack.adoc' : 5,
   'gitformat-signature.adoc' : 5,
