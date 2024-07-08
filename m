Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC211420DF
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 16:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720457309; cv=none; b=GX3m4wmmLXuUs88Y+TW79jW++i7HF/GGzy+5ZQpMzDCQYhjeTe1FT2vrRHP4wRTbjrPtSE6lxrU3sPpNUfwySl0fdwIWeWU9jG+6Cl+SAmJsXckH0jCQ7p/rn1oSjK7ovrfx/lFV1+Nb+1HnEo1XB5IFrRJtTTTe4cjWojqyJNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720457309; c=relaxed/simple;
	bh=QTogbQq7Yyda6x6AVGAxWrrAYw7/GqNs7Q6Cl2ji7mg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZxlcKyyENwHYmF7KpsCBNpU7WV9v4rw7cBCSN1aOPeO8L44LUvD2q/bEFZ6ZO23XuXpP663itPjJ5UWTx95Ili08QLE9PCXRj798Pk5XWmUVoibPceTolS6zlOuu/2OEU8/t7RgM4bqEM/5knY83BTmK65OJpgQ0mVpT9vTCQzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GK4glFUl; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GK4glFUl"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4563E1AE32;
	Mon,  8 Jul 2024 12:48:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QTogbQq7Yyda
	6x6AVGAxWrrAYw7/GqNs7Q6Cl2ji7mg=; b=GK4glFUlV2R1WeyElSC7lUmhi4n+
	8mVsXv0zlMTisglRhEwxarGs34Cn98aUxocalVf1/tGAhRMxxiMF5qRTGKO1ciuw
	Wq+jT21Lf0CXO3vxc5XzM7AqaSrCdsfGQd3ro4WXiIa/017SPU2/tn0bDclmQgVB
	aOauWZhmRxVvofo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3E9301AE31;
	Mon,  8 Jul 2024 12:48:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BD3C71AE30;
	Mon,  8 Jul 2024 12:48:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  chriscool@tuxfamily.org
Subject: Re: [PATCH 5/8] clang-format: avoid braces on simple
 single-statement bodies
In-Reply-To: <20240708092317.267915-6-karthik.188@gmail.com> (Karthik Nayak's
	message of "Mon, 8 Jul 2024 11:23:13 +0200")
References: <20240708092317.267915-1-karthik.188@gmail.com>
	<20240708092317.267915-6-karthik.188@gmail.com>
Date: Mon, 08 Jul 2024 09:48:22 -0700
Message-ID: <xmqqle2bj0dl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 E3F17D08-3D49-11EF-BFFF-DFF1FEA446E2-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Karthik Nayak <karthik.188@gmail.com> writes:

> Set the 'RemoveBracesLLVM' to 'true' which ensures that we avoid curly
> braces for single-statement bodies in conditional blocks.

Hmph, two warnings in its documentation [*] sound ominous, especially
the second one that says:

    Warning

    Setting this option to true could lead to incorrect code
    formatting due to clang-format=E2=80=99s lack of complete semantic
    information. As such, extra care should be taken to review code
    changes made by this option.

which implies it may not necessarily a good idea to add to
automation without telling contributors that they may get hit with a
false positive (or incorrect rewrite).

Reading from the examples in that documentation page, it was unclear
how it would handle if/else if/.../else cascade where not all branches
are multi-statement blocks, e.g.,

	if (A) {
		do_A_thing();
	} else if (B) {
		do_B_thing();
	} else {
		do_C_things();
		do_other_things();
	}

but looking around I am getting a feeling that the tool would do the
right thing, i.e., to match our preference that is to use {braces}
around all branches, if I am not mistaken.


[Reference]

 * https://releases.llvm.org/16.0.0/tools/clang/docs/ClangFormatStyleOpti=
ons.html#:~:text=3DRemoveBracesLLVM

> +# Remove optional braces of control statements (if, else, for, and whi=
le)
> +# according to the LLVM coding style
> +# This avoids braces on simple single-statement bodies of statements.

"... but keeps braces if one side of if/else if/.../else cascade has
multi-statement body."

> +RemoveBracesLLVM: true
