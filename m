Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544E6D52A
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718386813; cv=none; b=YNNJfCXTdyQC/BKNIPtfyI+Drr6sBv4LHFMFUcOCAwj2GRI6fnWgPTdh+i31/YclOXOjRX+ll4NRM+QaaX3fET9vT0N/jDDxK2EJSus5Ndd1SP8jlFYNNgQI4rneTSu4DlD1p8CFHmdIzlG/MG8Cd9TCcizfH9gw9HKW5WwWWmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718386813; c=relaxed/simple;
	bh=mM2UEAwsVle7/JyVHUk31UeRzfIP5xZRQXpp2PXRRvk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MuW2uxyaWAyZtINge1AyfJP617svDgj1H+Udha7bmmN5wUwFAdK13Ds6inVknVQptaC2o6oWIPtRBKvECwB7W5nI93P9Zat+WH9Dkm3qzjU+28hZHy/Ty1v6Ztn4D5l6cPhsuTwjT+LeG+2nb7OgzEungd/UDndWOhb6Nr6u1Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uu6LyGgg; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uu6LyGgg"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A8C061FD94;
	Fri, 14 Jun 2024 13:40:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=mM2UEAwsVle7/JyVHUk31UeRzfIP5xZRQXpp2P
	XRRvk=; b=uu6LyGggX/jOIhGaelsC7eFjRWxjpDnkyF+iI33n4tm+Z0Ypi3AG8t
	k4RT3/9FBpBcaxSST9BOKBY35+YvhHRkobELng4vho+ph36vju9+pXbJ477q1Aao
	MfkPKUEo/uJ390icZFadtXsQEBpY5JEMMZATbAyfl6aSXiCDVYXc8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A0E3B1FD91;
	Fri, 14 Jun 2024 13:40:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CA1E71FD90;
	Fri, 14 Jun 2024 13:40:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [GSoC][PATCH v4 0/7] t: port reftable/pq_test.c to the unit
 testing framework
In-Reply-To: <20240614095136.12052-1-chandrapratap3519@gmail.com> (Chandra
	Pratap's message of "Fri, 14 Jun 2024 15:18:00 +0530")
References: <20240611083157.9876-1-chandrapratap3519@gmail.com>
	<20240614095136.12052-1-chandrapratap3519@gmail.com>
Date: Fri, 14 Jun 2024 10:40:06 -0700
Message-ID: <xmqqo783fmo9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 242FA7A6-2A75-11EF-B12E-C38742FD603B-77302942!pb-smtp20.pobox.com

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> In the recent codebase update (commit 8bf6fbd, 2023-12-09), a new unit
> testing framework written entirely in C was introduced to the Git project
> aimed at simplifying testing and reducing test run times.
> Currently, tests for the reftable refs-backend are performed by a custom
> testing framework defined by reftable/test_framework.{c, h}. Port
> reftable/pq_test.c to the unit testing framework and improve upon
> the ported test.
>
> The first two patches in the series are preparatory cleanup, the third patch
> moves the test to the unit testing framework, and the rest of the patches
> improve upon the ported test.
>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
>
> ---
> Changes in v4:
> - Add a commit message for the second patch
>
> CI/PR for v4: https://github.com/gitgitgadget/git/pull/1745

Hmph.

A larger question is how pristine we want to keep the "imported
source" that is reftable/* stuff.

Obviously we are getting rid of some parts of it (like pq_test.c
here) so our "fork" will no longer be usable, without pulling some
of the stuff our project offers from outside that directory, by
outside people.  This concern is shared with other topics we saw
recently to move the unit tests bundled with the reftable library to
t/unit-tests/.

But this series brings in another twist that makes it a larger
question.  If we are willing to butcher our copy of reftable library
to a shape that cannot be reused by outside folks, do we still want
to use reftable/pq.c instead of getting rid of it and use the other
prio queue implementation we use elsewhere in our system?  If that
will be the longer term direction we want to go, then porting the
unit tests for reftable/pq.c may end up being a wasted effort.

So, I dunno.

> Chandra Pratap(7):
> reftable: remove unncessary curly braces in reftable/pq.c
> reftable: change the type of array indices to 'size_t' in
> t: move reftable/pq_test.c to the unit testing framework
> t-reftable-pq: make merged_iter_pqueue_check() static
> t-reftable-pq: make merged_iter_pqueue_check() callable
> t-reftable-pq: add test for index based comparison
> t-reftable-pq: add tests for merged_iter_pqueue_top()
>
> Makefile                     |   2 +-
> reftable/pq.c                |  29 +++--------
> reftable/pq.h                |   1 -
> reftable/pq_test.c           |  74 ----------------------------
> t/helper/test-reftable.c     |   1 -
> t/unit-tests/t-reftable-pq.c | 155 +++++++++++++++++++++++++++++++++++++++++++++
> 6 files changed, 166 insertions(+), 96 deletions(-)
>
> Range-diff against v3:
> 1:  3c333e7770 ! 1:  1873fb02ce reftable: change the type of array indices to 'size_t' in reftable/pq.c
>     @@ Metadata
>       ## Commit message ##
>          reftable: change the type of array indices to 'size_t' in reftable/pq.c
>      
>     +    The variables 'i', 'j', 'k' and 'min' are used as indices for
>     +    'pq->heap', which is an array. Additionally, 'pq->len' is of
>     +    type 'size_t' and is often used to assign values to these
>     +    variables. Hence, change the type of these variables from 'int'
>     +    to 'size_t'.
>     +
>          Mentored-by: Patrick Steinhardt <ps@pks.im>
>          Mentored-by: Christian Couder <chriscool@tuxfamily.org>
>          Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> 2:  bf547f705a = 2:  3cccf8266a t: move reftable/pq_test.c to the unit testing framework
> 3:  7dd3a2b27f = 3:  4b63849694 t-reftable-pq: make merged_iter_pqueue_check() static
> 4:  c803e7adfc = 4:  3698a7189f t-reftable-pq: make merged_iter_pqueue_check() callable by reference
> 5:  0b03f3567d = 5:  d58c8f709e t-reftable-pq: add test for index based comparison
> 6:  0cdfa6221e = 6:  69521f0ff7 t-reftable-pq: add tests for merged_iter_pqueue_top()
