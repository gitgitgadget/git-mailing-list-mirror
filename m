Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0C41CFEC1
	for <git@vger.kernel.org>; Sat, 14 Sep 2024 17:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726334240; cv=none; b=X/2+nJZzRYXe6/ucwCOhJ5Q/+p3Ksld9eh5t3QBA7MmKB41iz9dncMAzZqu7IpyqewV+sbGjBj/h5QlK37FBksiT6z6cBom4ks8UT33FjBy2dqWcnwJHM8DaRyVDWOtYZJwXnvDN+kI+MCa75rSYRFI64+v61zMoHT0YF9mAMXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726334240; c=relaxed/simple;
	bh=m8utrwKuKpvjDfJCbLFo5RQ8MkNDbvnbFnLi377iitA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=btXYct1ulBZTUMaPhWDdqS5/7y3WSbgAMD5ewuieBPYwccUAIbtBocvK6pQ6hgchM08yFdRE/r3fvu1yi08R1pLsi/IwPfzwyBoIc8rIHqXf/0j+dFQdMBUixN/K+U8L58ka4HuieWtMV+jqAICOspbo7oDWW17VXbtjLyswoik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Cmyy8b1f; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Cmyy8b1f"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CE85B190E4;
	Sat, 14 Sep 2024 13:17:17 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=m8utrwKuKpvjDfJCbLFo5RQ8MkNDbvnbFnLi37
	7iitA=; b=Cmyy8b1fq9UUOC4A4T7b81uPjNRfWpF6sOrC3W6y6giVF9XYlfRlCX
	d6F+ey6fCT2bKuk6GOGnDPF/0I6FDqLCIGMv/d0M2+ruAgitgC6cxnx3FF3LC1wL
	co0PlyxgLK3Ana3WDTy5A91EeLlroO4I1tsvCWV71SxQD+erDQDIM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C6816190E3;
	Sat, 14 Sep 2024 13:17:17 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 42F95190E2;
	Sat, 14 Sep 2024 13:17:17 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci(linux32): make Javascript Actions work in x86 mode
In-Reply-To: <20240914072932.GB1284567@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 14 Sep 2024 03:29:32 -0400")
References: <pull.1790.git.1726274559928.gitgitgadget@gmail.com>
	<20240914072932.GB1284567@coredump.intra.peff.net>
Date: Sat, 14 Sep 2024 10:17:16 -0700
Message-ID: <xmqq34m2tasj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3146C63C-72BD-11EF-95A9-9B0F950A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> I'm not totally opposed to this direction, but I'm a little concerned
> about the stability/maintenance of the solution. In particular:
>
>> +        NODE_URL=https://unofficial-builds.nodejs.org/download/release/v20.17.0/node-v20.17.0-linux-x86.tar.gz &&
> ...
>> +        curl -Lo /tmp/node.tar.gz $NODE_URL &&
>> +        tar -C /__e/node20 -x --strip-components=1 -f /tmp/node.tar.gz
>
> This is pretty intimate with how Actions work (both the node20 version
> and the "/__e/" magic). It's hard to say if/when that would bite us.

Thanks for clearly expressing the uneasiness I felt, which I could
not turn into concrete words, when I saw the patch first time.

Each of these approaches may have its pros and cons, but I somehow
do not see that the newly proposed alternative is 10x better than
what was reviewed and queued already to be worth the effort to
replace it.

Thanks, both.

