Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034B918059
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717779118; cv=none; b=b5v6Xfxt+zw32BF2JM5T9ffxwx1vsvZRKd04dtNEKn+6jUG2N47qBEe6rCOW3RmXqbl9zKM73qvUXoB+9dDaqjcoZcAAr61V2EQYNmLfzOhhgAoPrHj2n6QVEchdmwn875nxSIEZLjM1UalULaFHx7Eodcz36XBeW6mpZsQk+9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717779118; c=relaxed/simple;
	bh=WU8lERaZfFs9j0BilVbozoBufB+1uQLp/8bYal9nBHE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QSU0vUbWp/imJa5tcoindu4BHHx0rGPYPUjTEybVl3un1/NLr4pc8Fufmx7qo769T5f2THWTBufvkdAXIWAZZrdBXO86/uodmgmdMkxs9352PqOzEzrbi+j+JtuorEm3qGgWA/I/F4xqs+/kTX7ERB3zdeSLh82LFe3IPgcL/TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OPnfcke/; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OPnfcke/"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E111A37916;
	Fri,  7 Jun 2024 12:51:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=WU8lERaZfFs9j0BilVbozoBufB+1uQLp/8bYal
	9nBHE=; b=OPnfcke/VuPb5yXzJcLgeLddJyN+GzTqmktkHmppAnJAfCpsGxcioJ
	iRWY/4jx2eBJRjSgOrns8CFWM251IZhnKWgB3wmCLcy03nOg2klWRCmi+2n/xXgu
	Bn9ndtTuHkEP5pfE8y8fS3PkGrHHdJHjgZ4Z9zxHc5gxnlIqcFlJ0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D888837915;
	Fri,  7 Jun 2024 12:51:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 516C937914;
	Fri,  7 Jun 2024 12:51:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  James Liu <james@jamesliu.io>
Subject: Re: [PATCH v2 1/4] Makefile: extract script to lint
 missing/extraneous manpages
In-Reply-To: <489a6eaf2d328044307f38ff23dd35ecc5a4c515.1717660597.git.ps@pks.im>
	(Patrick Steinhardt's message of "Thu, 6 Jun 2024 10:01:00 +0200")
References: <cover.1717564310.git.ps@pks.im> <cover.1717660597.git.ps@pks.im>
	<489a6eaf2d328044307f38ff23dd35ecc5a4c515.1717660597.git.ps@pks.im>
Date: Fri, 07 Jun 2024 09:51:54 -0700
Message-ID: <xmqqsexoelw5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3F3BF608-24EE-11EF-BF9E-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The "check-docs" target of our top-level Makefile fulfills two different
> roles. For one it runs the "lint-docs" target of the "Documentation/"
> Makefile. And second it performs some checks of whether there are any
> manpages that are missing or extraneous via some inline scripts.

Yes.

> The second set of checks feels quite misplaced in the top-level Makefile
> as it would fit in much better with our "lint-docs" target. Back when
> the checks were introduced in 8c989ec528 (Makefile: $(MAKE) check-docs,
> 2006-04-13), that target did not yet exist though.

Correct.

> Furthermore, the script makes use of several Makefile variables which
> are defined in the top-level Makefile, which makes it hard to access
> their contents from elsewhere. There is a trick though that we already
> use in "check-builtins.sh" to gain access: we can create an ad-hoc
> Makefile that has an extra target to print those variables.

Yes.

> Pull out the script into a separate "lint-manpages.sh" script by using
> that trick. Wire up that script via the "lint-docs" target. For one,
> normal shell scripts are way easier to reason about than those which are
> embedded in a Makefile. Second, it allows one to easily execute the
> script standalone without any of the other checks.

Nicely done.  We might want to stop doing "make print-man1" in the
lint script, remove "print-man1" target from Documentation/Makefile,
and instead extract MAN1_TXT using the same "it is unlikely to have
an output line enclosing something in between XXX and YYY" trick,
but it may not be worth it.

> +check_missing_docs () {
> +...
> +		git-merge-octopus) continue;;
> +		git-merge-ours) continue;;
> +		git-merge-recursive) continue;;
> +		git-merge-resolve) continue;;
> +		git-merge-subtree) continue;;
> +		git-fsck-objects) continue;;
> +		git-init-db) continue;;
> +		git-remote-*) continue;;
> +		git-stage) continue;;
> +		git-legacy-*) continue;;
> +		git-?*--?* ) continue ;;

This looks easier to maintain than the original by listing one
pattern per line.  Again, nicely done.


