Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C47F83A1C
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711639394; cv=none; b=J0fmkYOalvugqnKOpdsQXVUqyZvMJf2dXyKqm8T5IxRRM0uHUeV2+nDmRGMGr95RI6s8RBpVD09SCEWi8Lti0zXhyfXHmNddspZ55zI/ILvIJ5utrtDEubyk0GOlEUG3nOnnaIBegU2waKc+l2rjRi9V7fkCBMfvBAOFA8wnxwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711639394; c=relaxed/simple;
	bh=RJoWet0AbJkhADEeJ9/xA2X45ffUfREXm+QrDLgpn/g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p3IHFEDCdYEyRlme1+AiuGGoo2fKZ5fupPUSQrdwgYRC+/D4JRGNnPCA2QwdJ/sEDzB3OdkvscOC6u+8yJO87CRRQE3Ap1h0vzOi/tnEwinEg05xiIvNUBb2iIw4MJdvVG64cYJHwm5d/yTEcC9bDtbHuGyF5CQoKzHLfzsnBMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=lJ6790ct; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lJ6790ct"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 010471D526;
	Thu, 28 Mar 2024 11:23:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=RJoWet0AbJkhADEeJ9/xA2X45ffUfREXm+QrDL
	gpn/g=; b=lJ6790ct4r3NKrkU561LCJjd4KP8D9puaYZxndm87fU/UV+b0lU7JC
	AxE2sx7T0fcCWRdtAPNFma8dAyusm8oVXcosD3931DmarzLTZPricrbiR2VomD6N
	sX3NcuQDYMBa9r8WXWPHr4NDecJRB8ePJNv/XoYTHVS8u6MYRur+g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id ED6871D525;
	Thu, 28 Mar 2024 11:23:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 80D6B1D524;
	Thu, 28 Mar 2024 11:23:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: zhang kai <kylerzhang11@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Update message_advice_pull_before_push to mention how to push
 after rebasing
In-Reply-To: <CAK_130T8sZUZAuvj4x7sB278kVL7ARaBv3Pg2djQB45O+7xKTg@mail.gmail.com>
	(zhang kai's message of "Thu, 28 Mar 2024 17:54:13 +0800")
References: <CAK_130T8sZUZAuvj4x7sB278kVL7ARaBv3Pg2djQB45O+7xKTg@mail.gmail.com>
Date: Thu, 28 Mar 2024 08:23:06 -0700
Message-ID: <xmqqo7aywfc5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 14E10E02-ED17-11EE-9983-A19503B9AAD1-77302942!pb-smtp21.pobox.com

zhang kai <kylerzhang11@gmail.com> writes:

> Hi all,
>
> Our team uses git rebase a lot. A common hiccup we noticed during the
> daily work is that new devs often didn't know how to push properly
> after the rebase.
>
> When someone try to push to the remote after rebasing the branch, the
> push would mostly fail with the message_advice_pull_before_push:
>
>> Updates were rejected because the tip of your current branch is behind\n" "its remote counterpart. If you want to integrate the remote changes,\n" "use 'git pull' before pushing again.\n" "See the 'Note about fast-forwards' in 'git push --help' for details.
>
> However, in this situation, pull will "invalid" the rebasing. After
> pull then push, devs often will be surprised by the merge/pull request
> containing diffs that should not be in this branch. In this case, we
> often should just do `git push --force-with-lease`.

Use of --force-with-lease without specifying exactly what commit to
expect there is not a good hygiene, but when you rebase your topic
branch on the updated upstream, you are already committed to force
update your published topic branch.  So "your push does not
fast-forward; pull first before pushing again" is not sufficient.
If you know your push does not fast-forward, and if you want to
force push, then you should not pull first.

> If we add a message like "If you just rebased your branch, please
> consider 'git push --force-with-lease'" to the
> message_adivce_pull_before_push, we may save devs some time figuring
> out what's wrong with their branch.

I am not sure if that is a good idea in general, though.  That "if
you just rebased" applies only to the case where you rebased your
topic branch.  If you forked to work on topic from the upstream's
primary integration branch, worked on that topic, and then rebased
your topic on top of the updated upstream integration branch (which
contains new work from others since you forked and while you were
working on that topic), you do not want to force.  force-with-lease
may help you avoid overwriting and discarding others work, but the
only sensible next step in such a case is to pull-rebase again,
which will rebase your work on the topic to build on these recent
work from others.

So, I dunno.
