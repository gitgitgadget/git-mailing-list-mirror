Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA993D0BD
	for <git@vger.kernel.org>; Tue,  7 May 2024 06:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715063128; cv=none; b=YtnJurVS7AEYEE4KnJ5zMAM5sli6jzrsqvOEiAQVPu2aMhjPRHiHnld3iJMlBbfYHIMFNBXpqoZo/Y22ns28BOh6xhtVT6R9kHdGXTR4WRqrOPCq6m48OfenQNpg85gS5zTXHFGebqVVFAyP8+eLdH+bhX++QDhiOeIx/IAnLZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715063128; c=relaxed/simple;
	bh=MFMj23a8rahxy5t/BMYgpnD2qb3qjCAUaijeDbNd+Fg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JD6Vozg9N4hzDVjcSXGf5q9DU7j6iMKUfzaRcJ2CL4E1mVDi8/v0d1kpBa9I4gp3N1OfHAHIqqIpLPBBqSjKYEZOOt49rh157BhiIjJJu8I4BJMrmILg2O0MrV1v+hYtEcmQnZ8TdjYXcYnEovc2H3/ECQI5T020pmmkXXixJ8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Mc4AO8UN; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Mc4AO8UN"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3D7822F106;
	Tue,  7 May 2024 02:25:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=MFMj23a8rahxy5t/BMYgpnD2qb3qjCAUaijeDb
	Nd+Fg=; b=Mc4AO8UNjb2gs9xgNuzFOlJGIdseqQIy5Xk6QZA3TfWXm/N6W5Uol+
	guotnHggedrCxxHgp3WtMkLae5L4cbG5RLD0svaQ3DPP4DZE4CAxGKEiycpnsHAh
	obTU2Ig5KCFYXjQmcYqsnHc1gUX6kWcGdjm5cbIDLMaMZsEQMINeU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 280C52F105;
	Tue,  7 May 2024 02:25:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 99DC32F104;
	Tue,  7 May 2024 02:25:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org,  ps@pks.im,
  phillip.wood123@gmail.com
Subject: Re: [PATCH v7 0/8] refs: add support for transactional symref updates
In-Reply-To: <20240507060035.28602-1-knayak@gitlab.com> (Karthik Nayak's
	message of "Tue, 7 May 2024 08:00:27 +0200")
References: <20240503124115.252413-1-knayak@gitlab.com>
	<20240507060035.28602-1-knayak@gitlab.com>
Date: Mon, 06 May 2024 23:25:21 -0700
Message-ID: <xmqq5xvqt9ym.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 956EC108-0C3A-11EF-9824-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> Junio, I've rebased my patches on top of, not sure if there is something else I
> missed here:
> - ps/ci-python-2-deprecation (2a686e00d2)
> - ps/reftable-write-options (f5545b173b)
> - ps/pseudo-ref-terminology (ad302a68fd)

This is a somewhat puzzling set of topics.  You are not touching
ci/lib.sh at all so I do not see the point of including the
ci-python one, for example.

