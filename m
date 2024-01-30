Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C1026AC6
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 17:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706634949; cv=none; b=X/zLejzhl8/c3v/IJCOvINEE8mA/bxC3pHLer2aV8Uij98QsDOM5EwdEooe/wM7XIbXzo0wkAZT+x1Dw0lxapn1ncHgnGyMnDC2aki6NXJGQ0QK3Ii3QhyFt6mtnyPWORIUTIzp/TLSDxIAhkUd9AkqQ0xJfT1eKwo8IYaqTd8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706634949; c=relaxed/simple;
	bh=IH6zcOS5l3n610Cr9a2nNGEslzXsWLETcge4MtEYscw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a7Y5qsu1ddvLDB3vyi0Mfqr9lL8Z6IcUSibxHugFtAT1Gj0rVybruoP4O0rZpiLur54cMPE3H0JoOpdp4DJGHT1tgHP9AjFr+0XipiHsBlCoWwq/GZZVraReXLas+06q5oYv3gJPDSa6VrQCa4fgOSt1HTcadNsiFAK8E1Dn7Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vXZUSbYG; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vXZUSbYG"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A78E428C38;
	Tue, 30 Jan 2024 12:15:47 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=IH6zcOS5l3n610Cr9a2nNGEslzXsWLETcge4Mt
	EYscw=; b=vXZUSbYG+M52ZdguFicexQhPWGbzCWI6vRdPSE2jcSOd8s4Z+DmwbI
	hCNkbRuqYxhnQX6wua/O4H8J8g16TC2AlvS5yMsZbn1rEVv1R3EcBzaD6DCYO3BV
	Ri3uupRaGuaOFTzT8sjKlNqNuXBSRKmZoxEpukMNCIu6h0Yueussw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9F35228C37;
	Tue, 30 Jan 2024 12:15:47 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 323BF28C35;
	Tue, 30 Jan 2024 12:15:42 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] merge-tree: accept 3 trees as arguments
In-Reply-To: <CABPp-BFPe_RrX5ZHo7-mMHHS96j_O+1wiEwGC5+zGPP5h+686Q@mail.gmail.com>
	(Elijah Newren's message of "Mon, 29 Jan 2024 23:04:53 -0800")
References: <pull.1647.git.1706277694231.gitgitgadget@gmail.com>
	<CABPp-BFPe_RrX5ZHo7-mMHHS96j_O+1wiEwGC5+zGPP5h+686Q@mail.gmail.com>
Date: Tue, 30 Jan 2024 09:15:40 -0800
Message-ID: <xmqqbk92bv43.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 326DF464-BF93-11EE-8C27-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Elijah Newren <newren@gmail.com> writes:

>> ---merge-base=<commit>::
>> +--merge-base=<tree-ish>::
>
> A very minor point, but any chance we can just use `<tree>`, like
> git-restore does?  I've never liked the '-ish' that we use as it seems
> to throw users, and I think they understand that they can use a commit
> or a tag where a tree is expected

You are right that the "X-ish" was invented exactly so that folks
(including the nitpicky types among us) can tell if only "X" is
accepted, or other types of objects that uniquely can be peeled to a
"X" also can be used.  Many commands at the Porcelain level may take
a commit or a tag that eventually peel to a tree where at the lowest
level we only need it to be a tree, but it still matters in some
lower level corners of the system where the plumbing commands that
only accept a tree but not a tree-ish exist.  We've discussed this
in the past, e.g.:

    https://lore.kernel.org/git/7voc8ihq4a.fsf@alter.siamese.dyndns.org/

In general, I am OK to update the documentation and usage strings to
drop the "-ish" suffix when it is clear from the context.  But what
does it exactly mean that "--merge-base=<tree>" is meant to take any
tree-ish from the context of this documentation we are discussing?

 - Is it because merge-tree is a Porcelain command and we would
   adopt "Porcelains are to peel liberally what they accept, and
   when they are documented to take X they always accept any X-ish"
   rule?

 - Is it because the description that follows "--merge-base=<tree>"
   header does not mention "contrary to our usual convention, this
   option only accepts a tree and not a commit or a tag that points
   at a tree" and we would adopt "all commands and options that are
   documented to take X take X-ish, unless explicitly documented
   they only take X"?

As long as we clearly spell out such a ground rule and make sure
readers of the documentation understand it, I will not object to
such a tree-wide clean-up.  The current ground rule is "We write X
when we mean to take only X and we write X-ish otherwise", if I am
not mistaken.

>>         opt.branch1 = branch1;
>>         opt.branch2 = branch2;
>
> If branch1 and branch2 refer to trees, then when users hit conflicts
> they'll see e.g.
>
> <<<<<<< aaaaaaa
>   somecode();
> =======
>   othercode();
>>>>>>>> bbbbbbb
>
> but aaaaaaa and bbbbbbb are not commits that they can find.

Correct.  They are what they fed as two trees to be merged, aren't
they?  They (or the script that drives merge-tree and fed these two
trees) should be recognise these two trees, as long as they are told
that is what we show, no?

> That raises the question: if the user passes trees in, should we
> require helpful names be provided as additional parameters?

If the user wants to give human-readable name to override whatever
the code would internally produce, such new options may help them,
and should probably apply equally to input that happens to be a
commit (or a tag that is a tree-ish) as well, I would think.

> Or are
> the usecases such that we don't expect callers to have any useful
> information about where these trees come from and these suboptimal
> conflicts are the best we can do?

I do not necessarily think the output is "suboptimal" from the point
of view of our users, exactly because that is what they fed into the
command themselves.
