Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E72E186E20
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 22:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718405290; cv=none; b=GpWk/YzttMQA5xPNB95oHwdG+O2UsGlA1Jb8Ag13HOW1rag5O/ZS7wXOIIWB3+inDCrdAQu2M32jJb65HjWJ0SjgGemqK/hjFAYv4lwV0Cz5wDwQfGNFIOt8GAcl08xlNAtA4ydo9euvYWmkHj8Qa2EjsLFVA9znIhNL5x1rfTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718405290; c=relaxed/simple;
	bh=ttxzN3K2TdlIBEXo9EDx+H2LGjimLuP08/E4zOnVXVk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s1B4P5VVLQoZfsqPh8p3lAYXJ6rYHjJ8eOSVQxKdnqU1r0wWcVmOe3R02NpDE2y1IkJQIrv2CJH48RP5hbTZB/ME9i2eJTkG1HAW8Zn4N4uzoq9pzPbyEdz4Z73PnGXB1ZRTPEmwB/wbwrINaAO7xGF9gx0ajjvYkBi4ntnlIYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KD+Aqsn7; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KD+Aqsn7"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9507734F77;
	Fri, 14 Jun 2024 18:46:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ttxzN3K2TdlIBEXo9EDx+H2LGjimLuP08/E4zO
	nVXVk=; b=KD+Aqsn7eiY2U9bjYWQAHK1E9MrRwUSAmJ0Nhf7ymHr6yh8dzektns
	LZd02TWnN1BCkWC0n8314DSwIR3udoyipxd6EoPT71w8Be7tulMS/uOCDIFsXgUG
	nAVvw/H0iwgL8ekIckBk7QDKqODU+Aup88yvxf0scqtJez6nyOBHU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8AD8B34F76;
	Fri, 14 Jun 2024 18:46:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F01F334F75;
	Fri, 14 Jun 2024 18:46:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] show-ref: introduce --branches and deprecate
 --heads
In-Reply-To: <CABPp-BEZhR8T56bwxpi+_uGG8w7nms+7HtCR45S4oVjPom9Stg@mail.gmail.com>
	(Elijah Newren's message of "Fri, 14 Jun 2024 21:42:17 +0000")
References: <20240603200539.1473345-1-gitster@pobox.com>
	<20240604220145.3260714-1-gitster@pobox.com>
	<20240604220145.3260714-4-gitster@pobox.com>
	<CABPp-BH3ZozGnDueK=J4QvZMYZkS13Gk+0rhe+Dywqbx1F30DA@mail.gmail.com>
	<xmqq7cerdxv4.fsf@gitster.g>
	<CABPp-BEM4fqU9s7_dxgi_twe_T169mGjZN9-CJRLU5cjnUi8WQ@mail.gmail.com>
	<CABPp-BEZhR8T56bwxpi+_uGG8w7nms+7HtCR45S4oVjPom9Stg@mail.gmail.com>
Date: Fri, 14 Jun 2024 15:46:31 -0700
Message-ID: <xmqq5xubcfco.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F297FEFC-2A9F-11EF-A45C-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Elijah Newren <newren@gmail.com> writes:

> ...or maybe my argument breaks down because `HEAD` is more prominent
> and tends to be used by users more (`git reset --hard HEAD`, `git
> checkout HEAD~1`), and thus there's an argument it already is somewhat
> aligned with user terminology?

Yeah, you are correct to say that HEAD is a lot more prominent than
"refs/heads/".  "git branch --list" does not expose the
"refs/heads/" part (but "git for-each-ref" does), but you'd see HEAD
in many places (e.g. "git show -s <RETURN>" gives the --decorate
output that says "HEAD -> master" etc.).

Of course we _could_ plan to rename "HEAD" to something else, like
"CURRENT" and deal with the fallout, and then rename "refs/heads/"
to "refs/branches/", but for what cost to achieve what benefit?  The
tradeoff does not look all that good to me.

So I'd say renaming --heads to --branches would probably be a good
place to stop, at least for now.
