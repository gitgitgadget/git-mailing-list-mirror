Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B61A18E760
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 23:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727305897; cv=none; b=lZYCil63G8oFvi8ZkZwJ9CdSj/QgnRzN9uwbg3ClrYPACAPSUyp71wGDT1PdMIfqXkvCBJLbHATHr+aKCukzoKBLhZbxsq5zt+Uitq47oh1rjGVAgaBzJvGXOdppgYuCguH0dPR/yK8S7JQ8VArsyShSTh3vnnzow3ie9JLqN6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727305897; c=relaxed/simple;
	bh=uJQVre48aMtkwzjrDXPBFmHHtnBCd6yvd/ob/XGfEy8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mI0WMDmMplEbL25WQY8ZiLGvVe9uLYgb9soT5wzuHAVgUskL1jsmVq07DNXr2VTA6eE+ZnCv8DXA/XQ79jh0s1X59xuIBwElp0FbV+L0HYjOS+Bym+6HpQDfoAApbTNp3xPTYW1Yx7tbO7W4C+kVJSItZx2oj3SlPIrZTnOodm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=p+b+5NqF; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="p+b+5NqF"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C87F2FA99;
	Wed, 25 Sep 2024 19:11:28 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=uJQVre48aMtk
	wzjrDXPBFmHHtnBCd6yvd/ob/XGfEy8=; b=p+b+5NqF5gRBX4TV4ZtoBL1am49M
	yQv3+zLKYRlnKXa4RKxGjSP7k4l5uuniTUW7sBQIv8OUxMsJ3tdAJS8ujJU29ywp
	G+yTstQJT+TfRuf9oXP+cBN14iN14IUB33cl6QqYGukpkaFcQOwnLL3fvfN8jXrr
	JN1CuxWIxrMTISc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 34FD42FA98;
	Wed, 25 Sep 2024 19:11:28 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7884F2FA94;
	Wed, 25 Sep 2024 19:11:26 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Anselm =?utf-8?Q?Sch=C3=BCler?= <mail@anselmschueler.com>
Cc: git@vger.kernel.org
Subject: Re: Confusing error message for git switch -d
In-Reply-To: <ce9f0440-e724-4116-b63a-0e62c46c170d@anselmschueler.com>
	("Anselm =?utf-8?Q?Sch=C3=BCler=22's?= message of "Thu, 26 Sep 2024
 00:25:16 +0200")
References: <ce9f0440-e724-4116-b63a-0e62c46c170d@anselmschueler.com>
Date: Wed, 25 Sep 2024 16:11:25 -0700
Message-ID: <xmqqr097miqq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 7D578BD6-7B93-11EF-B34B-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Anselm Sch=C3=BCler <mail@anselmschueler.com> writes:

> I wanted to get the code for CPython 3.12, so I tried running git
> switch -d 3.12, expecting 3.12 to be a tag (which it wasn=E2=80=99t, an=
d it
> was a remote branch).
>
> Git produced this error message:
>
> fatal: '--detach' cannot be used with '-b/-B/--orphan'
>
> This is confusing since I didn=E2=80=99t pass any of these options.

True.  FWIW, this is shared between "checkout" and "switch', and I
agree that there is a huge room for improvement.

With (arguably overly aggressive for its own worth) the "--guess"
option being default, giving the name of a unique remote-tracking
branch (that is, "3.12" appears as a remote-tracking branch of only
one remote, among possibly multiple remotes you have defined for the
repository) would behave as if what you said, which is "3.12", is
equivalent to "-b 3.12 --track origin/3.12" (where the "origin"
thing is the "only one" remote for which 3.12 exists as a
remote-tracking branch).  So

    $ git switch --detach 3.12

behaves as if you said

    $ git switch --detach -b 3.12 --track origin/3.12

and the error message is given.

I am merely saying that the mechanism from which this error message
is given can be _explained_.  I do not think it is well designed, as
it does not give a great end-user experience.

Disabling checkout.guess configuration would force you into the
habit of being a bit more explicit.  Even with checkout.guess
configured to false, you can still say

    $ git switch --detach origin/3.12

and because this does not blindly translate to -b/--track, you would
not see such an error.

A more appropriate design for "--guess" would be to notice the
presence of "--detach" and act differently, i.e. not rewriting
blindly 3.12 to "-b 3.12 -t origin/3.12" unconditionally, instead
rewrite "--detacu 3.12" to "--detach origin/3.12" if "--detach" is
there.

Patches welcome ;-)

