Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB0682880
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 15:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703020; cv=none; b=AFlxbZqMY4sAc1Z85WHdqBh/MBxmiC68PNzBmSLgsNc/3DobmXcC6JUT4PJ6E7YLrTzVQN0qOtl4vAcraUA+ooZUxhuWfo/+JCwNsbE8TzvZ5aItwJvTNbFf+fMTq3ox8JPXmxYXcnXpBfrDfBY6NTQtEYbgFoQvgTW5DIQ6k4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703020; c=relaxed/simple;
	bh=6Rl+thCn10CNsuUDYyPcgxOYJMKBiYIjHGGWB2chqbs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f/C9HVDqQyXTbub954PKNxDkRIia5CqukkQ2hzqrTDNZQML4KYIOmOGidUL+i4Iv+s8FJz2SFSgB0VzTj9yt7R03RhUFw8u+A658OUvJJje1+J3MoN9rhQQ2rzLx8FPpAuunBh9rmVmCSMaggJhd3rWnpA2o8EE5Bql+oYqpGNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JIm1avK3; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JIm1avK3"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9E2CF25691;
	Fri, 23 Feb 2024 10:43:38 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=6Rl+thCn10CNsuUDYyPcgxOYJMKBiYIjHGGWB2
	chqbs=; b=JIm1avK3Q5IXPPZh1X+O4pzlQdZxLhfVsdiYpcZaoFyYip0v4rGz1/
	7s/hilDsGs3iowN1u2UIdDBYMuPlGoVaxiHbK9ZhTyKM8WRfbu5beb4XwZBG9+7q
	7n8P+ikyvy+RbHrfvXTehFz39Q8cS9OagBBtFpoChDmehuNqf29hU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8378F2568E;
	Fri, 23 Feb 2024 10:43:38 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3CEEA2568B;
	Fri, 23 Feb 2024 10:43:33 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Leslie Cheng via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Eric Wong <e@80x24.org>,  Leslie Cheng
 <leslie.cheng5@gmail.com>,  Leslie Cheng <leslie@lc.fyi>
Subject: Re: [PATCH v2] Add unix domain socket support to HTTP transport
In-Reply-To: <xmqqzfvrzic9.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	23 Feb 2024 00:37:58 -0800")
References: <pull.1681.git.git.1708506863243.gitgitgadget@gmail.com>
	<pull.1681.v2.git.git.1708653536115.gitgitgadget@gmail.com>
	<xmqqzfvrzic9.fsf@gitster.g>
Date: Fri, 23 Feb 2024 07:43:31 -0800
Message-ID: <xmqq5xyfyyn0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4CD43C14-D262-11EE-B857-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> "Leslie Cheng via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> Subject: Re: [PATCH v2] Add unix domain socket support to HTTP transport
>
> Perhaps
>
> 	Subject: [PATCH] http: enable proxying via unix-domain socket
>
> to follow the usual "<area>: <description>" format?
>
>> From: Leslie Cheng <leslie.cheng5@gmail.com>
>>
>> This changeset introduces an `http.unixSocket` option so that users can
>
> "This changeset introduces" -> "Introduce".  There may be other
> gotchas that might use help from Documentation/SubmittingPatches,
> but I didn't read too carefully.
>
> Besides, it is a single patch, not a set of changes ;-).
>
> `http.unixSocket` is a configuration variable.  It may be confusing
> to use the word "option".  Speaking of options, shouldn't there be a
> command line option that overrides the configured value?
>
> We should honor the usual http.<url>.VARIABLE convention where
> http.<url>.VARIABLE that is destination-specific overrides a more
> generic http.VARIABLE configuration variable.

Clarification.  I know the above is automatically achieved, given
the way we have laid urlmatch foundation to allow easy parsing for
configuration variables structured this way.  I did not mean that
you'd need to do anything special; rather, I meant that we should
advertise that we do in the commit log message.

