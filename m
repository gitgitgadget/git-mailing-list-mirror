Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE04208CB
	for <git@vger.kernel.org>; Mon, 13 May 2024 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715620560; cv=none; b=EKNor6RJ66Vi8qL+YkmawkoN43g7FM1qR37ju0lmFYVaRIgAvgSdL9pxf+zEulES8RJAa2JR9q7ZvMls0turywKxS7z3tbYmVrStgQpSFGJONTqGG43ZQ0+N7EgLoSjY35rNH5oylQ2W0YHSWWmcK5b4uWNv/HspVzvRcKj7lu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715620560; c=relaxed/simple;
	bh=H5D4ryJHhbjD/WNEN1CFJIphkmiHXh2lzXtn93MtM44=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d8RFYhLf7rxEFfcatuQTP7WcW6oQEiDsiCUXwcBln64vHiXZw8OWnJQcQDOsi7mO1p2/7tL84nWjVC+/IY6rjlGtAsXu9XoYqRRy0dFMSWJ0HHAVBx2jdD6qjpuaiuGPjU6m2tL0Xs03wFn0qxMUW9lquFyaNbE+9Q+WR2+LyLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xkYAC75E; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xkYAC75E"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BF44C26B01;
	Mon, 13 May 2024 13:15:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=H5D4ryJHhbjD/WNEN1CFJIphkmiHXh2lzXtn93
	MtM44=; b=xkYAC75EWZyGmElyV4DdsS8Qh+JfKdYutQjdOxD4AykXYbUlk4KQmM
	mEZEzQ3kWkVPjpHEndY0TTJUzBxHK8znbqnXIlkY5ECyE8j4PNFHnqD6AGgKGrA1
	ljU5ZI1Sypo8I+lojVvKcY3V7gE3rckMhmcuyMwpcHmLQ/D7t54v4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B6FFE26B00;
	Mon, 13 May 2024 13:15:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2A62A26AFF;
	Mon, 13 May 2024 13:15:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  phillip.wood123@gmail.com
Subject: Re: [PATCH v8 0/8] refs: add support for transactional symref updates
In-Reply-To: <CAOLa=ZRERwUEbj3nc+SUuiLvwJ+JK7qswxX4P6hbstX4+5vXHw@mail.gmail.com>
	(Karthik Nayak's message of "Sun, 12 May 2024 10:17:14 -0700")
References: <20240507060035.28602-1-knayak@gitlab.com>
	<20240507125859.132116-1-knayak@gitlab.com>
	<xmqqy18lpoqg.fsf@gitster.g>
	<CAOLa=ZRERwUEbj3nc+SUuiLvwJ+JK7qswxX4P6hbstX4+5vXHw@mail.gmail.com>
Date: Mon, 13 May 2024 10:15:55 -0700
Message-ID: <xmqqy18dfx9w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 75B75228-114C-11EF-A07B-25B3960A682E-77302942!pb-smtp2.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> I find the '...' always so confusing, I would say suggesting to use
> 'git-merge-base' would be much nicer here.

They are equivalent, except that "..." in

	git checkout --detach A...B


is internal as opposed to

	git checkout --detach $(merge-base A B)

that uses one extra process.  I thought people loath spawning
processes?

>>      Check out the latest 'origin/master' (which may be newer than
>>      the base used by (2)), "merge --no-ff" the topics you newly
>
> For my own understanding, even if we use '--ff' the end result should be
> the same, but using '--no-ff' would ensure that the changes and
> conflicts are isolated to the merge commit, right?

It will make it easy for you to look at 

	git log --first-parent --oneline master..

by hiding the base commits you depend on behind a single merge
commit.

>>      $ git merge --no-ff --into kn/ref-transaction-symref ba/zqux
>>      ... rebuild the topic ...
>
> I guess you mean '--into-name' here? I would skip mentioning this since
> it doesn't have any real effect and is perhaps confusing.

Again this is to help that "one liner first-parent chain" output.
