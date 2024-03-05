Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CE114012
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 21:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709674188; cv=none; b=eWle0F7hxzux0e+SF+GEv+XNVfIq/mC0VET920j4RNeUhkePb2u9OtGsmexd7f8zL5mpxVv5cJdjLV8ImeosgmX+shk7YRlvDsCO2AWkLSsHfqvJfCUhddaT2BhwjHfL+WjDRuwh3pxwasiNQOLSiLFpW/Z71KZDPzwatV9w1Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709674188; c=relaxed/simple;
	bh=yHemRaO+fXaIpRqm2abUYnzTmwRGEfl+O3eSYwroEuk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VNRyIrIkltGgf2oplqYF5lbockl3ZSc6Fh5YxYTGohxRSOKaKIF88A7OHQEjBIlTyT2cZ+bKkj6Vr0da+ZvxxoJPrlwky0vHQQJG4QUNtB7njoOEgr0jX2qqzjZOT3Nk+GbupravL7w3IEhY500hVYNhlIjl+ym2gUI7Znes80E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vdUCQjL3; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vdUCQjL3"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 981F21FA1F;
	Tue,  5 Mar 2024 16:29:46 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=yHemRaO+fXaIpRqm2abUYnzTmwRGEfl+O3eSYw
	roEuk=; b=vdUCQjL3WxmWMwbVnqv72wpiL2/Go6rorOdwgAysBAYlk9dyd/M+yV
	D1ktD6FtLKbBeokdpVEQmnbkWnfdjXngDXiuys90mHOY7RgMpwE6dFXCY2dJRCC8
	a5pKBnBvXyeTaqANQpT3jhivn4cqkJxgi85k+uMiklmON20ZGHzNA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 90F581FA1E;
	Tue,  5 Mar 2024 16:29:46 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E7CD31FA1D;
	Tue,  5 Mar 2024 16:29:42 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: John Cai <johncai86@gmail.com>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] show-ref: add --unresolved option
In-Reply-To: <44609CA3-1215-4EAD-8456-DDD66A3B93A8@gmail.com> (John Cai's
	message of "Tue, 05 Mar 2024 15:56:03 -0500")
References: <pull.1684.git.git.1709592718743.gitgitgadget@gmail.com>
	<xmqqplw9mviu.fsf@gitster.g>
	<44609CA3-1215-4EAD-8456-DDD66A3B93A8@gmail.com>
Date: Tue, 05 Mar 2024 13:29:41 -0800
Message-ID: <xmqqzfvcz7sq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7B13F780-DB37-11EE-8522-A19503B9AAD1-77302942!pb-smtp21.pobox.com

John Cai <johncai86@gmail.com> writes:

> I think something like --no-dereference that was suggested in [1] could work
> since the concept of dereferencing should be familiar to the user. However, this
> maybe confusing because of the existing --dereference flag that is specific to
> tags...

True.

As a symbolic reference is like a symbolic link [*], another possibility
is to use "follow", which often is used to refer to the action of
reading the contents of a symbolic link and using it as the target
pathname (e.g., O_NOFOLLOW flag forbids open(2) from following
symbolic links).  Unfortunately the checkbox feature "--follow" the
"git log" has refers to an entirely different kind of following, so
it is just as confusing as --dereference.

Perhaps "--readlink", if you are showing only "ref: refs/heads/main"
instead of the usual object name in the output?  If we are showing
both, we may want to use a name that signals the optional nature of
the symref part of the output, e.g., "--with-symref-target" [*].


[Footnote]

 * In fact that is how the symbolic reference started out as.  We
   literally used a symbolic link .git/HEAD that points at the
   current branch, which can be seen in v0.99~418 (git-init-db: set
   up the full default environment, 2005-05-30).

 * Yes, I know, I am terrible at naming things---my names may be
   descriptive but end up being unusably long and verbose.

