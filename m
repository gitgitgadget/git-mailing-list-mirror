Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E37158DD2
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722873194; cv=none; b=h47010Jjj3SxaH8sHT8OoDbTFSmKGxufWZwNc7z3aisdhS4woetE+i4HdzUHn3gi8+GWFrNCvnGbZjyMLgH7lRDTwdgb3qKLJsRv+7461K22zZ89SG0D78pXGeeGBr8P7e8yHFUDkzgq8RNbEeklvaXOi5nAXhWOboZV8lh8hdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722873194; c=relaxed/simple;
	bh=CVywrS8rJugyJTgiHYCGauQ4ktERtsLoBE83KsIVp8o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q9oy3LE2GluFx0flPx/vv8ODvvDDyHDDsbBf0VYm7UeDjNwf+RLfDrWQkTXnCGk8ZoQLvQJiqf2T5+fy1umuac2t45x2jtOuR0h+AWdD+GAzWmBFh2rqoPYB4iFO1ZtG+4rdgz5p1Sp9p2lFxp3YFDK9PRzrdwHd1xOceF5wtQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VyFCNrF6; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VyFCNrF6"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A05C35A98;
	Mon,  5 Aug 2024 11:53:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=CVywrS8rJugyJTgiHYCGauQ4ktERtsLoBE83Ks
	IVp8o=; b=VyFCNrF6xqyLECpe7jtYp9YcFbPEjQ1PQlNgwZJEztuyQqxroKDRZ6
	gOXQO9gtBnAOwi0Luht/Y+CyA2LdNGOt1vt5vwLhN/+OEDl0VNdaQJLhZyp1Aiyi
	Ns5c4YPKlipX15FH8tMsBUMjBo1QtrChBa6Rl8pz14rajIiLJ04yE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 82DCA35A97;
	Mon,  5 Aug 2024 11:53:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E968635A96;
	Mon,  5 Aug 2024 11:53:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,  git@vger.kernel.org,
  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [GSoC][PATCH v7 0/5] t: port reftable/tree_test.c to the unit
 testing framework
In-Reply-To: <ZrCx0NWRbFOOReki@tanuki> (Patrick Steinhardt's message of "Mon,
	5 Aug 2024 13:04:48 +0200")
References: <20240802121318.4583-1-chandrapratap3519@gmail.com>
	<20240804141105.4268-1-chandrapratap3519@gmail.com>
	<ZrCx0NWRbFOOReki@tanuki>
Date: Mon, 05 Aug 2024 08:53:09 -0700
Message-ID: <xmqqr0b33r16.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D0EA4532-5342-11EF-8901-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Sun, Aug 04, 2024 at 07:36:44PM +0530, Chandra Pratap wrote:
>> The reftable library comes with self tests, which are exercised
>> as part of the usual end-to-end tests and are designed to
>> observe the end-user visible effects of Git commands. What it
>> exercises, however, is a better match for the unit-testing
>> framework, merged at 8bf6fbd0 (Merge branch 'js/doc-unit-tests',
>> 2023-12-09), which is designed to observe how low level
>> implementation details, at the level of sequences of individual
>> function calls, behave.
>> 
>> Hence, port reftable/tree_test.c to the unit testing framework and
>> improve upon the ported test. The first patch in the series is
>> preparatory cleanup, the second patch moves the test to the unit
>> testing framework, and the rest of the patches improve upon the
>> ported test.
>> 
>> Mentored-by: Patrick Steinhardt <ps@pks.im>
>> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
>> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
>
> Only a single change compared to v6, addressing the only feedback on
> that version. So this looks good to me, thanks!

FWIW, I didn't have other feedback not because I found the rest
perfect, but because I didn't read the series myself carefully,
hoping others are sharing the burden.

Thanks.
