Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pkdyaX4k"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38608D0
	for <git@vger.kernel.org>; Tue, 12 Dec 2023 14:28:13 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8AAE82F973;
	Tue, 12 Dec 2023 17:28:12 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=waf+nM5oQ0s/MBxVo8klHoFaEYJ5hWodz3Fhl1
	KSYZM=; b=pkdyaX4kAFrwiKhscvAANhbzGvVTHhlDPOHVFYHsup7pxFyquKYzre
	rcdQqfj7u7OgyZsew2Je7A5iZzk/eMdpUSAk2dLJwPwrwqp3/Ahed/X/f1QggEZb
	vfBvMC411tblPmfs5uucuD4RSBF5WMRcylnvmg+V1o3PMkW4j60Q4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 832BF2F972;
	Tue, 12 Dec 2023 17:28:12 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D4F152F971;
	Tue, 12 Dec 2023 17:28:08 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Zach FettersMoore <zach.fetters@apollographql.com>,  Zach FettersMoore
 via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v6] subtree: fix split processing with multiple subtrees
 present
In-Reply-To: <CAP8UFD19phFz54d8fDM=MBRMSD9Rz4R0_463KgptN8eeFs7MnQ@mail.gmail.com>
	(Christian Couder's message of "Tue, 12 Dec 2023 17:06:38 +0100")
References: <pull.1587.v5.git.1701206267300.gitgitgadget@gmail.com>
	<pull.1587.v6.git.1701442494319.gitgitgadget@gmail.com>
	<CAP8UFD3FzP6QW4dJ9yiG1BAytLcsk+zGE+CBeArRJBJ8gsaDMQ@mail.gmail.com>
	<CAEWN6q3RTbVuMb0VyCYz196ZL+OGAAHbJLZ2-MnW1RVVabg7Mw@mail.gmail.com>
	<CAP8UFD19phFz54d8fDM=MBRMSD9Rz4R0_463KgptN8eeFs7MnQ@mail.gmail.com>
Date: Tue, 12 Dec 2023 14:28:07 -0800
Message-ID: <xmqqzfyfoy2w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BA125B7A-993D-11EE-B323-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

>> > $ git subtree split --prefix=apollo-ios-codegen --squash --rejoin
>> > Merge made by the 'ort' strategy.
>> > e274aed3ba6d0659fb4cc014587cf31c1e8df7f4
>>
>> Looking into this some it looks like it could be a bash config
>> difference? My machine always runs it all the way through vs
>> failing for recursion depth. Although that would also be an issue
>> which is solved by this fix.
>
> I use Ubuntu where /bin/sh is dash so my current guess is that dash
> might have a smaller recursion limit than bash.

That sounds quite bad.  Does it have to be recursive (iow, if we can
rewrite the logic to be iterative instead, that would be a much better
way to fix the issue)?
