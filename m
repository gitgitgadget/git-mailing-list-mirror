From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Move color option parsing out of diff.c and into color.[ch]
Date: Fri, 08 Sep 2006 01:49:20 -0700
Message-ID: <7vk64eivzj.fsf@assigned-by-dhcp.cox.net>
References: <20060908073452.GA25343@coredump.intra.peff.net>
	<20060908080318.GA3771@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 08 10:49:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLc2w-0002UE-81
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 10:49:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWIHItA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 04:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbWIHItA
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 04:49:00 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:64975 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750714AbWIHIs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Sep 2006 04:48:59 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060908084859.NUFL12909.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Fri, 8 Sep 2006 04:48:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Kkor1V00A1kojtg0000000
	Fri, 08 Sep 2006 04:48:51 -0400
To: Jeff King <peff@peff.net>
In-Reply-To: <20060908080318.GA3771@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 8 Sep 2006 04:03:18 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26689>

Jeff King <peff@peff.net> writes:

> +static int color_vprintf(const char *color, const char *fmt,
> +		va_list args, const char *trail)
> +{
> +	int r = 0;
> +
> +	if (*color)
> +		r += printf("%s", color);
> +	r += vprintf(fmt, args);
> +	if (trail)
> +		r += printf("%s", trail);
> +	if (*color)
> +		r += printf("%s", COLOR_RESET);
> +	return r;
> +}

Hmm,... don't you mean RESET first and then trail (which is often "\n")?

> +int color_printf(const char *color, const char *fmt, ...)
> +{
> +	va_list args;
> +	int r;
> +	va_start(args, fmt);
> +	r = color_vprintf(color, fmt, args, 0);
> +	va_end(args);
> +	return r;
> +}

Please spell NULL not 0 (please do not argue that writing a NULL
pointer as integral constant 0 is perfectly valid C -- we all
know that.  This is not the language-lawyers correctness issue,
but ../linux-2.6/Documentation/CodingStyle thing).  Using
pointer as boolean seems to be Ok style (e.g. "if (trail)" does
not have to be written "if (trail == NULL)").
