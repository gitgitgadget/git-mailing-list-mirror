Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49930635
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 04:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725424896; cv=none; b=DWM7uDCSRYJEngVfVnDBFmuEIsDddaKxqCn5fOOf9lGG7g7ResnA6C+nOSGgXDndGkGgBy4URFaEWwVsJxY5Q5frTjDvvp45PHuLDUV3RvBlCO2dAq0QRrGWV8FbZJ8lGTAykzLXReq7SMxZCKWR8M+SdcI/WEmsCNHpGJVI/V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725424896; c=relaxed/simple;
	bh=j+M8tehX3y+jG62fggJz7AvNdHAyvTN7VDrCPRlWhUA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jgj5AkZLoaZKjhES88iDP8+u98IcaC7KPTnHJRKrsR/Gwvr/b9hEVPWiiiT3Xu1zPk0eyJ+lOu6+JWM4JICOwSxFat9GuaHXKCIFhfjN43gjcUo1LOT0eW65ejmNwOByEGMryC3Vcc96FTuG4eqRCGkY9ZeiccyHoT9pJ/Ako1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WgdBKZ1P; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WgdBKZ1P"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 219923E1BB;
	Wed,  4 Sep 2024 00:41:33 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=j+M8tehX3y+j
	G62fggJz7AvNdHAyvTN7VDrCPRlWhUA=; b=WgdBKZ1Pps0W2gO6/ZrpFvRXXeZ2
	TmKPXW2Q2LF8RghefiMp/kbO0TdpvC5VlnmJnydkS5iNCZDTdzyixSrAgfR8EzSE
	PkOSPLumyz7bvQyE5mDUhGKhrecIKXJbqCXdWp0QZpVc7Kdja4/O0gtFooCxWFkk
	qCi7GrwZ51G+xMc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 191563E1BA;
	Wed,  4 Sep 2024 00:41:33 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 814433E1B9;
	Wed,  4 Sep 2024 00:41:32 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/5] apply: honor `ignore_ws_none` with `correct_ws_error`
In-Reply-To: <50d85a93-6711-4b42-87a5-f26b58b8c5c7@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Wed, 4 Sep 2024 00:06:10 +0200")
References: <6dd964c2-9dee-4257-8f1a-5bc31a73722e@gmail.com>
	<1eb33969-1739-4a27-a77b-3f4268f5519d@gmail.com>
	<xmqqseuqerb1.fsf@gitster.g>
	<afade304-51e3-441d-9ae6-e0a422d00bc4@gmail.com>
	<xmqqed66udmd.fsf@gitster.g>
	<50d85a93-6711-4b42-87a5-f26b58b8c5c7@gmail.com>
Date: Tue, 03 Sep 2024 21:41:31 -0700
Message-ID: <xmqqseugdo90.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 F592F6A8-6A77-11EF-9501-9B0F950A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> If I understand correctly the example you mentioned, using
> `in_fn_table()` cannot help us in `parse_fragment()`.  But I could be
> completely wrong and misunderstanding your intention.

Hmph.  It's unfortunate that the control flow goes like this:

 apply_all_patches()
 -> apply_patch()
    -> parse_chunk()
       -> parse_single_patch()
          -> parse_fragment()
    -> use_patch()
    -> check_patch_list()
       -> check_patch()
          -> apply_data()
             -> add_to_fn_table()

So deciding if a context line (or a new line for that matter)
contains a whitespace error is done too early in the current code,
and if you want to do this correctly, you'd need to move the check
down so that it happens in apply_one_fragment() that is called in
apply_data().  The rest of the whitespace checks are done there, and
regardless of the "patch that touches the same path twice" issue,
it feels like the right thing to do anyway.

Such a "right" fix might be involved.  If we want to punt, I think
you can still inspect the *patch inside parse_single_patch(), and
figure out if the target path of the current fragment you are
looking at has already been touched in the current session (we parse
everything into the patch struct whose fragments member has a
chained list of fragments).  Normally that should not be the case.
If we know we are not being fed such a patch with duplicated paths,
we do not have to inspect whitespace issues while parsing a context
' ' line in parse_fragments().

> I still don't see a better option than introducing a new value
> `default`.

As long as we can tell that our input is not a patch that touches
the same path twice, we shouldn't need a new knob or a command line
option.  When we are dealing with Git generated patch that does not
mention the same path twice, we can unconditionally say "unless
--ignore-space-change and other options that allow loose matching of
context lines are given, it is an error if context lines do not
exactly match, even when we are correcting for whitespace rule
violations".  Otherwise, we may need to keep the current workaround
logic in case a later change has a line as a ' ' context for a file
that an earlier change modified (and fixed with --whitespace=3Dfix).
=20
It is a different story if all you want to change is to add to
--whitespace family of options a new "silent-fix" that makes
corrections in the same way as "fix" (or "strip"), but wihtout
giving any warnings.  I think it makes sense to have such a mode,
but that is largely orthogonal to the discussion we are having, I
think, even though it might result in a similar effect visible to
the end-users.

Thanks.
