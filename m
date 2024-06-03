Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA955882B
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717429349; cv=none; b=lLcbxPjPMpnin4ZbYKBYvlhjiS/qBHKFcG+N5ehDGWlLBImzj+tmhJV9NX72aZSEeu4jq9KPHZDYnIu+J3HD0CUXHHkQ28uhZNLrv2uqK8Hk7U+KQlujSb1v3q9s2huR4zSvOwEm7xmo1MpyUGCBWTyR4jK9YhZONIYst75Xmao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717429349; c=relaxed/simple;
	bh=P6g2ErfAyP4Ri3NmDrljiSYuOVRzq8XOWkOeYi4qOHg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CjmQGskFeHOQRXhUjI3Y+CgZKX0Ax3YQWf4tOe7AeDmL+Q+2hrH0ZsFXlhpDChNJTNoqGIP1eFCQD0B3zdHZN0mwN2jk5eHFwXmT+f7tbWoGEaFWIveuV78/CgYis+wBsw9Zba9X2JK+a4qbq7gMMvnNwK0UCUINoRw5Todljpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FVZ6tjh6; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FVZ6tjh6"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2FAEA28DA9;
	Mon,  3 Jun 2024 11:42:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=P6g2ErfAyP4Ri3NmDrljiSYuOVRzq8XOWkOeYi
	4qOHg=; b=FVZ6tjh6DL8V9NksqmFDJU912XYAD+G5zU6RNJZYxjgn5JieNL5p4f
	jfAqk/moIiEaBeEBTtTI5q+yOfy4I9CJIhoz/o2hb+vNw4E7c8k/BFKrRyU8ed35
	OfE/n/P5hV64Jp8pwdLg2f0qZArpWDuFs/Cwc6978dwD1YpXd7dro=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 296AA28DA8;
	Mon,  3 Jun 2024 11:42:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4984128DA7;
	Mon,  3 Jun 2024 11:42:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Stefan Haller <lists@haller-berlin.de>,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>,  Patrick Steinhardt <ps@pks.im>,
  =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 0/2] rebase -i: improve error message when picking merge
In-Reply-To: <28796edf-65eb-4f28-8651-af97e00cabc9@gmail.com> (Phillip Wood's
	message of "Mon, 3 Jun 2024 10:22:32 +0100")
References: <pull.1672.v2.git.1712585787.gitgitgadget@gmail.com>
	<pull.1672.v3.git.1717076630.gitgitgadget@gmail.com>
	<xmqq7cfbp6pb.fsf@gitster.g>
	<28796edf-65eb-4f28-8651-af97e00cabc9@gmail.com>
Date: Mon, 03 Jun 2024 08:42:22 -0700
Message-ID: <xmqqh6ea6nj5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DF7435EA-21BF-11EF-A2A0-ACC938F0AE34-77302942!pb-smtp20.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

>> OK.  It would probably have been unnecessary to rebase only for this
>> update.
>
> I agree the conflict is easy to solve but GitGitGadget gets upset and
> refuses to run the ci if it cannot merge the branch into master

Heh.  TIL.  That's a tad unfortunate that we have to let the tail
wag the dog, but OK.
