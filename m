Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466B01E86F
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 17:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706290011; cv=none; b=IX2MFsy+Yg37mPae5jylPxi/rW6l2DHfxCgQ+zjs4l0+LVNM8iiSedvS+jmGV/taVEW4EaprrW1fLcgQGXUPOV9ZFGjlNddMPJin+9O8/JbRkkr/Kwd1tcE1opc5Ie8JmwRwoR98oGl0W61YelgfuKDt1c7PuLcQYtwNHw4NXps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706290011; c=relaxed/simple;
	bh=zKTiGOE+0lPpOXoDWvN7BCpVCS3wqh50ibjopFFE5+o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ddENQ6ewqEAaYzu4D/iAm0ihB/KF8UO035cnJ34GSMLXqCB0B04WW2MnOebdsz/unnYshj42StIwIMlkqgqGrDY7ANcyv1KzlOpIOcunA0Rkv4pQLm/kpBMxzZv0TnwipxDocmlV7rXIRzu8P7zR0fwh3pNIOIWLrTgypHRbNyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=iEsBd2na; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iEsBd2na"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 94BA02C440;
	Fri, 26 Jan 2024 12:26:49 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zKTiGOE+0lPp
	OXoDWvN7BCpVCS3wqh50ibjopFFE5+o=; b=iEsBd2naz74MWVF8dA0XhzY0k/Ud
	esbYmyEwrM8AQCFhC8zbmM+j9XYhuW2ECcLzwRh79is9kT3AkR5KrXaHjoy1QCO6
	NwqHac4Zvv8VInbeFEnypoXhaoZO746NGCdTjfJfQCwjuZtIRFB+lfMqfswFmrcZ
	VnREI1PLlZEndFU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8E4982C43F;
	Fri, 26 Jan 2024 12:26:49 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 39B2F2C43E;
	Fri, 26 Jan 2024 12:26:46 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/4] completion: introduce __gitcomp_subcommand
In-Reply-To: <8c902c53-815d-43c2-8ba9-8144d8884804@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Fri, 26 Jan 2024 13:51:27 +0100")
References: <98daf977-dbad-4d3b-a293-6a769895088f@gmail.com>
	<8c902c53-815d-43c2-8ba9-8144d8884804@gmail.com>
Date: Fri, 26 Jan 2024 09:26:44 -0800
Message-ID: <xmqqmsssngyz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 1491C16C-BC70-11EE-96F9-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> +# Completion for subcommands in commands that follow the syntax:
> +#
> +#    git <command> <subcommand>
> +#
> +# 1: List of possible completion words.
> +# Returns false if the current word is not a possible subcommand
> +# (possitioned after the command), or if no option is found in
> +# the list provided.
> +__gitcomp_subcommand ()
> +{
> +	local subcommands=3D"$1"
> +
> +	if [ $cword -eq $(($__git_cmd_idx + 1)) ]; then
> +		__gitcomp "$subcommands"
> +
> +		test -n "$COMPREPLY"
> +	else
> +		false
> +	fi
> +}


I am not at all familiar with the code in this file, so treat this
as a question from somebody who do not know the calling convention
used around here.

This helper function clobbers what was in COMPREPLY[@] before
calling it, from a caller's point of view.  Is it a pattern that
potential callers in this file should already find familiar, and
they do not have to be reminded that they cannot rely on what they
prepared in COMPREPLY to be preserved across a call into this
function?  Otherwise I would suggest mentioning it in the helpful
comment before the function, but I cannot tell if such a comment is
even needed by the intended audience, so...


