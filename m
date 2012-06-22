From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Restore use of 'help.format' configuration property in
 'git help'
Date: Fri, 22 Jun 2012 11:06:29 -0700
Message-ID: <7vy5nfp6fu.fsf@alter.siamese.dyndns.org>
References: <1340369326-1840-1-git-send-email-patthoyts@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Vincent van Ravesteijn <vfr@lyx.org>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Jun 22 20:06:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Si8Ff-0002IG-V5
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 20:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756007Ab2FVSGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 14:06:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50081 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751561Ab2FVSGb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 14:06:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 132977AB3;
	Fri, 22 Jun 2012 14:06:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SWdBBOCoF2mJq5/oZ5KUkEW1YHg=; b=xKXnGO
	l8fEVnvGMe1rxfwGCHwk4qqiKUCEKk/Lf22UDIVkr06tLB1ui5lWINqKa8xh3Iqo
	oeXDG5cggLvT+4JI5wAZme62KYHNyq7TtVeuMjYFZhIuANr0P0En5/DnJa+sJtlt
	gGOjy8E3QBxrYu9Cy8k3pAM26OGvYJOI3x0Ns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BI5vTp9xkS1eHN+WF0Lz01pi81HLFkcP
	RCMm2TvjJVFHzx6nsFZLaxVbdLH3PBWST9zqzblD7L7PH1AD18tHl4859KCheykZ
	qWKqMGCkxZ9/QyZozeIfwGBJkdGs8Q7JC+qb30up2uhEW4ZGoQZS/rrzdDO9P6CD
	B9vSTksPnj8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09BBA7AB2;
	Fri, 22 Jun 2012 14:06:31 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 65B207AB1; Fri, 22 Jun 2012
 14:06:30 -0400 (EDT)
In-Reply-To: <1340369326-1840-1-git-send-email-patthoyts@users.sourceforge.net> (Pat
 Thoyts's message of "Fri, 22 Jun 2012 13:48:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FE3ABB7C-BC94-11E1-B3B1-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200454>

Pat Thoyts <patthoyts@users.sourceforge.net> writes:

> Commit 1cc8af0 "help: use HTML as the default help format on Windows"
> lost the ability to make use of the help.format config value by forcing
> the use of a compiled in default if no command-line argument was provided.
> This commit restores the use of the help.format value if one is
> available, overriding the compiled default.

Of course.  Sorry for not catching it earlier.

>
> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
> ---
>  builtin/help.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/help.c b/builtin/help.c
> index 536d4fd..8f9cd60 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -449,10 +449,10 @@ int cmd_help(int argc, const char **argv, const char *prefix)
>  	setup_git_directory_gently(&nongit);
>  	git_config(git_help_config, NULL);
>  
> -	if (parsed_help_format == HELP_FORMAT_NONE)
> -		help_format = parse_help_format(DEFAULT_HELP_FORMAT);
> -	else
> +	if (parsed_help_format != HELP_FORMAT_NONE)
>  		help_format = parsed_help_format;
> +	if (help_format == HELP_FORMAT_NONE)
> +		help_format = parse_help_format(DEFAULT_HELP_FORMAT);
>  
>  	alias = alias_lookup(argv[0]);
>  	if (alias && !is_git_command(argv[0])) {
