Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C336A823CD
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 17:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411899; cv=none; b=mSunhzgeQeSMKLUfggZynzjBmhsCzbOR4l3PsZYzoSOsYBew06j8S2UuST9k/K/7I0bfI/sxWrQkoDQOkXa2NSJkLGzCF/BnQqNj96RxQREhaQuTgr5dUAOq+gqo0/yT73pj5k8HCVuf3Ni5bia/zcovtOfEzEPlH2M6JBSv0ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411899; c=relaxed/simple;
	bh=5+TrbgqIW3YRCd+xOW/JTe1Uucfk4dfws2DfqFbvzOA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vnk55XvXgegq8NL0zm5sX6eTUOqkQ8HUaS1RwVe6Kzn03v9OS/pa1BajvnifKJw+cfvHAPFbvn0IzgTD8/FsgriZ4cskAuzruldSy+VnCfKv7bzCs/X5GjmJWUzddZt4W/KEOFl5CXXRjDnbcA0/bBWUZ5gJ/+neeKVqUFFIflo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JZ/HsNuQ; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JZ/HsNuQ"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 42A581E750A;
	Thu,  8 Feb 2024 12:04:56 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5+TrbgqIW3YRCd+xOW/JTe1Uucfk4dfws2DfqF
	bvzOA=; b=JZ/HsNuQCLcNXxW5B2p75B+JtJveLdXGTjvMfN6U4CWP7VZIMixAKR
	W3k7VriNJetfX3TeNS6HbcBOZRjdWW4d50LT/g/UIzJlgbHEFGZ4pcKBkd556Bcj
	YcrP2DITYx2kftGDpy8hZPdXBf/iWsg57CnWcIbu3uzkgWQsGhF0Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 37B8B1E7509;
	Thu,  8 Feb 2024 12:04:56 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 714C71E7508;
	Thu,  8 Feb 2024 12:04:55 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  phillip.wood@dunelm.org.uk,
  git@vger.kernel.org
Subject: Re: [PATCH v3 4/4] for-each-ref: avoid filtering on empty pattern
In-Reply-To: <ZcSVx4slikt4xB3D@tanuki> (Patrick Steinhardt's message of "Thu,
	8 Feb 2024 09:50:15 +0100")
References: <92ba680d-0b48-49f0-aafc-f503e5a5e0ea@gmail.com>
	<xmqqle7xjzic.fsf@gitster.g> <xmqqr0hph1ku.fsf@gitster.g>
	<CAOLa=ZSZJ=_VCppHXcJeE=Z61go4_040xyc1NBTu-o=xysLrdg@mail.gmail.com>
	<xmqqcyt9fdc7.fsf@gitster.g>
	<CAOLa=ZRcWYmEYnxh_=ykOerahZ61xaanLCj_JHHLvtrvN=Xs-w@mail.gmail.com>
	<xmqq1q9oe029.fsf@gitster.g>
	<CAOLa=ZQzz7_L_9cBmK+pgFwd_DFqfWDVRiaZMAxU+54kBq6Pcw@mail.gmail.com>
	<xmqq1q9ocje3.fsf@gitster.g>
	<CAOLa=ZQaXxwrXmbmFvGR59EDo3Eqa-Xfc3OG9+6ES-veDU8Bhg@mail.gmail.com>
	<ZcSVx4slikt4xB3D@tanuki>
Date: Thu, 08 Feb 2024 09:04:54 -0800
Message-ID: <xmqq7cjeq43t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2EA9764C-C6A4-11EE-9C86-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> ```
> if (!starts_with(iter->ref.refname, "refs/") &&
>     !(flags & INCLUDE_ROOT_REFS || is_pseudoref(iter->ref.refname)))
>     continue;
> ```
>
> The problem I have is that it still wouldn't end up surfacing all refs
> which exist in the ref backend while being computationally more
> expensive. So the original usecase I had in mind when pitching this
> topic isn't actually addressed.

The reftable format, as a database format, may be capable of having
"refs/heads/master" and "refs/heads/master/1" at the same time, but
to be used as a ref backend for Git, it must refrain from surfacing
both at the same time.  I think it is the same deal that it should
only allow "refs/*", "HEAD", and so called pseudorefs to be stored.
So INCLUDE_ROOT_REFS should be sufficient as long as the "ref
creation and update" side is not letting random cruft (e.g.,
"config") in.  Isn't that sufficient?

> I know that in theory, the reftable backend shouldn't contain refs other
> than "refs/" or pseudo-refs anyway. But regardless of that, I think that
> formulating this in the form of "root refs" is too restrictive and too
> much focussed on the "files" backend.

It is not "focused on".  The ref namespace of Git is tree-shaped,
period.  The shape may have originated from its first ref backend
implementation's limitation, but as we gain other backends, we are
not planning to lift such limitations, are we?  So we may still say
"when there is a master branch, you cannot have master/1 branch (due
to D/F conflict)", even if there is no notion of directory or file
in a backend implementation backed by a databasy file format.  "HEAD"
and "CHERRY_PICK_HEAD", unlike "refs/tags/v1.0", are at the "root
level", not only when they are stored in a files backend, but always
when they are presented to end-users, who can tell that they are not
inside "refs/".

