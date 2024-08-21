Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E11C1C687
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 16:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724256426; cv=none; b=YwV8qNlq/55nhov5uEs2HYE9CqJfShD3oxE3ObysReUELyN1YrI8QbKlc864fgqOMOR87KPpsXLxzdrkha0Eotl6Rpv9LJl++1qYGg8U9bjfZ7qya4cHO6/GMPpzJC6W2K83OIl/GS8d7MfcsNOuvuW6NjjjZmqOMRt/2ObPNNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724256426; c=relaxed/simple;
	bh=w+E3nVW9jQj2yxVuRpGt6FTHrppYaBPGYvsGopM65FA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eJ7EAvNHKJ+dsAL/tr3Jehbav4Kp9nyjHCwLxQ3XVKYsfLkO90PCO9OFGlTcalqozaCvXPa/uV5xoPmOSbhwK6hQ/RNkqgg9XsATAmdn2yIuTN+YmZxz4CYq8LvW8e0I9CuVpgO/WoVU8rfck+96OTq1smIgBgZaDk7vU8YusQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FN4DvenP; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FN4DvenP"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4142C358CB;
	Wed, 21 Aug 2024 12:07:00 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=w+E3nVW9jQj2yxVuRpGt6FTHrppYaBPGYvsGop
	M65FA=; b=FN4DvenPeAC4QWw7BkybVjsL1ke6houQWhpX0BY3M8nsL9nHRVblOE
	KPqDqUddoU2CyM+xRTV+dUlaxayZ9sddgu7/Pr8ZQ73CBpmQ920Wj5g1p39clUyS
	NAVDeKJ/ZaOoNNjhvIdZJFks6TDQdZFgJMYMhs/TGGePFGRmQ0v80=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 39F43358CA;
	Wed, 21 Aug 2024 12:07:00 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C0E9F358C8;
	Wed, 21 Aug 2024 12:06:56 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Yukai Chou <muzimuzhi@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: builtin/config: --name-only doesn't imply --show-names in "git
 config get"
In-Reply-To: <CAEg0tHTWzgD5bw3oK7-Rtv9oTymqyhvZz3bcJ7yNRhF8wXMLGA@mail.gmail.com>
	(Yukai Chou's message of "Wed, 21 Aug 2024 16:10:33 +0800")
References: <CAEg0tHTWzgD5bw3oK7-Rtv9oTymqyhvZz3bcJ7yNRhF8wXMLGA@mail.gmail.com>
Date: Wed, 21 Aug 2024 09:06:55 -0700
Message-ID: <xmqqttfd2734.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 63C1C51A-5FD7-11EF-9024-BF444491E1BC-77302942!pb-smtp20.pobox.com

Yukai Chou <muzimuzhi@gmail.com> writes:

> The v2.46.0 doc of git-config(1) says
>
>> --name-only
>> Output only the names of config variables for `list` or `get`.
> https://git-scm.com/docs/git-config#Documentation/git-config.txt---name-only
>
> But the behavior of --name-only is more like "disable non-name outputs
> and leave the output state of names as-is". Thus using --name-only
> alone, one gets totally empty lines (which might be weird); only using
> --name-only and --show-names together, can one get output of just
> names.
>
> # get empty line(s)
> git config get --all --name-only remote.origin.fetch
> # get lines of name(s)
> git config get --all --show-names --name-only remote.origin.fetch
>
> Either the doc or the behavior of --name-only needs some adjustment.

This argues for making "all" imply we need to show the name of the
configuration variable, and introducing an option "--hide-name" to
omit the name.  That way, you'd need to give clearly contradicting
"--hide-name" and "--name-only" together to get a nonsense output.
