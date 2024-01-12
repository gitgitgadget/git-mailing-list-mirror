Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFA722608
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 17:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ovc6LqB8"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3046F1E3D59;
	Fri, 12 Jan 2024 12:52:10 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+sRRFdsOSy4K
	Yq1zRwuoww/Sp5Lz/CGDMdJQ/drIKzE=; b=ovc6LqB8LS6hgBcNROrvPKc5quMl
	ZgZPmYJHugqqLMQMgE9imYJXFMo4hPXCuVmZSpE4KF8LZSJo1Tq/ePEVuZa46q8C
	lXKGD6bA+VSdwm9mM6NoYs1d59YGqWWL59Mv3xSN4cUvnja9Hp4SNwPx9BLChBGj
	1DuDVLNAbFeKAVg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 27ED21E3D58;
	Fri, 12 Jan 2024 12:52:10 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 85F041E3D57;
	Fri, 12 Jan 2024 12:52:09 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] advice: fix an unexpected leading space
In-Reply-To: <60a90f4e-b22c-46cb-a79f-a0e01e711732@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Fri, 12 Jan 2024 10:10:01 +0100")
References: <04c3556f-0242-4ac3-b94a-be824cd2004a@gmail.com>
	<4aedc15c-4b3f-4f5e-abea-581b501600f8@gmail.com>
	<d5fbdb05-d16a-4390-946e-22a5a7a1b56a@gmail.com>
	<xmqqa5pbcpnx.fsf@gitster.g>
	<60a90f4e-b22c-46cb-a79f-a0e01e711732@gmail.com>
Date: Fri, 12 Jan 2024 09:52:08 -0800
Message-ID: <xmqqsf32bfsn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 4EC0769C-B173-11EE-8A23-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> On 11-ene-2024 17:21:22, Junio C Hamano wrote:
>> Rub=C3=A9n Justo <rjusto@gmail.com> writes:
>>=20
>> > [ ... ]
>> > diff --git a/advice.h b/advice.h
>> > index 0f584163f5..2affbe1426 100644
>> > --- a/advice.h
>> > +++ b/advice.h
>> > @@ -49,6 +49,7 @@ struct string_list;
>> >         ADVICE_UPDATE_SPARSE_PATH,
>> >         ADVICE_WAITING_FOR_EDITOR,
>> >         ADVICE_SKIPPED_CHERRY_PICKS,
>> > +       ADVICE_WORKTREE_ADD_ORPHAN,
>> >  };
>> >
>> > Note the hunk header, instead of a much more expected:
>> >
>> > @@ -49,6 +49,7 @@ enum advice_type
>>=20
>> Next time, don't include "diff" output in the proposed log message
>> without indenting.  It makes it hard to read and parse.
>
> My fault.  Sorry.
>
> Is there any way to make git-format-patch issue a warning or refuse to
> continue when the resulting patch is not going to be accepted by git-am=
?

I meant it as primarily to help human readers, but you are right, it
will break "am".  How about doing it in the pre-commit hook?
