From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/3] Move color option parsing out of diff.c and into color.[ch]
Date: Thu, 07 Sep 2006 16:56:43 -0700
Message-ID: <7vfyf3s01w.fsf@assigned-by-dhcp.cox.net>
References: <2ec783f6a8e8a901f7c30947e8c0eb50f71bc185.1157610743.git.peff@peff.net>
	<20060907063559.GB17083@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 08 01:56:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLTjf-0003NB-If
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 01:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbWIGX41 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 19:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751916AbWIGX41
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 19:56:27 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:3813 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751913AbWIGX40 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 19:56:26 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060907235626.WDYH12909.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Thu, 7 Sep 2006 19:56:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KbwH1V00s1kojtg0000000
	Thu, 07 Sep 2006 19:56:18 -0400
To: Jeff King <peff@peff.net>
In-Reply-To: <20060907063559.GB17083@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 7 Sep 2006 02:35:59 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26665>

Jeff King <peff@peff.net> writes:

> +#include <stdarg.h>
> +
> +#define COLOR_RESET "\033[m"
> +
> +static int
> +parse_color(const char *name, int len)
> +{

Style (applies to all functions you moved to this new file).

Some school of programming teach us to start the function name
at the beginning of the line, separate from its type.  They say
that would make "grep '^parse_color'" to work better.

That happens to be the way I was taught (actually it was a bit
more strange that return type was to be indented by one TAB, so
it looked like this:

		static int
	parse_color(const char *name, int len)

).  But git style is the kernel style, and I refrain from doing
that myself.

	static int parse_color(const char *name, int len)
	{
        	...

> +int
> +git_config_colorbool(const char *var, const char *value)
> +{
> +	if (!value)
> +		return 1;
> +	if (!strcasecmp(value, "auto")) {
> +		if (isatty(1) || (pager_in_use && pager_use_color)) {
> +			char *term = getenv("TERM");
> +			if (term && strcmp(term, "dumb"))
> +				return 1;
> +		}
> +		return 0;
> +	}
> +	if (!strcasecmp(value, "never"))
> +		return 0;
> +	if (!strcasecmp(value, "always"))
> +		return 1;
> +	return git_config_bool(var, value);
> +}

> +int
> +color_printf(const char *color, const char *fmt, ...) {

Style.

	int color_printf(const char *color, const char *fmt, ...)
	{
		...
