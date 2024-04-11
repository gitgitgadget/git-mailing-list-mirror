Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01031205E17
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 19:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712865575; cv=none; b=UCe2TUChrvysLNKrYrpHAby6gKMEgXubkKVXOM0XUuMSC3ClZVLsAmwfmoYQdVH8mz++PdczpwpFLX4T5HHQCF+9v9mimKWw0sMEZcEBHQAzV2R3Zle7mCWGIgB4ky63Gd+c/KLzHWvfXV4/x9gWgBj0cxh41/2fbbMLM7Q0MZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712865575; c=relaxed/simple;
	bh=bNNQC10DCx8Iw5m4EiJu00ckGsMwZroX1epLav5BAGI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KsnmmlJ3I8NO0AEPTAfXKFr63NuRlfIB882M66TQI2JVJ/shThDBrxH7N5ZYzDZ1mbyZKic+GhuwYkCNMmaOU4SQsyb8JT2BkRB4TUXkzNeuqk610SKJ9ubatebOKLHBc+KxKBiWDMkO4zpiomnLI8n3TPYZpTluMuF9TSawmCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=N9WxXNry; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="N9WxXNry"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CFF011EB433;
	Thu, 11 Apr 2024 15:59:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=bNNQC10DCx8I
	w5m4EiJu00ckGsMwZroX1epLav5BAGI=; b=N9WxXNryukoQzqrM6VSxiCDUyyzC
	rhBZa0MzHqJP2uXMeHyGdCRbjiHxfVY0PZhUHXnmAlC8uTJWdvSKa8+90FaNPXMp
	mzMNDNvfQf/KzLaieeKk72FEEK9/JDmUlpo9nqruH0lOeG+WAVn0Hf0U5kVh9xAD
	mIpbAkTdMvdv4jU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B69471EB432;
	Thu, 11 Apr 2024 15:59:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CD77C1EB431;
	Thu, 11 Apr 2024 15:59:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Thalia Archibald <thalia@archibald.dev>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Chris Torek
 <chris.torek@gmail.com>,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 3/8] fast-import: allow unquoted empty path for root
In-Reply-To: <39879d0a6627b62f685b38b9afcfe19e4c14c38e.1712741871.git.thalia@archibald.dev>
	(Thalia Archibald's message of "Wed, 10 Apr 2024 09:55:41 +0000")
References: <20240322000304.76810-1-thalia@archibald.dev>
	<cover.1711960552.git.thalia@archibald.dev>
	<cover.1712741870.git.thalia@archibald.dev>
	<39879d0a6627b62f685b38b9afcfe19e4c14c38e.1712741871.git.thalia@archibald.dev>
Date: Thu, 11 Apr 2024 12:59:30 -0700
Message-ID: <xmqqwmp3smal.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 0317265C-F83E-11EE-9AE3-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Thalia Archibald <thalia@archibald.dev> writes:

> For most of this feature's lifetime, the documentation has not
> prescribed the use of quoted empty strings. In e5959106d6
> (Documentation/fast-import: put explanation of M 040000 <dataref> "" in
> context, 2011-01-15), its documentation was changed from =E2=80=9C`<pat=
h>` may
> also be an empty string (`""`) to specify the root of the tree=E2=80=9D=
 to =E2=80=9CThe
> root of the tree can be represented by an empty string as `<path>`=E2=80=
=9D.
>
> Thus, we can assume that some front-ends have depended on this behavior=
.

If I were writing this, I would say "must" instead of "can", as
otherwise it would probably be a good idea if we could tighten it.

Of course no need to reroll just to update this.

> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index de2f1304e8..13f98e6688 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh

The changes needed to test both a C_quoted empty string and an
unquoted empty string are so small (when viewed with "show -w")
and pleasant.  Nicely done.
