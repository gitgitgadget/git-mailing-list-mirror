Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402DB15E215
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 20:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713472945; cv=none; b=nL/OvXvxdisQm2di4Irp92iq7wdPSJt4Uk922z64+qNu/vjC+wyOylL4bui4WpVquP9l/APdbJTXsUh0sI3Ig8ecN9Ay1jqvy6aggKtsLAX0KLY8B0j5d/7UQFjRdfn5+GHatvpz9G54tpia/fNYKPX5eL9JSyHlh1+tAEJuIPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713472945; c=relaxed/simple;
	bh=sP1zisNIhVlQDvh3CKg2d0JJcOOjJVIDLk1XUFLi9Ks=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W3Bzz9VkVvwufak4kZAUaEH0YEkQ/gKZJhsBYqv46OJDDrhXXgKQVHWUpVk+WdOJgG4WvWc1hW0ObJ9pZxqElX3ezdmxT3Jl3MdXh5q7cWNQaM7XQirfSW6GBipxYLRh9SQp2WqVZqgkr31iC2LTJXKa+aJq5cDbTrbbUsra7C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZpIJ2HRe; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZpIJ2HRe"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EAD311E75A3;
	Thu, 18 Apr 2024 16:42:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=sP1zisNIhVlQDvh3CKg2d0JJcOOjJVIDLk1XUF
	Li9Ks=; b=ZpIJ2HReeRXeumIx4gjtvJ9OUPm8AozNq0PmyD0jdETx5TvhOBLDXR
	1r1LIWRWvtF61tTkQ/43n21zHdkaSK69iwNyw1uwqnlOD6bkuJmZQxmrC48ySp8N
	GdFC9liC+w0qJphHzjj1nTPqOVGMyKJI1xRBh74WnpsC/XqkjIGzc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E1C2F1E75A2;
	Thu, 18 Apr 2024 16:42:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 192551E75A1;
	Thu, 18 Apr 2024 16:42:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  David Bimmler <david.bimmler@isovalent.com>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/5] sequencer: start removing private fields from
 public API
In-Reply-To: <2beedb4547013629a507d646d582ca6b3f420c2c.1713445918.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Thu, 18 Apr 2024 14:14:06 +0100")
References: <cover.1713445918.git.phillip.wood@dunelm.org.uk>
	<2beedb4547013629a507d646d582ca6b3f420c2c.1713445918.git.phillip.wood@dunelm.org.uk>
Date: Thu, 18 Apr 2024 13:42:20 -0700
Message-ID: <xmqqa5lqs8r7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 27FA2E2A-FDC4-11EE-81DB-25B3960A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> +/*
> + * A 'struct replay_ctx' represents the private state of the sequencer.
> + */
> +struct replay_ctx {
> +	/*
> +	 * Stores the reflog message that will be used when creating a
> +	 * commit. Points to a static buffer and should not be free()'d.
> +	 */
> +	const char *reflog_message;
> +};
> +
> +struct replay_ctx* replay_ctx_new(void)

Style.

Also if you intend to make the structure opaque and private,
shouldn't you make this static to make it truly internal?  The
initializer of the containing replay_opts structure would be the
only thing that needs to know how to instantiate it, no?  Or does a
replay_ctx has reason to exist outside the context of an instance of
replay_opts?

i.e.

	static struct replay_ctx *replay_ctx_new(void)

The remainder seem mechanical so I'll skip them.
