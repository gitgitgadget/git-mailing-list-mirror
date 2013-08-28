From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v2 3/3] status: introduce status.displayCommentChar to disable display of #
Date: Wed, 28 Aug 2013 13:05:38 -0700
Message-ID: <xmqq1u5da8dp.fsf@gitster.dls.corp.google.com>
References: <vpqhaeaasuf.fsf@anie.imag.fr>
	<1377694024-24173-1-git-send-email-Matthieu.Moy@imag.fr>
	<1377694024-24173-3-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, j.sixt@viscovery.net
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Aug 28 22:05:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VElzy-0006cH-Bi
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 22:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755238Ab3H1UFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Aug 2013 16:05:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51810 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755231Ab3H1UFp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 16:05:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 95B4F3D65B;
	Wed, 28 Aug 2013 20:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=etIyRke/EGBLFpoGAwNJVGTb/lk=; b=cM4uvR
	hXdCZfV+ExBP3AZvEoFOkquj6MGs0Z33iKgm+bE2zIdOrSAQBCDIzWtS7v9JAAje
	9B9n/xh0qjvQdoX2ArOEVHf5By+2hf4LZn9YPBAHdnr9B7uJ019mkzstg5afaxkT
	0WnatTj5JoL2oTV/6jES2nFIGozaZWDsuKlVE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Sx2wmdnrRi8zThfFGc6O2gHouQ2ZDmHo
	K+cTO/5E8STvMcOKthY7YP/SjyAF6fDk91BVrHq11Q89BsKO8V8Atai3QXq0Jmqx
	q95Kyx/H5RU9bzBi0vLrRVZVrhpa9umO/PJTwPjS0fI+M3oYcFLtOFs16kWv6/bg
	kGGaTSl0QmA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E6B13D659;
	Wed, 28 Aug 2013 20:05:43 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A8AA43D650;
	Wed, 28 Aug 2013 20:05:41 +0000 (UTC)
In-Reply-To: <1377694024-24173-3-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Wed, 28 Aug 2013 14:47:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 37502686-101D-11E3-BA47-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233205>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index ec57a15..dacf4b9 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2118,6 +2118,11 @@ status.branch::
>  	Set to true to enable --branch by default in linkgit:git-status[1].
>  	The option --no-branch takes precedence over this variable.
>  
> +status.displayCommentChar::
> +	If set to false, linkgit:git-status[1] will not prefix each
> +	line with the comment char (`core.commentchar`, i.e. `#` by
> +	default). Defaults to true.

We prefix core.commentchar followed by a single space for non-empty
lines; is that worth mentioning, I wonder?

Also I envision that we would extend core.commentchar to be more
than a single character.  Is "displayCommentChar" still a good name
for this setting?

"status.omitCommentPrefix" that defaults to false might be a better
setting, I suspect.  I further suspect that in the longer term, we
may want to consider flipping its default to true (for Git 2.0, it
is too late).  I do not think we need these comment prefix in the
human readable "status" output---after all, there is no line that is
not commented (other than "nothing added to commit" at the end) in
the current output, so the comment prefix only wastes the screen
real estate.

What are our plans to help existing scripts people have written over
time, especially before "status -s" was invented, that will be
broken by use of this?

> @@ -663,17 +666,18 @@ static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitt
>  	char summary_limit[64];
>  	char index[PATH_MAX];
>  	const char *env[] = { NULL, NULL };
> -	const char *argv[8];
> +	const char *argv[9];
>  
>  	env[0] =	index;
>  	argv[0] =	"submodule";
>  	argv[1] =	"summary";
>  	argv[2] =	uncommitted ? "--files" : "--cached";
>  	argv[3] =	"--for-status";
> -	argv[4] =	"--summary-limit";
> -	argv[5] =	summary_limit;
> -	argv[6] =	uncommitted ? NULL : (s->amend ? "HEAD^" : "HEAD");
> -	argv[7] =	NULL;
> +	argv[4] =	s->display_comment_char ? "--display-comment-char" : "--no-display-comment-char";
> +	argv[5] =	"--summary-limit";
> +	argv[6] =	summary_limit;
> +	argv[7] =	uncommitted ? NULL : (s->amend ? "HEAD^" : "HEAD");
> +	argv[8] =	NULL;

Not strictly your fault, but we should lose these funny indent after
"=" and use argv_array API here.
