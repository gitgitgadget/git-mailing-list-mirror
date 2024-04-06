Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EFD620
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 00:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712363303; cv=none; b=u3BruZ0nofWPVD0cL3C2+xwxsOlDGiFyYvWzT2n2Jdi2Ox8SwCc312SCcwHyhYvVTEQ1b7FVP9gXq5pXkz8kT2hnyGKYa5F0lYLP7gjK+Rmu35VxVOLamawxwcOQRRVAIjPCJWhs8CJ+UAhejeGCyZJo8Sq8VNCEClMTtwS9O7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712363303; c=relaxed/simple;
	bh=t5y9siuXxmWAqXMXORTJQYvbzZy9rwKxNPcL2wwe9UI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mk1P6wffx0hZxTO16m+RquaejunDKg14mTrxks8fD7I1VyrMg6tCifole9MAe+3zoCZfz3V/zIXp1VQdxKn7AAlATILAUA4HXRHxqty25pbEAFGTWd1lZzytFkKkS7qIAsxJgQ1LhDD0WO88BB7HRK7/1b5JZ0KsPPDfxsVL4UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OZhIkEgl; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OZhIkEgl"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 33D1327CEA;
	Fri,  5 Apr 2024 20:28:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=t5y9siuXxmWAqXMXORTJQYvbzZy9rwKxNPcL2w
	we9UI=; b=OZhIkEglDrjzb1RK1i2BoeuiASXgwdY2toxUbDSrk82LjQ8poKyFLM
	UM8braTtvxoN+FvYV86JhjjAeWXWjDBkejf+c0WDYztuSXywbd8yDPCXYJ/BGhTK
	m4B9t1CemVmnDeWd53dpdoYxwf5vHnZhlHhQq5yjMkymm4EGQuWXI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2B83927CE9;
	Fri,  5 Apr 2024 20:28:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A08CA27CE8;
	Fri,  5 Apr 2024 20:28:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 8/6] t1016: local VAR="VAL" fix
In-Reply-To: <20240406000902.3082301-1-gitster@pobox.com> (Junio C. Hamano's
	message of "Fri, 5 Apr 2024 17:08:56 -0700")
References: <20240406000902.3082301-1-gitster@pobox.com>
Date: Fri, 05 Apr 2024 17:28:16 -0700
Message-ID: <xmqqil0vs5b3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 90590436-F3AC-11EE-86B4-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

The series was based on maint and fixes all the tests that exist
there, but we have acquired a few more.

I suspect that the values assigned in many of these places are $IFS
safe, and this is primarily to squelch the linter than adding a
necessary workaround for buggy dash.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1016-compatObjectFormat.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git c/t/t1016-compatObjectFormat.sh w/t/t1016-compatObjectFormat.sh
index 8132cd37b8..be3206a16f 100755
--- c/t/t1016-compatObjectFormat.sh
+++ w/t/t1016-compatObjectFormat.sh
@@ -79,7 +79,7 @@ commit2_oid () {
 }
 
 del_sigcommit () {
-    local delete=$1
+    local delete="$1"
 
     if test "$delete" = "sha256" ; then
 	local pattern="gpgsig-sha256"
@@ -91,8 +91,8 @@ del_sigcommit () {
 
 
 del_sigtag () {
-    local storage=$1
-    local delete=$2
+    local storage="$1"
+    local delete="$2"
 
     if test "$storage" = "$delete" ; then
 	local pattern="trailer"
@@ -181,7 +181,7 @@ done
 cd "$base"
 
 compare_oids () {
-    test "$#" = 5 && { local PREREQ=$1; shift; } || PREREQ=
+    test "$#" = 5 && { local PREREQ="$1"; shift; } || PREREQ=
     local type="$1"
     local name="$2"
     local sha1_oid="$3"
@@ -193,8 +193,8 @@ compare_oids () {
 
     git --git-dir=repo-sha1/.git rev-parse --output-object-format=sha256 ${sha1_oid} > ${name}_sha1_sha256_found
     git --git-dir=repo-sha256/.git rev-parse --output-object-format=sha1 ${sha256_oid} > ${name}_sha256_sha1_found
-    local sha1_sha256_oid=$(cat ${name}_sha1_sha256_found)
-    local sha256_sha1_oid=$(cat ${name}_sha256_sha1_found)
+    local sha1_sha256_oid="$(cat ${name}_sha1_sha256_found)"
+    local sha256_sha1_oid="$(cat ${name}_sha256_sha1_found)"
 
     test_expect_success $PREREQ "Verify ${type} ${name}'s sha1 oid" '
 	git --git-dir=repo-sha256/.git rev-parse --output-object-format=sha1 ${sha256_oid} > ${name}_sha1 &&
