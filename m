Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2893C0B
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 00:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712362158; cv=none; b=U5hokfrV1+bBbzwX3Guy+X1x4z3UpeJg5CgXE66K6w24tyQmuh1RXzmhx2ovxpeVAT+ISjWq6/qkgHIDunphCs+f3ms7syJ8lzzpCAmb0Qq3utvJ2ZrIhQEshrZMngXSCu84FICJhMTrFDVBlcR0pgYS4+E+IClXHABRB704xhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712362158; c=relaxed/simple;
	bh=ApeOdrvDzYLcZ9/Qa9hRh/CgFwQN9rflZ7kbYOdPR/o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s8v43hhiW/14Cf1xmN1YVrxrC3CKAjqi/cgoSUEidq85IcYLXzgJYkJ7Y5tSTkWixcQq0DO9nUrmhNq23+s76sMxdnSuhgvB2siaH3JCL62FBfUZQTCTYUtOErrpPqnli3jdE6zrI3RvJZwkLX7Gpv4lpg5WjCDIwGeKano85S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TwFksmGh; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TwFksmGh"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E42FF24028;
	Fri,  5 Apr 2024 20:09:16 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=ApeOdrvDzYLcZ9/Qa9hRh/CgF
	wQN9rflZ7kbYOdPR/o=; b=TwFksmGhfzrs3CstyGqw8ujAnih3+IfIhP3gZlHt9
	cOLyLTJjXFwCmkXX0GQJFj6i2urIEPdUhwlR4lMNSfGgQ0oTFf0Wd8dTo+/iKfj4
	+RLi5GPFGDpoClIGz1ntu660CaVT+pqk/Et7AM8pYojr64uyaQ+f/Q+BNJ9k3mND
	dw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DE2C024027;
	Fri,  5 Apr 2024 20:09:16 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6ADD424025;
	Fri,  5 Apr 2024 20:09:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 4/6] t: local VAR="VAL" (quote command substitution)
Date: Fri,  5 Apr 2024 17:09:00 -0700
Message-ID: <20240406000902.3082301-5-gitster@pobox.com>
X-Mailer: git-send-email 2.44.0-501-g19981daefd
In-Reply-To: <20240406000902.3082301-1-gitster@pobox.com>
References: <20240406000902.3082301-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 E6569CC0-F3A9-11EE-8058-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Future-proof test scripts that do

	local VAR=3DVAL

without quoting VAL (which is OK in POSIX but broken in some shells)
that is a $(command substitution).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4011-diff-symlink.sh | 4 ++--
 t/test-lib-functions.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
index d7a5f7ae78..bc8ba88719 100755
--- a/t/t4011-diff-symlink.sh
+++ b/t/t4011-diff-symlink.sh
@@ -13,13 +13,13 @@ TEST_PASSES_SANITIZE_LEAK=3Dtrue
=20
 # Print the short OID of a symlink with the given name.
 symlink_oid () {
-	local oid=3D$(printf "%s" "$1" | git hash-object --stdin) &&
+	local oid=3D"$(printf "%s" "$1" | git hash-object --stdin)" &&
 	git rev-parse --short "$oid"
 }
=20
 # Print the short OID of the given file.
 short_oid () {
-	local oid=3D$(git hash-object "$1") &&
+	local oid=3D"$(git hash-object "$1")" &&
 	git rev-parse --short "$oid"
 }
=20
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 3204afbafb..3dc638f7dc 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1764,7 +1764,7 @@ test_subcommand () {
 		shift
 	fi
=20
-	local expr=3D$(printf '"%s",' "$@")
+	local expr=3D"$(printf '"%s",' "$@")"
 	expr=3D"${expr%,}"
=20
 	if test -n "$negate"
--=20
2.44.0-501-g19981daefd

