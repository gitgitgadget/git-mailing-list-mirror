Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA36EADA
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 06:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710569071; cv=none; b=s/zkh69TgrN3XbK6rYfrsYXJ+pYooG1BastEr8W6nAnJxYCKbf+coVwLKiDd1z5fKf4FUYaF+lbZNrFH/FRB/St49wnTlQ03zJck0pHFMAhLsfz77UN4MCnE3++5CpTtIETAfGd5P0hhlcEd/7VDvlDyGA3lYRwzGtGTd90T92E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710569071; c=relaxed/simple;
	bh=1yITBDXJZhtPTtUp5deTcVz9LvzzyKMii7oAqW6h7tg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GQGW9d51GbeY7/BfgYBQt83lIQPvN9xbYyPeawspEhIF1ZuTwYLsmYT8JCmEU4xzKurhMjD6dPmn+C1UXWL0qANTIpYDO7pk+6K0tC3UpmKvBU0UGiofbT2x+FsT5zTMl4RZr2wOlQFdG26hkV8LQgCmGPXh+YORu4QXWL0eigo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hL+IkWcl; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hL+IkWcl"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 943BB30E61;
	Sat, 16 Mar 2024 02:04:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1yITBDXJZhtPTtUp5deTcVz9LvzzyKMii7oAqW
	6h7tg=; b=hL+IkWclNQX75lWtluGL8TpGLEnORVjMpdajlDrBqjJUWSg+sSN+IE
	IV155MjMQMI3233RVbu0RQEQUtaShC0CLdYWKytF25d23DSV3OOzIX7Q27iDnjfb
	7NpWH/o/uh2sEdm1VDcXoWz+lUf91gR/nrXGrmJHO6rPwJgMV6PdM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8E34B30E60;
	Sat, 16 Mar 2024 02:04:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7279030E5F;
	Sat, 16 Mar 2024 02:04:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Beat Bolli <bb@drbeat.li>,  git@vger.kernel.org,  Beat Bolli
 <dev+git@drbeat.li>
Subject: Re: [PATCH v2 09/22] t/t4*: avoid redundant uses of cat
In-Reply-To: <ZfT3H7IiewuhAA7M@nand.local> (Taylor Blau's message of "Fri, 15
	Mar 2024 21:34:23 -0400")
References: <20240305212533.12947-1-dev+git@drbeat.li>
	<20240315194620.10713-1-dev+git@drbeat.li>
	<20240315194620.10713-10-dev+git@drbeat.li>
	<ZfT3H7IiewuhAA7M@nand.local>
Date: Fri, 15 Mar 2024 23:04:22 -0700
Message-ID: <xmqqy1ain255.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0A075DA8-E35B-11EE-BA2C-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> This and the two similar transformations below it look good to me. This
> obviously isn't the fault of your patch (nor should it necessarily be
> its aim to fix), but I wonder if it would be worthwhile to extract the
>
>     tr "\0" "\n" <out | head -n 3 | grep 3.bar | cut -f 2 -d " "
>
> pattern into a helper function, since it's used in a few places in this
> test script.

I somehow thought that the theme of the topic is to reduce the depth
of the pipeline.  "head -n 3" piped into "grep" sounds something a
single sed script can do, e.g.

	tr '\000' '\012' <out |	sed -n -e '1,3s/3.bar/&/p'

> That's just a suggestion, and shouldn't hold up this patch/series. Maybe
> just some #leftoverbits :-).

Ditto.  The whole thing can be turned into a Perl scriptlet, which
may be even easier to read (the cost to spin up one Perl interpreter
might be greater than constructing 4 process pipeline on certain
systems, though).

Thanks.

P.S. It is nice to hear from you Taylor.  It's been a while.

