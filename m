Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA022033E
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 17:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711732928; cv=none; b=hbwJwGSJwNqWSEksl53sLluHqFQdLwlbQd79BsGPp1CwKVcMNIsANTAimxiGAbEUljlzmz+8LA0B+PeZEenkO+n411KwmcsMG3/PsatFknUOrTs+nLE4bc+hfg890MK23A6dft5IiNLAB0ah/8y1irVREDwjVtwdXxoJmFRpR7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711732928; c=relaxed/simple;
	bh=hCIxeCkxpmPnMnY1LVLq80u0OyoKyKNaJvG2+T6iq78=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IaSGZtBBCQOK4oKomDPWUaK8HEymcgUA/96NbuxPyOKPEeu14xkgp36xy6SBys+H0Zi5knZ7Upc2nCw/AmEwjrTZGVywj9KCIo79UQMYes6r6XrSpoC8pK31XFZzDdIiCIJyGIWUyT2qrHcoWcXxpfNaMkx2xpRCNnArPS8bpJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=w8zt1syR; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="w8zt1syR"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D38F1E5CAD;
	Fri, 29 Mar 2024 13:22:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hCIxeCkxpmPnMnY1LVLq80u0OyoKyKNaJvG2+T
	6iq78=; b=w8zt1syRoxsu+pqROxdJm8vAFoxUFXLahKk6Ug4oGL+XdzwB7CMfNl
	GIV/+XKYI1PCaSHuNW+K/XsMGHeqqv+IzC/GrZiQcy458R4lPeXDlwmkEMrLN/h9
	Ho65gMQCIOzaer6qimCBtvGolKocPpphiRosVrqLcYeWKoRDZDS6U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E12671E5CAA;
	Fri, 29 Mar 2024 13:21:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 398BE1E5CA9;
	Fri, 29 Mar 2024 13:21:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,  Jeff King <peff@peff.net>,
  Han Young <hanyang.tony@bytedance.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] t4126: fix "funny directory name" test on Windows (again)
In-Reply-To: <xmqqwmplvbsa.fsf_-_@gitster.g> (Junio C. Hamano's message of
	"Thu, 28 Mar 2024 22:37:25 -0700")
References: <20240319095212.42332-1-hanyang.tony@bytedance.com>
	<xmqqttl2qml9.fsf@gitster.g> <xmqqfrwlltjn.fsf@gitster.g>
	<xmqqsf0bz5oj.fsf@gitster.g>
	<20240328103254.GA898963@coredump.intra.peff.net>
	<20240328114038.GA1394725@coredump.intra.peff.net>
	<CAPig+cQe1rAN2MUFTwo7JoCt3sO2eCk_psnJL9D=Rs=Q9MWO9A@mail.gmail.com>
	<xmqqa5miuutd.fsf@gitster.g> <xmqqh6gqt674.fsf_-_@gitster.g>
	<xmqqil15srub.fsf@gitster.g> <xmqqwmplvbsa.fsf_-_@gitster.g>
Date: Fri, 29 Mar 2024 10:21:58 -0700
Message-ID: <xmqq5xx50x8p.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D9879B20-EDF0-11EE-9FFF-25B3960A682E-77302942!pb-smtp2.pobox.com

Even though "git update-index --cacheinfo" ought to be filesystem
agnostic,

    $ git update-index --add --cacheinfo "100644,$empty_blob,funny /empty"

fails only on Windows, and this unfortunately makes the approach of
the previous step unworkable.

Resurrect the earlier approach to give up on running the test on
known-bad platforms.  Instead of computing a custom prerequisite,
just use !MINGW we have used elsewhere.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Another reason for using MINGW is that the custom prerequisite
 would not have been a good match for lazy_prereq mechanism, which
 wants to isolate itself by creating a temporary directory to run
 the test for prerequisites, which means we are not expected use the
 main index or object store to test for prerequisites, either, which
 in turn means we are pretty much forbidden from using Git while
 computing the prerequisite.  "a platform fails the prerequisite if
 the steps to create sample patches do not work" was how the earlier
 step computed the custom prerequisite, which cannot be done without
 creating another repository in the temporary place given, which
 means we cannot reuse the patches created in the real test.

 Also, if a platform other than MINGW fails the early part of this
 test, we would want to _know_ about it, even if we may not want to
 fix it.  A custom prerequisite will defeat that.

 t/t4126-apply-empty.sh | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/t/t4126-apply-empty.sh b/t/t4126-apply-empty.sh
index 2462cdf904..56210b5609 100755
--- a/t/t4126-apply-empty.sh
+++ b/t/t4126-apply-empty.sh
@@ -66,29 +66,28 @@ test_expect_success 'apply --index create' '
 	git diff --exit-code
 '
 
-test_expect_success 'parsing a patch with no-contents and a funny pathname' '
-	git reset --hard &&
-	empty_blob=$(test_oid empty_blob) &&
-	echo "$empty_blob" >expect &&
+test_expect_success !MINGW 'apply with no-contents and a funny pathname' '
+	test_when_finished "rm -fr \"funny \"; git reset --hard" &&
+
+	mkdir "funny " &&
+	>"funny /empty" &&
+	git add "funny /empty" &&
+	git diff HEAD -- "funny /" >sample.patch &&
+	git diff -R HEAD -- "funny /" >elpmas.patch &&
 
-	git update-index --add --cacheinfo "100644,$empty_blob,funny /empty" &&
-	git diff --cached HEAD -- "funny /" >sample.patch &&
-	git diff --cached -R HEAD -- "funny /" >elpmas.patch &&
-	git reset &&
+	git reset --hard &&
 
-	git apply --cached --stat --check --apply sample.patch &&
-	git rev-parse --verify ":funny /empty" >actual &&
-	test_cmp expect actual &&
+	git apply --stat --check --apply sample.patch &&
+	test_must_be_empty "funny /empty" &&
 
-	git apply --cached --stat --check --apply elpmas.patch &&
-	test_must_fail git rev-parse --verify ":funny /empty" &&
+	git apply --stat --check --apply elpmas.patch &&
+	test_path_is_missing "funny /empty" &&
 
-	git apply -R --cached --stat --check --apply elpmas.patch &&
-	git rev-parse --verify ":funny /empty" >actual &&
-	test_cmp expect actual &&
+	git apply -R --stat --check --apply elpmas.patch &&
+	test_must_be_empty "funny /empty" &&
 
-	git apply -R --cached --stat --check --apply sample.patch &&
-	test_must_fail git rev-parse --verify ":funny /empty"
+	git apply -R --stat --check --apply sample.patch &&
+	test_path_is_missing "funny /empty"
 '
 
 test_done
-- 
2.44.0-413-gd6fd04375f

