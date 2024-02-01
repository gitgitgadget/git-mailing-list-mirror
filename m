Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFF3522F
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706805701; cv=none; b=cQpvNz6RhWbjqF9e/Pmptc+g/76CL6B3JD8C0xET/F8X0jOcQ6IO1OPbFor81KTYq0xNVr4T2SKX3NwX9ILTqPHRAop1HsFRDTrR0fAcsiSE0AAlFhItbQo4Eyybco47iRJi/o538pc10i+1W4oBMHqfsYeeN2WL7J9cpp5LjWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706805701; c=relaxed/simple;
	bh=Z/2zuSV6ioqreU+cNSRce9oCYW4UV3Qz7JqtqtcXhP4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VJmNYYpLPgkMi+MVmuBDIm5TbEJWcfcLNSo/buQApIpkJzBSMImUxk6U1VCaWw8DjMDZpULRqIwHKk/0vSPWPFahWfiRHtooC/2brFBmGnB6IYrVRRtp5Dh65/6bBn/miGDXWihlgxWQ15O/MW0YbSuKto+zoM85134kSkquMoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=q+LN0qFq; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="q+LN0qFq"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 094B71BDC7;
	Thu,  1 Feb 2024 11:41:39 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Z/2zuSV6ioqreU+cNSRce9oCYW4UV3Qz7Jqtqt
	cXhP4=; b=q+LN0qFqCnDcu4BRMUXW6Ru0i0DOsvOCAcZ534Dnpu7Emq9Zv6ZUQw
	y95zhLTpWCylf61FaoSfoWeoNOuhVEiGJ25zz/jV28mIjXlYOfDpVeDfpLrGlcRj
	bgm2e5lInIYRfr/aGhlpk3Zh5drj524yrIeXQm06j5YwN0XOp27s8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 01C641BDC6;
	Thu,  1 Feb 2024 11:41:39 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2D8F11BDC4;
	Thu,  1 Feb 2024 11:41:35 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Linus Arver <linusa@google.com>,  Christian Couder
 <chriscool@tuxfamily.org>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Emily Shaffer <nasamuffin@google.com>,  Josh
 Steadmon <steadmon@google.com>,  "Randall S. Becker"
 <rsbecker@nexbridge.com>
Subject: Re: [PATCH v3 03/10] trailer: unify trailer formatting machinery
In-Reply-To: <xmqqfryd2drm.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	31 Jan 2024 17:07:25 -0800")
References: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
	<pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<5c7a2354df0f4a29841f9ab8294ead0e1c3b9cf5.1706664145.git.gitgitgadget@gmail.com>
	<xmqqy1c545y0.fsf@gitster.g> <xmqqa5ol409k.fsf@gitster.g>
	<owlyv879106s.fsf@fine.c.googlers.com> <xmqqfryd2drm.fsf@gitster.g>
Date: Thu, 01 Feb 2024 08:41:33 -0800
Message-ID: <xmqq4jes2l36.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C3233D78-C120-11EE-A6A7-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> ..., if that gives us a readable set of bite-sized changes that
> prepare a solid foundation to rebuild things on top.  I am having a
> feeling that not even a single person has reviewed them on list even
> though we are already at the third iteration, which is quite
> frustrating (and I would imagine that it would be frustrating for
> you, too), ...

I guess "not even a single person" was a bit unfair, given that we
did see some minor comments from me and also Josh during the first
round.

But neither of two rounds saw any in-depth reviews that question "is
the code doing the right thing?", which would take a real reading of
and a comparison between the code before and after the patches, with
some understanding of how things have been working, how things were
envisioned to evolve, and how the patch author would want to change
the course of the evolution of the code in the longer term.  

Christian, you've been touching the code in this area the longuest.
Can we have some of your time reviewing these?

Thanks.
