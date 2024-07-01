Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C2AC8C7
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 19:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719860808; cv=none; b=ozWKYLv9wUpwKjgTz1/tUl5sBSldxESB+M7pZCTjcKWle0EVQQqGhIdV8gxjkgW0IOTMFpVYNerKyMdpt2801/OcUgkCvC0hw+Dc89xbm3ooeep3St5zeqyl3bA+pv4sJHrSgt1XceKQHEzX4gGNOwoi2tfe1SS5aH6fXuyXhiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719860808; c=relaxed/simple;
	bh=nf5H/5K80MbwfkHHo0vavlfMtO1BCvXMlgrPW6OxkxY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ejN7ZtSVOdHLG8bzLtd2LrqtLSOzMO5Wir0xdbz1PYeVPubmuUfrcGqBomZ6FUkGINI/4Dqzs30928oXOccVL7irMar5gT1R95K9hsCR2sRwo1omqIMyEInEA5Iu/oyNc03dnQV97lJxy94hDRQaaBkNQQQqiyKNGx056bTaKrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TpA4WmfC; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TpA4WmfC"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E1EAA1A665;
	Mon,  1 Jul 2024 15:06:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=nf5H/5K80MbwfkHHo0vavlfMtO1BCvXMlgrPW6
	OxkxY=; b=TpA4WmfCvyXSUgvgo3OLaYhKNp8LGWh7o7rE86vZgiTLZ9u9t5fBK4
	GbOmapX1CQrw18U7UkWRyMEvZUUG5cQ4MwM0wLpMxiA6/lZq10NbcLg0cT8hc6g5
	BoUvUfChJAMK2y1qg/lm7oUSm5eC3u9tZgb5DYk4wdaY4MHlnqmKs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D97111A664;
	Mon,  1 Jul 2024 15:06:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 47EFE1A663;
	Mon,  1 Jul 2024 15:06:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Abhijeet Sonar <abhijeet.nkt@gmail.com>,  git@vger.kernel.org,  Paul
 Millar <paul.millar@desy.de>,  Phillip Wood <phillip.wood123@gmail.com>,
  Elijah Newren <newren@gmail.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v7] describe: refresh the index when 'broken' flag is used
In-Reply-To: <CAOLa=ZS359bMtUd+ktvJgHsiG-0=VVdGWYA2mKCNjc_1BrzcvQ@mail.gmail.com>
	(Karthik Nayak's message of "Sun, 30 Jun 2024 12:12:12 -0400")
References: <xmqqpls3zhc2.fsf@gitster.g>
	<20240626190801.68472-1-abhijeet.nkt@gmail.com>
	<03628ece-4f47-40d5-a926-acce684a21e5@gmail.com>
	<xmqqfrsyv155.fsf@gitster.g>
	<CAOLa=ZS359bMtUd+ktvJgHsiG-0=VVdGWYA2mKCNjc_1BrzcvQ@mail.gmail.com>
Date: Mon, 01 Jul 2024 12:06:44 -0700
Message-ID: <xmqqle2lvsmz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0F2436CC-37DD-11EF-A8C9-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> This explains for why 'broken' must use a subprocess, but there is
> nothing stopping 'dirty' from also using a subprocess, right? It
> currently uses an in-process index refresh but it _could_ be a
> subprocess too.

Correct, except that it does not make sense to do any and all things
that you _could_ do.  So...

