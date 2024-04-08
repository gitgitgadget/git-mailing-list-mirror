Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C83F51B
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 19:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712603543; cv=none; b=hzTQDp8HGpWWBHintD1uZbggMvP0Pkkxv5i33JNBOUZ6TDQk7cJLVKZ3sxudar1XYLikgzguVafOb6PJ6nuxXSYGbcKq2+b/imPs90Z8ryIORBQnBq5i0GzBN3pbe+YgO9ekxgtXcNlYvtw713vUbroOxQMguf9wGDYAOimTIxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712603543; c=relaxed/simple;
	bh=kkqwHybr0Xw95CCx8PhOKSd4IHC+c5o8gpmjfvThhjA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pP4CRWegSNEidyECkSm/9Noss6fmFhq/M+TTlhlJPG8YtMZIyVWP8G1wdrpf2v7i3HNKeDlqjbTBLCSdeFdjGAIgTvWzexE/o0xjuYlMmWDBN14MbbbFpislJ66122HFOghrtp7BFIesLvb6OtvH/vJ9aje0SisVDeM0mXXJR1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GWWPPEqH; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GWWPPEqH"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3FCEF1F40FA;
	Mon,  8 Apr 2024 15:12:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=kkqwHybr0Xw95CCx8PhOKSd4IHC+c5o8gpmjfv
	ThhjA=; b=GWWPPEqH6lSL2R1YDP6Ml+tt3uhkdwmlFl6NpqVQcIbFw+qit0q/Fw
	ouQ8ZU44q2LKrpQBT+jC+gvb38LAeo4QevtcOo58z35GjxdZAuIJp+dFwLJkDaMT
	q74RbNRLRDDhcfG1hKd3leX4In5mWbReMT7+iQDpQP2aZDfqf4JfU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 36E1B1F40F9;
	Mon,  8 Apr 2024 15:12:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9A3091F40F8;
	Mon,  8 Apr 2024 15:12:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Han-Wen
 Nienhuys <hanwenn@gmail.com>,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v6 0/3] reftable/stack: use geometric table compaction
In-Reply-To: <ZhQZaI3JcShhYwXn@tanuki> (Patrick Steinhardt's message of "Mon,
	8 Apr 2024 18:20:56 +0200")
References: <pull.1683.v5.git.1712255369.gitgitgadget@gmail.com>
	<pull.1683.v6.git.1712593016.gitgitgadget@gmail.com>
	<ZhQZaI3JcShhYwXn@tanuki>
Date: Mon, 08 Apr 2024 12:12:19 -0700
Message-ID: <xmqqmsq3bre4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EC51EEF2-F5DB-11EE-BE41-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Apr 08, 2024 at 04:16:52PM +0000, Justin Tobler via GitGitGadget wrote:
>> Hello again,
>> 
>> This is the sixth version my patch series that refactors the reftable
>> compaction strategy to instead follow a geometric sequence. Changes compared
>> to v5:
>> 
>>  * Reworded commit message to more clearly explain that the already existing
>>    configuration to disable auto-compaction is being exposed to callers of
>>    the library.
>>  * Simplified expression to set the disable_auto_compact configuration.
>> 
>> Thanks for taking a look!
>
> Thanks, this version looks good to me!

Will queue.  I'll mark it for 'next' after I take a brief look for
myself.

Thanks, both.  
