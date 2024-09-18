Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05BE12B17C
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 19:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726688358; cv=none; b=AwLcdi64Ki9tKKFBs3sBvu0/rpI8WhKZOR0ohwAzZZKelMZeXCz5zLTnBTHCi8SGsuegCk3d3KPvBu8xzUZ/FEHwYyrxDEx3pzR7xNrTkxNLTvklKTxq0xSL/89IiDYcFkpWpcWM1taK++/vteb/xUs5gipUYR6iwikNwowg/U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726688358; c=relaxed/simple;
	bh=/Ub2an1gdjnjqo1wOcJ21ePcGCeuIEwbAP+s6YwsknA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oh1EHX8e7snjOZVWlfXAyN/rEawXU/+fWJvl65WliLbVgfwfNPa0651idCfwIB+UvHsTY6lLsv8oPAG2SgTMLsHXHcxv0O0tQk4ePmbgs4XR598dS6I8XvOQ8IklRoBkPnnmQ4XLop5yAn1FCFsrhlf8dG/4WUBXWhNQRNWxOWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=IbYWnAVW; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IbYWnAVW"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3FDCD327D4;
	Wed, 18 Sep 2024 15:39:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/Ub2an1gdjnjqo1wOcJ21ePcGCeuIEwbAP+s6Y
	wsknA=; b=IbYWnAVWK0kfgdQ+t5EbsAg3RKcqXrM0EvxkVlzudgefFvrA2ap/WO
	tdjbicfFSKm03CfjaCmn2FQSbzGKEa0TgS3KGe0R6vZnhMa9ChxWtZcEl5IB3WER
	quPHJC3/Q8udTDetFX5bnjIoqBc1nMJe2Qdj45Jz7UFNtfn9RxRRk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 37431327CF;
	Wed, 18 Sep 2024 15:39:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A3F87327CE;
	Wed, 18 Sep 2024 15:39:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v4 3/5] ref: add more strict checks for regular refs
In-Reply-To: <ZuRzxyjAI3tp4uLK@ArchLinux> (shejialuo@gmail.com's message of
	"Sat, 14 Sep 2024 01:17:59 +0800")
References: <ZuRzCyjQFilGhj8j@ArchLinux> <ZuRzxyjAI3tp4uLK@ArchLinux>
Date: Wed, 18 Sep 2024 12:39:13 -0700
Message-ID: <xmqqr09gbvku.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AFB20D84-75F5-11EF-9FA2-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

shejialuo <shejialuo@gmail.com> writes:

> +`refMissingNewline`::
> +	(INFO) A ref does not end with newline. This will be
> +	considered an error in the future.

It is ONLY files backend's loose-ref representation to store the
object name that is the value of the ref as hexadecimal text
terminated with a newline.  With packed backend, even if the file
ends with an incomplete line, it would be confusing to say that such
lack of terminating LF is associated with a particular ref.  With
reftable backend, the object name may not even be hexadecimal but
binary without any terminating LF.

At least you should say "A loose ref file that does not end with...",
because a ref NEVER ends or contains newline, and what you are
expecting to be terminated with LF is not even a ref, but the value
of it.

Also, isn't it too strong to say "will be" without giving any
further information, like:

    As valid implementations of Git never created such a loose ref
    file, it may become an error in the future.  Report to the
    git@vger.kernel.org mailing list if you see this error, as we
    need to know what tools created such a file.

or something?

The same comment applies to the next entry.

> @@ -619,6 +619,10 @@ int parse_loose_ref_contents(const struct git_hash_algo *algop,
>  		*failure_errno = EINVAL;
>  		return -1;
>  	}
> +
> +	if (trailing)
> +		*trailing = p;
> +
>  	return 0;

In the pre-context of this hunk, if parse_oid_hex_algoph() failed to
recognise the initial segment of buf as a valid hexadecimal object
name, it would have already returned, so we know 'p' is always valid
here.  It is the byte that comes immediately after the hexadecimal
object name.

OK.

>  	if (parse_loose_ref_contents(ref_store->repo->hash_algo,
>  				     ref_content.buf, &oid, &referent,
> -				     &type, &failure_errno)) {
> +				     &type, &trailing, &failure_errno)) {
>  		ret = fsck_report_ref(o, &report,
>  				      FSCK_MSG_BAD_REF_CONTENT,
>  				      "invalid ref content");
>  		goto cleanup;
>  	}
>  
> +	if (!(type & REF_ISSYMREF)) {

Just like we punted for S_ISLNK() in an earlier step, we for now
deal with regular refs in this step.  OK.

> +		if (!*trailing) {
> +			ret = fsck_report_ref(o, &report,
> +					      FSCK_MSG_REF_MISSING_NEWLINE,
> +					      "missing newline");
> +			goto cleanup;
> +		}
> +
> +		if (*trailing != '\n' || *(trailing + 1)) {
> +			ret = fsck_report_ref(o, &report,
> +					      FSCK_MSG_TRAILING_REF_CONTENT,
> +					      "trailing garbage in ref");
> +			goto cleanup;
> +		}

Not limited to this patch, but isn't fsck_report_ref() misdesigned,
or is it just they are used poorly in these patches?  In these two
callsites, the message string parameter does not give any more
information than what the FSCK_MSG_* enum gives.

In fact, MSG_REF_MISSING_NEWLINE at least says that the complaint is
about refs, but "missing newline" does not even say from what the
newline is missing.  For TRAILING_REF_CONTENT, people may expect to
see what garbage follows the expected contents, but that information
(i.e. contents of *trailing) is lost here.
