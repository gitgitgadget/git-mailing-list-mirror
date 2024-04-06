Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D81E848D
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 00:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712362159; cv=none; b=aCAwDyTzZSZRw4EjDemPW9ySawW9Yi/+vAbmgQZ225ngKsMZc3jLs0Sm+/rnJxeNhZH5BTKKNfEjKONtSnuFpn0N1y59XjbIACM2Z5YAkNrOgZnLkfPn0819d8iGKPb5D2vrvWjvG7zEAsxMrntR0szE3rdL0QeYG/HwcVc9Hwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712362159; c=relaxed/simple;
	bh=wNOneWXNqWWmQK5R3agwgQwZ5GX0ELcvqgXnIR3/Jpc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/g2pSOmLXy6rHPMPjPTQFdrkzYBnGCKHCAtYoMfC0QUTUcP/mqff4BP5zHA1Brg5hBZwbm6Yj64z4da5QJdhW8E054GMgIbGw54B67ZEzzPLjRdIj1cJzEXqtuo84ndgzAF9si4qY8J8pjyPDtJgAr7bsLw3FlfHIkDOVsCpFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KeFLo0ox; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KeFLo0ox"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E7151F28BE;
	Fri,  5 Apr 2024 20:09:17 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=wNOneWXNqWWmQK5R3agwgQwZ5
	GX0ELcvqgXnIR3/Jpc=; b=KeFLo0oxt8a2rG1yfNLjFG832pX8iGfNj9fgMQfCo
	3XCPdIV2gVTlJpvcIIKEIBLd7aPn4AQYD6e13wr97lGL5HQ/b2z4t0UZYrIuHoQf
	HLsFqEWWA8TaCfFqK+PuX7W0C22vJT0kkxGtkP1MxVelJNETxZRj5sIC2pCh5Wz1
	6E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 765D11F28BD;
	Fri,  5 Apr 2024 20:09:17 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DDB9B1F28BC;
	Fri,  5 Apr 2024 20:09:16 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 5/6] t: local VAR="VAL" (quote ${magic-reference})
Date: Fri,  5 Apr 2024 17:09:01 -0700
Message-ID: <20240406000902.3082301-6-gitster@pobox.com>
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
 E8681458-F3A9-11EE-ADF8-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Future-proof test scripts that do

	local VAR=3DVAL

without quoting VAL (which is OK in POSIX but broken in some shells)
that is ${magic-"reference to a parameter"}.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/test-lib-functions.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 3dc638f7dc..029cb31ffe 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -330,7 +330,7 @@ test_commit () {
 		shift
 	done &&
 	indir=3D${indir:+"$indir"/} &&
-	local file=3D${2:-"$1.t"} &&
+	local file=3D"${2:-"$1.t"}" &&
 	if test -n "$append"
 	then
 		$echo "${3-$1}" >>"$indir$file"
@@ -1672,7 +1672,7 @@ test_oid () {
 # Insert a slash into an object ID so it can be used to reference a loca=
tion
 # under ".git/objects".  For example, "deadbeef..." becomes "de/adbeef..=
".
 test_oid_to_path () {
-	local basename=3D${1#??}
+	local basename=3D"${1#??}"
 	echo "${1%$basename}/$basename"
 }
=20
@@ -1840,7 +1840,7 @@ test_readlink () {
 # An optional increment to the magic timestamp may be specified as secon=
d
 # argument.
 test_set_magic_mtime () {
-	local inc=3D${2:-0} &&
+	local inc=3D"${2:-0}" &&
 	local mtime=3D$((1234567890 + $inc)) &&
 	test-tool chmtime =3D$mtime "$1" &&
 	test_is_magic_mtime "$1" $inc
@@ -1853,7 +1853,7 @@ test_set_magic_mtime () {
 # argument.  Usually, this should be the same increment which was used f=
or
 # the associated test_set_magic_mtime.
 test_is_magic_mtime () {
-	local inc=3D${2:-0} &&
+	local inc=3D"${2:-0}" &&
 	local mtime=3D$((1234567890 + $inc)) &&
 	echo $mtime >.git/test-mtime-expect &&
 	test-tool chmtime --get "$1" >.git/test-mtime-actual &&
--=20
2.44.0-501-g19981daefd

