Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797F435966
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 10:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745976; cv=none; b=hpVXjHzk+eZi5wciaoRnJrR2fVdcnQLqbEn7E2BgxeFAz929NRNxa5t8PMbUTGpgxOyFegKD0+/xLw342cUQWs0RHObtJ5WrSmcSar2EljV+KlE9otAbezXCqlubGM5zdjI0F9UgxXmc0IogCRkhQ4Nzpx/l7lphDeFm5geycIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745976; c=relaxed/simple;
	bh=IavuU3cxmCxWubI9VRMf1gW0uJb7HFGS13qq6CJTmOM=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tZkAndvSnXbnzAPXinPAlzaZzcG80fTzNi/we/IU2AKjj0bjQhlt677LC9X21R4OSJLx4EgUzu64+6Jg/RLWAeSwjJEj5Lz9pzCjflaa5Z1kRixoRHdVvJDl/G9Tozfm46L3ZGqfYDrwqllUiHJbdlTFS5Os5iZaC/f+q/jLWNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=3ZZL86/4; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="3ZZL86/4"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1759745969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nmm33A+iskNV7gkuRBFDrO4+4aYfgdkFTSkZ4pCo8QU=;
	b=3ZZL86/4KioXxatgOJQWe3E6aBCBH9vIo7Us9ABFYXrGDuh6Xl6CNTGHEu/6zjoNTO5fIi
	1sSX6b8yx5txc2tkc9SElVTu/zGrhYZXXkWiANQZ6SsufswVtPcLj2uLw1EqKEA82ZQY8U
	U2M3GTEiLugxEu4q7j2SiDkmXBmGfPQ=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 3/5] gitlab-ci: drop workaround for Python certificate
 store on Windows
In-Reply-To: <20251002-pks-gitlab-ci-windows-improvements-v1-3-6a8b6b45d728@pks.im>
References: <20251002-pks-gitlab-ci-windows-improvements-v1-0-6a8b6b45d728@pks.im>
 <20251002-pks-gitlab-ci-windows-improvements-v1-3-6a8b6b45d728@pks.im>
Date: Mon, 06 Oct 2025 12:19:12 +0200
Message-ID: <875xcsbae7.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> On Windows, we have been running into some issues in the past where the
> certificate store for Python is broken on the GitLab CI runners using
> Windows. The consequence was that we weren't able to establish any SSL
> connections via Python, but we need that feature so that we can download
> the Meson wraps. The workaround we employed was to import certificates
> from the cURL project into the certificate store via OpenSSL.
>
> This is obviously an ugly workaround. But even more importantly, this
> workaround fails every time Chocolatey updates its OpenSSL packages. The
> problem here is that the old OpenSSL package installer will be removed
> immediately once the newer version was published, But the Chocolatey
> community repository may not yet have propagated the new version of this
> package to all of its caches. The result is that for a couple hours (or
> sometimes even one or two days) we always fail to install OpenSSL until
> the new version was propagated.
>
> Luckily though, it turns out that the workaround doesn't seem to be
> required anymore. Drop it to work around the intermittent failures and
> to clean up some now-unneeded legacy cruft.

I assume this is a result of this change:
https://gitlab.com/gitlab-org/ci-cd/shared-runners/images/gcp/windows-containers/-/merge_requests/72

Makes sense to clean this up.

-- 
Cheers,
Toon
