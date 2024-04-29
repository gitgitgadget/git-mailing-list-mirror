Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A584E7E0F6
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714405078; cv=none; b=Uqa8mFb7NFgi4o76hs0LTeCtAkCqMgaLroCYkq8YsceDK8Puf3Nvi8R8j8UApkds0JOQqQHVcIgHpd0pVeTiuRL22RWvUzzRckx8OJfv/hoclRIgsBxpAlKQTYxP3tnunJ3YeS3K9HZK8i/3AdUUvGAtucSJqlD5otEMVfWWjaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714405078; c=relaxed/simple;
	bh=XoUP0mWsdAJdONJ6bNBd4NUQnhUjTykIJKowMWbnU/E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lH49ZObCDyZMvIhpvUAcGjDnG3nlQr9cR6vt1uAHPnLz/Y9n8NESokuSirGqpFOjeKFzj92/Jo12wh55YpeXdDMdiUsxia5lWEb2fmasiF535CnJ2DfsHuPIBxcqFPcW0gNlVph7sXjDCmCP4FUT5pcZfLj/0lNOf4lw5V4Ar3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=h82xGCMV; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="h82xGCMV"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2F2B736B9E;
	Mon, 29 Apr 2024 11:37:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=XoUP0mWsdAJdONJ6bNBd4NUQnhUjTykIJKowMW
	bnU/E=; b=h82xGCMVr5pMfC960skKH79UFe8hIhdBnhFciL54OoOX6Lxv2pcpHb
	TpU/bpPdJ0PYHyLcWo33aMO2/NoifHhuocunGKa5MIHfV8qbDIzGS+VEeNnNiviY
	d0EQX0t4+LCx8w223DXWMZlv7uZfUez1OBaN7PGFm/if+FpZCBE9U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2841236B9D;
	Mon, 29 Apr 2024 11:37:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EAC5E36B9B;
	Mon, 29 Apr 2024 11:37:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] gitlab-ci: add smoke test for fuzzers
In-Reply-To: <Zi86uFE5RlDG2RFN@tanuki> (Patrick Steinhardt's message of "Mon,
	29 Apr 2024 08:14:16 +0200")
References: <01fb94999f8e2014ba4d09ce7451a4f5d315ee72.1714371146.git.ps@pks.im>
	<Zi86uFE5RlDG2RFN@tanuki>
Date: Mon, 29 Apr 2024 08:37:49 -0700
Message-ID: <xmqqfrv4yyb6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 70128310-063E-11EF-BA77-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Apr 29, 2024 at 08:13:23AM +0200, Patrick Steinhardt wrote:
>> Our GitLab CI setup has a test gap where the fuzzers aren't exercised at
>> all. Add a smoke test, similar to the one we have in GitHub Workflows.
>> 
>> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>> ---
>> 
>> As identified by Junio in <xmqqwmoi31aw.fsf@gitster.g>.
>> 
>> Patrick
>
> I forgot to add the link to a successful run of this job:
> https://gitlab.com/gitlab-org/git/-/jobs/6735705569

Thanks.  I wonder if we can somehow automate a change like this.

Seeing how simple this fix has become thanks to the use of
before_script/script pair that merely point at ci/*.sh scripts,
perhaps we have already extracted enough commonalities as a set of
shell scripts in ci/ hierarchy.  I wonder if we can have a common
"source" that is "compiled" into .gitlab-ci.yml and its counterpart
for GitHub Actions?

Or perhaps a linter that can say things like "ah, you are adding
this new test to one, but not touching the other, shouldn't you?",
and "you are tweaking this existing test in one, but shouldn't you
be doing the same to the other?"


