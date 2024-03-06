Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FE11C28F
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 23:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709769148; cv=none; b=OBfS20KcO5InxA8sqFMmjGug98evGaAz23ictC5H2nw9b3vhUcin6/caElOUutCs7PxiQdiMkEhUw2BwaHpS8LVYgmdmdiGmODvJffR3N4Za7N3mAHeOLFmoRowSPRMs1k0L6ht6stEG7kGl4wxkmvGzcIMllVLIJAQ1jTXwY1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709769148; c=relaxed/simple;
	bh=opdclPBNna53mckK4KNh2xYGU6iwVJAVSixApmaR6ec=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WrQg52d4VtSJ645cIH79GO6sia46TzbF/6MsCwo5nTvkOFBsGVxTHl5P56Gho0mv4EQmRAFSoISQvBcMZw/YKW/li1TG7biRQ9hqOm/vOEPA0bzlEcuG2bMgCi7Jc/KChzIDdL/pRn51XToy1RI7eZ06fEtbvHUOllinsJVhqiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=eK1gjRzi; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eK1gjRzi"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 632E11E726E;
	Wed,  6 Mar 2024 18:52:25 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=opdclPBNna53mckK4KNh2xYGU6iwVJAVSixApm
	aR6ec=; b=eK1gjRziijRbiF6NibzrfXVf2ZAXVl3SiSUx+x0PbLHK6/zNOHvBQh
	DXmPXLTlDKVCOZZfz6F144TAQ+AZV5fZVO0utQjhE0uCnDQnVKfatXiewB3PtRQ+
	E3B/1/MmZhTxqyOZITnzQcrMTatZlocXhImqvOq0O7l3+JjMTprLw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B2281E726D;
	Wed,  6 Mar 2024 18:52:25 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BEF371E726B;
	Wed,  6 Mar 2024 18:52:24 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 0/8] builtin/config: introduce subcommands
In-Reply-To: <ZekAWSqr9qb8FIAD@nand.local> (Taylor Blau's message of "Wed, 6
	Mar 2024 18:46:33 -0500")
References: <cover.1709724089.git.ps@pks.im> <xmqqil1zs327.fsf@gitster.g>
	<ZekAWSqr9qb8FIAD@nand.local>
Date: Wed, 06 Mar 2024 15:52:23 -0800
Message-ID: <xmqq1q8mq5oo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 94BD94C4-DC14-11EE-BD29-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> I don't have strong feelings about this, but I wonder if `--urlmatch`
> (or `--url-match`) might be an argument to the "get" mode of this
> sub-command instead. Something like `git config get --urlmatch` feels
> much more natural to me than `git config get-urlmatch`.

I like that, too.

"--get-regexp" may also be a good candidate to be folded into the
base verb "get", with "--regexp" option to tweak what kind of key is
used.

Could "--get-color" and "--get-colorbool" become verb "get" with
"--type=color"?  The other parameters they get are somewhat
different from "get", so that may not work very well, I guess.
