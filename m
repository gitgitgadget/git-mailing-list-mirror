Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ABE7ED
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 01:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qTR/loVs"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7811910C0
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 17:34:29 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A4C3C1C5E0B;
	Tue,  7 Nov 2023 20:34:28 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=YveOoOc2hShX
	ZoTbN1OJ7ND8+CxzI4M0pFzpAGYyy2I=; b=qTR/loVsqiDciexWev48O34B6BYq
	3rizG7ujq40/BJ7Mkl62fo+yabNyG86uQJRTRaGz4e3XK8UEiUY0drNwvt+04B8A
	+YQiRsI2ZZ6mPv72Ku5tWEYCVlvAS2IF902AxQNUPF2z7mB3Xg6wkBPj2uBiWUjm
	SetU5dufblUM15k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C2101C5E0A;
	Tue,  7 Nov 2023 20:34:28 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C85601C5E09;
	Tue,  7 Nov 2023 20:34:27 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Michael Strawbridge <michael.strawbridge@amd.com>,  Douglas Anderson
 <dianders@chromium.org>,  git@vger.kernel.org,  entwicklung@pengutronix.de
Subject: Re: Regression: git send-email Message-Id: numbering doesn't start
 at 1 any more
In-Reply-To: <20231107070632.spe3cappk5b5jg3q@pengutronix.de> ("Uwe
	=?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Tue, 7 Nov 2023 08:06:32
 +0100")
References: <20231106153214.s5abourejkuiwk64@pengutronix.de>
	<xmqqwmuucwi9.fsf@gitster.g>
	<20231107070632.spe3cappk5b5jg3q@pengutronix.de>
Date: Wed, 08 Nov 2023 10:34:26 +0900
Message-ID: <xmqqpm0l81ul.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 F4CA106E-7DD6-11EE-B3C0-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:

> The output of git send-email dumps the messages it sends out and then I
> pick the message-id of the last mail by cut-n-paste and call my script
> with that as a parameter.

Yikes.  I was hoping that the whole "dumps the messages" output is
read by the script, so that it does not have to assume anything
about the Message-ID format (like "it has some unchanging parts,
the changing parts begin with 1, and it increments by 1 for each
message").

You could give Message-ID externally to the output of format-patch
before feeding send-email, which would just use them, and that way
you would have more control over the entire process, I guess.
