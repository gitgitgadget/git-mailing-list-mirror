Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE217F
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 00:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="U6eLlQrE"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65364ED
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 17:16:07 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 143191F3BA;
	Tue, 31 Oct 2023 20:16:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ML/i3l2k1jd+fyoqzYU0yeaGKrjFhhYCu9S0XF
	AXDjQ=; b=U6eLlQrEAN/YUWLvtgHdrs6yRhza6uRkgJtL5K1nR+ylQbDg7UmaWb
	Z6VGKRHI0fyc0/VaOamDCgVWT94Tx7SqoGa3FxpVwE/HEyBdIwYNfQfthAWQEYmI
	10CKRyhbWh08es8CGYmVYFPSGFvBAk1cYA6TEhoutWnXUkXfe/oUg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id ED77A1F3B9;
	Tue, 31 Oct 2023 20:16:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 78F281F3B8;
	Tue, 31 Oct 2023 20:16:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Elijah Newren <newren@gmail.com>,  Tony Tung via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Tony Tung
 <tonytung@merly.org>
Subject: Re: [PATCH v2 0/2] sequencer: remove use of hardcoded comment char
In-Reply-To: <f59f75cd-1991-456a-9ea6-638b39711bf1@gmail.com> (Phillip Wood's
	message of "Tue, 31 Oct 2023 11:18:10 +0000")
References: <pull.1603.git.1698635292629.gitgitgadget@gmail.com>
	<pull.1603.v2.git.1698728952.gitgitgadget@gmail.com>
	<CABPp-BEjV0H=waNQfKNNqibs3g_BU1CCrNjb8G8h_jXrt8kaiw@mail.gmail.com>
	<f59f75cd-1991-456a-9ea6-638b39711bf1@gmail.com>
Date: Wed, 01 Nov 2023 09:16:01 +0900
Message-ID: <xmqqo7gexr9a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D7E57136-784B-11EE-846B-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> As far as I can see those remaining instances are all to do with the
> '#' that separates a merge subject line from its parents. I don't
> think we need to complicate things anymore by respecting
> core.commentchar there as the '#' is not denoting a commented line, it
> is being used as an intra-line separator instead.

It is unfortunate that the format of the file needs an intra-line
separator in the first place, but I tend to agree with you that the
comment-line-char would be a terrible fit there.  '#' or any
replacement character at the beginning of a line is easy to spot as
a signal that the line in its entirety is commented out, but it is
much harder to eyeball-spot a single punctuation character in the
middle of a line.  If we do not have to look for a different
character depending on the comment-line-char setting, it would make
the system (slightly) easier to use.

> I agree that I don't see much point in respecting core.commentchar in
> the TODO file as unlike a commit message a legitimate non-commented
> line will never begin with '#'. Unfortunately I think we're committed
> to respecting it - see 180bad3d10f (rebase -i: respect
> core.commentchar, 2013-02-11)

Yeah, the ship has long sailed.

> I think splitting the changes so that we have one patch that fixes the
> TODO file generation and another that fixes the commit message
> generation for fixup commands would be best.

Yes, it would be great.

Thanks.
