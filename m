From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/18] Disallow demoting grave fsck errors to warnings
Date: Wed, 10 Dec 2014 10:06:51 -0800
Message-ID: <xmqqd27ridl0.fsf@gitster.dls.corp.google.com>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
	<fcf343ed359ca47d6154f0d1e1850738eb7768ac.1418055173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 10 19:07:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XylfB-00081I-KE
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 19:07:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522AbaLJSGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 13:06:55 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50031 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932490AbaLJSGy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 13:06:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E716A22872;
	Wed, 10 Dec 2014 13:06:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IMb0mSBcwjFOqDd61VufgmgpEP0=; b=U7mdSO
	LOF4UTBBP4Zr6zsS/C4vAarNAtMfyfcv6RWMsB7SBoQLdN4C//d+C2N4A4ahQT37
	HXrDi/VfqSjUJjg+DBGn2mz6q7eEKhlUhTbBC/jstoF1NTLfxPmMJrqIopTAfybR
	Qlr6YrJ+uLQw1g6S4aDApZqrRmMNY1CBbouRg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qgSixZz3oaUioeUSt/gT4wc0q2+VrDEJ
	vTEf5kbq1ZTPkPxulqUuZfMAxjthM2YpLm7kx+jUlQyQGnknH0DkuFLC53sugE0E
	Ebi21YXHL/ARM4dTHKPneMl+UJ/ejlWFAbXwStLBWolBA5rCpcDpp8OGaLL204id
	7sFBmShVo7E=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DBBCC22871;
	Wed, 10 Dec 2014 13:06:52 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4A9852286F;
	Wed, 10 Dec 2014 13:06:52 -0500 (EST)
In-Reply-To: <fcf343ed359ca47d6154f0d1e1850738eb7768ac.1418055173.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Mon, 8 Dec 2014 17:15:16 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5178803A-8097-11E4-A936-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261230>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Some kinds of errors are intrinsically unrecoverable (e.g. errors while
> uncompressing objects). It does not make sense to allow demoting them to
> mere warnings.

Makes sense, but the patch makes it look as if this is an "oops, we
should have done the list in patch 02/18 in this order from the
beginning".  Can we reorder the patches?

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  fsck.c                          | 8 ++++++--
>  t/t5504-fetch-receive-strict.sh | 9 +++++++++
>  2 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/fsck.c b/fsck.c
> index c1e7a85..f8339af 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -9,6 +9,9 @@
>  #include "refs.h"
>  
>  #define FOREACH_MSG_ID(FUNC) \
> +	/* fatal errors */ \
> +	FUNC(NUL_IN_HEADER) \
> +	FUNC(UNTERMINATED_HEADER) \
>  	/* errors */ \
>  	FUNC(BAD_DATE) \
>  	FUNC(BAD_EMAIL) \
> @@ -39,10 +42,8 @@
>  	FUNC(MISSING_TYPE_ENTRY) \
>  	FUNC(MULTIPLE_AUTHORS) \
>  	FUNC(NOT_SORTED) \
> -	FUNC(NUL_IN_HEADER) \
>  	FUNC(TAG_OBJECT_NOT_TAG) \
>  	FUNC(UNKNOWN_TYPE) \
> -	FUNC(UNTERMINATED_HEADER) \
>  	FUNC(ZERO_PADDED_DATE) \
>  	/* warnings */ \
>  	FUNC(BAD_FILEMODE) \
> @@ -56,6 +57,7 @@
>  	FUNC(NULL_SHA1) \
>  	FUNC(ZERO_PADDED_FILEMODE)
>  
> +#define FIRST_NON_FATAL_ERROR FSCK_MSG_BAD_DATE
>  #define FIRST_WARNING FSCK_MSG_BAD_FILEMODE
>  
>  #define MSG_ID(x) FSCK_MSG_##x,
> @@ -150,6 +152,8 @@ void fsck_strict_mode(struct fsck_options *options, const char *mode)
>  		}
>  
>  		msg_id = parse_msg_id(mode, equal);
> +		if (type != FSCK_ERROR && msg_id < FIRST_NON_FATAL_ERROR)
> +			die("Cannot demote %.*s", len, mode);
>  		options->strict_mode[msg_id] = type;
>  		mode += len;
>  	}
> diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
> index db79e56..8a47db2 100755
> --- a/t/t5504-fetch-receive-strict.sh
> +++ b/t/t5504-fetch-receive-strict.sh
> @@ -135,4 +135,13 @@ test_expect_success 'push with receive.fsck.missing-mail = warn' '
>  	grep "missing-email" act
>  '
>  
> +test_expect_success 'receive.fsck.unterminated-header = warn triggers error' '
> +	rm -rf dst &&
> +	git init dst &&
> +	git --git-dir=dst/.git config receive.fsckobjects true &&
> +	git --git-dir=dst/.git config receive.fsck.unterminated-header warn &&
> +	test_must_fail git push --porcelain dst HEAD >act 2>&1 &&
> +	grep "Cannot demote unterminated-header=warn" act
> +'
> +
>  test_done
