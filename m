Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531B7181CE0
	for <git@vger.kernel.org>; Wed, 29 May 2024 17:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717004872; cv=none; b=JCp7pylo2JaVaTFyC7l+ujeFPXbFZzV36QSdKkh9TVxHfpJiEW9DX4lcg4NySWwLuHMh2Sp+KIp1YmAFcfmh9ujnVXa0Vh/KPcFPS/FBWr+MtG09YfGry397NpWQh/tUfmMJeNwilnWP7we77RQuzlUZkHOg1nO0cQu5RdMjumg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717004872; c=relaxed/simple;
	bh=6OptR92XBeLUNW0fmgXbDyTIhUM+9iS9hs93gjEtsSI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sY+/9419DI8WAIfkXqzolr1F4Uo8inK1wSSGUgGCMVA4E/qIL9WZzJVdxJjj7BjjkYPoVmZXgtCJ7lmb0E1HL9oFyXsTDIvvcl6/632UYmuIUuYYacsGrIK93BMnW1dACkwDxqol0tlrvuzTHcR3j1d7EgL7M5PYfsjnqd1JdB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=btQUj6ew; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="btQUj6ew"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BABF32ADA3;
	Wed, 29 May 2024 13:47:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=6OptR92XBeLUNW0fmgXbDyTIhUM+9iS9hs93gj
	EtsSI=; b=btQUj6ewAPaxgEovaVisSNRJUcBYzGb9vBqb96mBynd/Qb/NEeOno5
	8aYP1OBkWuL4V2P3jeWBcGGZ2/71Uo8lXFsh59+cCK8uRyVgfE901yC1F8OnEoeW
	2IB4ap68m3TDDMvhYi94Ae1PNCKQhhtzp2NSfS4zNFuIbeNE6URyc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B3E362ADA2;
	Wed, 29 May 2024 13:47:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BF12B2ADA1;
	Wed, 29 May 2024 13:47:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 06/19] refspec: remove global tag refspec structure
In-Reply-To: <0eaa73c109198b332e348921bc0a0dc49c687f98.1716983704.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 29 May 2024 14:44:30 +0200")
References: <cover.1716983704.git.ps@pks.im>
	<0eaa73c109198b332e348921bc0a0dc49c687f98.1716983704.git.ps@pks.im>
Date: Wed, 29 May 2024 10:47:45 -0700
Message-ID: <xmqqa5k8y0fy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8FBBA220-1DE3-11EF-A1B5-ACC938F0AE34-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> +	refspec_item_init(&tag_refspec, TAG_REFSPEC, 0);
> ...
> -static struct refspec_item s_tag_refspec = {
> -	.force = 0,
> -	.pattern = 1,
> -	.matching = 0,
> -	.exact_sha1 = 0,
> -	.negative = 0,
> -	.src = "refs/tags/*",
> -	.dst = "refs/tags/*",
> -};

Regardless of the constness issue, replacing these hardcoded
initializer values that is an accident waiting to happen with a call
to refspec_item_init() is very much welcomed.

Unless parse_refspec() is an immensely high cost operation, which it
isn't.
