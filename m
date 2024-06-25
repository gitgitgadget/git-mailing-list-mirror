Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B468A2AEFD
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 00:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719273650; cv=none; b=nNGn2vdft+s4AotNrdkMCtwIaL+0AVukx7Q1+fV0SxCr5mJIvg4/VtvgxW0nn1sJJc9/QoSL3ytnDN0zFpTMBvEwgFMVUbhaEpGcAZl3ffHqPUn8PNOWKVOHas2hhg9YDU3wkgpnC7gqSopNTUXnRE9cqGmIvwb9rNkIwDJ3yxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719273650; c=relaxed/simple;
	bh=s91kZs7CO4SqfSpX2BgtQ9XlYuEXd9hKfr517A2eHg0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZvtS/kebKUzrpkkB4u2ojNytCwG8HUUTd6fsY+xAP1L1Ag1KIAND7R3dFSaDQRBKChUqp4j0tyPYHQXFaj7xFVj/BFpLF+OlsIvg8dZvJ3vdn3a4Z1MqQmq9IjBzXvlcM5kpoVE/+uRXmDYGlJUwmzxf/WGTgEZ2ZFiSekmQquo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=E23R3hu/; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="E23R3hu/"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D2D4F32686;
	Mon, 24 Jun 2024 20:00:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=s91kZs7CO4SqfSpX2BgtQ9XlYuEXd9hKfr517A
	2eHg0=; b=E23R3hu/mhK/W37A6kMMgyoB11j/89aZyazrp41rXzshyqaivlaZpN
	DlgYxDb2cSaUI3LBFTzHrcqwTIxmWWYL85Fq73zpMEWb70PPtRjdt7nJqTalGGSv
	WZjFr7lFlpOwi4ukSaNinUEZgQ6pf3k5ID8sM5aHLruCMwDGKrgOg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C9D0A32685;
	Mon, 24 Jun 2024 20:00:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EC52832682;
	Mon, 24 Jun 2024 20:00:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  "Randall S. Becker"
 <the.n.e.key@gmail.com>,  git@vger.kernel.org,  "Randall S. Becker"
 <randall.becker@nexbridge.ca>,  "Randall S . Becker"
 <rsbecker@nexbridge.com>
Subject: Re: [PATCH v2 1/2] Teach git version --build-options about libcurl
In-Reply-To: <20240624235557.GA2727@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 24 Jun 2024 19:55:57 -0400")
References: <20240621180947.64419-1-randall.becker@nexbridge.ca>
	<20240621180947.64419-2-randall.becker@nexbridge.ca>
	<f44f1e25-41ca-0784-3186-f9e1bdae0d4f@gmx.de>
	<xmqqed8me36c.fsf@gitster.g>
	<20240624235557.GA2727@coredump.intra.peff.net>
Date: Mon, 24 Jun 2024 17:00:43 -0700
Message-ID: <xmqq1q4lc2ms.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F85089A2-3285-11EF-8904-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> But we could also have "git version --build-options" call "remote-https
> --build-options" automatically, and just let it dump to the shared
> stdout stream.

Yes, if we were to care the version of libcURL dynamic library that
gets linked at runtime, what you describe does sound like the right
way to go.  The separation between "git" (which does not depend on
libcURL at all) and "git-remote-http" (which happens to depend on
it) is our business and it is our responsibility to hide that from
the end users.

It certainly is MUCH better than making "git-help" a standalone
binary that links with everything we link with, only for version
reporting.

Thanks.
