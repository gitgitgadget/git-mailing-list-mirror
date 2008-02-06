From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] Retain extra blank lines between the summary and the body
Date: Wed, 06 Feb 2008 12:30:37 -0800
Message-ID: <7v4pclx1xu.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0802061141320.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Feb 06 21:32:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMqwH-0003by-BD
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 21:32:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756710AbYBFUa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 15:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756820AbYBFUa7
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 15:30:59 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34078 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755663AbYBFUa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 15:30:58 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 071942E52;
	Wed,  6 Feb 2008 15:30:57 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7761F2E51;
	Wed,  6 Feb 2008 15:30:54 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72848>

Daniel Barkalow <barkalow@iabervon.org> writes:

> This is so that it's possible to have a message that will generate an
> email with the first line blank. If the email you're generating is
> actually a template, you may have a single line filling in for a
> ~3-line paragraph, meaning that the space starts with a blank line,
> which was impossible before as output from the message-splitting code.
>
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> ---
>  pretty.c |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)
>
> diff --git a/pretty.c b/pretty.c
> index f82380b..98efac2 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -713,7 +713,6 @@ void pp_remainder(enum cmit_fmt fmt,
>  		  struct strbuf *sb,
>  		  int indent)
>  {
> -	int first = 1;
>  	for (;;) {
>  		const char *line = *msg_p;
>  		int linelen = get_one_line(line);
> @@ -723,12 +722,9 @@ void pp_remainder(enum cmit_fmt fmt,
>  			break;
>  
>  		if (is_empty_line(line, &linelen)) {
> -			if (first)
> -				continue;
>  			if (fmt == CMIT_FMT_SHORT)
>  				break;
>  		}
> -		first = 0;
>  
>  		strbuf_grow(sb, linelen + indent + 20);
>  		if (indent) {

I have to wonder if this regresses the normal codepath to
cleanse commit messages that have extra blanks at the
beginning.
