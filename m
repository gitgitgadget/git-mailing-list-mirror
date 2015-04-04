From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/5] log: honor log.merges= option
Date: Sat, 04 Apr 2015 13:00:33 -0700
Message-ID: <xmqqy4m7ek9q.fsf@gitster.dls.corp.google.com>
References: <1428110521-31028-1-git-send-email-koosha@posteo.de>
	<1428110521-31028-2-git-send-email-koosha@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Koosha Khajehmoogahi <koosha@posteo.de>
X-From: git-owner@vger.kernel.org Sat Apr 04 22:00:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeUFO-0006sg-Bs
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 22:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752632AbbDDUAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2015 16:00:37 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62987 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752351AbbDDUAf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2015 16:00:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 216E645C03;
	Sat,  4 Apr 2015 16:00:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7FIolgh19s62F874V87Ms94rQ14=; b=rrRVkR
	2tIWuU+i1uqs+5/axBXf6D67hfxelNHBK00eQL8H4Nj9ttDmw3VsKzfYB6wikPIH
	B5kwL/lJaAdb8aifX3o+0Zx4toWSRLzeZQSPE+Be/ys3++1V+J7Yf1ByI2Ts+Yuj
	alJKZexCRVAosdT1lkOYlbo+DRH7y6trFkXfc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eP9fri2+UezdSGE7rU1YcmVKARmPlval
	u4qZD4mBTRMQmDqjLhG2LsapEVeLHBkupRtSooVNGvWY30eoEF4afsfu7nGKpwZC
	Efig9f0Z4fKpcTaaQPpJCUuHsbqR9XjPDjafXVTCfRhBmuAFMjroivG1+Sx3eCZ2
	fDeq+abj7zY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 18CAD45C02;
	Sat,  4 Apr 2015 16:00:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6EB4545BFF;
	Sat,  4 Apr 2015 16:00:34 -0400 (EDT)
In-Reply-To: <1428110521-31028-2-git-send-email-koosha@posteo.de> (Koosha
	Khajehmoogahi's message of "Sat, 4 Apr 2015 03:21:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 414AA5BC-DB05-11E4-9867-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266783>

Koosha Khajehmoogahi <koosha@posteo.de> writes:

> From: Junio C Hamano <gitster@pobox.com>
>
> [kk: wrote commit message]

Ehh, what exactly did you write ;-)?

I think the most important thing that needs to be explained by the
log message for this change is that the variable is honored only by
log and it needs to explain why other Porcelain commands in the same
"log" family, like "whatchanged", should ignore the variable.

I think that we must not to allow format-patch and show to be
affected by this variable, because it is silly if log.merges=only
broke format-patch output or made "git show" silent.  But I didn't
think about others.  Whoever is doing this change needs to explain
in the log message the reason why it was decided that only "git log"
should pay attention to it.

> Helped-by: Eris Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Koosha Khajehmoogahi <koosha@posteo.de>
> ---


>  builtin/log.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index dd8f3fc..c7a7aad 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -36,6 +36,7 @@ static int decoration_given;
>  static int use_mailmap_config;
>  static const char *fmt_patch_subject_prefix = "PATCH";
>  static const char *fmt_pretty;
> +static const char *log_merges;

The variable name may want to be updated to mimic other variables
used in a similar way, e.g. default_show_root is used to store the
value from log.showroot.

Perhaps "default_show_merge" or something?

Thanks.

>  static const char * const builtin_log_usage[] = {
>  	N_("git log [<options>] [<revision range>] [[--] <path>...]"),
> @@ -386,6 +387,9 @@ static int git_log_config(const char *var, const char *value, void *cb)
>  			decoration_style = 0; /* maybe warn? */
>  		return 0;
>  	}
> +	if (!strcmp(var, "log.merges")) {
> +		return git_config_string(&log_merges, var, value);
> +	}
>  	if (!strcmp(var, "log.showroot")) {
>  		default_show_root = git_config_bool(var, value);
>  		return 0;
> @@ -628,6 +632,8 @@ int cmd_log(int argc, const char **argv, const char *prefix)
>  
>  	init_revisions(&rev, prefix);
>  	rev.always_show_header = 1;
> +	if (log_merges && parse_merges_opt(&rev, log_merges))
> +		die("unknown config value for log.merges: %s", log_merges);
>  	memset(&opt, 0, sizeof(opt));
>  	opt.def = "HEAD";
>  	opt.revarg_opt = REVARG_COMMITTISH;
