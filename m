Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770C0ED8
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 18:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711650088; cv=none; b=BsJn0nf74D1gflCUUjflGh5/CckU8EKpITqAz/zy4A9WCrdBzQyvjHmNIWRajd/uzR78BLnLVq7quIdnt7J32Ame3SI6Z51TYqFjillA2XFh+tEY723xogkDu5bQWueL5/dYddhpt7IqtRWnCHiIu4OMm0OzMf+aAHNGGFmgD/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711650088; c=relaxed/simple;
	bh=sjStVPYvHfE3ImYO6iSZThkwpUuA0W32ahhjKH76SsU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Oe3+gPjwCqZSvzZtn0p5PkcRQ77XTMEOD5Rz/CybY+62kkByfKvfjytK0H3AmEbUUzpG+XjklRUht4oP2JfeUQ82zQRqP5/VbTWNFKSXvGmdwTWqFNDxh0JeduKCzQrzF/0Fm5n3+GU0pvFBAKQYE6jH75NaHKUzItzK1aUqMhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=N3LiBJdt; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="N3LiBJdt"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 10D101E8F7;
	Thu, 28 Mar 2024 14:21:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=sjStVPYvHfE3ImYO6iSZThkwpUuA0W32ahhjKH
	76SsU=; b=N3LiBJdtdg03u1dHPrHhbGq0dp2rWFOIl4zLpighuyhErMgTGlLqRB
	IY3Lz1c+t44MNjICsROMV3ChXFOB+xB9dqGiC6czEm0lg1sXhUhZhAhuRe9EQ2i4
	VsP875ik2HDdfKEBkLWtGA1eQhq2AJJXiAsQQ5auMCovK75kga5OI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 085601E8F6;
	Thu, 28 Mar 2024 14:21:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 948E31E8F5;
	Thu, 28 Mar 2024 14:21:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Eugenio Bargiacchi <svalorzen@gmail.com>,  git@vger.kernel.org
Subject: Re: Better visual separation of hunks in `git add -p`
In-Reply-To: <a9cffbe4aadd319760635ca6d5b4f465@manjaro.org> (Dragan Simic's
	message of "Thu, 28 Mar 2024 19:14:22 +0100")
References: <CAHfn=+snXChcPFiEgxvK=XFCq2uVMKQTyfrN9RNfAod18d0V=Q@mail.gmail.com>
	<xmqqo7ayuwpi.fsf@gitster.g>
	<a9cffbe4aadd319760635ca6d5b4f465@manjaro.org>
Date: Thu, 28 Mar 2024 11:21:20 -0700
Message-ID: <xmqq1q7uusin.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FB0CC0CA-ED2F-11EE-BE31-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> Here's a possible solution, or better said a new configuration option,
> which I've been thinking about for a while...  When running "add -p",
> displayed chunks can sometimes become confusing or a bit hard on the
> eyes, but simply clearing the screen _before_ displaying any new step
> (i.e. a new chunk, interactive help, etc.) could make it much easier
> on the eyes.  It would be a new option, of course.

Or your 'p' option can have a 'P' variant that clears before prints.
I have this feeling that even those who want clearing of the screen,
they do not want it always on, when many of their hunks are 7 lines
long.
