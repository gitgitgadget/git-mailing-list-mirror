Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72F5159217
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 15:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722872966; cv=none; b=Ib1uu7rSc73l84euYNGDFjnrC4FftMh4+Gwc7pTRDIo4r1SqMnrLTqlq08Xhgmi3d5YB4JN0jiCnAAuCdQDzbWnPrf9uRAHGeu8bueK0FwGbb3mkEuNF9dDAdflkF1yq9y52m8Aqfh9wDQggHbEB8LHr5ll5t4y6u/2boZ1cIy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722872966; c=relaxed/simple;
	bh=H7mQVvfd1ZJbABCLbJqqJrkm9EPs0dfLPCCA5Th8Gh0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iB8YcINeU3iATZkKp2QfyDCpjjFTlSCFoGcx3Uoab2YvCTMGy5dO8kicQIK3oYkQLuxGj401t7iDhdBSJLt2RRyWxILIbB7LZqFzjOVUvYaOdN8TgEKMf5zxnUQIyu1riTjRAyrZAsbAPFPMsc/6yQyKMp4aLO68W1lIaEkbuj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QsUyK56Y; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QsUyK56Y"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6AFBC359EE;
	Mon,  5 Aug 2024 11:49:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=H7mQVvfd1ZJbABCLbJqqJrkm9EPs0dfLPCCA5T
	h8Gh0=; b=QsUyK56YshaLwHyNQDUnAa5gQtfH2Og0SK5nmwyjj6Srz7Ra6f9GLF
	Tt8Q3I8T/PFKlI6FIotxu3mvVwCtTnlAzyQCicVgysWfeip2J8c7c6I8MGIfKSqq
	V2tWfkGpB/446SXq4+sS5trdomiikPEqM1lmBzdAPzm5Hqp+pXByc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6285D359ED;
	Mon,  5 Aug 2024 11:49:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B892B359EC;
	Mon,  5 Aug 2024 11:49:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  git@vger.kernel.org,  "W. Michael Petullo"
 <mike@flyn.org>
Subject: Re: Git clone reads safe.directory differently?
In-Reply-To: <20240805094709.GA632664@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 5 Aug 2024 05:47:09 -0400")
References: <20240728224807.GA1299337@coredump.intra.peff.net>
	<ZqjQi6i2kiY4gcc1@imp.flyn.org>
	<Zqlo-i8uCb1Yr4Jm@tapette.crustytoothpaste.net>
	<xmqqv80m8pha.fsf@gitster.g>
	<ZqlxtGIyz0G9jlJr@tapette.crustytoothpaste.net>
	<20240731072832.GB595974@coredump.intra.peff.net>
	<xmqqo76d7coa.fsf@gitster.g> <xmqq1q391afc.fsf@gitster.g>
	<20240801061417.GD621899@coredump.intra.peff.net>
	<Zqv9b_B5wKGp331o@tapette.crustytoothpaste.net>
	<20240805094709.GA632664@coredump.intra.peff.net>
Date: Mon, 05 Aug 2024 08:49:21 -0700
Message-ID: <xmqqzfpr3r7i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 48E5FFD2-5342-11EF-BF74-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> I suspect it could be made to give similar guarantees, but I don't think
> anybody has ever made a conscious effort.

I also recall that we thought upload-pack was safe because it does
nothing more than what it was asked to do, until we realized that in
a lazy clone it would slurp what it is missing from its promisors,
at which point it does more than just "serve things from here".

What worries me more is the fact that any such evaluation can only
be about the current state.  A careless change to say pack-objects
that allows innocent looking customization to take place _could_
turn out to be triggerable by the repository when upload-pack is
run, and the "innocent looking" customization may be more generic
than necessary and can be used creatively to cause damage.  "Don't
allow any customizations to 'rev-list' because its internal is
shared with 'pack-objects' that in turn is run from 'upload-pack'"
would not be an answer.

It is unclear to me how to make sure such an evaluation, that was
done once in the past, will stay valid.  That is something we need
to come up with a viable approach and document, too.

Thanks.
