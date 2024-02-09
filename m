Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B29C7BAF1
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 17:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707498958; cv=none; b=tadOmr7AulbwCF31LxML379LtTX4yIf+QcjyIy3RmaVHfvIWt2DyYJDkStdaf/d0dqpwpxZ1yQPx+jf4rr8VnR07ur0BEx+Kode6wsNQPXQNJbiPUwrAJDl8m1mLfztFJYKoSZ0n6f4cVyUqXAy5Wm2gRba+qTY4MZMFRKBUadc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707498958; c=relaxed/simple;
	bh=2MR2+PsxCi+T8Lb6jiKTs+5aXZOVDoF/dbUPWGywvCc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eJo7LhZ0iqQdfNSxipgr/68RDs1Z+nNac8s4HMWyh8909P/7CXqe4v8eWje2SfyQrEVBp8VUJ6ZSJoQUYjHndurvW3qkpQ0AHZqlkcEcDARFpVxu4+rzoQJgebCnerybc85wplFo4AW0MuCRc9VTir4QrmGSSpt6Md7fMfmNLkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ottdn7cv; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ottdn7cv"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D85711EA73;
	Fri,  9 Feb 2024 12:15:56 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2MR2+PsxCi+T8Lb6jiKTs+5aXZOVDoF/dbUPWG
	ywvCc=; b=Ottdn7cvatIaU3dMkflnuFsz+uV3hdM5S8SZLhh++bO+OL1Opbk5ta
	Jo66ddVSoCEChoFTpzLLumF6Jedrr595xodP7gM7PDI/wmZFJl0QPmOlU1mYD1pC
	ljbA+vFzE8R64bG4r8y7qbMxrhQSAHKCYWon9661t7sni7ZbL5Z6Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CE9771EA72;
	Fri,  9 Feb 2024 12:15:56 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F0B881EA70;
	Fri,  9 Feb 2024 12:15:53 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  phillip.wood@dunelm.org.uk,
  git@vger.kernel.org
Subject: Re: [PATCH v3 4/4] for-each-ref: avoid filtering on empty pattern
In-Reply-To: <ZcXddvQzlt6j7T7L@tanuki> (Patrick Steinhardt's message of "Fri,
	9 Feb 2024 09:08:22 +0100")
References: <xmqqcyt9fdc7.fsf@gitster.g>
	<CAOLa=ZRcWYmEYnxh_=ykOerahZ61xaanLCj_JHHLvtrvN=Xs-w@mail.gmail.com>
	<xmqq1q9oe029.fsf@gitster.g>
	<CAOLa=ZQzz7_L_9cBmK+pgFwd_DFqfWDVRiaZMAxU+54kBq6Pcw@mail.gmail.com>
	<xmqq1q9ocje3.fsf@gitster.g>
	<CAOLa=ZQaXxwrXmbmFvGR59EDo3Eqa-Xfc3OG9+6ES-veDU8Bhg@mail.gmail.com>
	<ZcSVx4slikt4xB3D@tanuki> <xmqq7cjeq43t.fsf@gitster.g>
	<ZcUOP_rWUwymhe5c@ncase> <xmqq34u2onaj.fsf@gitster.g>
	<ZcXddvQzlt6j7T7L@tanuki>
Date: Fri, 09 Feb 2024 09:15:52 -0800
Message-ID: <xmqq8r3timnr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E194C7AA-C76E-11EE-BDB0-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Depending on the answer, I think we can go one of two ways:
>
>   - Accept the diverging behaviour and add `--include-all-refs`. The
>     "files" backend does a best effort and only includes root refs, the
>     "reftable" backend lists all refs.
>
>   - Double down on the fact that refs must either be pseudo refs or
>     start with "refs/" and treat any ref that doesn't fit this bill as
>     corrupted. The consequence here would be that we instead go with
>     `--include-root-refs` that can be implemented the same for both
>     backends. In addition, we add checks to git-fsck(1) to surface and
>     flag refs with bogus names for the "reftable" backend.
>
> While I seem to have convinced you that `--include-all-refs` might not
> be a bad idea after all, you have convinced me by now that the second
> option would be preferable. I'd be okay with either of these options as
> both of them address the issue at hand.

For now my tentative preference is the latter.  If ref/head/foo is
an end-user mistake with one backend, it is cleaner if it is
considered a mistake with other backends.

Doesn't our ref enumeration/iteration API have "include broken ones
as well" bit?  I wonder if this issue becomes easier to solve by
(re|ab)using that bit.

