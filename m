Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4A53A27E
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 19:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723231799; cv=none; b=HqpouyLg7/ya4yNsYsibGKzBqK5Zmk7OucIsPt5n/1pal/juz2QSi+EXGh20MJdoQl3Kut6SoYhf2QTinYSZRkx85tl1OQ6bEs4+CrnYyyJC6c0Hl/q1joKVmUh+4gO8ij5+9WTR4YQTgyioizAxboEX7MygWZ9vnOTNMupdVCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723231799; c=relaxed/simple;
	bh=WnKSawheTXKqYdGuroNxpGQ4OUmdGi3tCTqkTNzmeaY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m2P0TK6XCFbAdJUvH85AV2cUmYaqFziM2j7QFHZIegY1/i2tt7pi7KD69cIxrWQF5gFM3s9P1TIRCr73VMT1mITKufCpqZSEwbtQgTrvqqCmCr4QiAQcUQ45OwG3v1kg8ehHzfs7+0Aegzf8LrtnhxxXPMsjbo3e7ljKGfxlvqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nCFEPEFQ; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nCFEPEFQ"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D8F991F778;
	Fri,  9 Aug 2024 15:29:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=WnKSawheTXKqYdGuroNxpGQ4OUmdGi3tCTqkTN
	zmeaY=; b=nCFEPEFQ8b6HLXpdVx/UvhwwTaTEEb/rOF49XPd7or1u+gjS9nFx+y
	R6BHYsUaiaZJzaLrfGOs9kG+BnY10KU8ZM5y9Scm4YtTLIyxaP5HK6UzvEVXxQmU
	ULowMxWpZEHjPKqCAg4cGWmu9kf3PtD2kJsuE+3I3cbla0zK85sDk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D189D1F777;
	Fri,  9 Aug 2024 15:29:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4BDE71F776;
	Fri,  9 Aug 2024 15:29:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  calvinwan@google.com,  spectral@google.com,
  emilyshaffer@google.com,  emrass@google.com,  rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 0/6] [RFC] Introduce cgit-rs, a Rust wrapper around
 libgit.a
In-Reply-To: <xmqqbk21cxhn.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	09 Aug 2024 12:22:28 -0700")
References: <cover.1723054623.git.steadmon@google.com>
	<xmqqbk21cxhn.fsf@gitster.g>
Date: Fri, 09 Aug 2024 12:29:46 -0700
Message-ID: <xmqq34ndcx5h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BD97C324-5685-11EF-8D1D-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Josh Steadmon <steadmon@google.com> writes:
>
>> We're sending this series as RFC because there is remaining work
>> we'd like to do, but we'd like to get early feedback on this approach,
>> and particularly to ask for advice on a few topics:
>
> I am not sure how much this is reusable, after seeing comments that
> "cgit-rs" may not be the best name for this thing and pathnames may
> have to change, but I needed the following merge-fix to get this
> into "seen" and have the result pass "make", due to interactions
> with the ps/config-wo-the-repository topic.

In case you are wondering "so... is there anything actionable for
*US*???", there isn't, exactly.  But you'd need to holler if the
"merge-fix" you saw in the message not correctly addressing the
semantic clash between these two topics.

Thanks.

>
>  contrib/cgit-rs/public_symbol_export.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/cgit-rs/public_symbol_export.c b/contrib/cgit-rs/public_symbol_export.c
> index 9641afca89..2732f5898e 100644
> --- a/contrib/cgit-rs/public_symbol_export.c
> +++ b/contrib/cgit-rs/public_symbol_export.c
> @@ -9,6 +9,8 @@
>  #include "setup.h"
>  #include "version.h"
>  
> +extern struct repository *the_repository;
> +
>  #pragma GCC visibility push(default)
>  
>  const char *libgit_setup_git_directory(void)
> @@ -18,7 +20,7 @@ const char *libgit_setup_git_directory(void)
>  
>  int libgit_config_get_int(const char *key, int *dest)
>  {
> -	return git_config_get_int(key, dest);
> +	return repo_config_get_int(the_repository, key, dest);
>  }
>  
>  void libgit_initialize_the_repository(void)
