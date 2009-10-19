From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add the --submodule option to the diff option family
Date: Sun, 18 Oct 2009 20:02:55 -0700
Message-ID: <7v3a5gdr1c.fsf@alter.siamese.dyndns.org>
References: <4ADA10FC.40708@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Oct 19 05:03:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MziWg-0006Ib-H7
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 05:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755813AbZJSDDE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 23:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755810AbZJSDDD
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 23:03:03 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64424 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755802AbZJSDDC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 23:03:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DC2B55E8C3;
	Sun, 18 Oct 2009 23:03:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k7LJraDVMUYWmFboSq+s/RrQHR4=; b=uht8hn
	dBQK61ZTLNFy6CnQ8WzAlH1taINebHwPhD/fa0uE3CCdX5xw47BThSFs/tWYPGpL
	K555GCJ6uQCboB82inThPs3V5KfxYfuMrITN9gkotF8nOMfhAnRKK9lBXinXN1IB
	IROaN9dtOiwfyNmgAQhNiGKy8L2y3VDZzkUH0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SygBJV0YMHkbOubcTdcCBurltO31adEp
	YYLBCxEbnfA0YyY59NiBL9pZ/0Rp26xaJ3WTRrA2F/ws0xxmKu/cm1zjc6N5SGXh
	QxVnITgdj8quoM0PmsQhhjLsPol8aHx+gR1m9FOnBPGl8Puy1lhpslZe0CeJ1CxX
	hq6nu/Ua2Ns=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B26875E8C2;
	Sun, 18 Oct 2009 23:03:00 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E94F45E8C1; Sun, 18 Oct
 2009 23:02:56 -0400 (EDT)
In-Reply-To: <4ADA10FC.40708@web.de> (Jens Lehmann's message of "Sat\, 17 Oct
 2009 20\:46\:20 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E921A7DC-BC5B-11DE-B995-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130641>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> When you use the option --submodule=left-right-log you can see the submodule
> summaries inlined in the diff, instead of not-quite-helpful SHA-1 pairs.
>
> The format imitates what "git submodule summary" shows.
>
> To do that, <path>/.git/objects/ is added to the alternate object
> databases (if that directory exists).
>
> This option was requested by Jens Lehmann at the GitTogether in Berlin.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---

Thanks.

I have four patches queued on js/diff-verbose-submodule topic and I think
this corresponds to the first three, correct?

> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 9276fae..99cb517 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -87,6 +87,13 @@ endif::git-format-patch[]
>  	Show only names and status of changed files. See the description
>  	of the `--diff-filter` option on what the status letters mean.
>
> +--submodule[=<format>]::
> +	Chose the output format for submodule differences. <format> can be one of
> +	'short' and 'left-right-log'. 'short' is the default value for this
> +	option and and shows pairs of commit names. 'left-right-log' lists the
> +	commits in that commit range like the 'summary' option of
> +	linkgit:git-submodule[1] does.
> +

Well, while left-right-log may be logically the most correct name for this
option, I think it is too long to be practical.  Because it is not like we
would want to have an option to have full log there when we are showing
"diff", I think it would make sense to making left-right-log the default
when "--submodule" (without format specification) is given, and possibly
give "--submodule=log" as the synonym for this format.

After all, if you do not give --submodule, we will give the traditional
short format, no?

> diff --git a/diff.c b/diff.c
> index c719ce2..8af1ae2 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2771,6 +2783,10 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
>  		DIFF_OPT_CLR(options, ALLOW_TEXTCONV);
>  	else if (!strcmp(arg, "--ignore-submodules"))
>  		DIFF_OPT_SET(options, IGNORE_SUBMODULES);
> +	else if (!prefixcmp(arg, "--submodule=")) {
> +		if (!strcmp(arg + 12, "left-right-log"))
> +			DIFF_OPT_SET(options, SUBMODULE_LEFT_RIGHT_LOG);
> +	}

I do not see --submodule (without "=<format>") supported here as the
documentation claims, but this is the logical place to do so.

> diff --git a/submodule.c b/submodule.c
> new file mode 100644
> index 0000000..206386f
> --- /dev/null
> +++ b/submodule.c
> @@ -0,0 +1,112 @@
> +...
> +void show_submodule_summary(FILE *f, const char *path,
> +		unsigned char one[20], unsigned char two[20],
> +		const char *del, const char *add, const char *reset)
> +{
> ...
> +	fwrite(sb.buf, sb.len, 1, f);
> +
> +	if (!message) {
> +		while ((commit = get_revision(&rev))) {
> + ...
> +		}
> +		clear_commit_marks(left, ~0);
> +		clear_commit_marks(right, ~0);
> +	}
> +}

I thought we had strbuf_release(&sb) here...  Where did it go?
