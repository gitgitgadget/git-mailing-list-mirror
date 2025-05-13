Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AD51C84CE
	for <git@vger.kernel.org>; Tue, 13 May 2025 19:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747164462; cv=none; b=WEO8pLAM6UWJwjc4tINJw0TgGvXvyRANDRLWUrJkTcH9PGG5kDfWTzBI5Z+63m+HbnL6/tl0MGWK0j9w5etwm5PEVv0dhT2vfS+Hi+vfuvXlYupXp+2ijjiQ7Ul4n4HrwEfUl9jz4xrBk21TMf9AsqLhK6T4Qj7w56Spjd0tvmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747164462; c=relaxed/simple;
	bh=ZCVa0vUJzdMWRvgDDrNgtAkUpGkPKfHEQkYmvJnYYGY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tK/U7p11xt68OGPm6GpXWIuvzIUWlqQHCu3WTllYIg8iUoG4ocbZ0P6eQhE4HCECrzAbc4fiJtUbAenUuBr7d6AL32iW3fFfvMuoZ39h+2luu50SKRx4ee6nYNULCogsrBvz8ns54q4tLdUdTOH3eEA2JEZAR/4W/P8tNuc2hTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=twH/8J7P; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="twH/8J7P"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1747164454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZCVa0vUJzdMWRvgDDrNgtAkUpGkPKfHEQkYmvJnYYGY=;
	b=twH/8J7PskBiKq4pg4/EdZfFnIQkKQYzocxskuI8xYgp5X0peqCGcc1rO+VT4TI+Irl1FS
	vY+0UijpA8zg1/X4GDW8rftWBAqCIW2PUOWI3KX5epMAsGoS7IAEQysMxs4+D+IKx1N9u3
	nld/SfaOUu3wuIyO29BdhUZFt+AUBnA=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/17] object-store: rename `raw_object_store` to
 `object_database`
In-Reply-To: <20250509-pks-object-store-wo-the-repository-v2-1-103f59bf8e28@pks.im>
References: <20250509-pks-object-store-wo-the-repository-v2-0-103f59bf8e28@pks.im>
 <20250509-pks-object-store-wo-the-repository-v2-1-103f59bf8e28@pks.im>
Date: Tue, 13 May 2025 21:27:20 +0200
Message-ID: <87cyccjopz.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> The `raw_object_store` structure is the central entry point for reading
> and writing objects in a repository. The main purpose of this structure
> is to manage object directories and provide an interface to access and
> write objects in those object directories.
>
> Right now, many of the functions associated with the raw object store
> implicitly rely on `the_repository` to get access to its `objects`
> pointer, which is the `raw_object_store`. As we want to generally get
> rid of using `the_repository` across our codebase we will have to
> convert this implicit dependency on this global variable into an
> explicit parameter.
>
> This conversion can be done by simply passing in an explicit pointer to
> a repository and then using its `->objects` pointer. But there is a
> second effort underway, which is to make the object subsystem more
> selfcontained so that we can eventually have pluggale object backends.

Tiniest nit, but worth mentioning in case of a reroll:

s/pluggale/pluggable/

--
Toon
