Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F867F7DC
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031513; cv=none; b=C3jkrKx6qe73FoT9P3lJkp/DslWkJB8LC8tpLP8bpzqRB5FMcen7BlE6ZvAfNMIHIRNYioYTnL2Tgs1ataom6PR07HC+qr89aawfbUXEO1kzTxSipY3xQWwZNu0tcLBumZwaymJ9bSUT3XlSjA4jzd/8Ije37f1uTHvBAz8y6fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031513; c=relaxed/simple;
	bh=f/nIjHp2b//FGmbS2SUETGYqUULCtVRZL3cROVrDxrQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MqlAmWntm+KfQOokUnc+Olw/Nue+pGsXQae5R6A8D/RjhTscR0HCuWMrvCZklsHmprJFkO8aQkXYo24Uog4EH167WBB9ig7QVRJ8c1Y5XTMo3Y7qyx7Obq7FV5hdqGCREnW1UE/Uhg6WhfBkU5tojvWRWOYpzXjhrQMXvyljtIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rdWGerU2; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rdWGerU2"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 602E8324E0;
	Tue, 23 Jan 2024 12:38:24 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=f/nIjHp2b//FGmbS2SUETGYqUULCtVRZL3cROV
	rDxrQ=; b=rdWGerU2Qr+DRLIY/QMQZaINbT9KaubQcNcoEstwhI807O/mEl5fIj
	TA+9HAX4ahtqbkxIMlfIi3XgZF5v1BKCTaVJPOCcemLuYc+1JBYW04D3pwWXxULb
	fBRMYXJVaFQAq7GHA3JG2sIsJcdxxNyhhqvzVupOEXUkuOYkwhTio=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5939B324DF;
	Tue, 23 Jan 2024 12:38:24 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E8214324DC;
	Tue, 23 Jan 2024 12:38:20 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/5] refs: make `is_pseudoref_syntax()` stricter
In-Reply-To: <ba721840-7b67-4822-8046-c0da4d3b9bde@gmail.com> (Phillip Wood's
	message of "Tue, 23 Jan 2024 11:03:28 +0000")
References: <20240119142705.139374-1-karthik.188@gmail.com>
	<20240119142705.139374-3-karthik.188@gmail.com>
	<ee977173-bc6d-48f6-9bc8-e1d84fe3d95d@gmail.com>
	<xmqqplxtrucm.fsf@gitster.g>
	<ba721840-7b67-4822-8046-c0da4d3b9bde@gmail.com>
Date: Tue, 23 Jan 2024 09:38:19 -0800
Message-ID: <xmqq5xzkosqc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3369C938-BA16-11EE-825A-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> I not sure I quite understand what you mean here. Are you saying that
> scripts should stop using "git update-ref" and "git rev-parse" for
> anything that does not match the new pseudoref syntax?

Yes, I am saying that, and also that we should have been stricter on
what we accept and consider as pseudorefs---not just any file that
sits directly under $GIT_DIR/., but ideally we should have limited
to "^[A-Z]*_HEAD$" or something.  The idea I am floating is to see if
such a tightening can be done now without hearing too many screams.
