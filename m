Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB5514C585
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 19:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718307529; cv=none; b=a8I/SsCiy88TOtgv6NUJ64BGVFHmUmm4tJL2ksETeM/AsU//U7VSnbnhyB3NCoVBmE+A/AOcL/Gkhlj5/bbUXKHIPMQ5EI0eH/ZO3LG339oNeptpwLWDIMeySZ763skzPUJ+Moiy7+WtGrR/dHRVltyqCZIX4VI1RsZoFhQCeHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718307529; c=relaxed/simple;
	bh=p/X9Fs0V7fa8qDau1Ngts0PYLNQj3nNVm+evc7EgXRI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hleljzPbUmwYleyss4r2fyk/c46Ca3wmfo1W1yOWDr0OMOXWxjhfpyAGd8OqZU8QQFxnU/k+8Y7wntHgMIJz0QOU5NsUsct4kFyHFPlDG9iloI13wij1qsv8BGnl0WTGhfqwhoGaj0LqJn2D9PC4OS0Q0m5ojM0WNLHPB1eT3MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rjQgQ94c; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rjQgQ94c"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1719A1B9C3;
	Thu, 13 Jun 2024 15:38:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=p/X9Fs0V7fa8qDau1Ngts0PYLNQj3nNVm+evc7
	EgXRI=; b=rjQgQ94cMpjSMz/J2GYeyjuxKuXDn4lwronChc2jfDVzrbyZerqcki
	UHWu6NH4CulTqBe88BH8chvHHoeXl1/B9zjxwbQC7v7HsRpLpBKx4azV2uRxqZ/G
	s5/PWuca+V2sDlKvOnSse2CnCHzYX9bYwb90btK/IQSrGUL2jkLs0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0E1BA1B9C2;
	Thu, 13 Jun 2024 15:38:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 735471B9C1;
	Thu, 13 Jun 2024 15:38:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC][PATCH v2 7/7] fsck: add ref content check for files backend
In-Reply-To: <20240612085349.710785-8-shejialuo@gmail.com>
	(shejialuo@gmail.com's message of "Wed, 12 Jun 2024 16:53:49 +0800")
References: <20240530122753.1114818-1-shejialuo@gmail.com>
	<20240612085349.710785-1-shejialuo@gmail.com>
	<20240612085349.710785-8-shejialuo@gmail.com>
Date: Thu, 13 Jun 2024 12:38:45 -0700
Message-ID: <xmqqr0d0iqey.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8CD1C94C-29BC-11EF-B4A3-965B910A682E-77302942!pb-smtp2.pobox.com

shejialuo <shejialuo@gmail.com> writes:

> In order to check the trailing content, add a new parameter
> "trailing" to "parse_loose_ref_contents" function.

About this one.

>  int parse_loose_ref_contents(const char *buf, struct object_id *oid,
>  			     struct strbuf *referent, unsigned int *type,
> -			     int *failure_errno)
> +			     int *failure_errno, unsigned int *trailing)
>  {
>  	const char *p;
>  	if (skip_prefix(buf, "ref:", &buf)) {
> @@ -607,6 +607,10 @@ int parse_loose_ref_contents(const char *buf, struct object_id *oid,
>  		*failure_errno = EINVAL;
>  		return -1;
>  	}
> +
> +	if (trailing && (*p != '\0' && *p != '\n'))
> +		*trailing = 1;
> +
>  	return 0;
>  }

We know what the garbage looked like at this point.  The caller owns
the "buf" pointer and we are pointing into that buffer with the
pointer p, and the garbage is right there.

So I am not sure if losing information by using "uint *" is a good
idea.  Wouldn't it make more sense to take "const char **trailing"
as a parameter and tell the caller where the trailing junk begins?

> +static int files_fsck_symref(struct fsck_refs_options *o,
> +			     struct strbuf *refname,
> +			     struct strbuf *path)

This does not take things like HEAD or refs/remotes/origin/HEAD to
validate.  Instead, the caller is responsible for either doing a
readlink on a symbolic link, or reading a textual symref and
stripping "ref: " prefix from it, before calling this function.
The "refname" parameter is not HEAD or refs/remotes/origin/HEAD but
the pointee of the symref.

So I'd imagine that renaming it to fsck_symref_target or along that
line to clarify that we are not checking the symref, but the target
of a symref, would be a good idea.

> +{
> +	struct stat st;
> +	int ret = 0;
> +
> +	if (lstat(path->buf, &st) < 0) {
> +		ret = fsck_refs_report(o, refname->buf,
> +				       FSCK_MSG_DANGLING_SYMREF,
> +				       "point to non-existent ref");
> +		goto out;
> +	}

Is that an error?  Just like being on an unborn branch is not an
error, it could be argued that a symref that points at a branch yet
to be born wouldn't be an error, either, no?

> +	if (!S_ISREG(st.st_mode) && !S_ISLNK(st.st_mode)) {
> +		ret = fsck_refs_report(o, refname->buf,
> +				       FSCK_MSG_DANGLING_SYMREF,
> +				       "point to invalid object");
> +		goto out;

The use of "object" here is highly misleading.  Yes, you can call a
filesystem entity like "a regular file", "a directory", etc. "an
object", but the word can refer to many other kinds of "object".  In
fact, I originally read this to mean "we are referring to an object
in the object database that is corrupt" or something, but of course
that is not what we are complaining about. We are complaining that
the symbolic link points at a file of wrong type (like a directory).

So, in short, missing is probably OK.  Pointing at a wrong thing
(like a directory or block device) is not.  Where, if any, do we
catch a symbolic ref that tries to escape the refs/* hierarchy
(e.g. ".git/refs/heads/my-crazy-ref" that is a symbolic link that
points at "../../../../else/where" that is not even part of the
repository), by the way?

Thanks.
