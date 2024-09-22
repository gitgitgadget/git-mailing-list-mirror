Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C7B26AC1
	for <git@vger.kernel.org>; Sun, 22 Sep 2024 17:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727027517; cv=none; b=WGiemixIgYYE6p7+ENyt77tZYPlImQ4tItd4abYmJq5B7My/IMorPUVHjAgc4IBHt/GT/O6eIqFPiitdUeoQ0wmMLRMPHE83fm9qf4NqJSKzkP+8utrPvL595ewc84/y7i7e/C7I/ZqPJqJ6HghQsd4BZy7rXAJE43S38VKxDkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727027517; c=relaxed/simple;
	bh=HXi0Ponnilci+VPeoGHeH2Uu5YglEI4EJKPOERosHJA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k0PjawBi7dKX44XXXtLMdUkv1qppgE5tVlOvFOKuJJ5Q2zhOVPuLHf+/2esQ4RjBmC2N1sfaDBxMMprlg7X0nyNZyB16+TP0ZlNi4Q73S+NwPWJQmni8WEHWhQhmTlBkmv+6VG3KFJhUSuibcZn0ZMs59l7ydRkXpcZoaC1ej+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=v/hS815R; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="v/hS815R"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B47433DF61;
	Sun, 22 Sep 2024 13:51:54 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=HXi0Ponnilci+VPeoGHeH2Uu5YglEI4EJKPOER
	osHJA=; b=v/hS815Rf8XUkzuF/SiBwNK6LqFZ1TyIp9O1M1/xQ+nscZwZsEPtCX
	yJc+Nz8HFPmSVSwuDmxDAFSH0Yg/3D4lmGIgLe6i/Vy2QQ/CVq9Rgi6fNitB999n
	Hcd0MJG+cTqQcFO9PQnTFenvd7re3BMTDzuizial+70VR3fy5hP6g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AC9DB3DF60;
	Sun, 22 Sep 2024 13:51:54 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0F5A13DF5F;
	Sun, 22 Sep 2024 13:51:53 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,  Derrick Stolee <stolee@gmail.com>,
  Jonathan Nieder <jrnieder@gmail.com>,  Emily Shaffer
 <nasamuffin@google.com>
Subject: Re: [PATCH] BreakingChanges: early adopter option
In-Reply-To: <xmqqploydn7j.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	20 Sep 2024 14:33:52 -0700")
References: <xmqq7cb77810.fsf@gitster.g> <xmqqploydn7j.fsf@gitster.g>
Date: Sun, 22 Sep 2024 10:51:52 -0700
Message-ID: <xmqqtte77f0n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5A71CDE6-790B-11EF-8CE5-9B0F950A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Discussing the desire to make breaking changes, declaring that
>> breaking changes are made at a certain version boundary, and
>> recording these decisions in this document, are necessary but not
>> sufficient.  We need to make sure that we can implement, test, and
>> deploy such impactful changes.
>>
>> Formalize the mechanism based on the `feature.*` configuration
>> variable to allow early adopters to opt into the breaking change in
>> a version of Git before the planned version for the breaking change.
>> ...
> ... to see what it involves
> to allow early adopters to experience Git 3.0 features/removals
> before it actually happens.

Sorry for a long monologue on this important topic, while everybody
is away.  Hopefully we'll see more comments when they get back once
the week starts ;-)

> Switching behaviour at runtime with feature.git3 should work well,
> and we can also add tests that checks the new behaviour by doing
> "test_config feature.git3 true".
> ...
> If we are willing to burden early adopters a bit more, we could make
> it a build-time option.  With "make GIT_BUILD_FOR_GIT3=YesPlease",
> binaries will be built for all the then-current Git 3.0 features and
> documentation under development.  It certainly is a simpler-to-build
> option that is easier for us, but I am not sure if that is acceptable
> by those who volunteer to test the upcoming big version.
>
> One thing to note is that depending on the nature of a change, once
> you start using a feature only available in a newer version of Git
> in your repository, the resulting repository may not be understood
> by an older version of Git...

While I still am with the position that we can do this either at
runtime or at build time, with the trade-off being that it is more
costly for developers to do it at runtime and more cumbersome for
early adopters to do it at build time, I realize that the last point
above is unrelated.  If one or some of the features behind either
feature.git3 runtime option or GIT_BUILD_FOR_GIT3 build-time option
makes a repository inaccessible to versions of Git without these
features, we have the extension.* mechanism to make sure nothing
breaks, and testing that such a Git3 feature is properly protected
by the extension.* mechanism is part of the early adopter testing.

How much more costly to do at runtime is still subject to further
analysis, I think.  I know that it means we need to build and
install the docs twice to support "git -c feature.git3=on help", for
example, but I am not sure what the best way to use CI would be
(write tests that check features with different behaviour by
explicitly running them with "git -c feature.git3=on"?  Run the same
set of tests in a separate job that has "[feature] git3" in its
$HOME/.gitconfig?).
