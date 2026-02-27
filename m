Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF69218AC4
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 01:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772157185; cv=none; b=MKqcwPqcoJmLGWUbbE2qUXPucxFPQblWySFygAaS06neSZtujD2H3R9zxXmj3xmHIQqruTrrIudjwx90Z0zCzKUxXOCRWoCR1IKPnxJWY6DFJIHT+uR9IN125NvRpuktLcy0/i0BKpe+cunvQwwzTujPZV2Ond/6bAvRHQGE9KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772157185; c=relaxed/simple;
	bh=vezTu1hmDCRS2Ik2XEpNl5pvFc3hIKGXmdnjWVexHsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F/DTAhNpQeI09hDWa9SC7ePRLCGJI1smIUkQ0jH6DcO6Vmzo9YdihjsxintJ9sFfYqITj3ukAIDy8OSH6GolF1GcoFy1bsYmSOl5oPHjck1InuTN/CYsYOD7BLUcZp8dQcdDHdjxRKPcZEYms213eiLWbd7qn61sVodInHanBSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=J66QLeLw; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="J66QLeLw"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1772157174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EHDrAIl0aF49Q/YKKK5Ha/EKt9RONLWqbNtdi5hfV8M=;
	b=J66QLeLwt6Ec2FHZ99cyotQ27//O8mRxAI694GCrWFyHqpzXAYfGGJI+XJNksyHDfkN4p+
	9+jeGIZkY+AWaeyJ0olsAWLl87SFtSw7l43OKT8RDQBmCYsEa9LUNFWMS4HT9y2e03V3qC
	hMQhMD5+wfngwLON9+5wJjN47lntSfsrr2hE20fU7a7SkygeS5wh4yrcyhz90SSXzIqA3h
	DAzhP2DFguDRuCe10a3ZfO9a6m2mSUwXYVuXYLPpPi/SwDbDFu7YG5O5EGCZaSaamxxoHX
	PePz5ElbBRIhgJrykrEy3FRWFSZ4aurP9MCjZlRG3IqeFm/KblUzb/9DVrVkdg==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v3 0/4] format-patch: add cover-letter-format option
Date: Fri, 27 Feb 2026 02:52:35 +0100
Message-ID: <cover.1772156996.git.mroik@delayed.space>
In-Reply-To: <cover.1771925291.git.mroik@delayed.space>
References: <cover.1771925291.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1214; i=mroik@delayed.space; h=from:subject:message-id; bh=vezTu1hmDCRS2Ik2XEpNl5pvFc3hIKGXmdnjWVexHsE=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpoPiZaT1WIOPI/h0v5iycUBUrqqlBqiCmLtLvY jjSmKWQq3+JAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaaD4mQAKCRBIeX6hnBm+ 0RImD/0c2t4WUZ5f55Qyaq7Z37R8bQxHKAzCjd+6VkzEVur4NMaGjm8QX8JjZhz+9rxqXrT4JMw sqlPgp5dAA4UNeUIYeX1aGX7aJZAgF65reerPdYikKiu3BwqoDMxPCcFH/qiiLJEprG8FKFtplC SDiqkQuQYtotkrj/mzIZLoBdwn9fJCfJgWwBaHjU9mHiabhsaHa7NT8T5azn2kXS/JIFqOFBV0X bdJfZVxIqmXevNWKMEQpYmEMGe2q5pOYunvLnWFQ6ARVy70gHEZbEM0pQ7fH48zkFTwBzaDw6By EqlyfJGnQVi+yrpeU3zFnmeiegbbCjqiyx8GgPtvqPLCAb6paOL/533rjUAtXevBh8eMdnVtA9K Gyxfg84DG87mQfhJeNCNUHGREMBQH7U0YrSHOmHMKyDffqplfiYOakXDZ/ZhEQ9MmDRWH+u+7aB fnSKj28UOF8jfG1zynVU//gE9ntbbgd/zgmwJqQimOLR1xjpoWvLVsUOZ/F237HkDNbPeM2m8YY u3zV8897oMNtmz0tTirpk+KCXbKDyOIb9wWDN3/rBeW7b8Qk1tq2ItXiu/hs7Ia1m5VmqSW0EP0 9Q6hxrMP5YvRflm/2dYENB0+pAuDEBHXr7SEE43uMNbHLtsrFUh+Qomg6izqU/1zxrgPVFHg4Cr T+6TXkSta
 dFcZbg==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -

As Jeff requested I added two new placeholders to make the numbering
part customizable as well. The width of %(count) will always be the same
width of %(total).

I've also moved the code for generating the shortlog format into its own
function.

There are now tests for both patch 3 and 4. Unfortunately I couldn't add
tests for patch 1 as the variables that are coupled with %(count) and
%(total) are not used for any command that accepts "--format" or
"--pretty".

I've also went over the code and fixed the parts that you marked as
problematic (hopefully I haven't missed anything).

Thank you both for the reviews.

[1/4] pretty.c: add %(count) and %(total) placeholders (Mirko Faina)
[2/4] format-patch: move cover letter summary generation (Mirko Faina)
[3/4] format-patch: add ability to use alt cover format (Mirko Faina)
[4/4] format-patch: add commitListFormat config (Mirko Faina)

 builtin/log.c           |  94 +++++++++++++++++++++++++++++++------
 pretty.c                |  15 ++++++
 t/t4014-format-patch.sh | 101 ++++++++++++++++++++++++++++++++++++++++
 t/t9902-completion.sh   |   1 +
 4 files changed, 197 insertions(+), 14 deletions(-)

-- 
2.53.0.4.g55f3102ead

