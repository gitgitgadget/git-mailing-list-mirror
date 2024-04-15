Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92AA84A4E
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 17:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713202649; cv=none; b=t9IX5ZqaxuL0/7ns2Lb+ZOx/I6AzMu9eqpbckYPw2EwmyMRpaErWlnyoO3nn7mQoWraweyQKn/pobewxegIx3Siq1zUP0r6jHoPkqq0hdzbdOCdoTzreMUFSqCLFXn5fnYy+VtcIUuCZORK0ZLn46yvie1dujapmkDMU5PBamPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713202649; c=relaxed/simple;
	bh=9XM3EjtAspmU2ki1VkPIzLHv4w4d+R8q08MVHPHPwG4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nEzRLKuW7xnDBCloXG9kcvq4fTZU225gkHusraae9bN+fOau+2rmWG8kl/f2syOiF7gq4kepVAxalSmL7Bwe5rTlo5O+Mhel7IWefm62RFfn+wgzTTXQfUZyBIRNzF01TqydVkA3Mf1qP/FTf0FGpdtKZYEdwyOOSs2upcqq6j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xISQsN2x; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xISQsN2x"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E8C321FBDED;
	Mon, 15 Apr 2024 13:37:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=9XM3EjtAspmU2ki1VkPIzLHv4w4d+R8q08MVHP
	HPwG4=; b=xISQsN2xBFAWRiNU1eFzynQYxjdpiKwuEF0UTV1OehOPst9NN4K873
	ORu9idXHCaGzU2iVyMfEpdUBAbyV/+kTnHvx4IKL+Yj4OSZT/YtkzV2UZl69oD5U
	oIEyHURksjd9yAfDVzuy7YMQo7tENQNh9Sc0urk9qpL/zzpBJWAyg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E04A71FBDEC;
	Mon, 15 Apr 2024 13:37:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4C7981FBDEB;
	Mon, 15 Apr 2024 13:37:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2024, #05; Fri, 12)
In-Reply-To: <ZhzV38Ga1Lg99bUF@tanuki> (Patrick Steinhardt's message of "Mon,
	15 Apr 2024 09:23:11 +0200")
References: <xmqqfrvqhwlg.fsf@gitster.g> <ZhzV38Ga1Lg99bUF@tanuki>
Date: Mon, 15 Apr 2024 10:37:25 -0700
Message-ID: <xmqqpluqo7ca.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D322417A-FB4E-11EE-B61C-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> * ps/reftable-block-iteration-optim (2024-03-27) 9 commits
>>  - reftable/block: reuse `zstream` state on inflation
>>  - reftable/block: open-code call to `uncompress2()`
>>  - reftable/block: reuse uncompressed blocks
>>  - reftable/reader: iterate to next block in place
>>  - reftable/block: move ownership of block reader into `struct table_iter`
>>  - reftable/block: introduce `block_reader_release()`
>>  - reftable/block: better grouping of functions
>>  - reftable/block: merge `block_iter_seek()` and `block_reader_seek()`
>>  - reftable/block: rename `block_reader_start()`
>> 
>>  The code to iterate over reftable blocks has seen some optimization
>>  to reduce memory allocation and deallocation.
>> 
>>  Needs review.
>>  source: <cover.1711519925.git.ps@pks.im>

The above refers to v1; as ps/reftable-binsearch-updates, which v2
added as its dependency, has been merged to 'master', let me pick
that one up.

Thanks.
