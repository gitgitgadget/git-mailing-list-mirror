Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D37512FB1E
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 17:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708104148; cv=none; b=c3Eflj/8mO7x36loQsFXJ4HngUt0QKgRNs891bH4jtsEUd7c3+6EuF9ODDsE3ML90JuOgeAydnQeeuQjCAf4K+rhpeS6gBoCQc9GZiCnLouCLurwv4syF3KZb6QSLSd1Bn6vNanH/M2Ymt7zgggeLjkn4CyLHMaDsPAxW378i8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708104148; c=relaxed/simple;
	bh=j2AxLKnBMGFDC2e0k4aiCu3xZqA1lJiS/zPcmM8RsSM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q/ppFXN84zbd+ZtLPuoxO7DIocwdpEeAo/jVBTPnXjkrSQlIb+pirw2IUvXaUFm8LZ448lmhTm2lWbNtOka8ROk+DM6q7HwIkDzMDpp39r4ELF2Z11R3xkGuH376aR3byxnZEQA5W/CuKyzxhRHGON6gmSNPFpWsHIxziFPhLSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vorb8wOt; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vorb8wOt"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C39F230419;
	Fri, 16 Feb 2024 12:22:25 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=j2AxLKnBMGFDC2e0k4aiCu3xZqA1lJiS/zPcmM
	8RsSM=; b=vorb8wOtJaegHqppaAX1GLHZMHMnD1/l4qqJo7YZPTLCfUp75vBLtO
	O7wZ9b1B6ZOT5Ydu3WHRFaQTHPfG7RdF6fQzg5xIxa5azHNYkYDZUew9YpacF9ka
	yAkwi2lFm9qvP08Zsm4W7B4OIlKX9hZEGVcUksAEVTS6jGTdJE9ZE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B44A630418;
	Fri, 16 Feb 2024 12:22:25 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5906330416;
	Fri, 16 Feb 2024 12:22:22 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] git: --no-lazy-fetch option
In-Reply-To: <xmqqv86pslos.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	15 Feb 2024 09:04:51 -0800")
References: <xmqq1q9mmtpw.fsf@gitster.g>
	<20240215053056.GD2821179@coredump.intra.peff.net>
	<xmqqv86pslos.fsf@gitster.g>
Date: Fri, 16 Feb 2024 09:22:20 -0800
Message-ID: <xmqq1q9cl3xv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F1F6EE30-CCEF-11EE-8655-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Yuck, I was hoping that we can get away with the tiny change only
> for builtins,but you're right.

Here is a preliminary clean-up only for Documentation.  Will not be
queuing before the final, but just so that I won't forget.

------- >8 ------------- >8 ------------- >8 -------
Subject: [PATCH] git: document GIT_NO_REPLACE_OBJECTS environment variable

This variable is used as the primary way to disable the object
replacement mechanism, with the "--no-replace-objects" command line
option as an end-user visible way to set it, but has not been
documented.

The original reason why it was left undocumented might be because it
was meant as an internal implementation detail, but the thing is,
that our tests use the environment variable directly without the
command line option, and there certainly are folks who learned its
use from there, making it impossible to deprecate or change its
behaviour by now.

Add documentation and note that for this variable, unlike many
boolean-looking environment variables, only the presence matters,
not what value it is set to.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git c/Documentation/git.txt i/Documentation/git.txt
index 95f451b22b..2f1cb3ef4e 100644
--- c/Documentation/git.txt
+++ i/Documentation/git.txt
@@ -174,8 +174,10 @@ If you just want to run git as if it was started in `<path>` then use
 	directory.
 
 --no-replace-objects::
-	Do not use replacement refs to replace Git objects. See
-	linkgit:git-replace[1] for more information.
+	Do not use replacement refs to replace Git objects.
+	This is equivalent to exporting the `GIT_NO_REPLACE_OBJECTS`
+	environment variable with any value.
+	See linkgit:git-replace[1] for more information.
 
 --no-lazy-fetch::
 	Do not fetch missing objects from the promisor remote on
