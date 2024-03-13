Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EAC71B2F
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 18:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710354279; cv=none; b=OU+GAc4MA+RmI+Axe0ESQzJnFCvE/0KoeN3EI692akpAKNCyagj5kXheAxXklEUSsyLoPcvGLR5HLkiRJCgndVLTaE5e/WJqhthdX6hvxqzYqWZ5gwM0gFfD8gHhbFTPM/yHev3Ji8vL2Z+JL7YjfOGJxA9IsNVDmMCsXYQBF24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710354279; c=relaxed/simple;
	bh=2l60/QO7orXILEJeB8IHsY1Mq1YuQLtdy66lokoksns=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BiR+93IWbAz4jAkqYEeUlNU3vHxNS3lUyY0rFJuYHqJXs/sf3ZgjuAkIA5n4RdJ7g1yPzZ/tauh4P6ZQRNJXrLpO8hm+fwQY+Ymdq38IUUmJz7pRL10ZoRg1UVFaXxjfyvG1Ib0xsl+nXBY0PLg3UqIFzp+pPjykoWf8Ju6RDtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VvWHfmiY; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VvWHfmiY"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 956061A3C4;
	Wed, 13 Mar 2024 14:24:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2l60/QO7orXILEJeB8IHsY1Mq1YuQLtdy66lok
	oksns=; b=VvWHfmiYx0/7L0AMn+UTNApVA0/lXPN6WJa4aaiojhugYr32R4aXrA
	Ol7L8uk+H0VJaS/gn9Io3pAGPYi+6vQDZG7WNFfC0OuJ+Lk4Gll148wKOYR4FOIE
	MGam1u3L8xj9XynS5DG3LN0AjsbeoYAC0zO2hjQWmOEfxxqW1TMEU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8DAAA1A3C3;
	Wed, 13 Mar 2024 14:24:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3C5F61A3C0;
	Wed, 13 Mar 2024 14:24:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Osipov, Michael (IN IT IN)" <michael.osipov@innomotics.com>
Cc: git@vger.kernel.org
Subject: Re: bisect does not respect 'log.date'
In-Reply-To: <645c8253-f1ef-410f-8284-7d6c8b6db601@siemens.com> (Michael
	Osipov's message of "Wed, 13 Mar 2024 12:07:22 +0100")
References: <645c8253-f1ef-410f-8284-7d6c8b6db601@siemens.com>
Date: Wed, 13 Mar 2024 11:24:32 -0700
Message-ID: <xmqq7ci6c7mn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F11449BE-E166-11EE-B1BA-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Osipov, Michael (IN IT IN)" <michael.osipov@innomotics.com> writes:

> An oversight or bug?

Neither, i.e. WAI, I would say.

The configuration variable log.date is about "git log" and its
documentation makes no promises how "git bisect" may or may not be
affected.

Having said that, I think it is not unreasonable for you to make it
a feature request to add bisect.dateformat or whatever.  The only
interesting part from the output being the exact commit object name
the problem bisects to, I personally would not see it a high priority
feature request, though.

Thanks.

