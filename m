Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2798158D99
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 17:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548744; cv=none; b=lSPnL7W82OU++YaBGxInMQY6GTmTz8NH8I0koV+bqgGofBlXqvocRrj1BDnda38olOvXkKlv6mWmOeHJNG4A/8ks9LuNMc8/0d/qbGphIr8qdNL/FWx9qoD4WsFL3VTJAwVt1xOxzeE394A87eEPEEbShm2VXubwP7r28+cl2oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548744; c=relaxed/simple;
	bh=Ll+Gh7BSFtsPbh1LglAvtjDhgWKPZojO+VTCgz0sHaE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T1P4BwyuUX/9QppXWF781LIzvfuaRFUx7lPEIdMon4OfT60DEMQEscaQ/JXoLYAuhtsI9SmljrZyWHteeSfPbJpNTRcrrJFGbMiAaFSEspohi4C5bd6lTL/lOljlZ/9c9bDkPbG6YyACh9yCfh/3qMLfZt9/i32J+zMPPh0kgGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GMr4OJ7a; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GMr4OJ7a"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AFB3D20947;
	Mon, 29 Jan 2024 12:19:01 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Ll+Gh7BSFtsPbh1LglAvtjDhgWKPZojO+VTCgz
	0sHaE=; b=GMr4OJ7aI7JLKPablUcH59CD0RNL6m7OIVGs8Ex4uPdT1ZomeTZHIi
	idKHtIBv4O0ehOuxlZVIAEKEOspCAbcyOVexdQxtjXm+V1DBBh7KML8zTANkICF4
	Kei57RgOQDbhJjPe7uU6dcdn3kCh6Py5uG+XE/MvVCY34EAColRpc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A85E520946;
	Mon, 29 Jan 2024 12:19:01 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3FE0720943;
	Mon, 29 Jan 2024 12:18:58 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: John Cai <johncai86@gmail.com>,  John Cai via GitGitGadget
 <gitgitgadget@gmail.com>,  Jonathan Tan <jonathantanmy@google.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v3 0/2] index-pack: fsck honor checks
In-Reply-To: <ZbeI0ksoUQEkbt90@tanuki> (Patrick Steinhardt's message of "Mon,
	29 Jan 2024 12:15:30 +0100")
References: <pull.1658.v2.git.git.1706289180.gitgitgadget@gmail.com>
	<pull.1658.v3.git.git.1706302749.gitgitgadget@gmail.com>
	<xmqqfryjn686.fsf@gitster.g>
	<BF772E83-2BFE-4652-A742-67FADF3D8FE2@gmail.com>
	<ZbeI0ksoUQEkbt90@tanuki>
Date: Mon, 29 Jan 2024 09:18:56 -0800
Message-ID: <xmqqplxkjbwf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7CDF776C-BECA-11EE-A94A-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> I'm always a bit hesitant to add trailers referring to off-list reviews
> to commits. It's impossible for a future reader to discover how that
> trailer came to be by just using the mailing list archive, and expecting
> them to use third-party services to verify them feels wrong to me.
>
> It's part of the reason why I'm pushing more into the direction of
> on-list reviews at GitLab. It makes it a lot more obvious how such a
> Reviewed-by came to be and keeps things self-contained on the mailing
> list. It also grows new contributors who are becoming more familiar with
> how the Git mailing list works. If such a review already happened
> internally due to whatever reason then I think it ought to be fine for
> that reviewer to chime in saying that they have already reviewed the
> patch series and that things look good to them.

Thanks.  That would improve clarifying a situation like this one
(eh, actually, once it is done this particular situation wouldn't
need any clarification).

