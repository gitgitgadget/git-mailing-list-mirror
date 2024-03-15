Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FE03E468
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 17:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710522043; cv=none; b=A1ceSENEWs2Q+iCL3VUbnONHB5vSYTgN6NBqhfviAyO36wSrlgvORiesnm3VQqQ2FLboAmtlN3e9zxJtiJn9SdK6YPCe7L/UxM8DlfZrWAt2QCSq1KnYJ2LMOuWqP2ifJtFK6+ETq+38zpi2M+sIpFpeLxOPHKCjJn2z5B1LkH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710522043; c=relaxed/simple;
	bh=qwasQFhc1ivOoU0YV3Eso/u+KW0gQMq/Nx/GIK0ss1I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qesA9RPv/b2owpjv1BzFodbHLScgC8q7obEUWBuSv0LGcMkfKyLgk7fxSjPpEdSb2lj6+30jIshHkvOJMNgSO6/ao1opbswtdffYAVDvmblCorqhGAjfWksLlRXCwp3IvjqOurDUv1BJprk0tnGYZ8ahL08tMvLjZX3Bd0SFzPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=cqqE/eQ7; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cqqE/eQ7"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 626FD328DF;
	Fri, 15 Mar 2024 13:00:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=qwasQFhc1ivOoU0YV3Eso/u+KW0gQMq/Nx/GIK
	0ss1I=; b=cqqE/eQ7/mLlnBvWMQeaZZ5J3VU6vEpsKHL8aiLfCzRzfWGxhh82ca
	FfTyR9k6loz+e/U5aok44vuCpIHKxkVg9YRQ2qjEg1zCFtlgPgWTEeJjkf1cJX5t
	D6VsyEOEJ37XswlHJreRhgJRxgooZaBgMhAjOgGzZgyfUT5cCcljk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5A59D328DE;
	Fri, 15 Mar 2024 13:00:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EE643328DC;
	Fri, 15 Mar 2024 13:00:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: git@vger.kernel.org,  David Heidelberg <david@ixit.cz>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Dragan Simic <dsimic@manjaro.org>
Subject: Re: [PATCH v5] diff: add diff.srcPrefix and diff.dstPrefix
 configuration variables
In-Reply-To: <20240315055448.GA2253326@quokka> (Peter Hutterer's message of
	"Fri, 15 Mar 2024 15:54:48 +1000")
References: <20240315055448.GA2253326@quokka>
Date: Fri, 15 Mar 2024 10:00:36 -0700
Message-ID: <xmqqy1ajqvkb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8C0E5766-E2ED-11EE-B7C6-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Peter Hutterer <peter.hutterer@who-t.net> writes:

> Allow the default prefixes "a/" and "b/" to be tweaked by the
> diff.srcPrefix and diff.dstPrefix configuration variables.
>
> Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> ---
> Changes to v4 (as pointed out by Dragan):
> - copy/paste-o fixed in the dstprefix test

This one I understand is an improvement

> - reworded the description for the tests as suggested

Moving from "diff src/dstprefix" to "diff.*prefix" feels more like a
regresison to me, when it is about interaction between {src,dst}prefix
and other kind of prefix variables like {no,mnemonic}prefix.  I
would have understood if the updated title were more like:

    test_expect_success 'diff.{src,dst}Prefix are ignored with diff.noPrefix'

I am tempted to queue v4 with the z/ -> y/ fix from this round,
without any other changes from v4 to v5.

Thanks, both.

