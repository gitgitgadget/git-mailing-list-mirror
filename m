Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312A960878
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 19:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707853159; cv=none; b=h4Eg+2w+D8uusuXLVOd2cfcaJSKMnMWCv7GRZ7ZbgX4oMn+eTZm6yEQciGSzvViD6TZkDKUCg0i2INzUyHzi1S0hWy+9IMKwzNS4b0KTBgcy4MVrAxM7sf4IBq3KccBY2lHzhAHwZ7/44qYSSEHTHQ9pi3KkIaslaJaypuY3JU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707853159; c=relaxed/simple;
	bh=Eqp0g4cgkhP45bKggLO1sqh1XVy9dMJ++F3V8VXCWk0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K3YjX8KnO7xpsK8OQJb99yCfDCkL1lKtun9NTd5KDaCTEC4vggCWLRZYi1obsrpWrSh0mp+dIFAiBivvOdLS0MUdCo8J5XQ07pGgpQljSZJj7nIsSw4yvk+TMf6anQ73mn3qolo1E6SqCGAxIcrborzW/EA8eiItyHICXzjSpOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rz2IwXXM; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rz2IwXXM"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6873135CB8;
	Tue, 13 Feb 2024 14:39:17 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Eqp0g4cgkhP4
	5bKggLO1sqh1XVy9dMJ++F3V8VXCWk0=; b=rz2IwXXMUUmU9ESdQQ9Ck1edXPRd
	TgZYRjCX9nq+vt8Ji5oQp/+CR+OBMoxP3G9vL4iqZlVtulFfHrOe28o1kFnrzQiJ
	gYGd792XWO491FSRZx1FLqMLra+/GlmNMLznowuD1+keYAOdKBaE0Mex1FR5LAH1
	yrRCeadSQZRqZQc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6215035CB7;
	Tue, 13 Feb 2024 14:39:17 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1117435CB2;
	Tue, 13 Feb 2024 14:39:14 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,  git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] column: guard against negative padding
In-Reply-To: <69f60c3a-ff47-4cb9-a229-6c5a36e7d9fa@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Tue, 13 Feb 2024 19:39:51 +0100")
References: <1c959378cf495d7a3d70d0c7bdf08cc501ed6e5d.1707679627.git.code@khaugsbakk.name>
	<cover.1707839454.git.code@khaugsbakk.name>
	<9355fc98e3dac5768ecaf9e179be2f7a0e74d633.1707839454.git.code@khaugsbakk.name>
	<xmqqcyt08fa1.fsf@gitster.g>
	<69f60c3a-ff47-4cb9-a229-6c5a36e7d9fa@gmail.com>
Date: Tue, 13 Feb 2024 11:39:11 -0800
Message-ID: <xmqqle7o5f34.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 914847A4-CAA7-11EE-B1E7-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

>> This one happens to be safe currently because "git tag" passes 2 in
>> opts->padding, but I do not think this is needed.
>
> At first glance, I also thought this was not necessary.
>
> However, callers of run_column_filter() might forget to check the retur=
n
> value, and the BUG() triggered by the underlying process could be burie=
d
> and ignored.  Having the BUG() here, in the same process, makes it more
> noticeable.

The point of BUG() is to help developers catch the silly breakage
before it excapes from the lab, and we can expect these careless
developers to ignore the return value.  But "column --padding=3D-1"
invoked as a subprocess will show a human-readable error message
to such a developer, so it is less important than the BUG() in the
other place.

There is no black or white decision, but this one is much less
darker gray than the other one is.
