Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF46514884E
	for <git@vger.kernel.org>; Thu, 16 May 2024 15:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715873526; cv=none; b=OinPGblVk4PFUnNtXI/VJPYqmMHOVeypdYuCMMRYTWmTlOM2DqXXbt7lHsMTgHmut65tcjZ6H7IHwWSR/DEaViB+Fmjg1YJCDNmA+E0Lv1XnQRvLuW5FxQcB/V5hj79X//DO6C3n+L3TnMPsgP/7WUhj0OT+KAkpeP3WkzK+G6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715873526; c=relaxed/simple;
	bh=K/vx6Nhb771a6Dwh21CbH2wjr79eus6WVDraIXgLWEw=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oYgDTl48vc9lrgjqdWY1tFkKXXBqKHHfllryRhzVKICest12AsSo0Q6tkfBGG2CzpSK4Wf6tN+pDuVaVhrl6qnuqRE4kkxkiDHGLuIAP4Qp9xb6uSIKUD5Z3LpEFuIkbRAUhcQpp5dgH5cZjv9wnE+FBobdUO68gxyMja+5Oc7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=qJDnJLQf; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qJDnJLQf"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 931AC2682E;
	Thu, 16 May 2024 11:32:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=K/vx6Nhb771a6Dwh21CbH2wjr79eus6WVDraIX
	gLWEw=; b=qJDnJLQfAQSvhrbUnP/lAJNvL0s0ArAeWZw7Voft6kECrvUr0Q/heN
	gphFjH6T34RkyROn6GR3MHq813WkIOkQ1NrHcxemptwxk3gBKbwTYjcoD804i5MQ
	cFRtrHPCUcZJRuIKwiMIf+Rl7khnnk1EJfBlqagHgtMtry0ArrbiI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8C2192682D;
	Thu, 16 May 2024 11:32:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 13E332682A;
	Thu, 16 May 2024 11:31:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: [PATCH v4 1/5] setup: add an escape hatch for "no more default
 hash algorithm" change
In-Reply-To: <xmqqikzg48hm.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	14 May 2024 10:19:01 -0700")
References: <cover.1715582857.git.ps@pks.im>
	<20240514011437.3779151-1-gitster@pobox.com>
	<20240514011437.3779151-2-gitster@pobox.com>
	<xmqqikzg48hm.fsf@gitster.g>
Date: Thu, 16 May 2024 08:31:56 -0700
Message-ID: <xmqqcyplu61f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6EC2E898-1399-11EF-AE8A-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Having done all of this, I actually am very tempted to add the
> "always default to SHA-1" back as a fallback position to the
> set_default_hash_algo() function.  We know we are going to get the
> right hash algorithm when working in the repository, so the only
> case the default matters in practice is when working outside the
> repository.

Not really.  It does not add anything to help either real world or
our tests.  The current test setting is already bad enough in that,
unlike in the real world settings, even tests with the SHA-1
algorithm has GIT_DEFAULT_HASH environment variable set, which means
that such a "if the environment variable is not set, further fall
back to SHA-1" does not do anything.

Unless we change t/test-lib.sh not to set GIT_DEFAULT_HASH tweaking
the fallback default in repository.c:set_default_hash_algo() based
on GIT_DEFAULT_HASH would not be a workable solution.

I wanted to arrange things so that the end-user exectuion by default
has an extra fallback (perhaps to SHA-1, or GIT_DEFAULT_HASH) to
avoid disrupting their real-world use, which we can disable in our
tests to expose code paths that still rely on the "default" set when
in-core repository struct gets initialized, but that is not possible
without changing the way t/test-lib.sh uses GIT_DEFAULT_HASH, it
seems.  So the arrangement unfortunately has to be "we have no
default, and bugs will break the real-world uses as well as tests
the same way.  The real-world users have to export an extra
'workaround' environment variable to force "default" to SHA-1 (or
GIT_DEFAULT_HASH) --- which may be "workable" but very far from being
intuitive.  They can set GIT_DEFAULT_HASH but to make it effective
everywhere, including the "default" given by set_default_hash_algo(),
they need to set this other "workaround" thing.

> We already have such a custom code for "git diff --no-index", and we
> are adding a few more back in here, but they can disappear if we had
> code to set the fallback default when GIT_DEFAULT_HASH does not
> exist here.

While I think a manual setting of the_hash_algo in "diff --no-index"
code path should not hardcode "SHA-1" but instead use the hash
specified by the GIT_DEFAULT_HASH environment to be consistent with
the use of "git" by the same parent process that had that variable
exported to the environment, that should not be done globally in
repository.c:set_default_hash_algo().
