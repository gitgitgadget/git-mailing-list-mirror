Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA6E13399E
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 17:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708017519; cv=none; b=AM1M13wuW8rEMuE5Y+JveXXS49RayP797kzNyu86Sw/hFWSLRE1csFoAFxBSgAZkYtXPKxKMGMgl8EogAAHjxmiPjVbTTVSGOfwEdHAFEAwcLeO7MidxB0SidygbYKZTKgGMLcoYtggW3T0w04u0uELxtphTGG18PCySqIxPMiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708017519; c=relaxed/simple;
	bh=2r5BRLz2p8sOBWkXuWWt3rlr8tglSSARVGLeoKIKLZE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dJhKubGSo/rSrWFwaHRvJ8/hQ/lADtuGpkpO9Mu4cQNt93cT2Ii3uuT/f9JuPrjDiR5tLQKrusmEF5EGQ0W8EryvXb27u53L15U5+eLgppqaU66bAwZk/pJJpL3gJEhNQhgN6Q3H6zsQFsRDQoWNZpVurwF84rpuvf8LcImpbS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jQHUZtwI; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jQHUZtwI"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BC767283A5;
	Thu, 15 Feb 2024 12:18:31 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2r5BRLz2p8sOBWkXuWWt3rlr8tglSSARVGLeoK
	IKLZE=; b=jQHUZtwI5mpoZ/YeminGjz+NK/wySkeajYpvE7HCLVrsRJT2zHNBde
	DADhAU0mKTciNJCEaJFV6DBtdVFUxQ2pdGBvjnd5w44qKC+x5F3mvXEjbtRx6o3D
	4qNnFqvkCjhRSzg4bFwj4N9empdRItbF01zTXc8lGLStyMMPCuXy4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B3BB4283A4;
	Thu, 15 Feb 2024 12:18:31 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 60CFE283A3;
	Thu, 15 Feb 2024 12:18:28 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jonathan Nieder <jrnieder@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/7] t0410: enable tests with extensions with
 non-default repo format
In-Reply-To: <Zc3EbCXFdG8E7_v2@tanuki> (Patrick Steinhardt's message of "Thu,
	15 Feb 2024 08:59:40 +0100")
References: <cover.1707463221.git.ps@pks.im>
	<feef6a3e6cd0d9096816d0a8a5789837fb784517.1707463221.git.ps@pks.im>
	<xmqqle7mu00c.fsf@gitster.g> <Zc3EbCXFdG8E7_v2@tanuki>
Date: Thu, 15 Feb 2024 09:18:26 -0800
Message-ID: <xmqqr0hdsl25.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3C186798-CC26-11EE-A5DE-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Feb 14, 2024 at 02:57:55PM -0800, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> 
>> > In t0410 we have two tests which exercise how partial clones behave in
>> > the context of a repository with extensions. These tests are marked to
>> > require a default repository using SHA1 and the "files" backend because
>> > we explicitly set the repository format version to 0.
>> >
>> > Changing the repository format version to 0 is not needed though. The
>> > "noop" extension is ignored as expected regardless of what the version
>> > is set to, same as the "nonsense" extension leads to failure regardless
>> > of the version.
>> 
>> Isn't the reason why 11664196 kept the forcing of the format version
>> because it wanted to see noop ignored and nonsense failed even if
>> the format version is 0 to ensure the regression it fixed will stay
>> fixed?  IOW, we force version 0 not because we do not want to test
>> with anything but SHA1 and REFFILES; we pretty much assume that with
>> the default version, noop and nonsense will be handled sensibly, and
>> we want to make sure they will be with version 0 as well.
>> 
>> And once we force to version 0, we have trouble running with
>> anything other than SHA1 and REFFILES, hence these prerequisites.
>> 
>> So, I dunno.
>
> Hum, I guess that's fair. Let me adapt the test case to instead use the
> DEFAULT_REPO_FORMAT prerequisite then.

If we expect that "git init" by default will create version 0
repository in the foreseeable future (and when the default gets
fliped to create version 1, we will add CI task that forces version
0 somehow, just like we have special CI task to run test with ref
backend set to reftable), then I think the patch as posted may
actually be a good idea.  As long as somebody is checking these with
a repository in version 0 format, the original motivation behind the
tests is satisified, and if we in addition make sure noop and
nonsense are handled sensibly with higher versions, that would also
be good, too.

So perhaps we need some in-code comment next to these tests to
remind us about that, while removing these prerequisites?

Thanks.
