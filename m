Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A04E13A869
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723047009; cv=none; b=giBhPSMeEPT4Z5a2zr+7dXLkvPg2c0mWO39n7SU0/Bhefsz8Rey1PzWhbGIgtBvxblInAEvpOMGyq0S6c1SAJCcI3e17+tFR7jTi9HV1hHC6OBkqzO6W6OIC5Boxq8YqtraPRWpT7ulWEokwcFjicCoc9DYDGSmj8IK0w98ACAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723047009; c=relaxed/simple;
	bh=NxYuZ6EbolOrRLyDS+QlvZFUxl/KWztLO2+AgW2SSsU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LhvIE9t/6sZEtB7BldVi1S2XXAjDQkJg2cJouKrAbpzVC2TmlT1EBfv50IwriazHLAlSCjDfLuan61rh2Js+GVklOh9a+ctEUHaycRe+xLwi5LcDVdH2I7wXkA+i/rtkHiuugAqOyEdAluy93+HBRbRfVtZBSSV2NfE8JzERSOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DQ+m18UB; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DQ+m18UB"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BEEE0189DE;
	Wed,  7 Aug 2024 12:10:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=NxYuZ6EbolOrRLyDS+QlvZFUxl/KWztLO2+AgW
	2SSsU=; b=DQ+m18UBd8/iXxJvqb20zvTLjDUfIn/fMDwZWMfrKvqeg3GVmwk1Bw
	9aJBx0gnIuxeE3CAKHVhqCeZgHLrsB4xFdaJRbfoBGe17RGjs9aN5E5zrZxTWqIM
	VTeNcW91iwPIUkFP3bNFhhmekQZ8GLqRreJi7pK/n/F0t2iD73RUU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 53666189DC;
	Wed,  7 Aug 2024 12:10:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1AC9B189D9;
	Wed,  7 Aug 2024 12:10:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  Jeppe =?utf-8?Q?=C3=98land?=
 <joland@gmail.com>,  git@vger.kernel.org
Subject: Re: 2.46 submodule breakage
In-Reply-To: <ZrMkje9VugtKz-gB@tanuki> (Patrick Steinhardt's message of "Wed,
	7 Aug 2024 09:38:53 +0200")
References: <CA+osTZVApTAMogBDMaPDEVViJHrFT=BOer=Py4fjTvpsifzfKA@mail.gmail.com>
	<CA+osTZX4FBT5za3Nw2Hc=DCNNbFg=xL4b3AhNmN8S2XKb5BXUA@mail.gmail.com>
	<CAPig+cQ05ocHKELovvEhvptAn09DLuitQkdJyFQ=N5qvje-GhQ@mail.gmail.com>
	<ZrMWylPWZ8Tm5i45@tanuki> <ZrMkje9VugtKz-gB@tanuki>
Date: Wed, 07 Aug 2024 09:09:59 -0700
Message-ID: <xmqq7ccspb54.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 81283AD6-54D7-11EF-AA08-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> For the record, the fix is as simple as the below diff. We indeed end up
> initializing submodule ref stores with the parent ref storage format,
> not with the one of the subrepo. I'll spend some more time though to
> check whether other commands are impacted, as well, and write some more
> tests.

I think allowing separate ref format in submodules is a very
sensible thing to do.  The containing superproject should not even
have to know what ref backend is in use in the submodule, unlike the
object format used there, which it has to know in order to store the
name of commit objects in its tree entries as gitlinks.

And the preimage of this particular change does look wrong to
blindly reuse the format used in the superproject.

Thanks.

> diff --git a/refs.c b/refs.c
> index 915aeb4d1d..e4b1f4f8b1 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2011,7 +2011,7 @@ struct ref_store *repo_get_submodule_ref_store(struct repository *repo,
>         free(subrepo);
>         goto done;
>     }
> -	refs = ref_store_init(subrepo, the_repository->ref_storage_format,
> +	refs = ref_store_init(subrepo, subrepo->ref_storage_format,
>                   submodule_sb.buf,
>                   REF_STORE_READ | REF_STORE_ODB);
>     register_ref_store_map(&repo->submodule_ref_stores, "submodule",
