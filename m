Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CFA7EB
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 00:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711670774; cv=none; b=Uc3bZ+aDDsb8vG0Q1xENcYhFR3eOmodNLkL0TUWZtb/g0SfdApUEEAhlziMhvpSBBRBPMsjsUlp1sLi33vARE0NComaZMgqOOVmQEHkQfsITn3/Snco6yMjtIIiDvenfeaYAp1BlUIeXAhQhEIR3NGie+9r2nmeUtZFea3/KWm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711670774; c=relaxed/simple;
	bh=UvFjLL7xG1jOwl8fNQDx4emZx1butnBWcCue9ethU6c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kgZt95oHqxp2qYs8nxMyT881k64VVk4isn2+BJbqwFcWpowtaFWefRUqQbxYS8BW8NhAEEH1OHwNLOvouWluNiLk76f4kk64ic+5CuXFAY1ZJ2jiH6mEYl0iJd2V0V9MmCW6Wxd8coAWzDadTUC2+FYztLHRUaGwvrgrfKG22vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OY+GqCfZ; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OY+GqCfZ"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B77791DF790;
	Thu, 28 Mar 2024 20:06:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=UvFjLL7xG1jOwl8fNQDx4emZx1butnBWcCue9e
	thU6c=; b=OY+GqCfZnw0+f8Eikp6zn7WmhQoJc0K0bV+p07xj5gLgqJC3Z5DnWn
	5JRx/0KPfrt0yHV/jdKGe5I4+vkBqLBBVdfmnpDYV1Ce6qG3W0H6WdebKnc57TTY
	aawZQtCigYO5bejcSkbz8J4i/lIm2srhcv5NLKe88YcxGScCmn3fs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9CD051DF78E;
	Thu, 28 Mar 2024 20:06:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EC6F61DF78C;
	Thu, 28 Mar 2024 20:06:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: git@vger.kernel.org
Subject: Re: base-commit when prerequisite-patch-id is specified
In-Reply-To: <20240328-vehement-fine-tarantula-2b864a@lemur> (Konstantin
	Ryabitsev's message of "Thu, 28 Mar 2024 17:34:41 -0400")
References: <20240328-vehement-fine-tarantula-2b864a@lemur>
Date: Thu, 28 Mar 2024 17:06:09 -0700
Message-ID: <xmqqzfuhsxzi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2646272E-ED60-11EE-9640-25B3960A682E-77302942!pb-smtp2.pobox.com

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> Hello:
>
> I'm working on automatically supporting dependencies with b4, and I'm curious
> if "base-commit" should be used to indicate where to start applying
> dependencies, or if that's purely for the patch series itself.
>
> E.g.:
>
>     base-commit: [commit-ish]
>     prerequisite-patch-id: abcd...1234
>     prerequisite-patch-id: cdef...3456
>
> In this situation, does base-commit mean:
> 1. where to apply abcd...1234
> 2. the sha we should find when we apply both prerequisite patches

"git format-patch --help" has this to say:

  Imagine that on top of the public commit P, you applied well-known patches X, Y
  and Z from somebody else, and then built your three-patch series A, B, C, the
  history would be like:

      ---P---X---Y---Z---A---B---C

  With git format-patch --base=P -3 C (or variants thereof, e.g. with --cover-letter
  or using Z..C instead of -3 C to specify the range), the base tree information
  block is shown at the end of the first message the command outputs (either the
  first patch, or the cover letter), like this:

      base-commit: P
      prerequisite-patch-id: X
      prerequisite-patch-id: Y
      prerequisite-patch-id: Z

So, it appears to me that the only way to read your example is that
there is P, on top of which abcd...1234 and cdef...3456 should be
applied, before our series is ready to be applied on top?

There is no way to express the desired topology on top of P that X,
Y and Z are built, and I think it is acceptable to assume the author
of such a patch series, who took it out of a history other than the
above depicted single strand of pearls, e.g. a mergy one in the
example given in the "git format-patch --help" output:

  For non-linear topology, such as

      ---P---X---A---M---C
          \         /
           Y---Z---B

  You can also use git format-patch --base=P -3 C to generate patches for A, B and
  C, and the identifiers for P, X, Y, Z are appended at the end of the first
  message.

is responsible to ensure that linear application of X Y Z A B C on
top of P should give the same result as C the author had taken the
patches out of.  The recipient, or b4 tool, cannot do anything with
the existing information.

