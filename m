Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D171D498B9
	for <git@vger.kernel.org>; Mon, 18 Dec 2023 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z6tRuGyB"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A56CF1E152;
	Mon, 18 Dec 2023 11:26:45 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=CWQ/FMQVoJsuLy439WKgOMgVEOsNu18fYVtHrr
	+iwKY=; b=Z6tRuGyBDV8ffCWAW3GbuhNk8V3T1QUzkUmZvNnm0Lx36d8cKoIepn
	P021bhZrZgzVkctLabd8g7qRsxok2LTd8dzubPzCdbgLAeGrHVqCtvjcHDgop+At
	4UCrYBoRGtQa6WF/9lQbprKnE1qKqL9UhPls57CLKDd6BA22oyJRc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9D1AE1E151;
	Mon, 18 Dec 2023 11:26:45 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D2F8F1E150;
	Mon, 18 Dec 2023 11:26:41 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/5] git.txt: HEAD is not that special
In-Reply-To: <ZYAGyLH4nm4TebA_@tanuki> (Patrick Steinhardt's message of "Mon,
	18 Dec 2023 09:46:00 +0100")
References: <20231215203245.3622299-1-gitster@pobox.com>
	<20231215203245.3622299-2-gitster@pobox.com> <ZYAGyLH4nm4TebA_@tanuki>
Date: Mon, 18 Dec 2023 08:26:40 -0800
Message-ID: <xmqqplz3h3y7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3A15F132-9DC2-11EE-B6EB-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>>  Named pointers called refs mark interesting points in history.  A ref
>> -may contain the SHA-1 name of an object or the name of another ref.  Refs
>> -with names beginning `ref/head/` contain the SHA-1 name of the most
>> +may contain the SHA-1 name of an object or the name of another ref (the
>> +latter is called a "symbolic ref").
>
> On a tangent: While we have a name for symbolic refs, do we also have a
> name for non-symbolic refs? I often use the term "direct ref" to clearly
> distinguish them from symbolic refs, but it's of course not defined in
> our glossary.

You may find me saying "normal ref", "regular ref", or somesuch when
it is not clear from the context if you dig the list archive.
"direct" is a nice word, especially it would give us a good pair of
terms if we are to change "symbolic" to "indirect", but since we are
not going to do so, I am not sure the contrast between "direct" and
"symbolic" would make such a good pair.

But quite honestly I rarely felt a need for a specific term, as it
is fairly clear from the context, e.g.

 * "From a ref, we locate an object using the object name it
   records and use the object"

   A statement written from the point of view of the consumer of
   object name, it does not matter if the object name is directly
   found in the ref, or indirection is involved to find such a
   concrete ref that records an object name by following the
   original symbolic ref.

 * "A ref usually stores an object name, but it can also be a
   symbolic ref that points at another ref, in which case, asking
   what object such a symbolic ref points at would yield the object
   the other ref points at".

So I dunno.

>> +Refs with names beginning `ref/head/` contain the SHA-1 name of the most
>>  recent commit (or "head") of a branch under development.  SHA-1 names of
>> -tags of interest are stored under `ref/tags/`.  A special ref named
>> +tags of interest are stored under `ref/tags/`.  A symbolic ref named
>>  `HEAD` contains the name of the currently checked-out branch.
>
> I was briefly wondering whether we also want to replace SHA-1 with
> "object hash" while at it, but it's certainly out of the scope of this
> patch series.

Yup, there still are too many reference to SHA-1 (and "sha1", which
is even worse), and it is not a focus of this series.

Thanks.
