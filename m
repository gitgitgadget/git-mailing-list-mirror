Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB153BBC9
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 21:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726868037; cv=none; b=doDT7PzOvTClWavCK4/yygd6Y+cv3bPv5hqAHVCCT3e+xOBL0ZXo6cGdwKYhxxukeYM3W/XyiVLjK2Exz6oErheOElKhTzqJsJVzXoI4doJVcaY4J3xYYcH0LGVlou4RDtl11yLkppa33sznjDiSResHDHbDHaMyRzuYI8VyKbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726868037; c=relaxed/simple;
	bh=z+4syCtIOTrmFzk4j+lnztVwqi+rCJhqeZ3g64hhGF4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T6t3KgRTkEK+EeIMYDQngvaAoeemF59C4wRFQkpUoPLLHlLklO5BrAVqwzI2/s5az2T8v+hEycaZQZbrnK26ttDCJt7HfLJgUtIbXr5edqAEqowWuz2Inn8UbcyXpcse2eqNRT4YhkydPwtEfA9ZAxyeznmu4RhYn5LSazD4Hok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fBPqooRw; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fBPqooRw"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2130F1FB93;
	Fri, 20 Sep 2024 17:33:54 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=z+4syCtIOTrmFzk4j+lnztVwqi+rCJhqeZ3g64
	hhGF4=; b=fBPqooRwaTxVcwW703+bHt7yMm/kzs6aqRV7QgIF6+zszomNvLSrI/
	YOlrqaIsp4k/5SKZZ5QgpmLohPUwEdISLP/PDxSouqcISwae0/HXUs3poH8ZYYvA
	GZiyfUpIDRTbZvaEuJUN0mNo07cr26D6tBbKs6re6xkmJkPJRU1kQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 181721FB92;
	Fri, 20 Sep 2024 17:33:54 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7711B1FB91;
	Fri, 20 Sep 2024 17:33:53 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,  Derrick Stolee <stolee@gmail.com>,
    Jonathan Nieder <jrnieder@gmail.com>,
    Emily Shaffer <nasamuffin@google.com>
Subject: Re: [PATCH] BreakingChanges: early adopter option
In-Reply-To: <xmqq7cb77810.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	19 Sep 2024 12:33:47 -0700")
References: <xmqq7cb77810.fsf@gitster.g>
Date: Fri, 20 Sep 2024 14:33:52 -0700
Message-ID: <xmqqploydn7j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 089DEFBE-7798-11EF-ACC0-9B0F950A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Discussing the desire to make breaking changes, declaring that
> breaking changes are made at a certain version boundary, and
> recording these decisions in this document, are necessary but not
> sufficient.  We need to make sure that we can implement, test, and
> deploy such impactful changes.
>
> Formalize the mechanism based on the `feature.*` configuration
> variable to allow early adopters to opt into the breaking change in
> a version of Git before the planned version for the breaking change.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * Before I forget.  I'll find time to rewrite the "we no longer
>    honor core.preferSymlinkRefs" topic to follow this new guideline
>    when we see a rough concensus that both the procedure outlined
>    here and the idea to remove core.preferSymlinkRefs are good.

So I was looking at my other topic that prepares to deprecate and
remove core.preferSymlinkRefs configuration (i.e. we would still be
able to work with a repository whose HEAD is a symbolic link
pointing at refs/heads/main, but we would never be able to use a
symbolic link to represent a symref ourselves, so "git checkout
next" would replace HEAD with a textual symref, a file that has a
single line "ref: refs/heads/next" in it), to see what it involves
to allow early adopters to experience Git 3.0 features/removals
before it actually happens.

Switching behaviour at runtime with feature.git3 should work well,
and we can also add tests that checks the new behaviour by doing
"test_config feature.git3 true".

One trouble is what to do with "git $cmd --help" for those who
choose to be early adopters.

For "git $cmd --help" and "git -c feature.git3=true $cmd --help" to
show documents describing the behaviour before and after Git 3.0
version boundary, we'd need to install separate set of documents and
switch between them at runtime in builtin/help.c:setup_man_path()
and friends [*].  If we are going to have such a transition often
(e.g., more frequently than every few years), laying such an
infrastructure would certainly be worth it, but an obvious
alternative is to say that, even though the toggling of behaviour
can be done at runtime to allow the early adopters from going back
to the current behaviour to make their life less risky, the contents
of the manual pages are defined at the compile time.

If we are willing to burden early adopters a bit more, we could make
it a build-time option.  With "make GIT_BUILD_FOR_GIT3=YesPlease",
binaries will be built for all the then-current Git 3.0 features and
documentation under development.  It certainly is a simpler-to-build
option that is easier for us, but I am not sure if that is acceptable
by those who volunteer to test the upcoming big version.

One thing to note is that depending on the nature of a change, once
you start using a feature only available in a newer version of Git
in your repository, the resulting repository may not be understood
by an older version of Git (imagine you started using index v4---now
you are locked out of your repository if you want to go back to a
version of Git before 1.7.11).  So in that sense, it might be a
disservice to promise that an early adopter can experience the
future with feature.git3=on and then can safely go back to the
current world by flipping it off, and we might be better off to
control this with a single big red build-time switch.

Opinions?


[Footnote]

 * Alternatively we could tweak system_path() to hack the value we
   return when asked about GIT_INFO_PATH, GIT_MAN_PATH, and
   GIT_HTML_PATH, but I somehow feel dirty just for mentioning such
   an implementation possibility X-<.
