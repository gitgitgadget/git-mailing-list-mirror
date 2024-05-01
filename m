Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282AF1C68D
	for <git@vger.kernel.org>; Wed,  1 May 2024 23:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714604735; cv=none; b=O94JEQZgJnVsPu4p5qyjCcqy85dHL2jDYhnuFb0teuvptW7DQEyzKQZiF1JoBtvT7IO8yWP3YMET7hgk9jD/C0ux0QeonwWeVXBkhwDPgtyUuHg3T1sMREYlQ65qbtKvtMTFwRGfWRMlbEz12fb4Ij74CLVtkS5jJwqo1alcqAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714604735; c=relaxed/simple;
	bh=AkKu5WbQVge+Cw+HJKkSGkEsJGj7WXAvQ5yZe3aCzq8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GWchf0LLOR9I8zc6aY3MHEUHOBASr6N7be1zzJ40F0H/Fp5w5xj74so5mtctXfrelPRzLXtYzHnvgcvyhvQqjs23ssPIgEi3RwXJs1nV/0v0BZfcgrTB9EHJLJPBhdIqZRkQx1WcMywd4+4zI/0KY/fRCSXsyFuJjA11+JxTPSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CVS3haJH; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CVS3haJH"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DE6191B918;
	Wed,  1 May 2024 19:05:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=AkKu5WbQVge+Cw+HJKkSGkEsJGj7WXAvQ5yZe3
	aCzq8=; b=CVS3haJHzeOU9/Kq5EzEYl05GYm1aStAw6WJCQkoLG4Vfn+aTTMfmQ
	TlhoYaYZLbEfSo2OvIAAwEdw4X4KqoqBWaprtuspFQZlKxsqAOV/otnmfmLbgRKB
	gpWvvC9zZqH6LI+06H1fzB3lUMHK4ex1SWY+TEK9V/JZZMJZt8gyA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D58A21B917;
	Wed,  1 May 2024 19:05:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3ECE21B916;
	Wed,  1 May 2024 19:05:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v5 3/7] refs: support symrefs in 'reference-transaction'
 hook
In-Reply-To: <20240501202229.2695774-4-knayak@gitlab.com> (Karthik Nayak's
	message of "Wed, 1 May 2024 22:22:25 +0200")
References: <20240426152449.228860-1-knayak@gitlab.com>
	<20240501202229.2695774-1-knayak@gitlab.com>
	<20240501202229.2695774-4-knayak@gitlab.com>
Date: Wed, 01 May 2024 16:05:30 -0700
Message-ID: <xmqqy18tgmkl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4EE1D632-080F-11EF-BD56-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> +		if (update->flags & REF_HAVE_OLD && update->old_target)

Although the precedence rule does not require it,

		if ((update->flags & REF_HAVE_OLD) && update_old_target)

is probably easier to read.

> +			strbuf_addf(&buf, "ref:%s ", update->old_target);
> +		else
> +			strbuf_addf(&buf, "%s ", oid_to_hex(&update->old_oid));

So the promise this code assumes is that .old_target member is
non-NULL if and only if the ref originally is a symbolic ref?

And if the "we do not care what the original value is, whether it is
a normal ref or a symbolic one" case, .old_oid would be all '\0' and
REF_HAVE_OLD bit is not set?

If we can write it like so:

	if (!(update->flags & REF_HAVE_OLD))
		strbuf_addf(&buf, "%s ", oid_to_hex(null_oid()));
	else if (update->old_target)
		strbuf_addf(&buf, "ref:%s ", update->old_target);
	else
		strbuf_addf(&buf, "ref:%s ", oid_to_hex(update->old_oid));

it may make the intent of the code a lot more clear.  If we are
operating in "!HAVE_OLD" mode, we show 0{40}.  Otherwise, old_target
is non-NULL when the thing is symbolic, and if old_target is NULL,
it is not symbolic and has its own value.

The same comment applies to the other side.

> +		if (update->flags & REF_HAVE_NEW && update->new_target)
> +			strbuf_addf(&buf, "ref:%s ", update->new_target);
> +		else
> +			strbuf_addf(&buf, "%s ", oid_to_hex(&update->new_oid));


> +		strbuf_addf(&buf, "%s\n", update->refname);
>  
>  		if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
>  			if (errno != EPIPE) {
