From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/4 v2] Allow detached form for git diff
	--stat-name-width and --stat-width.
Date: Wed, 28 Jul 2010 21:36:28 -0500
Message-ID: <20100729023627.GJ29156@dert.cs.uchicago.edu>
References: <vpqr5ioukca.fsf@bauges.imag.fr> <1280310062-16793-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Jul 29 04:36:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeIzF-0001cr-Dv
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 04:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954Ab0G2Cga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 22:36:30 -0400
Received: from camembert.cs.uchicago.edu ([128.135.164.153]:34151 "EHLO
	smtp.cs.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194Ab0G2Cg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 22:36:29 -0400
Received: from dert.cs.uchicago.edu (dert.cs.uchicago.edu [128.135.11.157])
	by smtp.cs.uchicago.edu (Postfix) with ESMTP id 7D7F9A0EE;
	Wed, 28 Jul 2010 21:36:28 -0500 (CDT)
Received: by dert.cs.uchicago.edu (Postfix, from userid 10442)
	id 48C246914; Wed, 28 Jul 2010 21:36:28 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <1280310062-16793-2-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152150>

Matthieu Moy wrote:

>  diff.c |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)

Just some nitpicks:
 
> +++ b/diff.c
> @@ -3071,6 +3071,7 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
>  	else if (!strcmp(arg, "-s"))
>  		options->output_format |= DIFF_FORMAT_NO_OUTPUT;
>  	else if (!prefixcmp(arg, "--stat")) {
> +		argcount = 1;
>  		char *end;

declaration after statement.

> @@ -3079,8 +3080,20 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
>  
>  		switch (*arg) {
>  		case '-':
> +			if (!strcmp(arg, "-width")) {
> +				if (!av[1])
> +					die("Option `--stat-width' requires a value");
> +				width = strtoul(av[1], &end, 10);
> +				argcount = 2;
> +			}
>  			if (!prefixcmp(arg, "-width="))

Could save an extra string comparison with an "else" here.

[...]
> +				name_width = strtoul(av[1], &end, 10);
> +				argcount = 2;
> +			}				

Whitespace damage: trailing tabs.

How about something like the following?

Jonathan Nieder (1):
  diff: split off a function for --stat-* option parsing

Matthieu Moy (1):
  diff: allow --stat-width n, --stat-name-width n

 diff.c |   80 ++++++++++++++++++++++++++++++++++++++++++---------------------
 1 files changed, 53 insertions(+), 27 deletions(-)
