Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8864A1E4BC
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 01:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708392169; cv=none; b=ZPrudK7v1IQfkkouqso/DpKvWGJ2JAcFYkAhGXoCv1VQe/NjPjxYbWxpqIw9LpXdq1NKPd6Oz0FzhXRdw8B1uL5n/gMH6YGINDgp2cUp4OGzQWOj2KPiR6GH8+4/erWXNO1ZDVwwngiWYFX0wGp8JO0enC6QNijtpEbRBLuuXxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708392169; c=relaxed/simple;
	bh=GWjYIsb+ZNo3mIF8XY+7JbrinUrV1VSEwlE/5hanpuI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nck5+rAVAgAtKnAKVHQcOd2z+dD2PtSVr9ZmchU2DYIoZGJJVEGXeglTbdT2jkRPB06UZ7uP7Ft1m4TjmZ2cO79OnBFgt5E4HWDUyu2Kkwgz6gqkgoLai0ahD9jaa70SQ/Rll7XF9JKUCOiZC5Rkd6gcN6iF/5k9wTp6hSJsmBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xvSK5NpC; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xvSK5NpC"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 71A131D480B;
	Mon, 19 Feb 2024 20:22:46 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=GWjYIsb+ZNo3mIF8XY+7JbrinUrV1VSEwlE/5h
	anpuI=; b=xvSK5NpCDKUIyaqHrlQnoNru6xC+UMJthHUsNsvsrBK13fZtIGxKlS
	D3VUKl8QlNM+Bz4VuKZDSRfgDA3F6HBRPNKxjEXW1yvBdUL/CJSOMIqLhKgq9H+/
	UEpIRccFYYqQ+n4ph39c9SCjQWGrGTu93eUWVk+JWGvHPho9t2wFU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A5221D4808;
	Mon, 19 Feb 2024 20:22:46 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CC99E1D4807;
	Mon, 19 Feb 2024 20:22:45 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Maarten Bosmans <mkbosmans@gmail.com>
Cc: git@vger.kernel.org,  Maarten Bosmans <maarten.bosmans@vortech.nl>
Subject: Re: [PATCH v2 1/5] log: Move show_blob_object() to log.c
In-Reply-To: <20240218195938.6253-2-maarten.bosmans@vortech.nl> (Maarten
	Bosmans's message of "Sun, 18 Feb 2024 20:59:34 +0100")
References: <20240205204932.16653-1-maarten.bosmans@vortech.nl>
	<20240218195938.6253-1-maarten.bosmans@vortech.nl>
	<20240218195938.6253-2-maarten.bosmans@vortech.nl>
Date: Mon, 19 Feb 2024 17:22:44 -0800
Message-ID: <xmqqjzn0x72z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8D55A132-CF8E-11EE-BD23-25B3960A682E-77302942!pb-smtp2.pobox.com

Maarten Bosmans <mkbosmans@gmail.com> writes:

> Subject: Re: [PATCH v2 1/5] log: Move show_blob_object() to log.c

"Move" -> "move".

> From: Maarten Bosmans <mkbosmans@gmail.com>
>
> From: Maarten Bosmans <maarten.bosmans@vortech.nl>

The earlier one is not needed.  Please do not include such a line.

>
> This way it can be used outside of builtin/log.c.
> The next commit will make builtin/notes.c use it.

The resulting file is only about a small part of the implementation
detail of "show", and has very little to do with "log".

"show.c" that happens to house show_blob_object(), a "canonical" way
to display a blob object, with an anticipation that somebody may
want to expand it in the future to house the "canonical" way to
display a tag, a tree or a commit object, would be OK, though.
