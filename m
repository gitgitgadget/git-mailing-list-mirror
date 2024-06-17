Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646FB1BDEF
	for <git@vger.kernel.org>; Mon, 17 Jun 2024 19:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718652928; cv=none; b=SWMeUoA8bAW4ZYdIhCdhEXg60jl3MfuTxXYcpL8Jov07d8/TBsAHhiZ6KUO14+lVKXKDNaBaU+b3i+FUpjQ7NePL/ASoUCrgPhYJA15eBniF24IJ7Ig4aNBVIn/Npef2HGrhMFpNP9UJYRWRy7xWOYxRiST9E+9euZJQWwxDXT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718652928; c=relaxed/simple;
	bh=9W1ApyrQ5VGsuB39IzacavV25a33jYAzspGqk8yd280=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VxGjz/RWDW6MLbdzthZFDgyonKvMBv0C0ucgI/hGoOn2B5Bji6p2k0f1QH4CxoeIheYtkMUFNOeXnkQA9FP8cwjRJ9zH8tgm8JSA0h8LInptVpLy2mQGZmVBKNeBhVD+OZd7CkB7F0AizbX1rVt6Ma41GekGAmv7Vi4nzpo2aH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=g/Bsv8DN; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="g/Bsv8DN"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 075E122B2E;
	Mon, 17 Jun 2024 15:33:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=9W1ApyrQ5VGs
	uB39IzacavV25a33jYAzspGqk8yd280=; b=g/Bsv8DNKwAQBeWh2CwOQUZbdRy9
	yFsgfZ4E14Kal7xC8EwHONST5WmHjd137UH6G8IOsbl19lLdgYYZtVvPTjEoLJAB
	bZnvfxvlSpux7utaKCTjqY/L9QvG2GpppHcGIWq5fvuXzH7jXnFflvXRykjDxuTO
	ySuy5+ZB/D/HGlA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 00EF622B2D;
	Mon, 17 Jun 2024 15:33:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8F5C322B2C;
	Mon, 17 Jun 2024 15:33:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Miguel_=C3=81ngel_Pastor_Olivar_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Miguel =?utf-8?Q?=C3=81ngel?= Pastor Olivar
 <miguelinlas3@gmail.com>,  Miguel =?utf-8?Q?=C3=81ngel?= Pastor Olivar
 <migue@github.com>
Subject: Re: [PATCH 2/2] cat-file: configurable "best effort mode" for
 symlink resolution
In-Reply-To: <5de72c45e767c4d704503c8cd5c8e6dce4ea04d6.1718615028.git.gitgitgadget@gmail.com>
	("Miguel =?utf-8?Q?=C3=81ngel?= Pastor Olivar via GitGitGadget"'s message
 of "Mon, 17
	Jun 2024 09:03:48 +0000")
References: <pull.1751.git.1718615028.gitgitgadget@gmail.com>
	<5de72c45e767c4d704503c8cd5c8e6dce4ea04d6.1718615028.git.gitgitgadget@gmail.com>
Date: Mon, 17 Jun 2024 12:33:54 -0700
Message-ID: <xmqqr0cv5pp9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 8916BBCE-2CE0-11EF-BAEF-DFF1FEA446E2-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

"Miguel =C3=81ngel Pastor Olivar via GitGitGadget"
<gitgitgadget@gmail.com> writes:

> From: =3D?UTF-8?q?Miguel=3D20=3DC3=3D81ngel=3D20Pastor=3D20Olivar?=3D <=
migue@github.com>
>
> This patch introduces a new "best effort mode" where the object found a=
t
> resolution step N is returned. If we've reached the end of the chain, t=
he
> returned object will be the file at the end of the chain, however, if, =
after
> n resolutions we haven't reached the end of the chain, the returned obj=
ect
> will represent a symlink
>
> The goal is to extend the symlink resolution process and provide the ab=
ility
> to return the object found at the designated depth instead of returning=
 an
> error.
>
> The current code already provides a limit to the maximum number of
> resolutions that can be performed and something similar to this is retu=
rned
> back to the caller:
>
> loop SP <size> LF <object> LF
>
> With the new config setting we are looking to return the actual informa=
tion
> of the object where the resolution stopped. Something similar to:
>
> <oid> blob <size>\ndata\n

I do not think this should be a configuration variable at all.
Either a command line option, or even better yet would be an
in-stream instruction ("flip into the 'tell me the last symlink
you saw before you gave up' mode"), is understandable though, given
that this is strictly for the "batch" mode.

For that matter, it is dubious that the previous one that added a
configuration variable to lower the symlink recursion limit is a
good idea.  It does not affect anything but "cat-file --batch" and
an in-stream instruction, e.g. "in this session, do not resolve more
than 3 levels", sounds like a much better fit to what this wants to
do.  That way, it will be a lot better isolated from unrelated code
paths.  It might even make sense not to introduce the new
max_symlink_depth global variable, but pass it through as a new
member in "struct object_context" given to get_oid_with_context(),
which in turn is passed as a new parameter to
get_tree_entry_follow_symlinks() function.

So, I am supportive to solving the problem this series attempts to
solve, but I am not on board with the design this series took.

Thanks.
