Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9360DD51C
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 18:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dQoOy2gg"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 81B0E1D2F5D;
	Wed, 10 Jan 2024 13:46:55 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=UpPiyLHmSgymiU1QaEl02I6LYJOHlZio3r4xtP
	SvtFk=; b=dQoOy2gg+4/PNIH0n9dZEVpKz2pVXBUQCv3DSTDV8Gx5mljT8brr+1
	HbQ4u2OCawWg2lpKXGBmMofqA8OLvISrovG8sY9+gCJ1S6ylFTajfT0W+rVXakzH
	KiD4pVuF8WG2cSv/YdpnqqWUPnAWRS+MUL9Bur65RQfHFPcgvzCVI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7992A1D2F5B;
	Wed, 10 Jan 2024 13:46:55 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DBA8A1D2F5A;
	Wed, 10 Jan 2024 13:46:54 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'Mohit Marathe'" <mohitmarathe@proton.me>,  "'Christian Couder'"
 <christian.couder@gmail.com>,  <git@vger.kernel.org>,
  <britton.kerin@gmail.com>,  <peff@peff.net>
Subject: Re: [GSoC][RFC] Replace use of atoi() with strtol_i(), as a
 microproject
In-Reply-To: <004601da43ee$2b6cd0c0$82467240$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Wed, 10 Jan 2024 12:55:11
	-0500")
References: <OqD4xQ_p-jcftCbAw0ovvrBztfiuoMGcTonCc0i6x7Ziy-hx3uA-Hoz4-3tfRI39KMj-V5OZIGgOe66b1eyX3YrKZNThMYjjMkn6g4-Ww8c=@proton.me>
	<CAP8UFD1d7FSa=mUzzUA5e3eSEcCVfaymxWewo5GjdDBi4GyE-g@mail.gmail.com>
	<F6ejgAfr2IMRNR3Tq0CDTHeT9xMWzJ9ley8M_fnSX97ayRNRp_CEgA62WdtOooi9bha1WJPGB53ptJYQFII2lCbIflwgNvbIaefw7nK8w7M=@proton.me>
	<004601da43ee$2b6cd0c0$82467240$@nexbridge.com>
Date: Wed, 10 Jan 2024 10:46:53 -0800
Message-ID: <xmqq5y01auw2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A0259EF4-AFE8-11EE-ABFB-25B3960A682E-77302942!pb-smtp2.pobox.com

<rsbecker@nexbridge.com> writes:

> I am not sure this is a good idea. The error detection inside strtol_i() reports a -1 if the supplied text value is invalid. This does not differentiate between an invalid value and a valid "-1" supplied. Replacing all instances of atoi() with strtol_i() will likely cause breakages as the error semantics are different between the two.

atoi() and strtol_i() have totally different function signatures, so
it won't be a straight replacement.  The report of "-1" you mention
is only about strtol_i() reporting "have we successfully read out a
number [yes/no]?".  The value we parsed goes to a separate location,
so there is no risk of confusion as long as the caller knows what it
is doing.

Thanks.

