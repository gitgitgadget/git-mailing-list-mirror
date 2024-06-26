Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27683181CE2
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 14:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719413958; cv=none; b=iAc99LsQxdSgIGYyfYHpdQlaKhid4jopThNJJInxrUCSYEk4O8RR8KgBFjLEWYVm9i4hcUApvhM3G///ERXZw62mtBR++gm/dz5LuXpfjjLalkMaR3BDzcukz7kM4MzXoErxIqJTOjpkucha045Dle4ez2OzUZH/Rxps+YZrqQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719413958; c=relaxed/simple;
	bh=IM9iM6PJt5iKQhkVtaasrLmOklKc7YWCBX5AONATjGo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AekzGH4AWU5WhE7ElXeJiZJhsyTljnfzbCXkeuuoEkgO9RX4/gMS6o3lx7L2XT4aFa7nQCHH3QP6ohPIJZ86HtMJIbIZikckFRt9PhFY/VJc+QkfHaBDZXFAqeJ7kRcyg8aF0Fxb0w8Dd74vg+uJ9k/nKmF0uG0cbhEB3g64SQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=treUre8Q; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="treUre8Q"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A500A3206B;
	Wed, 26 Jun 2024 10:59:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=IM9iM6PJt5iKQhkVtaasrLmOklKc7YWCBX5AON
	ATjGo=; b=treUre8QAfERsmj5CNgyOWTgv2Bcb3XpD+Oa/6IxllxWLIXL7jMUl/
	pbJZgkVJlISKIXwkm6v1nRvwEWqGO1imSIFHFLuSSZ1XwpXuhsDrtqOxOB//VbtJ
	dyyD1sz5C1AUmMGyhyPDOhhh5aaIBQkLFAB1J+i2rA6eVwPlU2tlM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9CC543206A;
	Wed, 26 Jun 2024 10:59:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 27B9532069;
	Wed, 26 Jun 2024 10:59:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Abhijeet Sonar <abhijeet.nkt@gmail.com>,  git@vger.kernel.org,  Paul
 Millar <paul.millar@desy.de>,  Phillip Wood <phillip.wood123@gmail.com>,
  Elijah Newren <newren@gmail.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v5] describe: refresh the index when 'broken' flag is used
In-Reply-To: <CAOLa=ZRz2KEGiBnX1YP6JG1nXXHLfw9A3dHKO3s_ViLhq+bWww@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 26 Jun 2024 07:30:19 -0400")
References: <xmqq34p1813n.fsf@gitster.g>
	<20240626065223.28154-1-abhijeet.nkt@gmail.com>
	<CAOLa=ZRz2KEGiBnX1YP6JG1nXXHLfw9A3dHKO3s_ViLhq+bWww@mail.gmail.com>
Date: Wed, 26 Jun 2024 07:59:10 -0700
Message-ID: <xmqqmsn7698h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A5EB722E-33CC-11EF-A928-C38742FD603B-77302942!pb-smtp20.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

>> +		cat file >file.new &&
>> +		mv file.new file &&
>> +		git describe --dirty >actual &&
>> +		echo "A" >expected &&
>> +		test_cmp expected actual &&
>> +
>> +		cat file >file.new &&
>> +		mv file.new file &&
>> +		git describe --dirty --broken >actual &&
>> +		echo "A" >expected &&
>> +		test_cmp expected actual
>
> Not worth a reroll, but you don't have to create file.new twice.

I think you have to make the "file" stat-dirty again after the first
test, as a successful first test _should_ refresh the index (and
that was why my manual illustration in an earlier message
<xmqqsex2b4ti.fsf@gitster.g> did "--dirty --broken" first before
"--dirty" alone, knowing that the former fails to refresh the
index).

You are right to point out that the expected results for "--dirty"
and "--dirty --broken" are the same and we do not have to create it
twice, though.

If the filesystem has a usable inode number, then replacing "file"
with a copy, i.e. "cat file >file.new && mv file.new file", is an
excellent way to ensure that the stat data becomes dirty even when
it is done as a part of a quick series of commands.  But not all
filesystems we run our tests on may have usable inode number, so it
may not be the best thing to do in an automated test.  We could use
"test-tool chmtime" instead, perhaps like:

    ... make the index and the working tree are clean wrt HEAD ...
    # we do not expect -dirty suffix in the output
    echo A >expect &&

    # make "file" stat-dirty
    test-tool chmtime -10 file &&
    # "describe --dirty" refreshes and does not get fooled
    git describe --dirty >actual &&
    test_cmp expect actual &&

    # make "file" stat-dirty again
    test-tool chmtime -10 file &&
    # "describe --dirty --broken" refreshes and does not get fooled
    git describe --dirty --broken >actual &&
    test_cmp expect actual

with the extra comments stripped (I added them only to explain what
is going on to the readers of this e-mail message).
