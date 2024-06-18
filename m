Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5DF1CD29
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718725352; cv=none; b=LKFn5UE2Jo1lIYDKp2egRCZXuiXiBNtnbsJoO8Ok2Op2mu8+RpdxJvzZ4rNUU0pJ8kFCtaE5CRZC1F7H2uUt+mi51MwyMG/IX5op/tXOf6gCv25HJBzQ13LbDMP7VAG7xGaz6v2hocbXvG8hvhNGhgGaw8+r6hUN0YCP+i0HcZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718725352; c=relaxed/simple;
	bh=JmJjhjr8zxxzmGSKg1sx7lnCD8zvPeWoeUsUrurn9w0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=topoZPAmLNTkD9GWtJ9myqKOaQuxpSKNHwICenlFrOboAJlefDNI5jb2fcyH6H8snfx+7g+z+y0quipBxsjxpCD00bZ07a5Yx5h5PhMMpph9jIMM3C2dvRVcZxJsivQhCkwW38vlLNJRs8Ynw8FrCZokBKA9Q0GHFgIc6Or6pR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=EvYoNRzY; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EvYoNRzY"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BBB4C2ABAF;
	Tue, 18 Jun 2024 11:42:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=JmJjhjr8zxxzmGSKg1sx7lnCD8zvPeWoeUsUru
	rn9w0=; b=EvYoNRzYEJmryoPaZMyWIcrYxy0p6qTPIK2VKZCwXp827P2DyX2Geh
	Z6ZTICHPmZmB8GaLYDzXFFv6sQbNlQNHEMXZuvth+gtYzX7vW+gRKhprCIWdEPv+
	HoTYjkC23H6nIHUvn8BoNrgdEqCG+uaS74Aggzbz2oigcquQuhWpc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B37352ABAE;
	Tue, 18 Jun 2024 11:42:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2A8C02ABAD;
	Tue, 18 Jun 2024 11:42:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC][PATCH v3 0/7] ref consistency check infra setup
In-Reply-To: <ZnFByMI1lWUDSxLd@ArchLinux> (shejialuo@gmail.com's message of
	"Tue, 18 Jun 2024 16:14:00 +0800")
References: <ZnFByMI1lWUDSxLd@ArchLinux>
Date: Tue, 18 Jun 2024 08:42:20 -0700
Message-ID: <xmqq8qz22r6r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5A61E278-2D89-11EF-A7D1-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

shejialuo <shejialuo@gmail.com> writes:

> This is the third version. Mainly focuses on the following problems:
>
> 1. Add "escape" check for symrefs and symbolic links.
> 2. Resolve the reviews.
> 3. Fix some errors in version 2.
>
> shejialuo (7):
>   fsck: add refs check interfaces to interface with fsck error levels
>   refs: set up ref consistency check infrastructure
>   builtin/refs: add verify subcommand
>   builtin/fsck: add `git-refs verify` child process
>   files-backend: add unified interface for refs scanning
>   fsck: add ref name check for files backend
>   fsck: add ref content check for files backend

What commit is this series based on?  It does not seem to apply
cleanly on top of the same base as I queued an earlier iteration of
this series (f931bfb2 (Merge branch 'ps/ref-storage-migration' into
sj/ref-fsck, 2024-06-13)), or the current tip of 'master' that
already merges that prerequisite topic.  The early 6 applies on top
of 'master' fine, but the last one.  I wiggled the last one in (the
patch to the fsck-msgids.txt documentation expects stale entries
that were already removed in 2.45.2), but if you are basing your
patches on an unusual commit, please describe it clearly here in the
cover letter so that others can locate (or recreate as needed) it.
