Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBE3384233
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 08:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780992118; cv=none; b=uUblSqO2407WacRxI3zh7g9AiuiLgQoAoV48LHNt62/oQ0VT2CEMbXrOoTy0J7yruqR3OXUzxt1VJ3RoSNmQd+EC7MIXTd+3b8C46FKsdDSQofo0vmO94vS1AV+KNcrU5jKqAk2QmAy0zNGAcCvJgqr6TMwSJiwpJRtYlZnnvWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780992118; c=relaxed/simple;
	bh=bLOTRc0ebBX7hByPp/Gx6uAUAcTQOcfOGye+x4jDjfc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j1aOzWp6uhF7mzMyYyp+i/tvdtLeefAr6jt+Zocm+clSwuy/i45gZBUJ8S7YzZqZkkgNx78G3M+EfeayvOoawThMibj5UEjow/A5oI5fM8O5YU9ApB53qWhFiy3UCQfbQvuugCgLFM3Z2J8c6PPGZxNSQdo6h99tRRZ/41o1KgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=4y9SN43d; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="4y9SN43d"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1780992107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XcqRyFHS2yyMLRqgkDxAPT4Mx8wGASHt6eCabOge9d4=;
	b=4y9SN43drsFCyvecZpPUdZMz7T/0IfKrAZstGemI3e6N97jvL0jreQuyon15rsPVIAEo9Y
	VqV2w8LO00YkWvctcWa+KDV5iwzn19Ce7GortqYLkooE9vXu9ICun9DJNVqabIQNJ0JLhT
	zcBCjQBj2EvInGT9uh0KHePLRhNOuqA=
From: Toon Claes <toon@iotcl.com>
To: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 Taylor Blau <me@ttaylorr.com>, Karthik Nayak <karthik.188@gmail.com>,
 Elijah Newren <newren@gmail.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Christian Couder
 <christian.couder@gmail.com>
Subject: Re: [PATCH v4 0/8] Auto-configure advertised remotes via URL allowlist
In-Reply-To: <20260527140820.1438165-1-christian.couder@gmail.com>
References: <20260519153808.494105-1-christian.couder@gmail.com>
 <20260527140820.1438165-1-christian.couder@gmail.com>
Date: Tue, 09 Jun 2026 10:01:35 +0200
Message-ID: <87ik7s16sg.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

_(resend because it seems I accidentally didn't reply-all)_

Christian Couder <christian.couder@gmail.com> writes:

> Changes compared to v3
> ======================
>
> Thanks to Toon, Kristoffer, Patrick and Junio for reviewing the
> previous versions of this series and of the preparatory series.
>
> This has been rebased onto master @ 56a4f3c3a2 (The 8th batch,
> 2026-05-25) to avoid a trivial conflict in "urlmatch.c".
>
> Only minor changes have been made since v3, in the following patches:
>
>  - Patch 4/8 ("promisor-remote: add 'local_name' to 'struct
>    promisor_info'"):
>
>    - The promisor_info_internal_name() function has been renamed
>      promisor_info_local_name() for clarity.
>
>    - A `const char *local` local variable has been renamed
>      `remote_name` for consistency with another similar variable.

I can really appreciate these two changes. Both make things more
consistent and cleaner.

>  - Patch 6/8 ("promisor-remote: trust known remotes matching
>    acceptFromServerUrl"):

I previously reviewed v2 and compared to that I like the changes you've
made toward being clear about precedence. And this consistency carries
through in PATCH 7/8.

And thanks for mentioning username and password components are ignored
intentionally.

But I previously mentioned I felt the naming of 'acceptFromServer' and
'acceptFromServerUrl' are a bit confusing. So I'm wondering whether we
can consider another proposal:

What if 'acceptFromServer' would configure if 'acceptFromServerUrl'
should be used? I mean, imagine we put this in the config:

    [promisor]
        acceptFromServer = Match
        acceptFromServerUrl = https://my-org.com/*

(we can still argue over naming, but to get the idea)

So the value "Match" for 'acceptFromServer' would inform Git to use
'acceptFromServerUrl'. This way precedence isn't a concern no more,
because every value for 'acceptFromServer' is mutually exclusive.

This has one downside though, you can no longer combine
acceptFromServer=KnownUrl with a 'acceptFromServerUrl'. So URLs
advertised by the server can no longer fall-through to
'acceptFromServer' if they don't match 'acceptFromServerUrl'. You can
argue whether that's a good thing or not.

What do you think? If you disagree, I'm fine with the current approach
and I think this version looks good.

-- 
Cheers,
Toon
