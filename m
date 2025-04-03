Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C3A1A9B2B
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 20:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743712283; cv=none; b=lClOjKhuGsGo9BUPn32NR7RuFAqT/2KeodX9YCgSnSQN0pWiXDqZVFrvMU8C6KLIpmIpZoLSTQgNTMpLbsO0WULcVxXANVekouJTQ2vUp9w8h/QzRUPffPzirBlXP4zY3mKtOT3DhiSNur5+GVvlt13SHTKsJ6m9+4CNMMY1Wns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743712283; c=relaxed/simple;
	bh=gcJ6S21gn0hbmfCCTjHFYSa41jjIbTmatMYWcfSKqRo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=E5J1PJRalsc2WmjWv48oeK4F+ovtlN6sSCwj3BI9YZ6UpeyTVYVVVw/mjPt5vyxhc8PoV+VFpJiZvULdVKDOxzUcdgZ1FgT0/maxKG4DJ68ellyVlrL6QVGfFux3U4OldkTTFFW4hQke/3/q54SjpyP3VkNvmMDoF12I81xY41U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev; spf=pass smtp.mailfrom=buenzli.dev; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buenzli.dev
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ZTD0H5XdRz9t4t;
	Thu,  3 Apr 2025 22:31:11 +0200 (CEST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Apr 2025 22:31:08 +0200
Message-Id: <D8XAETM3PJ4A.1RBPVHJWE9DFT@buenzli.dev>
Cc: "Martin von Zweigbergk" <martinvonz@google.com>, "Git Mailing List"
 <git@vger.kernel.org>, "Edwin Kempin" <ekempin@google.com>, "Scott Chacon"
 <scott@gitbutler.com>, "philipmetzger@bluewin.ch"
 <philipmetzger@bluewin.ch>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
From: "Remo Senekowitsch" <remo@buenzli.dev>
To: "Theodore Ts'o" <tytso@mit.edu>, "Elijah Newren" <newren@gmail.com>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com> <CABPp-BFRz-yjnti4W17AEBozb0v52kmNsgTLUZW6-MF34R-xdw@mail.gmail.com> <20250403174847.GB3051250@mit.edu>
In-Reply-To: <20250403174847.GB3051250@mit.edu>
X-Rspamd-Queue-Id: 4ZTD0H5XdRz9t4t

On Thu Apr 3, 2025 at 7:48 PM CEST, Theodore Ts'o wrote:
> On Thu, Apr 03, 2025 at 08:39:31AM -0700, Elijah Newren wrote:
>>=20
>> But <change ID> isn't unique, right?  The whole point of having the
>> change ID is to preserve it despite edits (e.g. rebase, commit
>> --amend, cherry-pick), meaning that you end up with multiple commits
>> with the same <change ID>.
>
> It's supposed to be unique, but it isn't always.  I've certainly seen
> cases where it might not be, but that's arguably a bug.  I suspect in
> some cases it's because users are cutting and pasting commit
> descriptions, and sometimes when they rebase a patch series, patches
> will get collapsed or split apart --- especially when backporting to
> an older LTS release.
>
> Perhaps because of this, in some communities, their tooling in front
> of Gerrit will always regenerate the Commit-ID when doing a
> cherry-pick (For example, when cherry-picking from the development
> HEAD branch back to a release branch).
>
> So as a cauaionary note, as people use Change ID's in Gerrit today,
> sometimes the Change ID changes between rebases, and I've certainly
> seen cases where the sematic meaning of the commit has changed
> significantly without changing the Change ID.  So it's great as a
> hint, but in practice, at least today, it might not be completely safe
> to assume the semantics are as advertised....

That is all true. I would just say that some change-ids not being unique
doesn't systematically take away from the benefits. If a given change-id
is unique, you get all the benefits for that patch, independent of
the uniqueness of the other change-ids. If some patch changes a lot
semantically while keeping its change-id, that will degrade its review
history, but without affecting the review history of any other patch.

Remo
