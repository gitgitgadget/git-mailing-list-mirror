Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC1574077
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 19:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719603620; cv=none; b=FnJwHf6hfxuf+hH7NL+JKsvMKu04ojYV4nKU1g/WLGRxtfskZVAKst2hFS0JIY69iL/cd3PNap7UXLwLB5rrYmSiy984nXRJ3KrgdAZzqvYdPMIEDhSbfZGIO7jUiDGcINwgXjgfiUTa6hAsBivVbVAszFXW/IZsQjqN4gDeMio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719603620; c=relaxed/simple;
	bh=j14RzkNjeACh545Fid5wZLnqq1VrLDDefZzwy0zrdEA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j0ihiJsJ/dc4RlEy8ZvCuXqbbe0SRe7vZ5/wTAI2mSHACj4tit4pCzVf/jszjo8djaWVesxpjmE5UoisbX8vWTIgt6YBtBB1kg1oozKPLniAtBhnvbjxvzoVioUXhv8CtKJMtt59eLPAdtqDc9Nk/E1KIAnqIEQ+iPcU6a/6wOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=d43+YN7t; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="d43+YN7t"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C659B22606;
	Fri, 28 Jun 2024 15:40:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=j14RzkNjeACh
	545Fid5wZLnqq1VrLDDefZzwy0zrdEA=; b=d43+YN7tuxkLuL1VeATWLmRe4Fka
	T71VUt0rQb/pNCGcjwCuDQN/rPRFTp57/XSv1F6nrd77dnJq2zj6Upl/MeORa6GG
	V1kGF+lfHNVPFNBwxFZMCHX/vFcIgwS59EN1oOcq3RJalPn07yVJiyj3jzB0RjAH
	8VWOBCvmrtcn2O4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BD46722604;
	Fri, 28 Jun 2024 15:40:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2D6B022600;
	Fri, 28 Jun 2024 15:40:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Mushegh Khachatryan <mushegh.khachatryan20@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: git init fails because of includeIf configuration
In-Reply-To: <0b92381d-b21f-4d3a-8e68-ad9977a8b45d@gmail.com> (Mushegh
	Khachatryan's message of "Fri, 28 Jun 2024 19:29:01 +0400")
References: <0b92381d-b21f-4d3a-8e68-ad9977a8b45d@gmail.com>
Date: Fri, 28 Jun 2024 12:40:10 -0700
Message-ID: <xmqqseww26w5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 3B81C850-3586-11EF-B1E6-5B6DE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Mushegh Khachatryan <mushegh.khachatryan20@gmail.com> writes:

> $ git init
> BUG: refs.c:2123: reference backend is unknown
> zsh: IOT instruction (core dumped)=C2=A0 git init

Thanks for a report. =20

Is this the same issue that was reported some time ago and corrected
in 407997c1 (setup: fix bug with "includeIf.onbranch" when
initializing dir, 2024-05-22), I wonder. =20

You can try 'git' built from a recent tip of 'master' [*] to see if
it is the same issue.  Anything that is not older than 7b0defb3 (The
tenth batch, 2024-06-03) should has the fix 407997c1 (setup: fix bug
with "includeIf.onbranch" when initializing dir, 2024-05-22).


