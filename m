Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D5913D621
	for <git@vger.kernel.org>; Thu, 23 May 2024 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716472854; cv=none; b=PwR736JSXn0vtdW/vZkUG8QT5GdRl+TI16PZjcdxny/2FVb4SVrgeMoIx3RdEbs+dnn0Cv2TchaNAhyvgH/Wk72CsxYE/BZEVoEhDSbOIsSYNbqcWlf0n7skYVmtFL5hDUbhGI5AK9DHJNQL/25neDyLHHihJBa5ocqzvLxcMV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716472854; c=relaxed/simple;
	bh=eNAzTx4Bl8E26KRhLDBHe6uIYIYd6R1AK2XSKx92F1w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rUHkcYHQpDYDKciK4LZKlJZ3LrbgIkBFkrzNa2nIFsT4D3w4Uck0nnxF0SXB35HUVcRuK53aYP45J0zg5Iv5MuEDctBu7YMWbkuAk7oDUAKStxX8ar+xojg+64YXcdj6qmtfsH1DbUvRAisqj/JFAIacweveLnmAW7pLh8lnY4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GQN9gu0l; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GQN9gu0l"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E095C1FC8F;
	Thu, 23 May 2024 10:00:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=eNAzTx4Bl8E26KRhLDBHe6uIYIYd6R1AK2XSKx
	92F1w=; b=GQN9gu0ltOhTayAu5hoLWFkwr166ITKVvUySjl4TxaYmwgH9LfF19C
	ow0TxeZObKZa+AjgiA0ALOI/8Sv2eI9u5wkB/YykWCsLFdi3hEV3cDYhroqvptAu
	GV/Ecv1xj1gQjiTGZDbdOTdGbAxx8RQoEz/eyctiOLhp3cT64P61U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D8F341FC8E;
	Thu, 23 May 2024 10:00:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4B8F81FC8D;
	Thu, 23 May 2024 10:00:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  Dragan Simic
 <dsimic@manjaro.org>,  Git
 List <git@vger.kernel.org>
Subject: Re: [PATCH 5/5] add-patch: render hunks through the pager
In-Reply-To: <20240523090601.GC1306938@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 23 May 2024 05:06:01 -0400")
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
	<eb0438e8-d7b6-478f-b2be-336e83f5d9ab@gmail.com>
	<xmqqh6esffh1.fsf@gitster.g>
	<ec5d73e22a6e4587f3d87314a9c0e422@manjaro.org>
	<20240521070752.GA616202@coredump.intra.peff.net>
	<5f6f3ce7-a590-4109-ab8a-1d6a31d50f3c@gmail.com>
	<20240523090601.GC1306938@coredump.intra.peff.net>
Date: Thu, 23 May 2024 07:00:47 -0700
Message-ID: <xmqqjzjky6eo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DC0308E8-190C-11EF-AF32-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> I do still think it
> would be useful to be able to configure its pager separately (in my
> case, I'd use "less -FX" rather than my default setup, which doesn't use
> either of those options).

Even better.  Allow to optionally have the command after the option,
e.g.,

    (1/1) Use this hunk [y,n,q,j,k,e,p,P] P<RET>
    (1/1) Use this hunk [y,n,q,j,k,e,p,P] Pless -FX<RET>
    (1/1) Use this hunk [y,n,q,j,k,e,p,P] Pcat<RET>

The first one feeds the default program with the hunk via pipe, the
second one instead invokes command you specifed, "less -FX", and
feeds the hunk to it via a pipe.  The last one emulates a plain 'p'
behaviour.

And for usability, perhaps giving a specific command would change
the default program a bare 'P' invokes for the rest of the session
until another specific command overrides.  Another usability hack
may be "[interactive] pipecommand = less -FX" configuration variable
gives the initial default for each session.

At that point, we can explain it as

   p - print the current hunk
   P[<program>] - pipe the current hunk to a program

or even use '|' instead of 'P'.

