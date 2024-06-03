Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FECE12D205
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717428669; cv=none; b=U7gRigEwGVOvutK7vHKtqefW8z3rTi7SxD+ntp9IVWl+Hr8wFlVNGL+uPvKZRhTeKjUZJDWgcYkFX7TgZvlqlEJOoa/Mn/5ZOUGPWW2izv8gQ9w7b3Iu8HmdsQ3CEV8JjX2VrIvgiVpbVPFpFaUomMU49gewg1piB+1pWl7+MYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717428669; c=relaxed/simple;
	bh=KHXjjv1bkXAb8dPF/tWA1fzM9kZfG+AUN6wKzAdJOLw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zy9WvxSSP/ILCpntRFvsiwNNU/JqESrIDo5lbBAgbaj9IbHlJ77aGiUiXCAPmLBMKj0cpEM4f6alr3KnjbowXkzMgAfQXkAqqEvin0MmuhRsVLpvE6B7XBx0kr5keA3bMMLxRo5MNcNjy0PodMdgfi9hCUYDKeN8ylQjuCVzzLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=UYbSkbh0; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UYbSkbh0"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 99B1F3357E;
	Mon,  3 Jun 2024 11:31:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=KHXjjv1bkXAb8dPF/tWA1fzM9kZfG+AUN6wKzA
	dJOLw=; b=UYbSkbh0kuPBPyecJCtPNC1JqMePt3OmhgwfYTXO10szy3uA71FE+Y
	znJ1ek4A4M+tZc5+ykq80wGsA8wBmuaqVzO+KHN70s/XpWW+KWDM81rwxEDb9MJd
	47HMA0LN9Sh+P1qNlEQy5cDRCES7w589pxz92Q+BP64TOq+LduC2A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 32FBE3357D;
	Mon,  3 Jun 2024 11:31:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7B21C33579;
	Mon,  3 Jun 2024 11:31:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Arundas T C <arundas.tc@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: git pull --ff-only errors when git merge --ff-only passes
In-Reply-To: <CAKRNJbAnUBmR5MHY=uSF1A3docO-uxWG4agWuFZEyPUnduyWHw@mail.gmail.com>
	(Arundas T. C.'s message of "Mon, 3 Jun 2024 14:28:41 +0800")
References: <CAKRNJbAnUBmR5MHY=uSF1A3docO-uxWG4agWuFZEyPUnduyWHw@mail.gmail.com>
Date: Mon, 03 Jun 2024 08:31:02 -0700
Message-ID: <xmqqo78i6o21.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4A54BC10-21BE-11EF-B404-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

Arundas T C <arundas.tc@gmail.com> writes:

> What happened instead? (Actual behavior)
>
> error: cannot pull with rebase: You have unstaged changes.
> error: Please commit or stash them.
>
> What's different between what you expected and what actually happened?
>
> It errored out because of unstaged changes, even though doing `git
> merge --ff-only` will correctly do what's expected. See below.

But you are not doing "merge" but "rebase", according to the error
message.  "pull" was told to do "rebase" instead of "merge" and it
stopped because it did not want to clobber the local changes.  So
it appears that what "merge --ff-only" would have do has very little
to do with what "pull --ff-only" you configured would do, no?

