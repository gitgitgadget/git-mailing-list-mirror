Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7941BC3C
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 23:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720825910; cv=none; b=MAzQzOq0P5Uus1dUmxt+uZ7ZYsRIaiM9WTX6cI8yrAsZYaDHCh/GAHTvLusjMjYEIEyJMAQE0KlLpeuMiqud/CtzyLg1lrSn2QnM+DwGqCLeAXJN2T5/nm3dAfS4Jz4wnw+8xaCosvFvnkBWnFPhFDVhK1NPNFBvNLhX5C+UXDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720825910; c=relaxed/simple;
	bh=gLbKeE4W/XptNkoT+D9AUe2rWPDXEeYD+bJY0gW6k8s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cCiZ9jo4B3Y3qtcQ9AiiQfv+jmfweK+4nO6JCDqiMVgC5rxy3xMLo+9PXParx72lMfIx4qw8f684KAgHqH2Z6HzeM2oucSP03dcRsufsyzWJrffwCpG8okuSzq2SsfFK/QFOIfPymP7YX+KMb77Pl2Cz67Qn1UQs6f+0tS5/e00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rGFTRJ+R; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rGFTRJ+R"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id EEAE025C25;
	Fri, 12 Jul 2024 19:11:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=gLbKeE4W/XptNkoT+D9AUe2rWPDXEeYD+bJY0g
	W6k8s=; b=rGFTRJ+RZcmeli/HH0z8H/IEfxL77963YjI+t7hRLLKQD8TXa3dIJ8
	+b1I6jTVFfXo0wZcBA1LoMfYKSEjoCPfval7U9oW6cKHB5cxjB2t3GYvXlfGyt8A
	kJqHLo/q+MMutk7tFhfhHUxfYiKFHlpcI6rd8MLtNe//cRyijXWgk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E7A1C25C24;
	Fri, 12 Jul 2024 19:11:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1172C25C23;
	Fri, 12 Jul 2024 19:11:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] doc: clarify post-receive hook behavior
In-Reply-To: <20240712224748.56843-1-jltobler@gmail.com> (Justin Tobler's
	message of "Fri, 12 Jul 2024 17:47:48 -0500")
References: <20240712224748.56843-1-jltobler@gmail.com>
Date: Fri, 12 Jul 2024 16:11:43 -0700
Message-ID: <xmqq8qy6jjdc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1B6F37A4-40A4-11EF-B009-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Justin Tobler <jltobler@gmail.com> writes:

> The `githooks` documentation mentions that the post-receive hook
> executes once after git-receive-pack(1) updates all references and that
> it also receives the same information as the pre-receive hook on
> standard input. This is misleading though because the hook only
> executes once if at least one of the attempted reference updates is
> successful. Also, while each line provided on standard input is in the
> same format as the pre-receive hook, the information received only
> includes the set of references that were successfully updated.

Yup, it sounds like is a sensible design that gives the most useful
information to the hook.

> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index 06e997131b..f9eb396a79 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -415,13 +415,13 @@ post-receive
>  
>  This hook is invoked by linkgit:git-receive-pack[1] when it reacts to
>  `git push` and updates reference(s) in its repository.
> -It executes on the remote repository once after all the refs have
> -been updated.
> +It executes on the remote repository once if any of the attempted ref
> +updates are successful.

We could instead say "at least one of", but "any of" should be fine.
OK.

> -This hook executes once for the receive operation.  
> +For a receive operation, this hook executes a single time at most.  

Hmph, maybe we can strike this sentence as we already said "once" in
the previous paragraph.  The intention of the original description
that said "only after" was to convey two things:

 (1) it runs only once, and
 (2) it does not run before all the ref-update requests have been
     processed (either successfully or unsuccessfully).  

If the "only after" was not serving the original purpose of
conveying both of the two, then perhaps we should remove the word
"once" from the previous paragraph instead and keep this sentence.

My preference is revert your "once after" -> "once if" to get back
to the original "once after", and then remove "this hook executes
once for the receive operaiton" of the original, without adding your
"For a receieve ... at most".

    The hook executes on the remote repository once after all the
    proposed ref updates are processed and if at least one ref is
    updated as the result.

> -It takes no
> -arguments, but gets the same information as the
> -<<pre-receive,'pre-receive'>>
> -hook does on its standard input.
> -It
> +takes no arguments, but for each ref successfully updated, it receives a
> +line on standard input that follows the same format as the
> +<<pre-receive,'pre-receive'>> hook.

This part of the update is great.  The "but" there is annoying, but
that badness was inherited from the original and not a fault of this
patch.  If I were writing it from scratch I would probably have said
something like:

    The hook takes no arguments.  It receives one line on standard
    input for each ref that is successfully updated in the same
    format as the pre-receive hook.

Thanks.
