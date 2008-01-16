From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] Do not show "diff --git" metainfo with --no-prefix
Date: Wed, 16 Jan 2008 01:37:48 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801160133150.17650@racer.site>
References: <c0f2d4110801150559x155ffabaj6bea52715522a070@mail.gmail.com> <alpine.DEB.1.00.0801151444180.5289@eeepc-johanness> <c0f2d4110801150758t68714570y83e1e74acbb67325@mail.gmail.com> <alpine.LNX.1.00.0801151728120.13593@iabervon.org>
 <7vhched3kw.fsf@gitster.siamese.dyndns.org> <7v4pded1rk.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Chris Ortman <chrisortman@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 02:38:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JExEb-0003Io-U6
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 02:38:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260AbYAPBh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 20:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753581AbYAPBh7
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 20:37:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:50179 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751979AbYAPBh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 20:37:58 -0500
Received: (qmail invoked by alias); 16 Jan 2008 01:37:56 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp005) with SMTP; 16 Jan 2008 02:37:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+U5mNSYy+U6r1el2MXvksBlK4hlF31Ej0RgrYWyJ
	Ujap75e4KapwiJ
X-X-Sender: gene099@racer.site
In-Reply-To: <7v4pded1rk.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70596>

Hi,

On Tue, 15 Jan 2008, Junio C Hamano wrote:

> diff --git a/diff.c b/diff.c
> index b18c140..8126a74 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1246,30 +1258,46 @@ static void builtin_diff(const char *name_a,
>  	char *a_one, *b_two;
>  	const char *set = diff_get_color_opt(o, DIFF_METAINFO);
>  	const char *reset = diff_get_color_opt(o, DIFF_RESET);
> +	int is_git_diff = with_standard_prefix(o);
>  
>  	a_one = quote_two(o->a_prefix, name_a + (*name_a == '/'));
>  	b_two = quote_two(o->b_prefix, name_b + (*name_b == '/'));
>  	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
>  	lbl[1] = DIFF_FILE_VALID(two) ? b_two : "/dev/null";
> -	printf("%sdiff --git %s %s%s\n", set, a_one, b_two, reset);
> +
> +	if (!is_git_diff)
> +		printf("%sIndex: %s%s\n", set, b_two, reset);
> +	else
> +		printf("%sdiff --git %s %s%s\n", set, a_one, b_two, reset);
> +

Hmm.  AFAICT plain diff outputs "diff ...", not "Index: ...".  IMHO doing 
half of what SVN does, and half what GNU diff does, but not completely 
what something else does, does not help anybody.

So I'm mildly negative on this hunk.

Also, I am not quite sure what to do about the "rename from" and "copy 
from" headers... The "--git" was always an indication that this patch may 
contain something like these headers.

All in all, I think this would be too much.  Let's just keep our patch 
format, and if anybody else is not able to grok unified diffs as we output 
them, have a transformer.  Let's not have git core affected.

Ciao,
Dscho
