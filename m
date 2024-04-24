Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D4D156999
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 21:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713994594; cv=none; b=Y0p327evp9maxz79mriLEYGP0aAKOejdH7Gj1eUiAoCE2NzCoerQxVvepCWmLEpCzUS7a+iDDEui5ySAsPzlFoZLfWLqQhpW9FM0qxWId8gOguIcz9YEVnPs2ABqw20jsZRODmzIhbIEWjvHP9iGZR/7ayiMOjqfwbI0rt3CMO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713994594; c=relaxed/simple;
	bh=rvZ0DSB2tI6kgMv5Pt6L/lwKOEqs2iauba/SsYusPUM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fLSkijPPUq86QGsP5soy1m1JodPwAmNDaW/LPN2UyVgS3csLirHaB8UW3ep1eWl+Py1yNYAFEoi6EJoTrG1tUNRonp17XKxa0KDU4MMlDIm7HpPBazBfKUA45MIkr/TcttXnAb+KzM+9teYyru8MiaPSEsRuWyXrRIJU4K6waTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=qcxznwE1; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qcxznwE1"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0E0491CB3E;
	Wed, 24 Apr 2024 17:36:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=rvZ0DSB2tI6kgMv5Pt6L/lwKOEqs2iauba/SsY
	usPUM=; b=qcxznwE1Mcm8aOE3mA3DM4/GvMOzUDfbzxsgULZy2aBYOJ3iEJa+U3
	DD5MckqZYGx6z1INqeaVDTGHkT7vuYqQifiPYH7ZttSe9PLCSLNQbP/rreHWEx1I
	Gfd4DhwV/G/ypHp+q0IG1s6eobE1+xtcMVliQt1Df6LrOsOvzXkpU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 06CB61CB3D;
	Wed, 24 Apr 2024 17:36:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4BB261CB3C;
	Wed, 24 Apr 2024 17:36:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Roland Hieber <rhi@pengutronix.de>
Cc: git@vger.kernel.org,  Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] completion: add docs on how to add subcommand
 completions
In-Reply-To: <20240424210549.256256-2-rhi@pengutronix.de> (Roland Hieber's
	message of "Wed, 24 Apr 2024 23:05:48 +0200")
References: <20240424210549.256256-1-rhi@pengutronix.de>
	<20240424210549.256256-2-rhi@pengutronix.de>
Date: Wed, 24 Apr 2024 14:36:27 -0700
Message-ID: <xmqqedauxx2c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B5F13B20-0282-11EF-87CD-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Roland Hieber <rhi@pengutronix.de> writes:

> +# To add completion for git subcommands that live in external scripts,
> +# define a function of the form '_git_${subcommand}' while replacing all dashes
> +# with underscores, and the main git completion will make use of it.
> +# For example, to add completeion after 'git do-my-stuff' (which could e.g. live
> +# in /usr/bin/git-do-stuff), name the completion function '_git_do_stuff'.

You have either an extra "-my", or two "-my"s missing, in the above.

> +# See _git_show, _git_bisect etc. below for more examples.
> +#
>  # Compatible with bash 3.2.57.
>  #
>  # You can set the following environment variables to influence the behavior of
