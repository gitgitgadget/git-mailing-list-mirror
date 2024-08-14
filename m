Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2A71BC073
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 17:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723655712; cv=none; b=pfbetqDnzlylEgidaxKiymyIC9HobHxGApWsx58poaSFECB6MwBmGLihmFlIz7WpGgBBy0u5xfVSSkRVByHHs6r2BvGTqIVTA2Jlm69hW/EQmjoKFIQmCxapnnYs63/rAuHegW9mGsaQhuCrf+dRz6Ibj1r9e0evh6otaWGjYEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723655712; c=relaxed/simple;
	bh=CJ7KDsc3DtR7gS2WFX5+C/6/T4rU82wkqkbld19PEtk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m8F0PPLwqLzi2BnVNTeXX1c/vnbL213Iixy/8G/u977cx3PKHWsc3pIQKAQonSeBSZUWHOzllSqBZKeV86jH30T6yzOy1mogkkP4B+fXRI0KzkLg9KOQcySsb3RQKqvy7NyzICjm/XEL4kedaZdYMkyPSTy8rH5N7yKhAAal7Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kvddVlg0; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kvddVlg0"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 54BE618B00;
	Wed, 14 Aug 2024 13:15:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=CJ7KDsc3DtR7gS2WFX5+C/6/T4rU82wkqkbld1
	9PEtk=; b=kvddVlg0nAJO3/VJnEkHH6gYMvsTbePw8K3H0ZW53Hkl51D5pVTKko
	g3GR5TknB1mM2fenZCxuumv+b4meR06HprdSoIjv7GMYjjZhmVlbWoS5RTezV68+
	Du6DuX+bVPtnr6HFondz1uoMMnSi1lFYEy1BUXYyrEcHTBxCLogM8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 367CC18AFF;
	Wed, 14 Aug 2024 13:15:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C67D618AFD;
	Wed, 14 Aug 2024 13:15:08 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] safe.directory: normalize the configured path
In-Reply-To: <5e4906be-2cbe-44b5-b490-593ee5a42b95@gmail.com> (Phillip Wood's
	message of "Wed, 14 Aug 2024 14:20:41 +0100")
References: <20240720220915.2933266-1-gitster@pobox.com>
	<20240723021900.388020-1-gitster@pobox.com>
	<20240723021900.388020-3-gitster@pobox.com>
	<5332f244-7476-492a-a797-2ef7ba73f490@gmail.com>
	<xmqqbk2ljvty.fsf@gitster.g>
	<5e4906be-2cbe-44b5-b490-593ee5a42b95@gmail.com>
Date: Wed, 14 Aug 2024 10:15:06 -0700
Message-ID: <xmqqh6bnyqjp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C1E788CC-5A60-11EF-9554-9B0F950A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 25/07/2024 17:11, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>> 
>>> I think this is sensible if the key is an absolute path, if the key is
>>> a relative path I think we should ignore it as it is not clear which
>>> directory the user meant.
>> The only thing that worries me in that proposal is that doing so
>> would break a configuration that used to work.  I'd rather leave
>> the tightening of it to future work with its own justification.
>
> As far as I know the only caller that tried to match a relative
> directory was enter_repo(), all of the other code paths pass an
> absolute path from getcwd(). Before this series git daemon required
> the relative directory "." to be specified in addition to the absolute
> path so that will not be broken by removing support for relative
> directories. Are there other users of enter_repo() that still rely on
> being able to match relative paths?

Offhand I do not know of any, but no guarantees.  I am tempted to
leave it as a prerequisite task for those who want to tighten this
codepath further.

