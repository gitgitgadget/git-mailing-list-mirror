Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D3C190670
	for <git@vger.kernel.org>; Wed, 29 May 2024 17:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717003551; cv=none; b=bWFxvXs5OoxBZEzRCrtIEm1JKKtieRlXEDCV4vF58c8MAmc7Z5frnqeEKyzNV5IuEzk9b7/01KnxwPCXDD0ZBclA1h6XSUq7fQN/StMQBxyPFnr0gjodwmqrE1jPvj//ri9bxZbaqgICVHLF0u/RErR8hscfZ9tfMNUXB81ZDus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717003551; c=relaxed/simple;
	bh=QBA9ytwqJgvbJ1YI3KtR3Uu0YqvIgwoEYf3y5bNrlHo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BYGR3w/LR27pmaCarBzucKsGXYv9A7B5APC/SV0kW4W9lrISfRaj0t5nhbNOUfCxbi2yZerHcdkmtf9hMxdUYIgI07VBdqM2DXkHDzTN1oAkTsUbsUjtgOOTTToMPUGXLIMDjssz9AroWumP1xISdiQGTq+1rl0ft6aaKWuv/p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bRdJA26f; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bRdJA26f"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 012F133310;
	Wed, 29 May 2024 13:25:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=QBA9ytwqJgvbJ1YI3KtR3Uu0YqvIgwoEYf3y5b
	NrlHo=; b=bRdJA26fVCKisOtrzJu0K853h3DEEx9cTtX+9dCWNDhP0Az2kBfF9e
	f8So32KSfqEkEvp1ce0oWbpzG3hmPLEtirDe2Kn2N3+0jnsiZMpOc3pmdAxaCOfb
	CE9oOhh1SONACFmtOVK1/e0qYCojW+RYYy4qu3P9zlQ8rSmLY2eQg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EE66B3330F;
	Wed, 29 May 2024 13:25:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 640293330E;
	Wed, 29 May 2024 13:25:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 02/19] global: assign non-const strings as required
In-Reply-To: <51ee5660a1452797ac0a45819210141c57f3dcb9.1716983704.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 29 May 2024 14:44:11 +0200")
References: <cover.1716983704.git.ps@pks.im>
	<51ee5660a1452797ac0a45819210141c57f3dcb9.1716983704.git.ps@pks.im>
Date: Wed, 29 May 2024 10:25:47 -0700
Message-ID: <xmqqplt4y1gk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7D53064E-1DE0-11EF-8A3F-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> +	char refspec_str[] = "refs/heads/*";
>  
>  	memset(&refspec, 0, sizeof(refspec));
>  	refspec.force = 0;
>  	refspec.pattern = 1;
> -	refspec.src = refspec.dst = "refs/heads/*";
> +	refspec.src = refspec.dst = refspec_str;
>  	get_fetch_map(remote_refs, &refspec, &fetch_map_tail, 0);
>  	matches = guess_remote_head(find_ref_by_name(remote_refs, "HEAD"),
>  				    fetch_map, 1);

I have no objections to changes along this line, but this makes me
wonder if we somehow have ways to ensure that after everything is
done, refspec_str[], empty_str[], and the like in other hunks remain
to have their initial contents.  Stepping back a bit, without
applying this series, if we told the compiler to store these
constant strings in read-only segment, any attempt to write into
refspec.src or refspec.dst string would have been caught at runtime
as an error.  With the patch, that would no longer work.  The piece
of memory in refspec_str[] is a fair game to be overwritten by
anybody.

Which makes me wonder why these refspec.src and refspec.dst members
are not "const char *" pointers in the first place?  Obviously we do
not expect "refs/heads/*" to be overwritten after storing the pointer
to it in these members and making the get_fetch_map() call.

