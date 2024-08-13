Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3282F198A05
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 15:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723561957; cv=none; b=JAKbg/AypQ/zgPwjCrhv0bbXKqNv6hlPkMIMFzjEzifdbUB51HQgv1wp8m39Du2gZuoCvYXcNvvCkPedWKQGY4JzRieVdn3GOis2QZoIzQAGJ+sRQPHiR76G6lLG2BnRrTxTYbm4Fg3k4GITLofSBVLz3Vjbt++I0Sqptbzn5IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723561957; c=relaxed/simple;
	bh=axZELAuMjD7yh+VpudzURVOammWkEt8bBGk4tTGedU0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bylMZaubsc/inGEdVcODxkRBJM9cFStJZ6wKPgjr38Sm3DhLlLnbZaK2SJopJO2dTKeT0ogUQ4+/ZdBuosvwTWK92CkM3RJpvZ8sxZbn24VOJgxCwh/tiXPs/Z6izihjynk+4N5yNeCvid5Rzs57hcUDIbvhS5D7HnWfpL2lwjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NfQjgizs; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NfQjgizs"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 05DE935494;
	Tue, 13 Aug 2024 11:12:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=axZELAuMjD7yh+VpudzURVOammWkEt8bBGk4tT
	GedU0=; b=NfQjgizsHUB6VJtzI7Pehm0z2J3OFs1gOhGIhei7anoRXGi0J5iMqb
	m7vpMnBT3vT0aVpkM79FDG6EVFBBooVQOwdm02NvPJRpQAYIDBYa33sWdBM1pFTW
	RkcnRFBzEyLqmnpo8tDcgzvnC9msmr2L5gbLe/o+v8/nY3ag3w9Pg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F0A3A35493;
	Tue, 13 Aug 2024 11:12:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 50EA835492;
	Tue, 13 Aug 2024 11:12:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Justin Tobler <jltobler@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 02/20] path: expose `do_git_common_path()` as
 `strbuf_git_common_pathv()`
In-Reply-To: <ZrsmiWeu8JsX54nU@tanuki> (Patrick Steinhardt's message of "Tue,
	13 Aug 2024 11:25:29 +0200")
References: <cover.1723013714.git.ps@pks.im>
	<e7a143c30dd95d8192eacc35c876e7926cb7c6a4.1723013714.git.ps@pks.im>
	<ytv7y3jlbaru5o3ehotanqoqvjnwaomzsyj746k3hbb3htymts@m4qct6cvebiz>
	<xmqq5xs9eh4p.fsf@gitster.g> <ZrsmiWeu8JsX54nU@tanuki>
Date: Tue, 13 Aug 2024 08:12:33 -0700
Message-ID: <xmqq4j7oa23i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 77E0D812-5986-11EF-AD7F-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> Yes, if the function is about obtaining the path for a file in a
>> given repository's metadata directory, and its association with
>> "strbuf" is that it merely happens to use it instead of "char *",
>> it should not be named as if "strbuf_" ness is the primary
>> characteristics of the function.
>> 
>> strbuf_cleanup_path() should also be renamed for the same reason.
>
> Agreed. I was doing it for consistency's sake in this case, but let's
> rather not make the overall interface any weirder than it already is.

Thanks, then we are in agreement.

