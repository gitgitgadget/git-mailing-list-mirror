Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32FB13F434
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 16:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737132062; cv=none; b=dtyEycfgNP0GTEZbOrI30ATXQ9qcLsySBuX09zA4TORHUx8Ecm8a+s6BTd/4e1HlC7eGWIndYEZIHHlnAtK5wieWnv0175fqhIL24RgTDYkRUvVser7rFB9W8FHtoWy6fbfvVkSz+CehfWlMZstO+slJI7JTtppluCOBvCrKBcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737132062; c=relaxed/simple;
	bh=EOMC7hEAhURQj7G8PYGg9Ail6U+tzCxEJ+iRpyDbGw0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bor7gevGjXY3D+PDmQtVhC+xKqTuvcShu6NEHrZqtSUrEzsTXLQ9p9IR0jqbkwnRr0c6AdCbbcgFQlQVvDEC88u4lquP/NkU8+a8h756SrHM6S78xJ7tK7na6ywkGCBqOKqkTLOsUMRGg1BxZw3bofy/MNAdAD0B6IM2dl1AG0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=Rf3emQdZ; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="Rf3emQdZ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1737132052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BU3iFUbbniBKbHY2qAVZFGOmmAr8eXG9398T0ODjm3o=;
	b=Rf3emQdZnnwGeOPbTcttje0eP1yx+iWh2Edo1mvg/AOxHezjYHxgqdvbjKGRyvj2kBKArz
	6a+QIWhpF7S8OyzWfpHHs8S2l9i7N+cZ9YSgimJWd8kp6y5ocUnHQhmYnVKFwQw8pNxwb1
	zQmgDai7hJj5eAVAkX2TsJ6wrZlhKio=
From: Toon Claes <toon@iotcl.com>
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, gitster@pobox.com
Subject: Re: [PATCH v2 3/5] pack-write: pass hash_algo to `write_idx_file()`
In-Reply-To: <20250117-kn-the-repo-cleanup-v2-3-a7fdc19688f5@gmail.com>
References: <20250117-kn-the-repo-cleanup-v2-0-a7fdc19688f5@gmail.com>
 <20250117-kn-the-repo-cleanup-v2-3-a7fdc19688f5@gmail.com>
Date: Fri, 17 Jan 2025 17:40:45 +0100
Message-ID: <87wmetieb6.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Karthik Nayak <karthik.188@gmail.com> writes:

> The `write_idx_file()` function uses the global `the_hash_algo` variable
> to access the repository's hash function. To avoid global variable
> usage, pass the hash function from the layers above.
>
> Since `stage_tmp_packfiles()` also resides in 'pack-write.c' and calls
> `write_idx_file()`, update it to accept `the_hash_algo` as a parameter
> and pass it through to the callee.

Technically speaking you're updating it to accept a `struct hash_algo`.

Besides from this nit, and the other nit I've submitted on the first
patch, these changes look good to me. I'm doubtful any of the comments
needs a reroll.

-- 
Toon
