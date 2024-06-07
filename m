Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038B139FFB
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 18:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717786142; cv=none; b=S8kh7o4Xk161hOfI92H0rEhVpV7OYjJLo5aLlQw6TsH7Z9NNmUAgVtSaKdVerso34KxABTSBgjRhtNr2/Rwxhn/s4llHOy1L7kmbJXa7rf2Ej5LD0tU0DoraLSRNMJJHkWTo2aLIMR55Kz/OUpf0NbJpkbDT7b+f+e5HQXXEs0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717786142; c=relaxed/simple;
	bh=4Xd354Z372cU+wISOufSrPCnQWF6vXAslAkL64kwSfY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u06nOBKgiR/wST8a/wAfyRiLFXUYafYj+8doqryugj3u92ESX3L+zdMN0HLuqwG5120/1VbTYv6gM57zv0Ht852UoJMcPnl2s/ll/72wMISQcHZ/AmHFKgPdr6md23Kl/qG+36GNem+X53keXEs94l+07g42qzU+EDQ/a/M8MsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Xz63kNjY; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xz63kNjY"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9A4012D1D8;
	Fri,  7 Jun 2024 14:49:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=4Xd354Z372cU
	+wISOufSrPCnQWF6vXAslAkL64kwSfY=; b=Xz63kNjYQsIwwRhKE6lawZ/xPoN0
	P158E5p7QQan3Sm+hRj9WlrClIvrO3TPlxUQ3H3mtLJJaqH/7ESmFyNJbI5dKCG1
	BfFuDecgKKgouKiusOo6X1Q7z0JNV1TgLikgoZRkRidHFzRdAqo4LTuQn/9FjL74
	/qpc0edCqNUcNLU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 92E1A2D1D7;
	Fri,  7 Jun 2024 14:49:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B06522D1D6;
	Fri,  7 Jun 2024 14:48:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] ci: compile "linux-gcc-default" job with -Og
In-Reply-To: <bdf0e40a770c57b63e7519983d37b97a85ce07bf.1717662814.git.ps@pks.im>
	(Patrick Steinhardt's message of "Thu, 6 Jun 2024 11:31:45 +0200")
References: <20240606080552.GA658959@coredump.intra.peff.net>
	<cover.1717662814.git.ps@pks.im>
	<bdf0e40a770c57b63e7519983d37b97a85ce07bf.1717662814.git.ps@pks.im>
Date: Fri, 07 Jun 2024 11:48:56 -0700
Message-ID: <xmqqed98d1wn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 98E77D2A-24FE-11EF-B4F1-ACC938F0AE34-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

> While we could adapt all jobs to compile with `-Og` now, that would
> potentially mask other warnings that only get diagnosed with `-O2`.
> Instead, adapt the "linux-gcc-default" job to compile with `-Og`.

It seems that we are already triggering for 'seen'.  I haven't
checked if that is a false positive or a real problem, though.

https://github.com/git/git/actions/runs/9407652417/job/25913907166#step:4=
:139

  pack-mtimes.c: In function =E2=80=98load_pack_mtimes_file=E2=80=99:
  Error: pack-mtimes.c:89:25: =E2=80=98mtimes_size=E2=80=99 may be used u=
ninitialized in this function [-Werror=3Dmaybe-uninitialized]
     89 |                         munmap(data, mtimes_size);
        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors
  make: *** [Makefile:2757: pack-mtimes.o] Error 1
  make: *** Waiting for unfinished jobs....
  pack-revindex.c: In function =E2=80=98load_revindex_from_disk=E2=80=99:
  Error: pack-revindex.c:260:25: =E2=80=98revindex_size=E2=80=99 may be u=
sed uninitialized in this function [-Werror=3Dmaybe-uninitialized]
    260 |                         munmap(data, revindex_size);
        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors
  make: *** [Makefile:2757: pack-revindex.o] Error 1
  cat: exit.status: No such file or directory
