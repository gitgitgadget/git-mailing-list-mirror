From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/5] Help.c add --guide option
Date: Sun, 03 Mar 2013 15:38:35 -0800
Message-ID: <7vk3poyryc.fsf@alter.siamese.dyndns.org>
References: <1362342072-1412-1-git-send-email-philipoakley@iee.org>
 <1362342072-1412-4-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GitList <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Mar 04 00:39:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCIUj-0000qu-QZ
	for gcvg-git-2@plane.gmane.org; Mon, 04 Mar 2013 00:39:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754762Ab3CCXim (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Mar 2013 18:38:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57623 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754754Ab3CCXil (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Mar 2013 18:38:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12981B649;
	Sun,  3 Mar 2013 18:38:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=YrhKhXwMqr3Tifxm+v96uRxyRrE=; b=VyEpMiiyakCBl5bLEq73
	K7tWwh78Y0bnp2GrWooYyQwXwxBcPRVBj3QHu1DJ5gMZe/pN42sf0u+qiO3aM3NL
	/pri+tKHyY4Crquw6rUqyXuhooid+t+j1i7xSPeq8MY9Vt+kErc72Nkh5MPX/vel
	RkAEOIYNTHPbAI87ol+WkV4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=rW2/DoOM4VR+iR+O6zbERkeTquobxQkf4P04Yi7ZjWwyK3
	C4AHHPEPLlo6XYzpHPiZtEiXTEYhRirIicm2SHu/mc2JtoOuajkqjnFM9ZGwlyo/
	yHq/XKyviLC13FqRsomtWkrYH6MLZ9eKqkQ0GQYESd79degCuqVTdFA5HzIpY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06E72B648;
	Sun,  3 Mar 2013 18:38:41 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 354C2B63C; Sun,  3 Mar 2013
 18:38:37 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 787355B4-845B-11E2-A504-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217370>

Philip Oakley <philipoakley@iee.org> writes:

> Logic, but no actions, included.

I am not sure what you mean.  Is that to break "bisect"?

Ahh, you meant "command line is parsed but we do not actually show
guides yet, which is done by later patches in this series".  OK.

> The --all commands option, if given, will display first.
> The --guide option's list will then be displayed.
>
> The common commands list is only displayed if neither option,
> nor a command or guide name, is given.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
>  builtin/help.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/help.c b/builtin/help.c
> index d10cbed..6089d72 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -36,10 +36,12 @@ enum help_format {
>  static const char *html_path;
>  
>  static int show_all = 0;
> +static int show_guides = 0;
>  static unsigned int colopts;
>  static enum help_format help_format = HELP_FORMAT_NONE;
>  static struct option builtin_help_options[] = {
>  	OPT_COUNTUP('a', "all", &show_all, N_("print all available commands")),
> +	OPT_COUNTUP('g', "guides", &show_guides, N_("print list of useful guides")),
>  	OPT_SET_INT('m', "man", &help_format, N_("show man page"), HELP_FORMAT_MAN),
>  	OPT_SET_INT('w', "web", &help_format, N_("show manual in web browser"),
>  			HELP_FORMAT_WEB),
> @@ -49,7 +51,7 @@ static struct option builtin_help_options[] = {
>  };
>  
>  static const char * const builtin_help_usage[] = {
> -	N_("git help [--all] [--man|--web|--info] [command]"),
> +	N_("git help [--all] [--guides] [--man|--web|--info] [command]"),
>  	NULL
>  };
>  
> @@ -429,9 +431,11 @@ int cmd_help(int argc, const char **argv, const char *prefix)
>  		printf(_("usage: %s%s"), _(git_usage_string), "\n\n");
>  		list_commands(colopts, &main_cmds, &other_cmds);
>  		printf("%s\n", _(git_more_info_string));
> +		if (!show_guides) return 0;
> +	}
> +	if (show_guides) {
>  		return 0;
>  	}
> -

Ugly.

	if (show_all) {
        	... do not touch anything here ...
		... but remove "return 0;" ...
	}

	if (show_guides) {
        	... show guides but do not "return 0" ...
	}

	if (show_all || show_guides) {
		... we were asked to do either/or --all/--guides ...
                ... and have done what we were asked to do ...
		return 0;
	}

This is a tangent, but before all of the above, cmd_help() should
verify that it got no arguments (when show_all/show_guides is in
effect) or it got one argument (otherwise), I think.

>  	if (!argv[0]) {
>  		printf(_("usage: %s%s"), _(git_usage_string), "\n\n");
>  		list_common_cmds_help();
