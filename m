Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5BD17584
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 01:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707874540; cv=none; b=QGrrGOFEHn4owmln0WRkrHSo4bBjx5mhgVjlwjXyOLaPLwr+ErE7us6YyReBmpMXSxW2lZXkbErnowlI6yIuMZagS1wqI5G0ZFmSp3sPMBneGwdoKCoqdW2TIc7qal+RYAB8rx2kW9c45TyPEtTToqhfswf/JM7lu6xxUyVvTP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707874540; c=relaxed/simple;
	bh=nN0ohPCmRie2hiPCs6O+GMYwbvkGuAGMnBiaKbPjuLA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZsmlSOqzzoC1qi28izGUC1QMIbtC9UMu6gcCD/wbBSp4J/MruPlrE4aBWpJcrkbwFphji5uZQZ0yJOijcOjRvnAkzTZa5lhTEbY+YANrxTYB3pPijfy31iTMxIi3y+1sbJjnNeO1kWm5+BB11dVIL6dVmwU0JrIn4kmAkTBwRb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KDIjH12F; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KDIjH12F"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BA48D1C0AF;
	Tue, 13 Feb 2024 20:35:38 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=nN0ohPCmRie2
	hiPCs6O+GMYwbvkGuAGMnBiaKbPjuLA=; b=KDIjH12FzcxUXYU68OS8/FF+bbK4
	yRwJFFGAc2EiiGxcuszGqHxXp/BOO0e1JDanWZO3XggIsCbfABOOaDMYuUz4/0mp
	mmluyUTxGpiA72HN+wExcpmJdOFO88j/Z+2A3NBr1Tu0hevMrPoBjibgSNca9Da2
	//MGM0NuhoVQjIY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B1D0C1C0AE;
	Tue, 13 Feb 2024 20:35:38 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 625E31C0AD;
	Tue, 13 Feb 2024 20:35:35 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,  git@vger.kernel.org
Subject: Re: [PATCH] tag: error when git-column fails
In-Reply-To: <59df085d-0de8-45b1-9b8b-c69e91e56a1f@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Wed, 14 Feb 2024 00:36:38 +0100")
References: <1c959378cf495d7a3d70d0c7bdf08cc501ed6e5d.1707679627.git.code@khaugsbakk.name>
	<cover.1707839454.git.code@khaugsbakk.name>
	<9355fc98e3dac5768ecaf9e179be2f7a0e74d633.1707839454.git.code@khaugsbakk.name>
	<xmqqcyt08fa1.fsf@gitster.g>
	<69f60c3a-ff47-4cb9-a229-6c5a36e7d9fa@gmail.com>
	<xmqqle7o5f34.fsf@gitster.g>
	<8acde766-e2cd-4901-b665-f677cd15295d@gmail.com>
	<59df085d-0de8-45b1-9b8b-c69e91e56a1f@gmail.com>
Date: Tue, 13 Feb 2024 17:35:33 -0800
Message-ID: <xmqq1q9f25ga.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 598C68A4-CAD9-11EE-981B-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> @@ -530,7 +530,8 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
>  			struct column_options copts;
>  			memset(&copts, 0, sizeof(copts));
>  			copts.padding =3D 2;
> -			run_column_filter(colopts, &copts);
> +			if (run_column_filter(colopts, &copts))
> +				die(_("could not start 'git column'"));

Nice.  This obvious omission should have been here from the day one.

Will queue.  Thanks.

>  		}
>  		filter.name_patterns =3D argv;
>  		ret =3D list_tags(&filter, sorting, &format);
