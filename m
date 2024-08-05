Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FA480C04
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 16:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722875708; cv=none; b=uxxTv8e5iWa6pA646nrAYsRWdMQpnB9/wc2Hc8a29C4cjZCJwbzyH6HvTONzSJG/+GcWDfGwss+19Qs5wpapnZVuRuP7z/BPEiCPohRz7q7BbSVs0A5p1HhtmB5RyCZ8BNcew50te3k1OzeDNUHR0NDOSUXXEAPXkFj0qq3Btbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722875708; c=relaxed/simple;
	bh=H16rO+AiY/+eFK0GJFi8yaIcTqFlXqI3XozM0DMYTME=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jh3mvmCUCnYh9O8uRWeFCOh9rgkP+cGJpHo9RtNGgIyGdts0yJJcgFIapdrG0dZbBjP0S++8yb4oJlOxHl+ONAqpdtbjexBu69Ef2dPuO8Hm+93OQgxgT4GsGFIRYYxu6VU3G8MfTlb/5/M/4qRoTQQqCgjQodjW+I59foV8mCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ImAQd3oY; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ImAQd3oY"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9CF7B2EB17;
	Mon,  5 Aug 2024 12:35:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=H16rO+AiY/+eFK0GJFi8yaIcTqFlXqI3XozM0D
	MYTME=; b=ImAQd3oYZjkmWkj71/o1UzNKn1TUJuzogjEpDbi3gQO4wdJf9pKpMP
	7Fg0suOWuIgOj4ZLQe0vgWm3RcCY+730/BsMkS+Soj7nW+FT0cHby0sZKkq0CLZk
	qwyAdF/Mb2mtF5eXvNtFlPo7Hn55KnlVeXT/EKTd7S8UjV12fmnRk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 815D42EB16;
	Mon,  5 Aug 2024 12:35:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A47D02EB14;
	Mon,  5 Aug 2024 12:35:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Matt Thompson <fortran@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Bug: Git sees branch as valid commit ref and works; should fail
In-Reply-To: <CAFb48S8LDz4kiWsKSCBn8J=AHyQ5SVPFH4GY=z+8=DntT=PyAw@mail.gmail.com>
	(Matt Thompson's message of "Mon, 5 Aug 2024 11:07:41 -0400")
References: <CAFb48S8LDz4kiWsKSCBn8J=AHyQ5SVPFH4GY=z+8=DntT=PyAw@mail.gmail.com>
Date: Mon, 05 Aug 2024 09:35:00 -0700
Message-ID: <xmqqy15b2aiz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A96ADF8E-5348-11EF-87AE-BF444491E1BC-77302942!pb-smtp20.pobox.com

Matt Thompson <fortran@gmail.com> writes:

> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
>
> $ git clone https://github.com/GEOS-ESM/GFDL_atmos_cubed_sphere.git fvdycore
> $ cd fvdycore
> $ git checkout bugfix/mathomp4/trivial-ci-commit-gcc14
>
> What did you expect to happen? (Expected behavior)
>
> I expected a failure as there is no branch named
> 'bugfix/mathomp4/trivial-ci-commit-gcc14' in the repository.

If you run

  $ git for-each-ref | grep /bugfix/mathomp4/trivial-ci-commit-gcc14

I suspect you have a remote-tracking branch that matches the
pattern.  In such a case, "bugfix/mathomp4/trivial-ci-commit-gcc14"
is a very valid way to refer to a commit to any Git command.  It is
handy to say "git show bugfix/mathomp4/trivial-ci-commit-gcc14", for
example.

And when "git checkout" is given a commit that is not a local
branch, what it did below (by the way, thanks for giving a very
accurate "Actual behavior" description in your report) is very much
expected behaviour, including the part that it gave a message to
advise how to work on a detached HEAD.

> What happened instead? (Actual behavior)
>
> $ git checkout bugfix/mathomp4/trivial-ci-commit-gcc14
> Note: switching to 'bugfix/mathomp4/trivial-ci-commit-gcc14'.
> ...

