Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92047363
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 00:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712362155; cv=none; b=LxYhiLzKG4TwbyJ+JGBfpUS/II0+whE6lrhVWivNngHYUyNnf0vgQryDIhbe8R0UNf74XNkhJz02CR0QgZZBL4JgCmzBDh4w2VEXo1OjdwHpZWi8w+bizsnnd6sFtHb/QYxZ51nbyT+8WGAsceAYD5aIDPaKbyEsAtLhrnF5tk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712362155; c=relaxed/simple;
	bh=2ijkC/L/hBTaJWxb5FRrEyXVxCsUmkWN+/1HcypBIQ4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c0Ez9rMq1gpc6QS+tiVkAlJd+FlsCz6MozF7M4BtK+dXC0J2C+j4ssNH71esY0MfRIy+WzPJWTMaF/xBE10VTmdhPnoOT/ualowHXxxB/gF/M6t5W4zwI6c1Zhd9ls0OEmbW1v7e2yt+ly/+T/zw/2sEUoXlWCtWQzIgwahBQb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nqPn/4cT; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nqPn/4cT"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 279FE27C39;
	Fri,  5 Apr 2024 20:09:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=2ijkC/L/hBTaJWxb5FRrEyXVx
	CsUmkWN+/1HcypBIQ4=; b=nqPn/4cTKrqpGVT9uYYq9Iiotp1oam/GLAQlhWs3K
	83nEHVxtrA2J5zELAAKDb982OJhjGWiKejWyAe4xySFodAtQo67TgpZsajOLpPna
	bGuWPnRe54NCokVwJ3Xv+LFrw5AWdsm/HUifjUg3ndptkzBOEcqEkYwuVkIPrC+I
	CY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2042F27C38;
	Fri,  5 Apr 2024 20:09:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A5EA927C37;
	Fri,  5 Apr 2024 20:09:09 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 3/6] t: local VAR="VAL" (quote positional parameters)
Date: Fri,  5 Apr 2024 17:08:59 -0700
Message-ID: <20240406000902.3082301-4-gitster@pobox.com>
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
 E4193080-F3A9-11EE-B1B9-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Future-proof test scripts that do

	local VAR=3DVAL

without quoting VAL (which is OK in POSIX but broken in some shells)
that is a positional parameter, e.g. $4.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/lib-parallel-checkout.sh | 2 +-
 t/t2400-worktree-add.sh    | 2 +-
 t/t4210-log-i18n.sh        | 4 ++--
 t/test-lib-functions.sh    | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/lib-parallel-checkout.sh b/t/lib-parallel-checkout.sh
index acaee9cbb6..8324d6c96d 100644
--- a/t/lib-parallel-checkout.sh
+++ b/t/lib-parallel-checkout.sh
@@ -20,7 +20,7 @@ test_checkout_workers () {
 		BUG "too few arguments to test_checkout_workers"
 	fi &&
=20
-	local expected_workers=3D$1 &&
+	local expected_workers=3D"$1" &&
 	shift &&
=20
 	local trace_file=3Dtrace-test-checkout-workers &&
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 051363acbb..5851e07290 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -404,7 +404,7 @@ test_expect_success '"add" worktree with orphan branc=
h, lock, and reason' '
 # Note: Quoted arguments containing spaces are not supported.
 test_wt_add_orphan_hint () {
 	local context=3D"$1" &&
-	local use_branch=3D$2 &&
+	local use_branch=3D"$2" &&
 	shift 2 &&
 	local opts=3D"$*" &&
 	test_expect_success "'worktree add' show orphan hint in bad/orphan HEAD=
 w/ $context" '
diff --git a/t/t4210-log-i18n.sh b/t/t4210-log-i18n.sh
index d2dfcf164e..75216f19ce 100755
--- a/t/t4210-log-i18n.sh
+++ b/t/t4210-log-i18n.sh
@@ -64,7 +64,7 @@ test_expect_success 'log --grep does not find non-reenc=
oded values (latin1)' '
 '
=20
 triggers_undefined_behaviour () {
-	local engine=3D$1
+	local engine=3D"$1"
=20
 	case $engine in
 	fixed)
@@ -85,7 +85,7 @@ triggers_undefined_behaviour () {
 }
=20
 mismatched_git_log () {
-	local pattern=3D$1
+	local pattern=3D"$1"
=20
 	LC_ALL=3D$is_IS_locale git log --encoding=3DISO-8859-1 --format=3D%s \
 		--grep=3D$pattern
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 2f8868caa1..3204afbafb 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1689,7 +1689,7 @@ test_parse_ls_tree_oids () {
 # Choose a port number based on the test script's number and store it in
 # the given variable name, unless that variable already contains a numbe=
r.
 test_set_port () {
-	local var=3D$1 port
+	local var=3D"$1" port
=20
 	if test $# -ne 1 || test -z "$var"
 	then
--=20
2.44.0-501-g19981daefd

