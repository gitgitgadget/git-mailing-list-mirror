Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7790D14C59C
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 16:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719331559; cv=none; b=iv55CtOIe2zD/Q09qomF9yWGs2Kddg5REJjhwBy85LL9ZmbCayHq68NCFhp0P9hqpGMKiUORjyQ14GGhWKeBGPFqpouqzWkSPuBp6ouiEIRABjs27+HCk7hxl/O2Xd4H59egp2KQtN6Uaw5kMpCeGcxFYx57b31dnVk9lsjJ7uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719331559; c=relaxed/simple;
	bh=dbcsi1E8N09s6QQEU9Eo/Qn74qJb16p4bS23Lhh0WEc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hS9Z6cDrYIgZ9fddJh/WoZ3UzYwwUBAoeCVLEfKOyliMVoWREqJUj5Bgb6B9dQ8BHylXeoJdD0YGrkTBrMHJLdetPkraqQPZE2/rHFk3nz1U3d0jhy7czutyaARbMdSoKk1GiPIiq5ZJms5ySrI29yJHiTbNCngVSrzaGfdSuDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CUrHxWIJ; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CUrHxWIJ"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 17C8929C96;
	Tue, 25 Jun 2024 12:05:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=dbcsi1E8N09s6QQEU9Eo/Qn74qJb16p4bS23Lh
	h0WEc=; b=CUrHxWIJ0vusombSrKWAbK4jF5OkbCa3kaFWGLhzvi/3n5iI2rPYf/
	bVvCCuSdPgc5gSnQEW1rKDkdpW0Fv9hQZAok4lM9DkiEId8QgNiFFTKBukdLvHQO
	r7GwGRrv7eQGYSFAuThWu83Uo8yLoo9UbAGVeNUF6y8roNg7fGVrU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1097829C95;
	Tue, 25 Jun 2024 12:05:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A2C0B29C94;
	Tue, 25 Jun 2024 12:05:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Abhijeet Sonar <abhijeet.nkt@gmail.com>, git@vger.kernel.org,
  karthik.188@gmail.com,  Paul Millar <paul.millar@desy.de>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Elijah Newren <newren@gmail.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v3] describe: refresh the index when 'broken' flag is used
In-Reply-To: <xmqq34p1813n.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	25 Jun 2024 08:59:40 -0700")
References: <20240625133534.223579-1-abhijeet.nkt@gmail.com>
	<xmqq34p1813n.fsf@gitster.g>
Date: Tue, 25 Jun 2024 09:05:53 -0700
Message-ID: <xmqqy16t6m8u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CD2F89DA-330C-11EF-A70D-C38742FD603B-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> (#leftoverbit)
>
> Outside the scope of this patch, I'd prefer to see somebody makes
> sure that it is truly equivalent to prepare a separate and new
> struct child_process for each run_command() call and to reuse the
> same struct child_process after calling child_process_clear() each
> time.  It is unclear if they are equivalent in general, even though
> in this particular case I think we should be OK.
>
> There _might_ be other things in the child_process structure that
> need to be reset to the initial state before it can be reused, but
> are not cleared by child_process_clear().  .git_cmd and other flags
> as well as in/out/err file descriptors do not seem to be cleared,
> and other callers of run_command() may even be depending on the
> current behaviour that they are kept.

Ahh, the reuse of the same struct came directly from Karthik's
review on the second iteration.  I guess Karthik volunteered himself
into this #leftoverbit task?  I am not convinced that

 (1) the selective clearing done by current child_process_clear() is
     the best thing we can do to make child_process reusable, and

 (2) among the current callers, there is nobody that depends on the
     state left by the previous use of child_process in another
     run_command() call that is left uncleared by child_process_clear().

If (1) is false, then reusing child_process structure is not quite
safe, and if (2) is false, updating child_process_clear() to really
clear everything will first need to adjust some callers.

Thanks.
