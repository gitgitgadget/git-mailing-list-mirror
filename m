Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4375E126BF9
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 21:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725399247; cv=none; b=i02IYIbY+0bBsqR3yYW/Fxwhs/cUWWnCnxTofJm6ABSTUhWyAbDaii9siSpJMFW1tF3THyFeCPwJ5yVnOhUx5RiDvCFGawkQo09P6m2VJF/X4yh0RNCsxURoDNvDV19Y5/dKU1tcBAAycPntJMOR3GSZGoMb659W3ZL8T965gC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725399247; c=relaxed/simple;
	bh=IPBT6xg3SHiC/YVivc8BJ+6I26kf7WejVQScL9FTPPc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Utay9QWNB1oDT2pim5Afr3xcXv6ITPOoO65+5QQrD8E/t30iwLILWHVdhHF11e+AsKxJpdPzEZdk+Q4srq2HlCM/rDkd7Qyj44SrpE/o3sds/3RlmlXDgqEs9TPp/3KKDlBHVgRR0/i4xjsFDH0DX2QiqboapRcvNuTiu36yx1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=galqyk63; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="galqyk63"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 26D392A144;
	Tue,  3 Sep 2024 17:34:05 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=IPBT6xg3SHiC
	/YVivc8BJ+6I26kf7WejVQScL9FTPPc=; b=galqyk63YPPPl/hMKVNrmReMRhXY
	Mpm0HbYbDpURJY3p4RlgOR+LPK1H2c4hIf0eYLRuYK8Kjml3X9JqYqxPlgIDSxA/
	fVv2xZUUPctz9Fz0F8b8uEoj4XzgAuWcpYLPOjTqwSCQP1V4DA8LgD8gHYfj8PrM
	elC9jckEhtDt++Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1DA1F2A143;
	Tue,  3 Sep 2024 17:34:05 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6EA932A142;
	Tue,  3 Sep 2024 17:34:04 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: sideshowbarker <mike@w3.org>
Cc: git@vger.kernel.org
Subject: Re: Problem: git Notes not discoverable (+proposed solutions)
In-Reply-To: <Zp89ntYaeFUumaTO@w3.org> (sideshowbarker's message of "Tue, 23
	Jul 2024 14:20:30 +0900")
References: <Zp89ntYaeFUumaTO@w3.org>
Date: Tue, 03 Sep 2024 14:34:02 -0700
Message-ID: <xmqq7cbsh16d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 3E2126A6-6A3C-11EF-BCB3-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

sideshowbarker <mike@w3.org> writes:

> ## Problem description
>
> When a project has added git Notes for its commits, git by default does=
n=E2=80=99t
> automatically fetch the Notes; so, the Notes aren=E2=80=99t automatical=
ly discoverable
> to contributors who are using =E2=80=9Cgit log=E2=80=9D to read the pro=
ject commit logs =E2=80=94 and
> especially not discoverable to new contributors, or =E2=80=9Ccasual=E2=80=
=9D users of the logs.
>
> A user will see the Notes only if they _already_ know what git Notes ar=
e, and
> know that the project uses Notes, and the user knows how to get them.
>
> But the reality is: most users do not even know what git Notes are, and=
 don=E2=80=99t
> know how to get them if they exist. So most people end up never seeing =
them.

And even if they did, they wouldn't know how to use them, so not
much is lost here.

Quite honestly, a project that uses notes in such a way that it is
essential to understand/utilize the history should reexamine its use
of notes and try to see if they can make its commits more useful
without relying on notes, I would think.

> I=E2=80=99d be 100% happy to do the work of writing a patch to implemen=
t a solution
> (a git behavior change) for this =E2=80=94 if I could get confirmation =
that the git
> maintainers would actually be open to reviewing such a patch.

I've seen from time to time people ask "I am thinking of doing this;
will a patch be accepted?  If so, I'll work on it." before showing
any work, and my response always has been:

 (1) We don't know how useful and interesting your contribution would
     be for our audience, until we see it; and

 (2) If you truly believe in your work (find it useful, find writing
     it fun, etc.), that should be incentive enough for you to work
     on it, whether or not the result will land in my tree.  You
     should instead aim for something so brilliant that we would
     come to you begging for your permission to include it in our
     project.

> As far as what the change would be: I realize this has been brought up
> before =E2=80=94 but it seems the obvious solutions are to =E2=80=9Cjus=
t=E2=80=9D change git so:
>
> - Proposed solution #1: git auto-fetches all Notes when a repo is first=
 cloned,
>   and then auto re-fetches them again for every =E2=80=9Cgit fetch=E2=80=
=9D or=E2=80=9Cgit pull=E2=80=9D.
>
>   I think that auto-fetching-of-Notes would ideally be the _default_ gi=
t
>   behavior =E2=80=94 but short of that, at least a new [notes] _option_=
 for enabling
>   that behavior would help. That would seem somewhat more =E2=80=9Cappr=
oachable=E2=80=9D to
>   than =E2=80=9Cgit config --add remote.origin.fetch '+refs/notes/*:ref=
s/notes/*'=E2=80=9D.
>
> - Proposed solution #2: git checks if a clone lacks Notes vs remote, an=
d emits:
>
>   > Your clone is behind the origin remote by N notes. To fetch the not=
es
>   > from the origin remote, run =E2=80=9Cgit fetch origin 'refs/notes/*=
:refs/notes/*'=E2=80=9D
>
> Either way, I=E2=80=99d be very willing to put work myself into writing=
 up a patch.

A much more light-weight alternative would be to add an example to
the tutorial to tweak the "remote.origin.fetch" refspec so that it
will also fetch notes.

But stepping back a bit, none of the above (including your two) may
practically be workable unless you limit the source of the notes to
the upstream, or something.  If you add notes yourself after you
clone, and the upstream makes different changes to its notes,
reconciling the diverged history of the notes tree would not be so
pleasant.  As a mechanism for the only publisher to publish
auxiliary pieces of information to cloners, notes is a very useful
mechanism, but for such a use case to be effective, the project
participants must understand when they are supposed to use the notes
read-only.
