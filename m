Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3383A1F859
	for <e@80x24.org>; Tue, 16 Aug 2016 22:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753185AbcHPWPH (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 18:15:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53679 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753129AbcHPWO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 18:14:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0A12137332;
	Tue, 16 Aug 2016 18:09:43 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TauvxDmKQORD9R3fHR6Te5BsK1o=; b=VRaa6v
	8NTfTj8xOriaef72pQhZcyCZOknHTFXrdQMsxYiKhR3r0wTHvLbvJZfVbkkpxULi
	GpXexGbCn1ZEu6F8c4cj9Gudk1ehu+cm1Aqr8kZilRgQzLrGHk0qaeKVmcHwdlFa
	7YySNuIDEe6uNS5PGaCbbiwMEBu6JS29lAj7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rPE3AUh5jhF3vfHlt77b97/8GfNkooHH
	I0m+IEIkpzrhRokCC/hx4nd0oKv5ybezPlIJssP0IAoor5VppFdIbFInFxIyv7fX
	MAZCvdhmBpNkGYYwvzMaVl/70XGfPSv40dkt7l4tvePRa1GO/pyx5v4zmY9N7QQH
	jia0B9XKD5I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0066437331;
	Tue, 16 Aug 2016 18:09:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 74F433732F;
	Tue, 16 Aug 2016 18:09:42 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Linus Torvalds <torvalds@linux-foundation.org>
Cc:	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Prefer "long" key format output when verifying pgp signatures
References: <alpine.LFD.2.20.1608161309350.14878@i7>
Date:	Tue, 16 Aug 2016 15:09:40 -0700
In-Reply-To: <alpine.LFD.2.20.1608161309350.14878@i7> (Linus Torvalds's
	message of "Tue, 16 Aug 2016 13:35:46 -0700 (PDT)")
Message-ID: <xmqqinv0bc2j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2203AC52-63FE-11E6-AB45-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Tue, 16 Aug 2016 13:10:24 -0700
> Subject: [PATCH] Prefer "long" key format output when verifying pgp signatures
>
> Yes, gpg2 already uses the long format by default, but most
> distributions seem to still have "gpg" be the older 1.x version due to
> compatibility reasons.  And older versions of gpg only show the 32-bit
> short ID, which is quite insecure.
> ...
> But the 32-bit key ID's really are broken. Also note that because of the 
> differences between gpg-1.x and gpg-2.x, hopefully any scripted key ID 
> parsing code (if such code exists) is already flexible enough to not care.
>
> This was triggered by the fact that the "evil32" project keys ended up
> leaking to the public key servers, so now there are 32-bit aliases for
> just about every open source developer that you can easily get by
> mistake if you use the 32-bit short ID format.
>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>
> That's a very long commit message for a very trivial patch.
>
> I'm not particularly happy with the 64-bit long format either, but it's 
> better than what we have now, and appears to be as good as it gets.

Thanks.  Will queue.

>
>  gpg-interface.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/gpg-interface.c b/gpg-interface.c
> index 08356f92e7b3..8672edaf4823 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -217,6 +217,7 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
>  	argv_array_pushl(&gpg.args,
>  			 gpg_program,
>  			 "--status-fd=1",
> +			 "--keyid-format=long",
>  			 "--verify", temp.filename.buf, "-",
>  			 NULL);
