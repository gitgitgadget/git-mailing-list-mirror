Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65DD1B815
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 18:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724349669; cv=none; b=paQPGiWtCQ9rK5XWjqAPf6fm94mhn3MwG1ux5IP+OOjENFJavZWsYFBuzR8G54jyQdBcPhLrpWLTMOTCO3Ajo9RodfVguBSU2d0oCFzn6h5AamJXv/OvXO/v/iAJcAM/PJAkv/bjJ4EXhTTaOnX9ZBnfECDlJMq1JmO1byTy5q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724349669; c=relaxed/simple;
	bh=cni1eFNALHNAosuV8f2iWMsDYfgA+JPms8UEaGoc2I0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QN9pkl2TQAcQvsp4tKKnXabMN/0ugSM5ALOmVJoSFw7ShU2rE+02YttcTrwZfamV9qmQ7HIEwDo/y/PtKg9708qhFQ2yNui01yGpHB57a4sSmshSx1YoIkZN+jVnfyCBYCBdbcf+p3LIS/Wcx7+dDHBxzR5ZwR6wrG3er5rsd1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LjnvwPOU; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LjnvwPOU"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 248BD1A7B8;
	Thu, 22 Aug 2024 14:01:07 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=cni1eFNALHNAosuV8f2iWMsDYfgA+JPms8UEaG
	oc2I0=; b=LjnvwPOUIH1bJsXV3P8rvANZFvPjOMZHRhVSzHlfZRgjRsquKl6eg/
	/vV7g9SNL6QQCcfm5Brgalq4+DYdFwLgyHjQ6bpTWkVQLH12AGzI1o44qi+OvKKL
	ZfrTlqkKg/5gJ4E1TELBTbuXiXieZKjK6KST65Ri1TZGOWmNtKo7o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1B4161A7B7;
	Thu, 22 Aug 2024 14:01:07 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6C3581A7B6;
	Thu, 22 Aug 2024 14:01:03 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,  git@vger.kernel.org,
  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [GSoC][PATCH v3 00/11] t: port reftable/block_test.c to the
 unit testing framework
In-Reply-To: <ZsbdFU9aBQvqE3pb@tanuki> (Patrick Steinhardt's message of "Thu,
	22 Aug 2024 08:39:17 +0200")
References: <20240816175414.5169-1-chandrapratap3519@gmail.com>
	<20240821124150.4463-1-chandrapratap3519@gmail.com>
	<ZsbdFU9aBQvqE3pb@tanuki>
Date: Thu, 22 Aug 2024 11:01:01 -0700
Message-ID: <xmqqwmk8qvxe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7F186164-60B0-11EF-B7D4-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> - Use block_source_from_strbuf() instead of malloc_block_source()
>>   in log, obj, and index block tests (patches 9, 10, 11).
>> - Remove a line that causes a memory leak in obj test (patch 10).
>
> This addresses all comments I had on the preceding version and
> plugs the memory leak. So this looks good to me, thanks!

Thanks, both.  Let me mark it for 'next', then.
