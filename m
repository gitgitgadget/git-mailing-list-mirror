Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE269137C33
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 18:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717438308; cv=none; b=KTnEaWXZ4Qp3bfZGIhZ2xlrEbOzymR36TuxyWsGCBdCWIlG/IAIuFxGnspc4f+HC1QlCsR/loCvNM3joRfaBy/FTgsx+kq/TnK57Tnu9PM92+DRFofzthBdmS4T8qDgqOU4eaY3yEu42S5LIXs0OQVv6XCSBRiP4T4YXp/FwedQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717438308; c=relaxed/simple;
	bh=vzymfkRjdNQw0bfk0dvsHJL8zUFT264QwTvKttUrkVw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W+shlOA7kgwOVc4AuLs61m0kjBOvjX0564BJE4lAM2t92/ntIBPKRQu/ycVBCT2cVrvZgHxUzx0Sf9ZC+qXGiOXI9IxdZY1da7bbKLS7sT1QJckvA4c6TU04hwV2z1dcIx7JYXKbxHJubzOAm16In99mc5nI9ZdZGVW7TxhpY3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Boq6duat; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Boq6duat"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C5A2734647;
	Mon,  3 Jun 2024 14:11:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=vzymfkRjdNQw0bfk0dvsHJL8zUFT264QwTvKtt
	UrkVw=; b=Boq6duatqyTYbYVxybTP15ciNYbJzNRFV2mSz+N3PK3XINPtuJi5s4
	VgA+nbyVNxO+nHBgxAM9na3P2MCpaJWnM2+z+QUtFoSQ7ajSC4yOAcQcbxZqCQBB
	uq0iGfBuN3qY6PFuaS0oVMEQpQZC3TNQ3zHeGi8ZvpzfQP1wtUF4g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BD5A734646;
	Mon,  3 Jun 2024 14:11:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2D7A834645;
	Mon,  3 Jun 2024 14:11:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 05/27] refspec: remove global tag refspec structure
In-Reply-To: <db4d0620146fdf7acd59c649d93c0da68289a3d7.1717402403.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 3 Jun 2024 11:39:20 +0200")
References: <cover.1716983704.git.ps@pks.im> <cover.1717402403.git.ps@pks.im>
	<db4d0620146fdf7acd59c649d93c0da68289a3d7.1717402403.git.ps@pks.im>
Date: Mon, 03 Jun 2024 11:11:44 -0700
Message-ID: <xmqqikyp3nhb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BC8F2C96-21D4-11EF-A74B-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> We have a global tag refspec structure that is used by both git-clone(1)
> and git-fetch(1). Initialization fo the structure will break once we

"fo" -> "of".

> enable `-Wwrite-strings`, even though the breakage is harmless. While we
> could just add casts, the structure isn't really required in the first
> place as we can simply initialize the structures at the respective
> callsites.
>
> Refactor the code accordingly.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/clone.c |  8 ++++++--
>  builtin/fetch.c | 11 ++++++++---
>  refspec.c       | 13 -------------
>  refspec.h       |  1 -
>  4 files changed, 14 insertions(+), 19 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 92ab7d7165..bde1d284a2 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -523,6 +523,9 @@ static struct ref *wanted_peer_refs(const struct ref *refs,
>  	struct ref *head = copy_ref(find_ref_by_name(refs, "HEAD"));
>  	struct ref *local_refs = head;
>  	struct ref **tail = head ? &head->next : &local_refs;
> +	struct refspec_item tag_refspec;
> +
> +	refspec_item_init(&tag_refspec, TAG_REFSPEC, 0);
>  
>  	if (option_single_branch) {
>  		struct ref *remote_head = NULL;
> @@ -545,7 +548,7 @@ static struct ref *wanted_peer_refs(const struct ref *refs,
>  					      &tail, 0);
>  
>  			/* if --branch=tag, pull the requested tag explicitly */
> -			get_fetch_map(remote_head, tag_refspec, &tail, 0);
> +			get_fetch_map(remote_head, &tag_refspec, &tail, 0);
>  		}
>  		free_refs(remote_head);
>  	} else {
> @@ -555,8 +558,9 @@ static struct ref *wanted_peer_refs(const struct ref *refs,
>  	}
>  
>  	if (!option_mirror && !option_single_branch && !option_no_tags)
> -		get_fetch_map(refs, tag_refspec, &tail, 0);
> +		get_fetch_map(refs, &tag_refspec, &tail, 0);
>  
> +	refspec_item_clear(&tag_refspec);
>  	return local_refs;
>  }
>  
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 75255dc600..06b60867f5 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -582,11 +582,16 @@ static struct ref *get_ref_map(struct remote *remote,
>  		}
>  	}
>  
> -	if (tags == TAGS_SET)
> +	if (tags == TAGS_SET) {
> +		struct refspec_item tag_refspec;
> +
>  		/* also fetch all tags */
> -		get_fetch_map(remote_refs, tag_refspec, &tail, 0);
> -	else if (tags == TAGS_DEFAULT && *autotags)
> +		refspec_item_init(&tag_refspec, TAG_REFSPEC, 0);
> +		get_fetch_map(remote_refs, &tag_refspec, &tail, 0);
> +		refspec_item_clear(&tag_refspec);
> +	} else if (tags == TAGS_DEFAULT && *autotags) {
>  		find_non_local_tags(remote_refs, NULL, &ref_map, &tail);
> +	}
>  
>  	/* Now append any refs to be updated opportunistically: */
>  	*tail = orefs;
> diff --git a/refspec.c b/refspec.c
> index d60932f4de..1df5de6c2f 100644
> --- a/refspec.c
> +++ b/refspec.c
> @@ -7,19 +7,6 @@
>  #include "refspec.h"
>  #include "strbuf.h"
>  
> -static struct refspec_item s_tag_refspec = {
> -	.force = 0,
> -	.pattern = 1,
> -	.matching = 0,
> -	.exact_sha1 = 0,
> -	.negative = 0,
> -	.src = "refs/tags/*",
> -	.dst = "refs/tags/*",
> -};
> -
> -/* See TAG_REFSPEC for the string version */
> -const struct refspec_item *tag_refspec = &s_tag_refspec;
> -
>  /*
>   * Parses the provided refspec 'refspec' and populates the refspec_item 'item'.
>   * Returns 1 if successful and 0 if the refspec is invalid.
> diff --git a/refspec.h b/refspec.h
> index 8c0c446993..754be45cee 100644
> --- a/refspec.h
> +++ b/refspec.h
> @@ -2,7 +2,6 @@
>  #define REFSPEC_H
>  
>  #define TAG_REFSPEC "refs/tags/*:refs/tags/*"
> -extern const struct refspec_item *tag_refspec;
>  
>  /**
>   * A struct refspec_item holds the parsed interpretation of a refspec.  If it
