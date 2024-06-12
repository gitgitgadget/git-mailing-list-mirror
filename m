Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9B5381C4
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 19:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718221836; cv=none; b=ds1cOHuVMugKu3kyoqm7M5Rpat2oCTMB6GjMUNXb0JvqfEci9ibafc2kwO3um1d6LB+4HNAuKmyKcCBaOL1GTeGSzz3aPbVV3jSGsI74jlq8XN/WKUxJ/MnJrFW6kG3DroydWoBeIVkgTiT84Vymr7vIx1YwVXbWHWb87P1ccpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718221836; c=relaxed/simple;
	bh=fv55mZ7EzQm+AfO1pkSflXPivQkT4FNzOgiYvUd56zo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=umXOGNyN+xSTBHaQKxqp0/7/YSbfy1qNFp75Tldwha/6TmoQtoZ4S6WLBctkGdWzYjSXasQr/px0rTBlHZKduRyrZcFKUOhamwSJLWpoPtT8fgv3OyLDPZnuzxqrdVMRdHqCNgWTkKYxyDdTBmP/YnFm7P0vATOGs7fJa0mWI8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RYhHp31N; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RYhHp31N"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 03A63227CD;
	Wed, 12 Jun 2024 15:50:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=fv55mZ7EzQm+AfO1pkSflXPivQkT4FNzOgiYvU
	d56zo=; b=RYhHp31NkT5pLPP0JhoqQ5IQB49pqlgcOjkI5j18sZxNimgTQnEMm/
	w4RN94SG8U2csr5DJwOKKWQKJGKfJo5tos3i4d4YRsu7JTzAoN/uzEdHzo9GNMku
	M7jOO5rzxKRhG54hVrQhGEoMimDcda5twXRCAuVUz+/tOAg6qLrVA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EFBAF227CC;
	Wed, 12 Jun 2024 15:50:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6E077227CA;
	Wed, 12 Jun 2024 15:50:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 14/16] mktree: optionally add to an existing tree
In-Reply-To: <ZmltKHI-Vz1L44r8@tanuki> (Patrick Steinhardt's message of "Wed,
	12 Jun 2024 11:40:56 +0200")
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
	<df0c50dfea3cb77e0070246efdf7a3f070b2ad97.1718130288.git.gitgitgadget@gmail.com>
	<ZmltKHI-Vz1L44r8@tanuki>
Date: Wed, 12 Jun 2024 12:50:32 -0700
Message-ID: <xmqqcyomos8n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 07CB93F8-28F5-11EF-960D-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Jun 11, 2024 at 06:24:46PM +0000, Victoria Dye via GitGitGadget wrote:
>> diff --git a/Documentation/git-mktree.txt b/Documentation/git-mktree.txt
>> index afbc846d077..99abd3c31a6 100644
>> --- a/Documentation/git-mktree.txt
>> +++ b/Documentation/git-mktree.txt
>> @@ -40,6 +40,11 @@ OPTIONS
>>  	optional.  Note - if the `-z` option is used, lines are terminated
>>  	with NUL.
>>  
>> +<tree-ish>::
>> +	If provided, the tree entries provided in stdin are added to this tree
>> +	rather than a new empty one, replacing existing entries with identical
>> +	names. Not compatible with `--literally`.
>
> I think it'd be a bit more intuitive is this was an option, like
> `--base-tree=` or just `--base=`.
>
> One question that comes up naturally in this context: when I have a base
> tree, how do I remove entries from it?

Presumably the same way how you remove entries with "update-index --index-info"?
I.e. mode=0 entry in the input would serve as a signal to remove the
path?
