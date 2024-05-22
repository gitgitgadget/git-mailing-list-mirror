Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A9476048
	for <git@vger.kernel.org>; Wed, 22 May 2024 17:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716399622; cv=none; b=OxXe1qFDDJk4asVVQALHj/C6zvV35+eZ9Ts1LBzF3ivPwYF6s/ls6t3Q0C2a8xgUNS/naRs5D88+89sgVtGF0Rc4gdJEQg9UzCnOk6+XZvAjLLo9Vt6RNkBit0OBWWIl7gQst9Tvd5lLsONVRBfe/uBItugc+jJSSMZEX9lccTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716399622; c=relaxed/simple;
	bh=stDAaEznu2pKJHSeqwCtj7wPVsR/V8fQq5Ylo0zBVnY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iPRyOC1AJlt9OfCHlGkKCqhwG5jtal2TwarzCba/rL+02VXqHdhF4JOdjKdDJ6m4TqxeU89ukZV0p+ej3CKWjiaxmedQe+tFxNliTy5BzDhF5u+6YfgF2uyyKNaYPonwUYrl+yJideOaNZbDaH319J3kVE/6XUly1d7GSOIqrPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ljVi1V6I; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ljVi1V6I"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2EB8D18A58;
	Wed, 22 May 2024 13:40:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=stDAaEznu2pK
	JHSeqwCtj7wPVsR/V8fQq5Ylo0zBVnY=; b=ljVi1V6IRse2Z19GDu/CYXHXJORQ
	edeorck5i5n59Fuos+d9K8izMR/BHByM1xuzXQ51kc7IuR37xW4xCdmc/Gnb80K1
	4JLDwEq9l5o1dCUMgNw2n7JRka8LzP0vx5WcrPQuq5jDXRI1jmMRdfq6aQAU5pIE
	/xTGdF3jfqAEOaQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 27C5B18A53;
	Wed, 22 May 2024 13:40:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8594918A52;
	Wed, 22 May 2024 13:40:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/5] pager: do not close fd 2 unnecessarily
In-Reply-To: <501a610c-550f-45da-a311-d4c941ae4870@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Wed, 22 May 2024 19:19:08 +0200")
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
	<80f15223-246e-4cfb-a139-e47af829c938@gmail.com>
	<xmqqo790fg8z.fsf@gitster.g>
	<a9f199d8-bb06-479f-88c2-63d80338a4e9@gmail.com>
	<xmqqwmnm993k.fsf@gitster.g>
	<0574914d-8088-434d-8db2-013c1abe27c3@gmail.com>
	<xmqqikz6966t.fsf@gitster.g>
	<501a610c-550f-45da-a311-d4c941ae4870@gmail.com>
Date: Wed, 22 May 2024 10:40:18 -0700
Message-ID: <xmqqa5kh68zh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 5BAB7DCE-1862-11EF-AAA7-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> Perhaps this makes more sense?:
>
> 1:  8fe915a820 ! 1:  70cc34efc4 pager: do not close fd 2 unnecessarily
>     @@ pager.c: int pager_use_color =3D 1;
>      =20
>       static struct child_process pager_process;
>       static const char *pager_program;
>     -+static int old_fd2 =3D -1;
>     ++static int old_fd2;
>      =20
>       /* Is the value coming back from term_columns() just a guess? */
>       static int term_columns_guessed;
>     @@ pager.c: static void close_pager_fds(void)
>       	/* signal EOF to pager */
>       	close(1);
>      -	close(2);
>     -+	if (old_fd2 !=3D -1)
>     ++	if (old_fd2)
>      +		close(2);
>       }

Not really.  The name "old_fd2" strongly implies "where did fd#2
come from?" and it did not come from fd#0, did it?  Until [3/5]
this variable used to mean something different from "this was the
saved fd#2 we can use to restore it later", which is the name
"old_fd2" clearly wants to stand for.

If you really want to have them as two separate patches, I would
expect the proposed log message for the [3/5] step to say something
like

    ... we added variable X to signal if we should close fd#2 in
    function F in the previous step.  As store away the original
    fd#2 with dup(2) to be restored later after we close() it, the
    question the previous step asked, "should we be the one closing
    fd#2?" becomes equivalent to "have we stored away the original
    fd#2 (in which case we close() fd#2 when we are done with the
    pager and restore the original one)?"  Rename X to old_fd2 and
    have it serve both purposes.

or somesuch.
