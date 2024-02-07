Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCD67A723
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 16:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707321661; cv=none; b=FyprdrCLd5VI3En2t1on84iXmyn5GP8WAt+u6btJmimTkThr7pi6sjqU/gtZzrw0szI3ucPcWGpQYre56dhxW0ug+Nap8dAGTen3d8Wjfp4qxH6LD3HbcfmikUkG6sNI/qJQuGnfAwW2YIl1DGzjqhlUmirUs5oO2dcVgcmUVjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707321661; c=relaxed/simple;
	bh=8JMsH0aeegnEn4nf2nVhajnD00zHVV0pYEOzUhqrXTY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PcLllRSpiNrrIuj3fCS1RXWNIaGBO7VJGfjeas84mk6FHFiwsUiYc2Io2ZPjFFlTN7Mfhs6+8XXIF8yd1x1yFkjGJG0C7a3qRkbWU3tSgJ/s0hi4I6yOCG+Lj/lXxa+C1YikNS7XH8/V1mnN7wWbcUGLpq3nBKQZnzWhrCK0ZEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=SOcdcjp9; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SOcdcjp9"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D57C82CA24;
	Wed,  7 Feb 2024 11:00:52 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=8JMsH0aeegnEn4nf2nVhajnD00zHVV0pYEOzUh
	qrXTY=; b=SOcdcjp9Y1KPnaEwWirebHVu1921YrVOmWOncDBp7If6X4lzDiVefQ
	dDUneYRqyMfmazaOw8qc9HB15YPYD8rdbRYz80irIZIroEqM3cAh1MNpG+El95u+
	3g3Pqsnui7N0w1PlWTQ29VHaz7DqqkyvxGulbivd6Ept+vupvAStQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CD57A2CA23;
	Wed,  7 Feb 2024 11:00:52 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5AE992CA1E;
	Wed,  7 Feb 2024 11:00:48 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  phillip.wood@dunelm.org.uk,
  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v3 4/4] for-each-ref: avoid filtering on empty pattern
In-Reply-To: <CAOLa=ZRcWYmEYnxh_=ykOerahZ61xaanLCj_JHHLvtrvN=Xs-w@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 7 Feb 2024 15:10:27 +0100")
References: <20240119142705.139374-1-karthik.188@gmail.com>
	<20240129113527.607022-1-karthik.188@gmail.com>
	<20240129113527.607022-5-karthik.188@gmail.com>
	<98d79d33-0d7e-4a9c-a6a3-ed9b58cd7445@gmail.com>
	<CAOLa=ZR=_tt=ppphGMkxqj_YB5G+YkTMWGzRzcHTbrZz4ysb5w@mail.gmail.com>
	<92ba680d-0b48-49f0-aafc-f503e5a5e0ea@gmail.com>
	<xmqqle7xjzic.fsf@gitster.g> <xmqqr0hph1ku.fsf@gitster.g>
	<CAOLa=ZSZJ=_VCppHXcJeE=Z61go4_040xyc1NBTu-o=xysLrdg@mail.gmail.com>
	<xmqqcyt9fdc7.fsf@gitster.g>
	<CAOLa=ZRcWYmEYnxh_=ykOerahZ61xaanLCj_JHHLvtrvN=Xs-w@mail.gmail.com>
Date: Wed, 07 Feb 2024 08:00:46 -0800
Message-ID: <xmqq1q9oe029.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0F33358C-C5D2-11EE-A3E5-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> I'm thinking "--all-ref-types" might be a good alternative. Mostly because,
> "--include-root-refs" seems very specific to the files backend. Also, we don't
> include other refs which are not HEAD | pseudorefs, but in the $GIT_DIR.

I strongly disagree wiht the "files backend specific" part of the
comment.  No matter what backend you would use, refs and pseudorefs
have the full refname, which may look like "HEAD", "FETCH_HEAD",
"refs/heads/maint", etc., and you can easily see these full refnames
form a tree structure, with "HEAD", "FETCH_HEAD", "refs/" at the
root level.

I do not understand your "we don't include other refs", either.
There may be "things" that are ignored by your implementation of
"for-each-ref ''" even with the files backend in $GIT_DIR directory.
They are not refs, because the refs are by definition inside "refs/"
hierarchy, unless they are ones that are specifically included from
outside the hierarchy ("pseudorefs" is one class of specific
exception, "HEAD" is another).
