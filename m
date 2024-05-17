Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CB915E83
	for <git@vger.kernel.org>; Fri, 17 May 2024 07:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715929799; cv=none; b=cZ6gTulKQdSXyam7CJ76+C1wQjIT7C+oI7FoW5/Dt4FDhXcpn9JO1oKNsxl16j+fv2X8eMMdQ5165dgP4VSuMiB7vOEDHyUm4eDE5b74YXoDZ5C5bZyVcfxGFhipURKbZuWb8uCQhGbJQYz1NVDcMtqHRd2eH/GsLW7iWlOJ3P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715929799; c=relaxed/simple;
	bh=h4eVxGLeT0oVSx18y87uZ6HcilvTFgGuJFS++bO9X1o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iQoe8jkTxCY7z5ShngZ/Vd8UZXLV+oEOOP7m9WEXdrgFuOlmKyRC901Ei0UrD8EAzSvCRYO/YLl6wYsMsd3kJ/C4g53GWjXDQosC1af0wVogj4ndjyvOpTbzU0X1cYKq4i3pcWfh52ZiCErTTbvFsGXOXv/olyPlOTjqVL4p6x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hRV1RfAK; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hRV1RfAK"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F2E225AE4;
	Fri, 17 May 2024 03:09:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=h4eVxGLeT0oVSx18y87uZ6HcilvTFgGuJFS++b
	O9X1o=; b=hRV1RfAKrAkFz1QUxHiu2CnSYa/cvxrhFb1p/0fIDjkVIfGSnTlGUH
	emKOtZb7IVWWcuzIIMtGo6l+v7x6/RHGnrQLkFo44FP96qcDCB3a5nS0JRPhF8Do
	/eWNBXkWcQEgL8npcIFdtifcwbZ4dZYKXQ5VBMPPYBIDyuDaXV5C0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 86DF825AE3;
	Fri, 17 May 2024 03:09:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B4BB325AE2;
	Fri, 17 May 2024 03:09:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Sean Allred <allred.sean@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [Q] rebase -i: turn "pick" to "edit", make no change, what
 should happen?
In-Reply-To: <m0seyhs8o2.fsf@epic96565.epic.com> (Sean Allred's message of
	"Thu, 16 May 2024 17:18:05 -0500")
References: <xmqqy189o94c.fsf@gitster.g> <m0seyhs8o2.fsf@epic96565.epic.com>
Date: Fri, 17 May 2024 00:09:54 -0700
Message-ID: <xmqqmsoonccd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 76DC70E8-141C-11EF-A4F0-25B3960A682E-77302942!pb-smtp2.pobox.com

Sean Allred <allred.sean@gmail.com> writes:

> Setting aside the obvious reality that an actual change here could have
> pretty serious UX considerations for folks with muscle-memory, what in
> your opinion would be the right thing to do? Why? Are rebase commands
> 'shortcuts' or are they intended to be orthogonal? Do they have designed
> purposes?
>
> I'm wondering if you can tease out what the 'ideal' state looks like to
> you, then you can identify what if anything there is to be done about
> it.

Oh, it would be very simple.

If I say "edit", whether I made a tree change or not, I want to get
an editor when I said "rebase --continue".  If I say "reword", I
want to get an editor _without_ having a chance to muck with the
tree status.  That would be the "ideal" behaviour, iow, the "mental
model" is just "edit" gives the users a chance to edit both trees
(by first giving control back to a shell prompt) and the log message
(by opening the editor upon "--continue"), while "reword" is only
about the message so does not give shell prompt back to the user
(unless absolutely necessary, that is.  If the "reword" were to
conflict due to tree changes in earlier steps, it would need to give
control back to a shell prompt to ask the user's help to resolve the
conflict.  It is just that when there is no need to edit the tree
otherwise, that is skipped).

