Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F81A848E
	for <git@vger.kernel.org>; Fri, 17 May 2024 15:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715959082; cv=none; b=sC4JWG4PY145vfhSsQTPDLe8HM2Vah2cxPI9lLCds3KxU3UK59nzAJcffxSLNY19SAoGAKne9eEF5XcrB0es5YJ+n0ZuxoHJcx1ug5klm0rp2Q8OEmpwb6D6lXkyexZLIZbx1wJkeHE/sBfD6klIuinFRg+Fq3i9qzKHne9B6t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715959082; c=relaxed/simple;
	bh=BKT6tl9/xit4vrQNKvkRBR1Y07d5IRNj8E7inJEVby0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FlPQWHRK7mJ4CXGdPxyCli24NtAhYqydIK/Hpkq4viy7pGoHCXLm5mHcK57M4eXq+H/zJb6MtbKdP5npNmnkd1s7iDyFtQ4w3dgKR1L1hMk38weGASnWMEGYuYznLIbpD2paMnRJHd6qI5PsQr3DlHOQCiLoAmWchMaJBB24rnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=HxAlpp+b; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HxAlpp+b"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C01062EED3;
	Fri, 17 May 2024 11:18:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=BKT6tl9/xit4vrQNKvkRBR1Y07d5IRNj8E7inJ
	EVby0=; b=HxAlpp+bH14FLq4pG/PE+OLF62R4QLdTKCIOMDHR5hs/XoNmIqO3if
	RwzJyxc0K5lm9JMcih1tfpI/F9l92anSryTgKlz7Jou88PJzLGKzx6acsi+DxEBB
	Vf2T8jGgn/ZSVBsVINvUYk6VN7WDxILvka70pQt6gyGBt2Xe/mITU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B97492EED1;
	Fri, 17 May 2024 11:18:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4132B2EE93;
	Fri, 17 May 2024 11:17:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Sean Allred <allred.sean@gmail.com>,  git@vger.kernel.org
Subject: Re: [Q] rebase -i: turn "pick" to "edit", make no change, what
 should happen?
In-Reply-To: <ZkcH-LAkLkf_wvfq@tanuki> (Patrick Steinhardt's message of "Fri,
	17 May 2024 09:32:08 +0200")
References: <xmqqy189o94c.fsf@gitster.g> <m0seyhs8o2.fsf@epic96565.epic.com>
	<xmqqmsoonccd.fsf@gitster.g> <ZkcH-LAkLkf_wvfq@tanuki>
Date: Fri, 17 May 2024 08:17:55 -0700
Message-ID: <xmqqh6ewmpr0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A4027646-1460-11EF-AB4E-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> I quite frequently use "edit" just to inspect commits, stop at random
> points in the history, run tests and whatnot. So this would be a UX
> regression for me because I do not want to change commit messages and
> don't want to be bothered.

I sometimes (ab)use the "edit" exactly like that myself, so a
simple-minded unconditional change of behaviour would be a UX
regression to me as well.

> With the introduction of the "break" command you can certainly argue
> that "edit" is the wrong command to use in my case. Muscle memory is
> hard to retrain though :)

Yes, with a vim macro or its Emacs equivalent, it should be just as
easy as doing "s/^pick /edit /" to insert "break" after every line
that begins with "pick ", but "just as easy" is still an unwanted
forced change to the end-users.  If I really wanted to, the right
and only way out is to introduce a new insn similar to "edit" but
behaves more like what I said earlier.

Thanks.

