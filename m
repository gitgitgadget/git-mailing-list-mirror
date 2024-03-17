Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C4E1CD13
	for <git@vger.kernel.org>; Sun, 17 Mar 2024 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710694317; cv=none; b=Mpqt+jkGLQafgHGPafhsb0sr4WB2fzDZwcGTVL2dLNQIMIKgtTPTxd3ihnt9lvP/GLGPPR511x6odvguBmwa54adhz1UbTID4bksU73AMBuReTQA7JBt1GMI4EyZiwXKg/E5YYZd7wUSv3R312p1nKFJI0Csl6N7FBQLQxyYZaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710694317; c=relaxed/simple;
	bh=E38ZUp5IEHVG+wEa8cG21ExFudgluaAwSaUgrt1cxiI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u++gQaMoQ3H2uTG7ulkl30VhGtQ3tXjXspWCGNu7jdL4lH2AdIwCupuLbKJRjva+rRZUIYHOR9TPzPII6p0VPLhi50mMZ0rnCmHl287fZ8h4+PaxmFQcWK+webcHqwGUhR4PPH0/2Z17mRtyn5Uzvc2Msav34rl3F1J4DLNSMPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=yC4yL9nL; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yC4yL9nL"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id EF06018706;
	Sun, 17 Mar 2024 12:51:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=E38ZUp5IEHVG+wEa8cG21ExFudgluaAwSaUgrt
	1cxiI=; b=yC4yL9nLbvES/1oDYiue0kR1p7nWSN7CAFpv7zz2yzlaeUbVNMTZVd
	m7hzTnGBO0/h+PoVrPIb5sYXBd6ApQzEggdHRHVADSmYlUblMHRZBWD9HsnvoB8F
	A5sbutl67q96lvSNltHmCzd08evUQFkSz3n7I6FQMfqQsVYtu1hhI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E7EDB18705;
	Sun, 17 Mar 2024 12:51:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1994F18704;
	Sun, 17 Mar 2024 12:51:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Mohit Marathe via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Mohit Marathe <mohitmarathe@proton.me>
Subject: Re: [PATCH 0/2] utf8: change return type of some helpers from int
 to size_t
In-Reply-To: <pull.1690.git.1710664071.gitgitgadget@gmail.com> (Mohit Marathe
	via GitGitGadget's message of "Sun, 17 Mar 2024 08:27:49 +0000")
References: <pull.1690.git.1710664071.gitgitgadget@gmail.com>
Date: Sun, 17 Mar 2024 09:51:50 -0700
Message-ID: <xmqq7ci0n6mx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A76FFD6A-E47E-11EE-A632-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Mohit Marathe via GitGitGadget" <gitgitgadget@gmail.com> writes:

> There are lot of places in the codebase where int is used to store size of
> an object instead of size_t (which is better alternative due to reasons like
> portability, readability, etc). This patch series accomplishes one such
> #TODO comment, which addresses this issue.

Nice. In principle this is the right thing to do.

To reviewers, if I were reviewing this series (which I will not in
the next 24 hours), I'd pay particular attention to the callers that
currently accept "int" and use negative return value as an sign of a
failure.  Moving to "size_t" from "int" will break such callers.

Thanks.
