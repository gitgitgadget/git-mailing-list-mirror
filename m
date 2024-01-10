Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A2B4F610
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 21:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="O7dAylCC"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2E499315A9;
	Wed, 10 Jan 2024 16:46:28 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Zt64IiwBM+pLWam9bzhlbTK7ATwI3OQ8dD8+Ly
	OC5Gc=; b=O7dAylCC+OFjoB46H9pRXG6iTfGdcv20+/DcAH/LNyEO7qddIFiTmC
	5ETXV6uvhfkdLEJf4Eoy9t7ggXC9llYTDhITMeytkwMKApZfyPPM84wv+v4FReel
	ORR+CiZQZ0vmrmLQ9LihfV066bJf2zDSNWeGMnmHPxFmB5qPgUaAE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 274F1315A8;
	Wed, 10 Jan 2024 16:46:28 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 68394315A6;
	Wed, 10 Jan 2024 16:46:24 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] branch: error description when deleting a not fully
 merged branch
In-Reply-To: <xmqqbk9tcc57.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	10 Jan 2024 09:48:52 -0800")
References: <04c3556f-0242-4ac3-b94a-be824cd2004a@gmail.com>
	<xmqqbk9tcc57.fsf@gitster.g>
Date: Wed, 10 Jan 2024 13:46:22 -0800
Message-ID: <xmqqr0io980h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B3494076-B001-11EE-BEF7-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> This is probably one sensible step forward, so let's queue it as-is.
>
> But with reservations for longer-term future direction.  Stepping
> back a bit, when 'foo' is not fully merged and the user used "branch
> -d" on it, is it sensible for us to suggest use of "branch -D"?
>
> Especially now this is a "hint" to help less experienced folks, it
> may be helpful to suggest how the user can answer "If you are sure
> you want to delete" part.  As this knows what unique commits on the
> branch being deleted are about to be lost, one way to do so may be
> to tell the user about them ("you are about to lose 'branch: error
> description when deleting a not fully merged branch' and other 47
> commits that are not merged the target branch 'main'", for example).
>
> Another possibility is to suggest merging the branch into the
> target, instead of suggesting a destructive "deletion", but I
> suspect that it goes too far second-guessing the end-user intention.

The longer-term concerns aside, if you are inclined, we might want
to have this as a two step series, where [1/2] does a clean-up of
existing source file, i.e. losing the unwanted leading space from "
enum advice_type {" in advice.h and sort the advice.*:: list in
Documentation/config/advice.txt.  It is optional to sort the
advice_setting[] list in advice.c and "enum advice_type" in
advice.h, as they are not end-user facing, and we should be using
the defined constant without relying on their exact values.  But
keeping the config/advice.txt sorted would help readers more easily
locate which configuration variable to use to squelch a message.

And [2/2] does the rest.

Also I forgot that in the version I queued, I fixed the title to

    branch: make the advice to force-deleting a conditional one

Thanks.

