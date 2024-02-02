Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C332D4776F
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 17:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706894818; cv=none; b=ldG3ZyyKbI4TUp+ndA7TYohhBerORjor/qmuh85eqY7hmHts0ejkrXiUEzll1H1OL2sPL3cwUnT7nM8z7mDfNOMmpAzKI4eD1CrMzGJ8aXTdgZBgTumdSl0pBEhr58i3cy1hsRszWrlan/8p5Al4kpK1QVIkQsPv6QO6pd7TtOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706894818; c=relaxed/simple;
	bh=X459Z71zXBpLYP8J/CApNMiQML+eTC4NefTaHJwRjCg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XBSo/CU9LoZOnO8FWuNP7Zefl/0ME9avV0xnZgNdw62tRPYl3Ti+rwpV3mCx/vkqpoz5wP6Ji383jjEhHz+pm8aHQDOV0fPNzOSpayMr4RQNRoMAqeDC04GGhMMWKRikdaC5nkKm6R34O+087nSrO6devWsTH32YT9NY8yAZRJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AvtrgQcx; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AvtrgQcx"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 58A311C276E;
	Fri,  2 Feb 2024 12:26:55 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=X459Z71zXBpLYP8J/CApNMiQML+eTC4NefTaHJ
	wRjCg=; b=AvtrgQcxcmQRV03ie8FQ5w0ngcdp81S7/bb243oeEXk2Ha9PeoVVTK
	GHDSTHYsAetgZ+Z21Y3kbKwemm5/r8QRiNeNHlfkwaGpJCCnOpT3O7qZv75h7b90
	cjIMX79z7llFAA9bczJDCIfQ7P/ceH0fgX+DsTj7xdVUp1ckZQurg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4F09D1C276D;
	Fri,  2 Feb 2024 12:26:55 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B54F51C276B;
	Fri,  2 Feb 2024 12:26:54 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Linus Arver <linusa@google.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>,  Emily
 Shaffer <nasamuffin@google.com>,  Josh Steadmon <steadmon@google.com>,
  "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v3 03/10] trailer: unify trailer formatting machinery
In-Reply-To: <owlyil371g96.fsf@fine.c.googlers.com> (Linus Arver's message of
	"Thu, 01 Feb 2024 23:23:33 -0800")
References: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
	<pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<5c7a2354df0f4a29841f9ab8294ead0e1c3b9cf5.1706664145.git.gitgitgadget@gmail.com>
	<xmqqy1c545y0.fsf@gitster.g> <xmqqa5ol409k.fsf@gitster.g>
	<owlyv879106s.fsf@fine.c.googlers.com> <xmqqfryd2drm.fsf@gitster.g>
	<owlyo7d011no.fsf@fine.c.googlers.com> <xmqqa5okyori.fsf@gitster.g>
	<owlyil371g96.fsf@fine.c.googlers.com>
Date: Fri, 02 Feb 2024 09:26:53 -0800
Message-ID: <xmqq8r42u68y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4287E472-C1F0-11EE-9325-25B3960A682E-77302942!pb-smtp2.pobox.com

Linus Arver <linusa@google.com> writes:

> The hard part is not so much the rearranging of
> code but rather thinking up of good commit messages to explain the
> intent of each smaller step.

Good.

Coming up with a good explanation of what you did forces you to
think it thorough again.  People often discover bugs in the code
they just wrote, or different and better ways to solve the problem,
while explaining the change to their colleagues, and I found it has
very similar effect to try to write a good explanation in the commit
log.  Time to write such a good explanation is time worth investing
in.

Incidentally, this is why we value clearly written proposed log
message while reviewing.  A commit that is a product of "I tried
this, which did not work, and then tried something else, which did
not work either, and after some more random tries, this seems to
work" would not have a clear thinking behind it, but if such
iterations of random tries happened to hit the best solution,
thinking backwards from the result to the original problem and
explaining how the solution works would result in a good
description.

Thanks.
