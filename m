Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533782E851
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 19:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706641411; cv=none; b=qZMIN8ZbP7mQ7GbsAKPC/NCw+BqicUAM1QF1p64+ieJPFPv5E8yi2OLYQh1ekA25Yl+WGotSruiGf4ilHHMzcOew7jSl47KnZXWRGn/M8oVaGgT2cGAdwU+qSamesRzuEiiq5LOfu3m14HiWm6R0pjRTWvkzNC1m+CEExduGANM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706641411; c=relaxed/simple;
	bh=yKaIVbTD2BN9VQ1XL1tzxKRPI3kgPDrNkLkGdv+gNnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R9/8lO2GpafXVNeO7lJf/Z7oMYWH2cTAvf6adE8NIGnMz+ou7TSisbi+FRmPOtRG3NndmHU2yFUD+niZZxIv3UUUFwxKGyIUSfxenoOpuLWCz3tiEBEQppcohipkCZlc0LDFqCH9vmOsnv4yQPJNjHRskXJ0dfCAM6xQnf1wuEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dYDngHor; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dYDngHor"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C008A2A012;
	Tue, 30 Jan 2024 14:03:29 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=y
	KaIVbTD2BN9VQ1XL1tzxKRPI3kgPDrNkLkGdv+gNnU=; b=dYDngHor1VMtoEKSb
	7Qr5X9xqW9Oem5rmUPQNBi8L34JjZDbwNF8OHyiAZcQGpfLOhJr8jBEzX0Rd0SCv
	1NqwPlZwqrQSoIoybsdk6yUBG8+Li0XUD7ePuAuCxv9ix782cvAiB6cWvwy6UD0R
	KNilaH9X7bSgGuZGpKvXSn3AiQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B878F2A011;
	Tue, 30 Jan 2024 14:03:29 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E9CF32A010;
	Tue, 30 Jan 2024 14:03:25 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH] t0091: allow test in a repository without tags
Date: Tue, 30 Jan 2024 11:03:24 -0800
Message-ID: <xmqqv87aabk3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3F201B6A-BFA2-11EE-ABA3-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

The beginning of the [System Info] section, which should match the
"git version --build-options" output, may not identify our version
as "git version 2.whatever".  When build in a repository cloned
without tags, for example, "git version unknown.g00000000" can be a
legit version string.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0091-bugreport.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git c/t/t0091-bugreport.sh w/t/t0091-bugreport.sh
index 8798feefe3..fca39048fe 100755
--- c/t/t0091-bugreport.sh
+++ w/t/t0091-bugreport.sh
@@ -39,9 +39,9 @@ test_expect_success 'sanity check "System Info" section' '
 
 	sed -ne "/^\[System Info\]$/,/^$/p" <git-bugreport-format.txt >system &&
 
-	# The beginning should match "git version --build-info" verbatim,
+	# The beginning should match "git version --build-options" verbatim,
 	# but rather than checking bit-for-bit equality, just test some basics.
-	grep "git version [0-9]." system &&
+	grep "git version " system &&
 	grep "shell-path: ." system &&
 
 	# After the version, there should be some more info.
