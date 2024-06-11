Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205BE1109
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 00:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718065796; cv=none; b=SbYyFKoUrBptCcsdxAjAn0Z/O6aHAdx3tBSOkgzBVHMRo7Qir1XcXs/Ykh/lTnGhwWQYKmsSu9ToP0Lc0D9OrUMbLTYbBkLD5bD5TsHEORttspWoFRXwG7MKzWUnDcRAIigc3HqOWyeAIXZC55Up9dTovZbSGWxCT9PssxpbJdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718065796; c=relaxed/simple;
	bh=j9uNN99fZKUZDkjZOTzfHS1rpsSy1q0EeddVilD5Qps=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EXxuQQ0Hmk3nuigcpHvrvawWec9xwIrzQOuCzPHqrGOkY8zIAboejRJs8TX33M4FOk2EjGYha4D9i5tibgquLH603mhe/pB1uWtuD8zUxtvldVcRq0Y77uJDV+SirgxEk0ckUQ+KPYKbuVWkBblQjV8aDS00WzOrXcx5y1csat0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FzY8YtZs; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FzY8YtZs"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7818532461;
	Mon, 10 Jun 2024 20:29:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=j9uNN99fZKUZDkjZOTzfHS1rpsSy1q0EeddVil
	D5Qps=; b=FzY8YtZsk0Y/NNoSSpZYiHxVa4/5P6Qj5asSRQXzJ3/KRlRLDME29m
	+tgP2FCQQyzSOFa4tx9TQLDqSvLR2rPJjCNRvKbGi8EOpYsLDPdfQNKhi58/6T3b
	RPDy+B1nCmj2StCB7r3SDxHMMpu+T+ByRLqoD3dXObRTAMMNJrWiw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6380E32460;
	Mon, 10 Jun 2024 20:29:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 10A9E3245F;
	Mon, 10 Jun 2024 20:29:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'Yuri'" <yuri@rawbw.com>,  "'Git Mailing List'" <git@vger.kernel.org>
Subject: Re: [BUG] "git clean -df ." silently doesn't delete folders with
 stale .nfs* files
In-Reply-To: <0ee501dabb91$aa2340a0$fe69c1e0$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Mon, 10 Jun 2024 19:55:20
	-0400")
References: <ae862adb-1475-48e9-bd50-0c07dc42a520@rawbw.com>
	<xmqqwmmw1sev.fsf@gitster.g>
	<4ed426e4-beb6-45ed-b493-1e19c7c0511b@rawbw.com>
	<xmqqikygzdgk.fsf@gitster.g>
	<e8feffd0-ba6d-4aae-8c80-3d6482896b08@rawbw.com>
	<0ee501dabb91$aa2340a0$fe69c1e0$@nexbridge.com>
Date: Mon, 10 Jun 2024 17:29:49 -0700
Message-ID: <xmqqmsnsxqwy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B74930D2-2789-11EF-B435-8F8B087618E4-77302942!pb-smtp21.pobox.com

<rsbecker@nexbridge.com> writes:

> I have tried to reproduce your situation using git 2.43.0 without success.
>
> $ mkdir test
> $ cd test
> $ touch .nfs12309
> $ git clean -df .
> Removing .nfs12309

I suspec that this is different from a real NFSv3 client in that
removal of such "removed while still open" files would result in
another one automatically resurrected by the filesystem.

In any case, if we cannot remove a file (due to filesystem
limitation), we should report the fact, just like in a case
where we cannot remove a regular file, e.g.

    $ cd git.git/
    $ mkdir -p junk/ttt
    $ >junk/ttt/sss
    $ chmod a-w junk/ttt
    $ cd junk
    $ git clean -f -d -x ttt; echo $?
    warning: failed to remove ttt/sss: Permission denied
    1

Figuring out why it is not happening is left as an exercise to
readers ;-), as I no longer have an NFSv3 environment handy.

Thanks.
