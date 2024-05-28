Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FCD32C60
	for <git@vger.kernel.org>; Tue, 28 May 2024 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716912837; cv=none; b=L5uRZdzyDgoer5ILZ7iejVDGEoT8zGM9Oo/OHj7od6NvySFZc2jhXkkIo4difz2XEiM8qQlTtkEE2sC7FGpNHp5wPVnH5R74f9DkLGwHLP/OE1r17gl4CCQEAwLiAvHQxpgtffPsnC0sk2kmMc7W6iVyVLfycWhxGFyUNk4GHHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716912837; c=relaxed/simple;
	bh=/FhTRjercefXsYDlNSdm9VUQEB1c5pVGR2pS1vlS+58=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lCeDh4d/VMQVhr5unwvk+6njCkfaBb5OT49gOoA+SlQQcZjPLSoNk3yBmRnUJImTlXKDyYlzyfEqTpIO5VCIl2kYJgqGxA3QAx3kltQ6jGsaXb9SRL4Frlf5YazmVS5cBd6wkt1c2TapPNBeVE5PSmXIbeJsvtKlR0rWzbpNjzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LSg36M/s; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LSg36M/s"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E66781A9B2;
	Tue, 28 May 2024 12:13:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/FhTRjercefXsYDlNSdm9VUQEB1c5pVGR2pS1v
	lS+58=; b=LSg36M/sIEcTWFkeZXCVp4pIwEtY6Uv9XAHmJnrhTHIgTSlTVS0Efl
	LGfVFigFsXONvAMnqLw3w4RwGEPSuuMtM69LWSf8OrxqcXCC1zc7yR4DGmWx/xUX
	MeBk/75gJpcV0wjNlTMk0HSKJUYmhmcr6auBbdczQAFI/Is8SxP38=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DE2C01A9B1;
	Tue, 28 May 2024 12:13:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 507931A9B0;
	Tue, 28 May 2024 12:13:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Joey Hess
 <id@joeyh.name>,  git@vger.kernel.org
Subject: Re: [PATCH 00/12] Fix various overly aggressive protections in
 2.45.1 and friends
In-Reply-To: <8353645a-a684-417a-8b0e-d8cbd7da6b5a@gmail.com> (Phillip Wood's
	message of "Tue, 28 May 2024 16:02:37 +0100")
References: <20240521195659.870714-1-gitster@pobox.com>
	<Zk3ChIHr5amGh8Mt@kitenet.net> <xmqqv835xekc.fsf@gitster.g>
	<Zk9vafYPijqyWpXv@kitenet.net>
	<99225123-70f0-3546-a6fa-b6d1f981b41d@gmx.de>
	<8353645a-a684-417a-8b0e-d8cbd7da6b5a@gmail.com>
Date: Tue, 28 May 2024 09:13:46 -0700
Message-ID: <xmqqr0dl7w3p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4359B466-1D0D-11EF-B9BF-25B3960A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> What checks do we have in place to prevent git checking out blobs and
> gitlinks to paths under .git/? I'd have thought we should be applying
> the same restrictions to the target of symbolic links as we do to
> those.

We do not even allow ".git" slip into the index (most likely from a
malicious tree object), so a direct "checkout" is not much of an
issue.  Of course you can introduce bugs to that regular mechanism
in the future but that is not the target for 2.45.1's check we are
going to revert.  I think what Dscho worries about in his message is
that we might by mistake write via a symbolic link in the working
tree.  If our procedure to update a checked out blob in the working
tree were open/truncate/write/close an existing file, a checkout
that switches from a version with a symbolic link at path F to a
version with a regular file at path F may end up overwriting the
target of F.  I think the idea was (Dscho can correct me if I am
misleading the log messge of a33fea08 (fsck: warn about symlink
pointing inside a gitdir, 2024-04-10)) that such a bug from
overwriting a file in our repository if we did not allow a symbolic
link F to point into our repository.
