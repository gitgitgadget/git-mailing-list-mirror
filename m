Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F9A225D0
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711644655; cv=none; b=SnsnkSvhg6M+ym28b3X/LaOipLrvk/A+b/bcaEP/QSbrnEg7PSQLzxq1gAMHRJpkr3kABR2zo3pRs9gAZoXS90BgtrC6G6vRY94kAwTkd4wDvxcDpgkTO1FC2kB5HAfQClAGuezasNqsXvuM7Xi/nSzyi+hgX9Hq7zPOqSRWXGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711644655; c=relaxed/simple;
	bh=JQhJaXXEIJ9LAtMwgyUq5C6dAYJ7fidmLsSTCOcf1Fw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JgiDSdT0AhAQJi/MVa2prW3H2Laqo32zYO6difAsC24Sq4+yMjhfPcp3QejL86K/vSAR8pxd658140rsLHIaaGf/In+ke6w6KhIbsmfOJMTxJNhzlseWX7NofVJOZCiptL66z5PuHHaA+taMTSgjhKyWk1WVk2bTrrYpSYd9t3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=UrOlLXRi; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UrOlLXRi"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BF1031EB6FA;
	Thu, 28 Mar 2024 12:50:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=JQhJaXXEIJ9LAtMwgyUq5C6dAYJ7fidmLsSTCO
	cf1Fw=; b=UrOlLXRisfGAy+iF+TP7ka5sTZjYm25h7XNUcmBnUZC4bb29ic2ck4
	7AxTBpcNPE7OUYbn35LHLGMDaxVY2k8C7wLgRKxUAJ8Qv3wFXrYIcTRIT78NHjSO
	bdeY1zXg6z7yV6VuYGJ3cnAMkJP2xTWjV/h+X5XsBTpSsNPgAX8fk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B74BF1EB6F9;
	Thu, 28 Mar 2024 12:50:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 020CC1EB6F8;
	Thu, 28 Mar 2024 12:50:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eugenio Bargiacchi <svalorzen@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Better visual separation of hunks in `git add -p`
In-Reply-To: <CAHfn=+snXChcPFiEgxvK=XFCq2uVMKQTyfrN9RNfAod18d0V=Q@mail.gmail.com>
	(Eugenio Bargiacchi's message of "Thu, 28 Mar 2024 14:36:11 +0100")
References: <CAHfn=+snXChcPFiEgxvK=XFCq2uVMKQTyfrN9RNfAod18d0V=Q@mail.gmail.com>
Date: Thu, 28 Mar 2024 09:50:49 -0700
Message-ID: <xmqqo7ayuwpi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 56298B58-ED23-11EE-999E-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Eugenio Bargiacchi <svalorzen@gmail.com> writes:

> I'm looking for a way to print some sort of separator between hunks
> when running `git add -p`, as I have a bit of trouble detecting when
> the previous hunk begins and the current one starts. Being able to
> print an empty line or a couple lines filled with "=======" would
> really help me out.

Hmph, my hope when I designed that particular UI was that the
command prompt for the previous interaction followed by the hunk
header of the current hunk would give us clear enough separation.

For example, after answering "n" to the prompt for the previous
hunk, we'd see

    ...
    +   (merge bff85a338c bl/doc-key-val-sep-fix later to maint).
    +
      * Other code cleanup, docfix, build fix, etc.
        (merge f0e578c69c rs/use-xstrncmpz later to maint).
        (merge 83e6eb7d7a ba/credential-test-clean-fix later to maint).
    (1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,?]? n
    @@ -233,3 +245,6 @@ Fixes since v2.44
        (merge 781fb7b4c2 as/option-names-in-messages later to maint).
        (merge 51d41dc243 jk/doc-remote-helpers-markup-fix later to maint).
        (merge e1aaf309db pb/ci-win-artifact-names-fix later to maint).
    +   (merge ad538c61da jc/index-pack-fsck-levels later to maint).
    +   (merge 67471bc704 ja/doc-formatting-fix later to maint).
    ...
    (2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,?]?

The '@' (the first character of the hunk header line for the current
hunk) and "(1/2" are surrounded by lines that begin with a space,
and the hope was that it was sufficient "separator" already.

These days (long after I stopped mucking with the interactive add
code actively), the prompt line is painted in prompt_color (you can
tweak it with the color.interactive.prompt configuration variable,
it defaults to BOLD BLUE) while the first part of the hunk header
line is painted in the fraginfo color (default CYAN), which should
give you even more visual distinction.

Perhaps

    [color "interactive"]
	prompt = bold red reverse

would be sufficient?  I dunno.

