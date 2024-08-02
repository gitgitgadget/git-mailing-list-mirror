Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064011A34C0
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 17:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722619822; cv=none; b=HtqX14FyzisGbHLMHodTzqLIWDPUmLbATIazqPUngcBWvCxWps99Rsz5erDzcXMCHcH52BcWQDa9b+0s/UUqmpdVgafyA6ridW68RdcYk6X9kpoz+yoxfoVS5OQ6d9LrIi9ReL7f/lDB1omyOiQ31C7M7dHqyVcg4e2GK1R+YyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722619822; c=relaxed/simple;
	bh=KHJ5FL7AwN+EMWExtEWIrqAwOpsS1q3tq1GVwV5j15A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DNGzfBA2bsgZc1mlEbvxfwCUVcBMbHT1ZQHQ2nYIUUNlO/3aiuGPZVO228vzKz2Z4RPTLcsx91J6L5EwQC7dyrf3SIQaOi8eGlHsq/y28heKZehpdLv+57JJkz4aRWpyf3QjXMe0Ca18yIkAB0GUyypCDzS4WjAyH1i5NBKIxnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bgxP5moz; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bgxP5moz"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 786393553B;
	Fri,  2 Aug 2024 13:30:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=KHJ5FL7AwN+EMWExtEWIrqAwOpsS1q3tq1GVwV
	5j15A=; b=bgxP5moz0ho+MyD2JWGdWNpo7Y6SbsocpsNyy4pKB6r1JYz7c+TXEc
	kxzlNlWZvLsLGANrbuIT4QjbrLiBPepQghiHN41mniqguTQZmdKGMkIRSM/aGtCV
	bk2amrrwPDi5PrtOncedYROZvnEiFVppFrSpLrXq9gw7mIgrvB9ww=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 70C7C3553A;
	Fri,  2 Aug 2024 13:30:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 85C1335536;
	Fri,  2 Aug 2024 13:30:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  vdye@github.com
Subject: Re: [PATCH 0/3] git for-each-ref: is-base atom and base branches
In-Reply-To: <xmqqzfpudful.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	02 Aug 2024 09:55:30 -0700")
References: <pull.1768.git.1722550226.gitgitgadget@gmail.com>
	<xmqqmslvhmgm.fsf@gitster.g>
	<27f3de89-55b2-413d-b4b4-6b35f8c4bcc9@gmail.com>
	<xmqqzfpudful.fsf@gitster.g>
Date: Fri, 02 Aug 2024 10:30:12 -0700
Message-ID: <xmqqo76ade8r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E0CE5740-50F4-11EF-9A40-92D9AF168FA5-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

>> +is-base:<committish>::
>> +	In at most one row, `(<committish>)` will appear to indicate the ref
>> +	that minimizes the number of commits in the first-parent history of
>> +	`<committish>` and not in the first-parent history of the ref.

This was a bit too dense for me to grok.  So if I have a <commit>
that is at the tip of a branch B forked from 'master', and then
'master' advanced by a lot since the branch forked, the number this
is minimizing for 'master' is the commits on the branch B, but when
showing 'maint', then even though the branch B may have the tip of
'maint' as an ancestor, the number for 'maint' would be a lot more
than the number for 'master'.  If there were another branch C that
was forked from 'master' and shared some (or all) commits that are
near the tip of branch B, e.g.

    ---o---o---o---o---o---o---o---o---o 'master'
            \
             o---o---o---o 'C'
                      \    
                       o---o---o---o 'B'

then the number may be even smaller for branch 'C' than 'master'.

And for at most one ref, %(is-base:<commit>) becomes "(<commit>)";
for all other refs, it becomes an empty string.

OK.

> OK.  Knowing what definition you used is crucial when reading the
> implementation, as we cannot tell what you wanted to implement
> without it ;-)
>
> Thanks.
