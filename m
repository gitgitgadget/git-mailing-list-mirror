From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 01/40] apply: move 'struct apply_state' to apply.h
Date: Mon, 13 Jun 2016 15:49:24 -0700
Message-ID: <xmqq7fdsbt6z.fsf@gitster.mtv.corp.google.com>
References: <20160613160942.1806-1-chriscool@tuxfamily.org>
	<20160613160942.1806-2-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 00:49:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCafk-0001pw-4s
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 00:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423156AbcFMWt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 18:49:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64899 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422699AbcFMWt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 18:49:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 840A924DC3;
	Mon, 13 Jun 2016 18:49:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9VPRyBVV/Yd20a+UoKT644/Tn7s=; b=x2UJ3U
	ZFfkoglj55B9n1WWHmQJFifYct5FfsiGPcCVwQhprhNvGfgYdlqS65SL//KO8WdQ
	oL6ZpNh/Qeby+U2TA1JfMUf82/2CbyYC1SPdspwe8uDL3lSRkVDASk1Ua+uUAwrx
	mAwLAfDex+mZXj3ECgXFtr81yN71lcuWW2ztA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FIp4kGPJVBO0fphLHCRASmLKdRIxUu/k
	wdKg1Gva9bCjBKsFUbAv0WoNP07nHO4wNygktMfmzaZ5mKu9CrhVjAz3p4QPUNSW
	8L7jpRWB1ONcksA8gbLMtC6Q0vHIo3Crz7YIn5Riw2ILtl5ZoWonkRL6kMWj8N4l
	/Hy/YoNoC00=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7AD9424DC1;
	Mon, 13 Jun 2016 18:49:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E874D24DBF;
	Mon, 13 Jun 2016 18:49:25 -0400 (EDT)
In-Reply-To: <20160613160942.1806-2-chriscool@tuxfamily.org> (Christian
	Couder's message of "Mon, 13 Jun 2016 18:09:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1446CC7E-31B9-11E6-B90A-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297257>

Christian Couder <christian.couder@gmail.com> writes:

> To libify `git apply` functionality we must make 'struct apply_state'
> usable outside "builtin/apply.c".
>
> Let's do that by creating a new "apply.h" and moving
> 'struct apply_state' there.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  apply.h         | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  builtin/apply.c |  98 +-----------------------------------------------------
>  2 files changed, 101 insertions(+), 97 deletions(-)
>  create mode 100644 apply.h
>
> diff --git a/apply.h b/apply.h
> new file mode 100644
> index 0000000..9a98eae
> --- /dev/null
> +++ b/apply.h
> @@ -0,0 +1,100 @@
> +#ifndef APPLY_H
> +#define APPLY_H
> +
> +enum ws_error_action {
> +	nowarn_ws_error,
> +	warn_on_ws_error,
> +	die_on_ws_error,
> +	correct_ws_error
> +};
> +
> +enum ws_ignore {
> +	ignore_ws_none,
> +	ignore_ws_change
> +};
> +
> +/*
> + * We need to keep track of how symlinks in the preimage are
> + * manipulated by the patches.  A patch to add a/b/c where a/b
> + * is a symlink should not be allowed to affect the directory
> + * the symlink points at, but if the same patch removes a/b,
> + * it is perfectly fine, as the patch removes a/b to make room
> + * to create a directory a/b so that a/b/c can be created.
> + *
> + * See also "struct string_list symlink_changes" in "struct
> + * apply_state".
> + */
> +#define SYMLINK_GOES_AWAY 01
> +#define SYMLINK_IN_RESULT 02

Everything below is agreeable, but all the names that are made
public above by this change do not sound specific enough to "apply".
I wonder if they should get "apply" somewhere in their names to
avoid confusion coming from the namespace contamination...
