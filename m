Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2907E15B1
	for <git@vger.kernel.org>; Sat,  9 Mar 2024 17:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710005897; cv=none; b=oAluouOX2gZml2qzLtZUN0max3tzbIP5D1FScYutPboXzX4e5hoCtX7Af9XXvHMBYFk7VJHx30v+jGbNiCzCXe0/eG8e60LS9zOtcFz7GFc9gATmg2FtMbRr8z3d+QUg5qKoKeQ3bv/B85iahKFFXZ7spWnu6sV9RGkM2FVyYrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710005897; c=relaxed/simple;
	bh=4bWTvGsVYuE5gaGJ7hxYhKjrJYSMXIi5PmJdXtEYZX8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sMF01FJEFvIjBAydt+cTXq5Cd6TKdMAm2s102v2lh4weXr86ivsKMn2iT91AiG1cwKMVy0B8Bc2ZAwkr2w4ouGbKA3Mb3d7g9cDQhs6GozuE8BlN4B5TEuHAz5XuUs1C2VcVkQRwUwzj+xAVl5Pu0sUEl1Ue0tCOkxbQ3lEpBU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Pw71uS6v; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Pw71uS6v"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 971271A5AC;
	Sat,  9 Mar 2024 12:38:15 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4bWTvGsVYuE5gaGJ7hxYhKjrJYSMXIi5PmJdXt
	EYZX8=; b=Pw71uS6v113qHEftfnz6oAax/Bz3XLSEqKO+qZf5Z2cVZz0xqlDdFu
	MqlCa/AnjQTUxDYo/h0jqQXsiL4sMKMuMxxcFIXshydxeE136urNAmHEjq95lrSQ
	10QntS2iOKdC3bexoVS4ajetPsAT9XZ7MWHSnnZP8MaM4NAoKaqxE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8FA171A5AB;
	Sat,  9 Mar 2024 12:38:15 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3D5F21A5AA;
	Sat,  9 Mar 2024 12:38:12 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ignacio Encinas Rubio <ignacio@iencinas.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] config: learn the "hostname:" includeIf condition
In-Reply-To: <01a9baa2-b36b-4b4e-8e54-7645e35d1a47@iencinas.com> (Ignacio
	Encinas Rubio's message of "Sat, 9 Mar 2024 11:47:55 +0100")
References: <20240307205006.467443-1-ignacio@iencinas.com>
	<20240307205006.467443-2-ignacio@iencinas.com>
	<xmqqil1xk9fv.fsf@gitster.g>
	<01a9baa2-b36b-4b4e-8e54-7645e35d1a47@iencinas.com>
Date: Sat, 09 Mar 2024 09:38:10 -0800
Message-ID: <xmqq8r2re265.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CD3AA8D6-DE3B-11EE-A92A-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Ignacio Encinas Rubio <ignacio@iencinas.com> writes:

>>> +test_expect_success 'conditional include, hostname' '
>>> +	echo "[includeIf \"hostname:$(hostname)a\"]path=bar12" >>.git/config &&
>>> +	echo "[test]twelve=12" >.git/bar12 &&
>>> +	test_must_fail git config test.twelve &&
>> 
>> Emulating other tests in this file that uses here document may make
>> it a bit easier to read?  E.g.,
>> 
>> 	cat >>.gitconfig <<-EOF &&
>> 	[includeIf "hostname:$(hostname)a"]
>> 		path = bar12
>> 	EOF
>
> Thanks for pointing that out. I just read the last tests from that file
> where they used the echo "..." >> approach. Do you think it is
> worthwhile rewriting those tests to use the approach you suggested?

I had an impression that existing ones do not have ugliness of
backslash-quoting and do not benefit from such a rewrite to use
here-document as much as the one you added does.  

If that is not the case, and existing ones would concretely improve
the readability with such a rewrite to use here-document, surely.
If we want to do that route, we should either do one of the two.

 - The patch [1/2] does such a "style update" only on existing tests
   to improve their readability, and then patch [2/2] then does your
   addition to the tests, together with the code change.

 - Or you do this patch alone, without touching existing tests, but
   with your tests added in an easier-to-read style.  And then after
   the dust settles, a separate "style udpate" patch clean the
   existing ones up.

> By the way, before contributing, I saw there is some work on moving to
> unit tests. I wasn't sure how to test this particular feature there, so
> I went with the "old" approach as it seemed more natural. Is this ok?

We are not really "moving to".  We did not have a test framework for
effective unit tests, so some tests that would have been easier to
manage as unit tests were instead written as an end-to-end
integration tests, which was what we had a framework for.  These
tests are moving to, but for a test like "the user uses the
'[includeIf X:Y] path = P' construct---does the git command really
shows the effect of include from P when condition X:Y holds?", the
unit testing framework would not be a better fit than the end-to-end
behaviour test, I would say.


