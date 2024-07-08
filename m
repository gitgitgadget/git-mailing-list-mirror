Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE4D1CD1F
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 19:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720467274; cv=none; b=LRxZW5wgMBOdSfB9wLCG8ETZsliYy7RNlZzsNbvI1lCYLEKtxUHxG0W4EvlNUArKfNCBr897jYwQO+o62DBQdrQa10XuSEqicZrQ+HS+z1kh5PXFIVQMkfaH44IZKY46pcgpLAWoWLZqHqJPfQjCzUR2ChcNhIsDxj4dGklyv8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720467274; c=relaxed/simple;
	bh=BkVb58WFBwiRr/36MczebTJeMD22UPoLX2DbC6DpmHY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=quFJInMW2vU2LfzugSTaL13ukpquFmKdjd9rdV5/fbnDY4CX+q0k9FDGsCZKzdKrvNbEeDk6TbEDMoiShkSRrVIj26BwMEZQrckbCTvMR+OYKELwzug34l3FAqAOB7HCXSH3utJImzi/ae618NET38HTbwbbMND3g2wBTiTJAc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=SQQM4XH5; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SQQM4XH5"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EA26F2C586;
	Mon,  8 Jul 2024 15:34:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=BkVb58WFBwiRr/36MczebTJeMD22UPoLX2DbC6
	DpmHY=; b=SQQM4XH59pYtQNf01ljJ7xhcyL45ims3KS28GGgNriMnE32vnnU9FT
	MavUex0u7HZXZe2JInLPa/urKO/kUDqloqUBgU6DpJErEUw19iX/kb32tJX19NyT
	A9RckE0VK+AeTsrKor+kp/Wo+7xeT4IKalyvT+VGyLLS2aK65lfDI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E1FBB2C585;
	Mon,  8 Jul 2024 15:34:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 58E282C584;
	Mon,  8 Jul 2024 15:34:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  newren@gmail.com,  vdye@github.com,
  rsbecker@nexbridge.com,  =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH v2] advice: warn when sparse index expands
In-Reply-To: <pull.1756.v2.git.1720448038745.gitgitgadget@gmail.com> (Derrick
	Stolee via GitGitGadget's message of "Mon, 08 Jul 2024 14:13:58
	+0000")
References: <pull.1756.git.1720019679517.gitgitgadget@gmail.com>
	<pull.1756.v2.git.1720448038745.gitgitgadget@gmail.com>
Date: Mon, 08 Jul 2024 12:34:24 -0700
Message-ID: <xmqqo777ekzj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1582FD94-3D61-11EF-8C68-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     ... This idea has always been in the back of my
>     mind since the sparse index was created, but it didn't make sense
>     initially when only a few builtins could operate without immediately
>     expanding a sparse index to a full one.

Yeah, if this triggered for a command whose operation does require
expanding, then that would be annoying to the users.

The phrasing that suggests "git clean" used in this version does
look better.  I wonder if "git clean" would also have to expand and
then trigger this warning, though ;-)

Thanks.
