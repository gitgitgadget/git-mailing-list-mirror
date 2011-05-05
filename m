From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/checkout.c: show usage with options on missing
 argument 'branch'
Date: Thu, 05 May 2011 11:45:55 -0700
Message-ID: <7vsjst6l5o.fsf@alter.siamese.dyndns.org>
References: <1304614690-12493-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Thu May 05 20:46:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI3Yx-0003Pz-Nt
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 20:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116Ab1EESqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 14:46:05 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51325 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932072Ab1EESqD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 14:46:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 248B44367;
	Thu,  5 May 2011 14:48:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SuJWV+v9COEEnL0lv9h20J6eSZY=; b=mO27wp
	G6U0zj3j09Cxa5Wl/fsf65mZU38ZCkoB6n3R0Pp58SmtRyVIMaI4lTCnTQyHitfA
	pSEOanGNR2oyG2LKDBmTPhdeIg/9ERTsiXG9ZosSQhhVr162vB7Fc+nW44ou/4vr
	QrL3hzvkwlihFaop0owsVnA2EPi8Ejx4P0NLE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jczmoBEL/sFUvom22zcTkcjQrTir4WNn
	/+UygLz4b2SByj/04U9aTJlPx2HI6lC7Nr+qm80lm72YfL0HBViDWHO/lf8Z+ZTo
	R/fZj2mcfCtC4qR4pBBnyes1aBt/y9bZzhwgtlr2YwlBuHWePwaed07a2eSjs/Zn
	OwL5f26Zbv4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0298A4366;
	Thu,  5 May 2011 14:48:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DE8624365; Thu,  5 May 2011
 14:48:01 -0400 (EDT)
In-Reply-To: <1304614690-12493-1-git-send-email-ralf.thielow@googlemail.com>
 (Ralf Thielow's message of "Thu, 5 May 2011 18:58:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 360CC286-7748-11E0-9B6A-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172867>

Ralf Thielow <ralf.thielow@googlemail.com> writes:

> Show the usage with options for 'checkout' command on missing argument 'branch'.

Please describe what exact command line you typed, what output and side
effect you got from the command, what you _think_ should have happened
instead, and what the differences between two are.

In other words, what problem you are trying to solve?

> Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>
> ---
>  builtin/checkout.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 38632fc..4aa613a 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1086,5 +1086,10 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>  	if (opts.writeout_stage)
>  		die(_("--ours/--theirs is incompatible with switching branches."));
>  
> +	if (new.name == NULL) {
> +		usage_with_options(checkout_usage, options);
> +		return;
> +	}
>
>  	return switch_branches(&opts, &new);
>  }

What value are you returning from a function whose return type is int?

If you read the function switch_branches(), you would notice that it is
prepared to handle the case where new.name is NULL (by the way, check
against NULL is typically spelled as "if (!new.name)" as you can see
there), and then would realize that your change by itself cannot be a
correct fix for whatever problem you are trying to solve.

Have you run "make test" at all?

If you are changing this command:

	$ git checkout -b frotz
	Switched to a new branch 'junk'

to error out with a message, then that is a regression.
