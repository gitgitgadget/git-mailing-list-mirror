Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C292741CD
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161171; cv=none; b=Cfvb/CULxwPYkVfUhtAEfDrnVv6A1E3UakSJu4ZCiPkTt7BwpdXgLFASBAkgu0yglWNvBDUGcvIWyaFXvehnG5fOwGNmUNR4j2u1/m1ZoUm02TrAhfIemiOQ8tHSlqZFqYP049ZuwAtrA9NZsoXpUedzZGmwP4nKUarcE7pjwYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161171; c=relaxed/simple;
	bh=PXJw4FLYEvNZOeGx0KYPOMOtl9sr+FOViGjGE2kZzBQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L2r7k4V1RRtyIk+XoeFkN32ricE7rmlBMHja/6P3+DDWkuRCw2VQvvs4dijt/2secAADMnQmD9TkCV93sC++up3f2iPZOHSp80o14qEi3isvf7hsl8sEcRG2o16bxL5DsJBr6dv6LBcvPt94k4TF2TrBuJw/bTmATPc2uJ36m0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=f9kMZEUw; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="f9kMZEUw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1752161160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v396oE8QewdTDyl1QaXJgcR4uTgRPZei7DKmY36Zuao=;
	b=f9kMZEUw0PXuN+zEp+Jj9WXxuEX5JosTuMR0ozsitxlnDK1hgEJaTJZGJOjRte7frAnRJ6
	g+nnSPG4k90ey9YlCakNj0DcC5TeVOX5rTLeey+HvRMim6xeeqVFIjz6lxAJZARnYdC0we
	Bs5ByqkbbPLkskZxrq8YQ52OGZO7Lbk=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, irecca.kun@gmail.com, Eli
 Schwartz <eschwartz@gentoo.org>, Jeff King <peff@peff.net>, Junio C Hamano
 <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 3/8] meson: improve summary of auto-detected features
In-Reply-To: <20250709-b4-pks-meson-cleanups-v3-3-29ab15b9ab85@pks.im>
References: <20250709-b4-pks-meson-cleanups-v3-0-29ab15b9ab85@pks.im>
 <20250709-b4-pks-meson-cleanups-v3-3-29ab15b9ab85@pks.im>
Date: Thu, 10 Jul 2025 17:25:49 +0200
Message-ID: <87h5zkcbk2.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> The summary of auto-detected features prints a boolean for every option
> to tell the user whether or not the feature has been auto-enabled or
> not. This summary can be improved though, as in some cases this boolean
> is derived from a dependency. So if we pass in the dependency directly,
> then Meson knows to both print a boolean and, if the dependency was
> found, it also prints a version number.
>
> Adapt the code accordingly and enable `bool_yn` so that actual booleans
> are formatted similarly to dependencies. Before this change:
>
>   Auto-detected features
>     benchmarks      : true
>     curl            : true
>     expat           : true
>     gettext         : true
>     gitweb          : true
>     iconv           : true
>     pcre2           : true
>     perl            : true
>     python          : true
>
> And after this change, we now see the version numbers as expected:
>
>   Auto-detected features
>     benchmarks      : YES
>     curl            : YES 8.14.1
>     expat           : YES 2.7.1
>     gettext         : YES
>     gitweb          : YES
>     iconv           : YES
>     pcre2           : YES 10.44
>     perl            : YES
>     python          : YES
>
> Note that this change also enables colorization of the boolean options,
> green for "YES" and red for "NO".

Nice, I'm really liking this change.

I've also reviewed the rest of the patches, and all looks good to me.

-- 
Cheers,
Toon
