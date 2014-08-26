From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 03/23] refs.c: add a new refs.c file to hold all common refs code
Date: Tue, 26 Aug 2014 14:31:24 -0700
Message-ID: <xmqqd2bngcpf.fsf@gitster.dls.corp.google.com>
References: <1408465847-30384-1-git-send-email-sahlberg@google.com>
	<1408465847-30384-4-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 23:31:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMOL5-0002Fk-EN
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 23:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755441AbaHZVbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 17:31:35 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54074 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755184AbaHZVbe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 17:31:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 571573426F;
	Tue, 26 Aug 2014 17:31:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IY1i5iq8luBU+bvQUGAWW2CSkog=; b=U7vaAv
	nVohVY4s2gue9j0cD0fRR2LrEhmbb9tlfvr1bU1M5+oev7uuyVk0jVVQqmq61dC4
	W2Vh1WcJHnAmYZWUlAqf719RbMqDdF/F+zBCROhlOIdgCEer7YFmgx4TYWa1NI/T
	es6URHExPO5qz9kAXY8CPY03fZDZprZHeun2k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gRuSnnsUfCD1afp5EM6fHbb/PKKTKhpv
	j+9RlAJ1wtBvQrE2pie31PkL+q3E5iApfhJ7QFPca8HV8zTdp//BtirpHr/Hoe+j
	PJ8WH4bom7C5xmTNHJvQR942nBgKtwGYQe+6Iu5osN6jETEpydxdoDqlyYaiDoHE
	obSiM1RjmFE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4A8CC3426D;
	Tue, 26 Aug 2014 17:31:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5F2E53426B;
	Tue, 26 Aug 2014 17:31:26 -0400 (EDT)
In-Reply-To: <1408465847-30384-4-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Tue, 19 Aug 2014 09:30:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 559AA940-2D68-11E4-A227-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255946>

Ronnie Sahlberg <sahlberg@google.com> writes:

> Create a new erfs.c file that will be used to hold all the refs
> code that is backend agnostic and will be shared across all backends.
>
> The reason we renamed everything to refs-be-files.c in the previous patch
> and now start moving the common code back to the new refs.c file
> instead of the other way around is the etive volumes of code.

Huh?  Why not create refs-be-files.c and move whatever need to be
there over there, instead of rename the file and move things that
shouldn't have been moved back like this?

Puzzled.

I do not see 02/23 here, but I am assuming that is is just

    git mv refs.c refs-be-files.c

which may have been a seven-line patch with "format-patch -M" ;-)

>
> With the ref_cache, packed refs and loose ref handling that are all
> part of the files based implementation the backend specific part
> of the old refs.c file is several times larger than the backend agnostic
> part. Therefore it makes more sense to first rename everything to be
> part of the files based backend and then move the parts that can be used
> as common code back to refs.c.
>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  Makefile | 1 +
>  refs.c   | 3 +++
>  2 files changed, 4 insertions(+)
>  create mode 100644 refs.c
>
> diff --git a/Makefile b/Makefile
> index e010ad1..937d22a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -857,6 +857,7 @@ LIB_OBJS += quote.o
>  LIB_OBJS += reachable.o
>  LIB_OBJS += read-cache.o
>  LIB_OBJS += reflog-walk.o
> +LIB_OBJS += refs.o
>  LIB_OBJS += refs-be-files.o
>  LIB_OBJS += remote.o
>  LIB_OBJS += replace_object.o
> diff --git a/refs.c b/refs.c
> new file mode 100644
> index 0000000..77492ff
> --- /dev/null
> +++ b/refs.c
> @@ -0,0 +1,3 @@
> +/*
> + * Common refs code for all backends.
> + */
