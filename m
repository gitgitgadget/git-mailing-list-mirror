Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CC33921CE
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 04:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790742122; cv=none; b=bgiAEjAb/1OXmvFxFyOTwOpnMhQIqFzRV+zFYYUa7BJ0MqSEosbsjUpepo9CfbVRNLGeBl0kbNZlJxYAPMVfmNKQDCmul3ScOVeR08Oiew9ehVLJYu0aRP29fJtXKM3dbke8X9WiiQOTjlc9N7usXxWkHlgApTkYZW4iS0vHYsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790742122; c=relaxed/simple;
	bh=b3vTyKbwDSGxmQmNfd0rbcqCmneAcvFqEPCxACQOHPU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=HUQAvKET9lAwT/UshUXW/qX6bnQih33xyABQy7UMipmCj0dv+6v+eBD9dto3hj28gPbI4wWmSZsyqPAfRtJr/Zs9OafrWZ8Isr9vWjmAOezvDxakZ3B693ssqY0/t5mzhsWwW5ecRgHwNaPor2htXPDS+VXm5wdC/6PZ+NRLbBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=Su26xend; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="Su26xend"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1790742113; bh=b3vTyKbwDSGxmQmNfd0rbcqCmneAcvFqEPCxACQOHPU=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Su26xendpfE4aVaPSQfyKgKcXQ7ZZNrmgpPkMri508kpLdjJb+UUYqYFlVHJeaAUC
	 LBQTWmv4RJcM1A6wGhRc9kHjBOqr3dSi8cH6AHvTQjDmKaQ37iqoHczw8c0BMYe6nl
	 C+jV9KkD9gKeW6bhSAsmNzd1IPx9OAbRoOChz5zk=
Received: by mail.normalmode.org (Postfix) with ESMTPSA id B824D614AE;
	Wed, 30 Sep 2026 04:21:53 +0000 (UTC)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Sep 2026 00:21:48 -0400
Message-Id: <DLSD3JY380Q4.2VPO95D7M213G@lfurio.us>
Subject: Re: [PATCH v2] fetch.c: defer fetch.followRemoteHEAD validation
Cc: <git@vger.kernel.org>
To: "Colin Hinton" <colinlewishinton@gmail.com>, "Junio C Hamano"
 <gitster@pobox.com>
From: "Matt Hunter" <m@lfurio.us>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260922040047.2567-1-colinlewishinton@gmail.com>
 <20260925192658.1166-1-colinlewishinton@gmail.com>
 <xmqqo6dlt906.fsf@gitster.g>
 <CAHeTm9Pb-fb-ZS_m4UVNZxfp+ENQwBUGDvP1E24dEDTZy5RFFw@mail.gmail.com>
In-Reply-To: <CAHeTm9Pb-fb-ZS_m4UVNZxfp+ENQwBUGDvP1E24dEDTZy5RFFw@mail.gmail.com>

On Fri Sep 25, 2026 at 4:30 PM EDT, Colin Hinton wrote:
> On Fri, Sep 25, 2026 at 12:40=E2=80=AFPM Junio C Hamano <gitster@pobox.co=
m> wrote:
>>
>> We should do something similar to what remote.c parses for
>> consistency, but other than that, it seems this topic is moving in
>> the right direction.
>>
>> Thanks.
>
> The only critical difference I see in the configuration parse between
> remote.c and fetch.c is the case for "warn-if-not-$branch". From
> reading the git-config manpage, this is only a setting for a remote
> and not for fetch directly so I do not see a reason to check this in
> fetch.c. Perhaps I am missing something else to make this more
> consistent,

I agree with this assessment.  However, I wonder if Junio meant

    We should (do something similar) to (what remote.c parses) ...

instead of

    We should do (something similar to what remote.c parses) ...

as the issue in the NEEDSWORK _does_ apply to both sides.

Perhaps at a minimum, this patch should leave the comment intact (or
reworded) if not yet addressing remote.c.  v3 otherwise is looking good
to me, and functionality seems to work.
