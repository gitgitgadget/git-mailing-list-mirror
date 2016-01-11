From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] builtin/grep: rename use_index to no_index
Date: Mon, 11 Jan 2016 09:33:25 -0800
Message-ID: <xmqqd1t8xbq2.fsf@gitster.mtv.corp.google.com>
References: <1452435597-12099-1-git-send-email-t.gummerer@gmail.com>
	<1452435597-12099-3-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eQ==?= =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?= Duy 
	<pclouds@gmail.com>, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 18:33:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIgLW-0004cC-TU
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 18:33:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933882AbcAKRdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 12:33:31 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53265 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933793AbcAKRd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 12:33:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2955739006;
	Mon, 11 Jan 2016 12:33:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hfxVOIbDaUsoyEDZWoGfC7uYVUU=; b=Le1m/W
	yDBmJPHU+/XbKVDeicer09QOwUyJwTV7vWg/MbOyUfGKOzToTtsZbq3cxC9H3PMY
	5JFVZQ1W+VZqe3fgro7ybvMVhWzekOIeYTD/SEfIQkeHp0/enCQ2tPkQfeYVyXOl
	YeEkSUC7rbqz3xjio5dmt8Ew4b94soTKSrO0c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NYVgXalTVjmbwlpN+JZU0/FwVweB8oSy
	0mByyY4AKyXvxFJXtNaAi4/2+cD7Kg/SiVcLTpg2W+J7jb+wLHzNTPnl8smXhbrP
	tDjdw0MQp2HSKQ2o6yVZq7x1KOxbCeErLa+jSJrKc/eC/3Fpr/8C7gugzGGA8xlm
	X6FW8LqZtPs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2030239005;
	Mon, 11 Jan 2016 12:33:27 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9558339004;
	Mon, 11 Jan 2016 12:33:26 -0500 (EST)
In-Reply-To: <1452435597-12099-3-git-send-email-t.gummerer@gmail.com> (Thomas
	Gummerer's message of "Sun, 10 Jan 2016 15:19:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6BFB01B4-B889-11E5-9476-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283681>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Switch the OPT_NEGBIT argument to a OPT_BIT argument, and rename the
> corresponding use_index variable to a no_index variable.  This will make
> the following step easier to follow.  No functional changes intended.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  builtin/grep.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

This makes the resulting code full of double negations, I am
afraid.  Please do not do this.

I am open to turning "use_index" to a tristate, initialized to -1
(unknown), set to 0 with OPT_SET_INT("no-index"), and optionally set
to 1 with OPT_SET_INT("use-index").  Then after parsing the command
line argument, if use_index is still -1 (i.e. no command line option),
set it to 1 when we can use the index, or 0 (the new feature you
want to add with 3/3).

> diff --git a/builtin/grep.c b/builtin/grep.c
> index 4229cae..3a27bd5 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -625,14 +625,14 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  	struct string_list path_list = STRING_LIST_INIT_NODUP;
>  	int i;
>  	int dummy;
> -	int use_index = 1;
> +	int no_index = 0;
>  	int pattern_type_arg = GREP_PATTERN_TYPE_UNSPECIFIED;
>  
>  	struct option options[] = {
>  		OPT_BOOL(0, "cached", &cached,
>  			N_("search in index instead of in the work tree")),
> -		OPT_NEGBIT(0, "no-index", &use_index,
> -			 N_("find in contents not managed by git"), 1),
> +		OPT_BIT(0, "no-index", &no_index,
> +			N_("find in contents not managed by git"), 1),
>  		OPT_BOOL(0, "untracked", &untracked,
>  			N_("search in both tracked and untracked files")),
>  		OPT_SET_INT(0, "exclude-standard", &opt_exclude,
> @@ -755,7 +755,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  			     PARSE_OPT_STOP_AT_NON_OPTION);
>  	grep_commit_pattern_type(pattern_type_arg, &opt);
>  
> -	if (use_index && !startup_info->have_repository)
> +	if (!no_index && !startup_info->have_repository)
>  		/* die the same way as if we did it at the beginning */
>  		setup_git_directory();
>  
> @@ -873,11 +873,11 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  	if (!show_in_pager && !opt.status_only)
>  		setup_pager();
>  
> -	if (!use_index && (untracked || cached))
> +	if (no_index && (untracked || cached))
>  		die(_("--cached or --untracked cannot be used with --no-index."));
>  
> -	if (!use_index || untracked) {
> -		int use_exclude = (opt_exclude < 0) ? use_index : !!opt_exclude;
> +	if (no_index || untracked) {
> +		int use_exclude = (opt_exclude < 0) ? !no_index : !!opt_exclude;
>  		if (list.nr)
>  			die(_("--no-index or --untracked cannot be used with revs."));
>  		hit = grep_directory(&opt, &pathspec, use_exclude);
