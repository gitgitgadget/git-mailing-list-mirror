From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] diff: allow unstuck arguments with --diff-algorithm
Date: Fri, 5 Apr 2013 13:43:16 +0200
Message-ID: <876201td7v.fsf@linux-k42r.v.cablecom.net>
References: <8fc6f21da7c876d50f2f35c73252e95d525dffb5.1365160527.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Michal Privoznik <mprivozn@redhat.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sat Apr 06 18:48:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWFe-0002u6-7n
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756157Ab3DELnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 07:43:20 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:20741 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752337Ab3DELnT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 07:43:19 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 5 Apr
 2013 13:43:06 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS20.d.ethz.ch (172.31.51.110) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Fri, 5 Apr 2013 13:43:16 +0200
In-Reply-To: <8fc6f21da7c876d50f2f35c73252e95d525dffb5.1365160527.git.john@keeping.me.uk>
	(John Keeping's message of "Fri, 5 Apr 2013 12:15:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220163>

John Keeping <john@keeping.me.uk> writes:

> The argument to --diff-algorithm is mandatory, so there is no reason to
> require the argument to be stuck to the option with '='.  Change this
> for consistency with other Git commands.
>
> Note that this doesi not change the handling of diff-algorithm in
                     ^
strayi ;-)

> merge-recursive.c since the primary interface to that is via the -X
> option to 'git merge' where the unstuck form does not make sense.
>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
>  diff.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index db952a5..e0152f8 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3596,8 +3596,8 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
>  		options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
>  	else if (!strcmp(arg, "--histogram"))
>  		options->xdl_opts = DIFF_WITH_ALG(options, HISTOGRAM_DIFF);
> -	else if (!prefixcmp(arg, "--diff-algorithm=")) {
> -		long value = parse_algorithm_value(arg+17);
> +	else if ((argcount = parse_long_opt("diff-algorithm", av, &optarg))) {
> +		long value = parse_algorithm_value(optarg);
>  		if (value < 0)
>  			return error("option diff-algorithm accepts \"myers\", "
>  				     "\"minimal\", \"patience\" and \"histogram\"");
> @@ -3605,6 +3605,7 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
>  		DIFF_XDL_CLR(options, NEED_MINIMAL);
>  		options->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
>  		options->xdl_opts |= value;
> +		return argcount;
>  	}
>  
>  	/* flags options */

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
