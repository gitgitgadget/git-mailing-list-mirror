Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E9E220189
	for <e@80x24.org>; Wed, 22 Jun 2016 17:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbcFVRhl (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 13:37:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59303 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751707AbcFVRhk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 13:37:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 70DF825C2A;
	Wed, 22 Jun 2016 13:37:39 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LV+ch7NMiOjZ4ZPBNVlmRuLNTe4=; b=RxOm0K
	8DrR2pqB2mv4YgOBUlBwrkZpWlLYS0CrWhJA8GG/+/ondbu/EDCs9Jjjt8LofwkB
	b7x6/9J/VJF/4hE9fKHSVrZPfXTKWsHsn6UpAzp4eedYP5qAA0t41T1q0WBpYUFb
	oZd3LOZzACMGPc5OWL++NkJahdDeVp+PF1aBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qimf0ABSY05T3tdAJ2Yap91V5LtuqGUW
	+O8TUN7PYQEVsBSJvDhjfw2Ka9Pann4Zh5oHC4s2fI0M6cruf49miEJldJDCcr19
	Fe4aTPgoNcyqm2V6CF39TebrU8vHjn5mpKU9PLHdh9KYNinI+9JihuDyJgTpMGu+
	REuJgpfaOIo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 62BE525C29;
	Wed, 22 Jun 2016 13:37:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E1D9A25C27;
	Wed, 22 Jun 2016 13:37:38 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH 5/5] format-patch: avoid freopen()
References: <cover.1466244194.git.johannes.schindelin@gmx.de>
	<de218a6cc529b3f5c33dc4b8282f16fd8a5329a8.1466244194.git.johannes.schindelin@gmx.de>
	<CAPig+cTiexRhzS3MwMEntGYxKms-XQvtoc7HOnUGJvDaBSK7JA@mail.gmail.com>
	<alpine.DEB.2.20.1606200814510.22630@virtualbox>
	<xmqq4m8nvodo.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1606210906190.22630@virtualbox>
	<xmqqvb12qyeu.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1606220849480.10382@virtualbox>
	<xmqqeg7pns0a.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1606221811300.10382@virtualbox>
Date:	Wed, 22 Jun 2016 10:37:36 -0700
In-Reply-To: <alpine.DEB.2.20.1606221811300.10382@virtualbox> (Johannes
	Schindelin's message of "Wed, 22 Jun 2016 18:14:43 +0200 (CEST)")
Message-ID: <xmqqwplhm8f3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03B32360-38A0-11E6-AFDF-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Well, if I change `rev.diffopt.use_color != GIT_COLOR_ALWAYS` to
> `rev.diffopt.use_color == GIT_COLOR_AUTO`, then the files will contain
> ugly ANSI color sequences if I run `git format-patch -o . -3`.
>
> The reason is, as I tried to explain, that the use_color field is *not*
> initialized to GIT_COLOR_AUTO (which is equivalent to 2), but to -1.

Ah, OK.

It still feels safer to force no-color only when it is auto
(i.e. the user said --color=auto) or -1 (i.e. the default), rather
than when it is anything other than always, though.
