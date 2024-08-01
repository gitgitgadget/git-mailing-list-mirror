Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AF3143883
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 18:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722538276; cv=none; b=aYzO31xrWeoND7GTxM2ZWZhSe1ZF+y8TJKG4gGYUJcOQDDfkLDBw4GPeMFA7/uZWXcCKn3qR9aNDgJEOLupUOvCZHwKn5ANxq30CGdU791a3lOkXseybtzFF4gFfyLQz0Lnt5RoZYNVy6JRnTBe/HuqlGsZPFxaUyAWsdI9pBDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722538276; c=relaxed/simple;
	bh=parfmYAd7UooAnuk4XGb8azyJ+6XWO/bP40qWPfbxgk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M6/YaHgsfnTTKYt2MmtfdxwXBMdSJCWhQoRqHtz06xqTkD2wt/SMrx7qdTFV6mr5JtgyolthRQTg6zLScvFqJu8gQtVV/tHiZ4gN1yPnZap9p7y3uB2UUlapIbg7DMCRKoPej6+MQJXIeq5JRU4k9M2AF23h+5ZotdcZUGNgijM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=M0Xwl5Mq; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="M0Xwl5Mq"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D0FE02BAA1;
	Thu,  1 Aug 2024 14:51:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=parfmYAd7UooAnuk4XGb8azyJ+6XWO/bP40qWP
	fbxgk=; b=M0Xwl5Mq/JmzWbsO6Nxk7j5DwDAaJzIPXXh9pcq6uwIe/AegJZKJiQ
	84Xc0E7cQoh/gRK2V7QRZKMETH93FVAgM6aQkQCEXcso4iOLcFkoVFXUUN07oM/7
	mvfCZzybjaqKAz2cjyLzYrd8L1dDQAPi2XP1wPqb9iNMq8Xsn7nPY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CA46F2BAA0;
	Thu,  1 Aug 2024 14:51:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3F3132BA9F;
	Thu,  1 Aug 2024 14:51:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
Cc: <rsbecker@nexbridge.com>
Subject: [PATCH] t0018: remove leftover debugging cruft
In-Reply-To: <xmqqbk2cum5o.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	01 Aug 2024 11:34:59 -0700")
References: <02d401dae43e$c076b000$41641000$@nexbridge.com>
	<xmqqbk2cum5o.fsf@gitster.g>
Date: Thu, 01 Aug 2024 11:51:12 -0700
Message-ID: <xmqq7cd0ulen.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0668D4B2-5037-11EF-8365-34EEED2EC81B-77302942!pb-smtp1.pobox.com

The actual file is copied out to /tmp, presumably so that the tester
can inspect it after the test is done, which may have been a useful
debugging aid.

But in the final shape of the test suite, such a code should not
exist.  We cannot even assume that we are allowed to write into /tmp
(our TMPDIR may not even be pointing at it) or read from it for that
matter.

Noticed-by: Randall S. Becker <rsbecker@nexbridge.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0018-advice.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t0018-advice.sh b/t/t0018-advice.sh
index b02448ea16..040a08be07 100755
--- a/t/t0018-advice.sh
+++ b/t/t0018-advice.sh
@@ -93,7 +93,6 @@ EOF
 		>README &&
 		GIT_ADVICE=true git status
 	) >actual &&
-	cat actual > /tmp/actual &&
 	test_cmp expect actual
 '
 
-- 
2.46.0-179-g92bab5172e

