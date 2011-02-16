From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] rerere "remaining"
Date: Wed, 16 Feb 2011 13:14:20 -0800
Message-ID: <7vk4gziswj.fsf@alter.siamese.dyndns.org>
References: <7vbp2dnjkt.fsf@alter.siamese.dyndns.org>
 <1297853265-18993-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297853265-18993-2-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 22:14:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppohq-00086C-Bn
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 22:14:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754713Ab1BPVOe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 16:14:34 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39558 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030Ab1BPVOc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 16:14:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C86A341E7;
	Wed, 16 Feb 2011 16:15:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MNdi7bOHhZ4H08IH9E2b+747DXs=; b=t3BGOq
	Ursx0DJUMlNupRlrh55kQXVw8XqGZWHXELFvyCnpv9/DGHm1Ut+pdAJJxZ4OAxuz
	Z2S747l1FAiupDGSzhuW56FuYXCJev+kqqWM8aehW56qQyJ5c9VhrsSb6XTelT2K
	Bp6zSwjUF9LQkGniPbZn034SwLTJ71uqdvOyc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AsCSpXKinfvd2jtqgCaYuvXVxFApaik8
	m33oR1X7fiwRSLlxV+XzsIcVZLj5k5NMJcA/FVUkmtufVzLNx/OI8F31zrNRVG23
	BtMQdtVOE5vhQP0N51lpTyaE2yDGkVsEWZZlfxYFitDAMoDKMwHyzSepnFp+9Kan
	ObQXTzsa38w=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 91DD741E2;
	Wed, 16 Feb 2011 16:15:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B2F0A41E1; Wed, 16 Feb 2011
 16:15:27 -0500 (EST)
In-Reply-To: <1297853265-18993-2-git-send-email-martin.von.zweigbergk@gmail.com> (Martin
 von Zweigbergk's message of "Wed\, 16 Feb 2011 05\:47\:44 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E49D2FE4-3A11-11E0-83E3-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167001>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> Junio, I wasn't sure how to handle the sign-off etc, so feel free to
> modify those as appropriate.

At this point I think the primary value of the change is your adding
"rerere_remaining()" to only where it matters (i.e. the isolation of the
change) and you should get the credit as the primary author.  Mine was
impossible to read because I contaminated merge_rr in a wrong place and
had to work it around in unrelated codepaths all over the place.

This was much cleaner and easier to read.

>  builtin/rerere.c |   17 +++++++++--
>  rerere.c         |   79 +++++++++++++++++++++++++++++++++++++++++++++++-------
>  rerere.h         |    8 +++++
>  3 files changed, 91 insertions(+), 13 deletions(-)
>
> diff --git a/builtin/rerere.c b/builtin/rerere.c
> index 642bf35..7b9fe18 100644
> --- a/builtin/rerere.c
> +++ b/builtin/rerere.c
> @@ -8,7 +8,7 @@
>  #include "xdiff-interface.h"
>  
>  static const char * const rerere_usage[] = {
> -	"git rerere [clear | status | diff | gc]",
> +	"git rerere [clear | status | remaining | diff | gc]",
>  	NULL,
>  };
>  
> @@ -154,9 +154,20 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
>  	} else if (!strcmp(argv[0], "gc"))
>  		garbage_collect(&merge_rr);
>  	else if (!strcmp(argv[0], "status"))
> -		for (i = 0; i < merge_rr.nr; i++)
> +		for (i = 0; i < merge_rr.nr; i++) {
>  			printf("%s\n", merge_rr.items[i].string);
> -	else if (!strcmp(argv[0], "diff"))
> +		}

Unnecessary {} around a single printf().  Will clean-up.

Thanks.
