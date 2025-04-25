Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076801DED69
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 11:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745580277; cv=none; b=GYCYtxupdPQkD+Ke8Kb66bsYWUAxCxOZPT4qFWKQjVl4xdthFdUeqYzepGN0hHZsUi3sIAY51aleZU7BpnpBLXPUFXG/5hx73ayOYjgj+is0NQi8akxZTc8wXWVbsok4rkRpv/hCC88g3bEEWclfEKppKiNqEJpu0i8xVaYhKgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745580277; c=relaxed/simple;
	bh=4CRHdde4CQh/hjpGkww87eLAEGCuVMWVH4TDEqF97IE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cttK/rbIa6xlaRZXxGsbe1AwaDrnvFpveUaGMf07SfgOwmSgThf0hCLMm9mZAYGGLNFEtTwicAtKE6B5fq3fxeRH7KahBBNuHzGHsN2MHm5RkP69FUYbHzw4hTAQFdlUTutvOD8KGklRpKQYWHyHKB1bO1on46MWCvccWSloWlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=s6sASzYU; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="s6sASzYU"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1745580270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZZc6iD0t7RSdHOItOd4Ot4OdZZ4uyRLcoSmVbxuVJQw=;
	b=s6sASzYUPZJFumqxLMglt3zOcF+ahlYFttC+g/dueCbYFvMPxB96EVqezrVVfRyVnrF6ta
	xOBfUbhiXCB/0EtR7Xijc9U13x2hBk812Hx8EDg9izGlRC2uDdKOYyzbLtVkPic0SCC0wx
	dhvsRVZNpNo3pz5MGm393MeppgeOIr8=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Peter Seiderer <ps.report@gmx.net>, Junio C Hamano <gitster@pobox.com>,
 Eli Schwartz <eschwartz@gentoo.org>, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 0/2] meson: prefer '/bin/sh' over PATH lookup
In-Reply-To: <20250425-pks-meson-posix-shell-v2-0-fddc6123511b@pks.im>
References: <20250424-pks-meson-posix-shell-v1-0-45e06ee4b6ad@pks.im>
 <20250425-pks-meson-posix-shell-v2-0-fddc6123511b@pks.im>
Date: Fri, 25 Apr 2025 13:24:19 +0200
Message-ID: <871ptgfpr0.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> at GitLab, we recently got a couple of bug reports about Git not being
> able to find its shell anymore. The root cause is that with Meson we
> have started to look up the shell via PATH, which may exist on the build
> host, but not on the target host. We have worked around this issue with
> a cross file:
>
>     $ cat >cross.ini <<-EOF
>     [binaries]
>     sh = '/bin/sh'
>     EOF
>     $ meson setup build --cross-file=./cross.ini
>
> But this made me remember the report from Peter [1] that Debian also
> faced this issue. So I decided to address the issue in Meson directly by
> preferring `/bin/sh` over a PATH-based lookup.
>
> Changes in v2:
>   - Simplify how we generate the summary.
>   - Add a comment to explain ordering of the program path.
>   - Link to v1: https://lore.kernel.org/r/20250424-pks-meson-posix-shell-v1-0-45e06ee4b6ad@pks.im
>
> Thanks!
>
> Patrick

Reviewed and looks good to me. It behaves as explained, although I don't
know how to easily test the original error we've been seeing.

-- 
Toon
