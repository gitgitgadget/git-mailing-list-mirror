Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C9F4EB55
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 15:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718380483; cv=none; b=BQ9v5ZHkGnzaA28KUMK/JDH7JY/Hkaoml1ZAxWwf0cREJAtRklCqblLkGe3d4TjMOj7lvK3U4D1W3p5qkkh6M+oJ/jstbN1EdNPONDWx4DmuNdKeueMMRsc5c3UyF2P5FthCw+DanKFzl+sYrjPiMpRizdyYcaXWLBc2KBgPiYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718380483; c=relaxed/simple;
	bh=siBIy+EVAx9oQ8dEu+Dcx/BiFcAN7/ol3lbzZ3sNaF8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bwk/uHnoUVVGquqgnefSEVVQyf6RS8lmu3e2EUZIeExKQIzgIsvWpsLIcNHS3yOsXXzbI3tAqLnByrqd+0J5+tv8sIfGKdG+CpAdTq0rx3szFJXsLSmrTy1ax85FcFSvmVv42eSpPhwfXEmq1+pgSjF2TlPHh4E3PKICvibOfkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=B76mNwd4; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="B76mNwd4"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 947691F2D8;
	Fri, 14 Jun 2024 11:54:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=siBIy+EVAx9oQ8dEu+Dcx/BiFcAN7/ol3lbzZ3
	sNaF8=; b=B76mNwd4UUsl5TpISI5IZiFI2a1WjNCjuz9+ehOsWpk9qNyFxDUdew
	RR/jCTgFPz/KDRX5rdv7lPmeatphobCcWFMOftWp5ZJbH0rAfrDOgUZSZSPtBtMR
	3M9k3s7+Jqnc12jsUGvz8MIDcFirqcrOsFmLuhz1VbNjpwFKDCX1Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8C90C1F2D7;
	Fri, 14 Jun 2024 11:54:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C01511F2D4;
	Fri, 14 Jun 2024 11:54:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,  git@vger.kernel.org,
  Ghanshyam Thakkar <shyamthakkar001@gmail.com>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 00/20] Introduce `USE_THE_REPOSITORY_VARIABLE` macro
In-Reply-To: <ZmvVBwLEb0qofY2m@tanuki> (Patrick Steinhardt's message of "Fri,
	14 Jun 2024 07:28:39 +0200")
References: <cover.1718106284.git.ps@pks.im> <cover.1718259125.git.ps@pks.im>
	<xmqqcyoklo26.fsf@gitster.g> <xmqqfrtgk7ah.fsf@gitster.g>
	<b69449d0-46f4-448e-b80e-002a8b5c4e1f@ramsayjones.plus.com>
	<CAPc5daUpzc+FDTH4-ajjf6ctnchE5Z6mHVvpm0qnbPLup18ykg@mail.gmail.com>
	<9d085d3f-5fdf-4a28-b31c-458ba68ebcd4@ramsayjones.plus.com>
	<xmqqfrtgjs3f.fsf@gitster.g> <ZmvVBwLEb0qofY2m@tanuki>
Date: Fri, 14 Jun 2024 08:54:30 -0700
Message-ID: <xmqq5xubikp5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 639CB064-2A66-11EF-A5AD-C38742FD603B-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> > But that does beg the question - why is repository.c not
>> > defining the USE_THE_REPOSITORY_VARIABLE?
>> 
>> I think the goal of the series is to eventually get to the point
>> where nobody uses the_repository variable.  If repository.c, which
>> consists of a set of service routines that work on a repository
>> instance, defined it, showing willingness to implicitly rely on
>> the_repository through things like get_oid_hex() (which would rely
>> on the_repository->hash_algo), that would go the opposite direction,
>> so everything, other than the definition of the_repository variable
>> itself that allows other files that still do rely implicitly on the
>> variable to link with it, in repository.c would actively want to
>> refuse to use services only available to those who define USE_THE_*
>> macro.
>
> Exactly, that's why it doesn't declare `USE_THE_REPOSITORY_VARIABLE`.
> The macro doesn't only guard use of `the_repository`, but does also
> guards other functions that implicitly relies on it, and we do not want
> to use these in "repository.c". So even though the added `extern`
> declaration is somewhat ugly, I think it is preferable over defining the
> macro.

Slightly off-topic, but in retrospect, the approach of marking "this
file is done" taken by the very initial version of the "no more
implicit access to the_index" series may have been easier to grok
easier to grok for reviewers casually looking at it from the
sideline, than marking "this file still needs work".  When we
gradually deprecated the convenience API that implicitly access
the_index instance, we marked with NO_THE_INDEX_COMPATIBILITY_MACROS
the files that no longer require it (in other words, we are done
with the file wrt the transition).  We later flipped the polarity
and gave USE_THE_INDEX_COMPATIBILITY_MACROS to those that are not
marked with NO_THE_INDEX_COMPATIBILITY_MACROS as we progressed and
the source files that still used the convenience API has become
minorities.

Anyway, I think now people understood what this series aims to
achieve and how it does so, hopefully.

Thanks.

