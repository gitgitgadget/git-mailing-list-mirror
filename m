Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA381F1302
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 13:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764162702; cv=none; b=m8vzLLYOxZNdwcu7P86UoyKZSVBPvFOcT9JFoZYX4ayb46NX8QpS7g90ko61vyTeP2NO4Ee9hnX3/XzU4/acysHpyLMyU2lBL28EqaWWXIdSY9vTtjMVi8VGxK2ql4zdXnOD/V8baPOJa6s60GbF53M1iG46qbYQmen4YcR343s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764162702; c=relaxed/simple;
	bh=YvmDUeKljiezc3Q0SZcNtNxe4NRc4J02RNP2wva418A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pjQowCmuM94H0dXYhisYiqaBZaRK6KiuzqYZ2N1jI1KOq+QOYfK6VegWxilvNwq91cVmPapA0n3UZ6gslVabJN+E17PwaV2lHPKWC9tZBv+3b/y6GwHOcSSiz4pvnaBQW3gGP1SPTbfavS56fLcme8J0QxhK4uxhr/ZmQy20qGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=X5AvBsZY; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="X5AvBsZY"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1764162695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wf4jFqK8t53U0Fv+qwYeofLn2XJ7LVULSIMrj4q08yE=;
	b=X5AvBsZYrQCTLrWZMHdtiwCH0mG7n1ESDb9bsOHMMIhHn7W6NRMJw/NYL1bYSaUxyFLx57
	9/HI1TkrM+8BRAlOJziPGndL5LL20FRYxXB0hedqTnAY58c0yPZkWpjxgUbXt4tO+UOOHe
	HBzXvdci2DfPgpvRD9l7oCGb5sOgkf4=
From: Toon Claes <toon@iotcl.com>
To: Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 2/2] refs: add GIT_REF_URI to specify reference backend
 and directory
In-Reply-To: <CAOLa=ZTn5UEqifJrJcVfCt=YyVOa3CMdLRsLpG=g4x2vmDPeKQ@mail.gmail.com>
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
 <20251119-kn-alternate-ref-dir-v1-2-4cf4a94c8bed@gmail.com>
 <87pl9b5wos.fsf@iotcl.com> <xmqq34675pz1.fsf@gitster.g>
 <CAOLa=ZTn5UEqifJrJcVfCt=YyVOa3CMdLRsLpG=g4x2vmDPeKQ@mail.gmail.com>
Date: Wed, 26 Nov 2025 14:11:23 +0100
Message-ID: <87see1vszo.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Karthik Nayak <karthik.188@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Toon Claes <toon@iotcl.com> writes:
>>
>>>>     <ref_backend>://<path>
>>>
>>> I like this idea. This would allow us in the future to also do something
>>> like:
>>>
>>>     reftable+nfs://10.11.12.13/ref-dir
>>
>> I actually thought from Karthik's definition that what you are
>> trying to say is spelled more like this:
>>
>>     reftable://nfs://10.11.12.13/ref-dir

LOL, I didn't realize since 07c7782cc8 (Disown ssh+git and git+ssh,
2016-02-15) 'ssh+git' isn't actually mentioned no more.

>> IOW, the underlying URI to "reach the resource" is in the <path>
>> part (i.e., "nfs://<addr>/<directory>").  And I found it somewhat a
>> strange syntax, because the "to reach the resource, visit this" URI
>> may not necessarily look like <path>, and I also wondered if
>> spelling it like <ref_backend>:<URI-for-resource> is more
>> appropriate.
>
> This is a much better way to state what I was going for, I was
> considering the entire <ref_backend>:<path> as the URI since currently
> we only deal with FS paths (for files and reftable). But that could
> potentially change. As such, it makes sense to state it as
> <ref_backend>:<URI-for-resource>. Will modify accordingly.

I don't really care on the format, as long as we're consistent. I know
Patrick is working on pluggable object databases and also there he's
suggesting to do `<backend_type>://<URI>` which might also lead to
double `://` use. But I guess that's still subjected to change.

That said. Should we change the current proposal of
`<ref_backend>://<path>` to `<ref_backend>:file://<path>`? Or can we
simply assume the latter implied from the former?


-- 
Cheers,
Toon
