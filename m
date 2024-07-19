Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C8010E6
	for <git@vger.kernel.org>; Fri, 19 Jul 2024 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721401423; cv=none; b=qJw9OA6WAX33xk4ocE8dEXIVlUAdkhY6ZPu4o/vO2cC96ADkG13iTaTwExiQrhj/hMxuuiobnlsaTKS6Pmij9r2ynZ2qzkHqYf0bw0CvuEbZwqLGzkyaX3bi1Z1pOoEs8+K5f5VQ4ZW1pvRiB9mQnu+2vjXxQT98Wur1aAJyQmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721401423; c=relaxed/simple;
	bh=CXOVzqhFXA4m1qjuZW62Pkd7kAU+xqMH2xNAfl7xlW8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jk4Kv4vX/JEuRKmYwa7El9aOrSDsZRzcTBW9ZxtcC4UgQO27JDXi+pIb+/Eqr/w82I6AUeth6f12zuUGXfZRAnqHMMIZHMau3t17IqvjY7O157+25dznQhHX0st70YaeSjyllOb//mDLP5dpCaZTP8ci7qkEkiCSIpRty98QBkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pGHMeYXL; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pGHMeYXL"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BEE801C7D3;
	Fri, 19 Jul 2024 11:03:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=CXOVzqhFXA4m1qjuZW62Pkd7kAU+xqMH2xNAfl
	7xlW8=; b=pGHMeYXLraZZwYe4k1mv2C7u8ZodlN1ld0D3YiPFkHt0R4VQSDW5QM
	wM3eLo9iducRjjQbc5pyG5EdsfGZ6gVYq6rLo+689wCvpSTjQODSrbA4KoSFrcu1
	01VRIDdez/YRcm/3RjjMBS6yNTWoeWxf4xov93tzYEXUm0hEv339o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B65451C7D2;
	Fri, 19 Jul 2024 11:03:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C7E2F1C7CF;
	Fri, 19 Jul 2024 11:03:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: chriscool@tuxfamily.org,  git@vger.kernel.org,  jltobler@gmail.com,
  phillip.wood123@gmail.com
Subject: Re: [PATCH v5 5/6] check-whitespace: detect if no base_commit is
 provided
In-Reply-To: <CAOLa=ZQhcb7O4i9E=Xn+9ZbaNhiY0gzD_a2kTqriegF2o-Eeyw@mail.gmail.com>
	(Karthik Nayak's message of "Fri, 19 Jul 2024 01:33:21 -0700")
References: <20240715093047.49321-1-karthik.188@gmail.com>
	<20240718081605.452366-1-karthik.188@gmail.com>
	<20240718081605.452366-6-karthik.188@gmail.com>
	<xmqqfrs6ycc3.fsf@gitster.g>
	<CAOLa=ZQhcb7O4i9E=Xn+9ZbaNhiY0gzD_a2kTqriegF2o-Eeyw@mail.gmail.com>
Date: Fri, 19 Jul 2024 08:03:35 -0700
Message-ID: <xmqqbk2tl8zc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 13C35922-45E0-11EF-8AB5-9625FCCAB05B-77302942!pb-smtp21.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> Thanks Junio for explaining with examples, really nice of you! I'm on
> the fence with this, even the existing change from the previous more
> verbose code. I know this is shorter, but it is always more readable to
> use the longer version with 'test'. I find it hard to remember the
> specifics.

You'd never remember unless you practice, but it boils down to one
question: is it reasonable to expect that most developers who need
to touch this code find it worth to learn to read and write shell
scripts well in this day and age?  The answer is probably no.

As you may remember, this R=${A-${B?}} dance started at

  https://lore.kernel.org/git/xmqqwmlpb8er.fsf@gitster.g/

where I said:

    ...
    in a separate "after the dust settles" clean-up #leftoverbits topic.

    We could replace the first 7 lines with a single-liner

       R=${CI_MERGE_REQUEST_TARGET_BRANCH_SHA-${CI_MERGE_REQUEST_DIFF_BASE_SHA?}}

    if we wanted to, but all of that will be mere clean-up changes.

Even the longhand to set a single R with if/elif cascade so that we
can have a single location that invokes ci/run-style-check.sh was
considered extra clean-up for #leftoverbits at least by me.

But after seeing you used the ${A-${B?}} dance, which is more
advanced than the #leftoverbits clean-up, I thought you were
interested in using such a construct that pursues parameter
expansion mastery, and that was the primary reason why the
demonstration in the message you are responding to was added.

I personally do not care too deeply which one to use wrt the
readability, but

	R=${A-${B?}}
	if test -z "$R"
	then
		error
	fi

looks strange and inconsistent by spreading the error check to two
places.  The code would be better off if it were

	R=${A-$B}
	if test -z "$R"
	then
		error
	fi

(or with R=${A:-$B}) instead.  Then it makes it clear that the
author wanted to take care of the error case with the if part.
