Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D81C2018A
	for <e@80x24.org>; Tue, 28 Jun 2016 21:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411AbcF1Vjp (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 17:39:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58179 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751952AbcF1Vjp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 17:39:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D03829CEC;
	Tue, 28 Jun 2016 17:39:44 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oTphP0PviYXWU4OLJmpI4O6FWQc=; b=Z+zs2x
	hM1JWbuTLdQXMVHzej4Wj47o4AZSTJzkk+YF/nC9ZsvhpgpBj3uclI5M4KDy7JCZ
	pFI3tDoxSlWVWFxgJUUCh2PzQVqdQQO1dUCq9z0lFwTQsOI6clxVPAuMEhyC26W3
	Er6AzkPSKxo5ewTaAciVwdzfJ772w87Xzkf0o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nWrDbFw+n5PRYzLlkJ+kCg6X3he937qn
	M9U4s4PJQd9hySZIg4dd5c9B4xS4OTbs1rBZUJoEifqQkgA3AIp29BVLUa/8wwUH
	Ok5gLnKmDTGefTTP0U4BMsqm5TKa/Uu5Nw3Gy1BMbj5V2RCOWdAiXbLk2jELyNKx
	9bmAuMeYTW8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2486629CEB;
	Tue, 28 Jun 2016 17:39:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 97CB429CEA;
	Tue, 28 Jun 2016 17:39:43 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Christian Couder <christian.couder@gmail.com>
Cc:	git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v8 33/41] write_or_die: use warning() instead of fprintf(stderr, ...)
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
	<20160627182429.31550-34-chriscool@tuxfamily.org>
Date:	Tue, 28 Jun 2016 14:39:41 -0700
In-Reply-To: <20160627182429.31550-34-chriscool@tuxfamily.org> (Christian
	Couder's message of "Mon, 27 Jun 2016 20:24:21 +0200")
Message-ID: <xmqqoa6l6lia.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D39CACC2-3D78-11E6-BB95-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> diff --git a/write_or_die.c b/write_or_die.c
> index 49e80aa..c29f677 100644
> --- a/write_or_die.c
> +++ b/write_or_die.c
> @@ -87,8 +87,7 @@ int write_or_whine_pipe(int fd, const void *buf, size_t count, const char *msg)
>  {
>  	if (write_in_full(fd, buf, count) < 0) {
>  		check_pipe(errno);
> -		fprintf(stderr, "%s: write error (%s)\n",
> -			msg, strerror(errno));
> +		warning("%s: write error (%s)\n", msg, strerror(errno));
>  		return 0;
>  	}
>  
> @@ -98,8 +97,7 @@ int write_or_whine_pipe(int fd, const void *buf, size_t count, const char *msg)
>  int write_or_whine(int fd, const void *buf, size_t count, const char *msg)
>  {
>  	if (write_in_full(fd, buf, count) < 0) {
> -		fprintf(stderr, "%s: write error (%s)\n",
> -			msg, strerror(errno));
> +		warning("%s: write error (%s)\n", msg, strerror(errno));
>  		return 0;
>  	}

I do not think you call write_or_whine() at all.  As another topic
in flight removes the last caller of this function, this hunk is
very much unwelcome.  The only effect of it is to force me resolve
unnecessary merge conflicts.
