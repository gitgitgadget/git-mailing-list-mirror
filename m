From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] rebase-i-exec: Allow space in SHELL_PATH
Date: Fri, 13 Nov 2015 01:25:35 -0500
Message-ID: <20151113062534.GE32157@sigill.intra.peff.net>
References: <1447394599-16077-1-git-send-email-fredrik.medley@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Fredrik Medley <fredrik.medley@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 13 07:25:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zx7nq-0000JI-Bu
	for gcvg-git-2@plane.gmane.org; Fri, 13 Nov 2015 07:25:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753528AbbKMGZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 01:25:38 -0500
Received: from cloud.peff.net ([50.56.180.127]:56981 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751651AbbKMGZh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 01:25:37 -0500
Received: (qmail 17583 invoked by uid 102); 13 Nov 2015 06:25:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Nov 2015 00:25:37 -0600
Received: (qmail 22025 invoked by uid 107); 13 Nov 2015 06:26:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Nov 2015 01:26:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Nov 2015 01:25:35 -0500
Content-Disposition: inline
In-Reply-To: <1447394599-16077-1-git-send-email-fredrik.medley@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281243>

On Fri, Nov 13, 2015 at 07:03:19AM +0100, Fredrik Medley wrote:

> On Windows, when Git is installed under "C:\Program Files\Git", SHELL_PATH
> will include a space. Fix "git rebase --interactive --exec" so that it
> works with spaces in SHELL_PATH.
> 
> Signed-off-by: Fredrik Medley <fredrik.medley@gmail.com>
> ---
>  git-rebase--interactive.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 30edb17..b938a6d 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -610,7 +610,7 @@ do_next () {
>  		read -r command rest < "$todo"
>  		mark_action_done
>  		printf 'Executing: %s\n' "$rest"
> -		${SHELL:-@SHELL_PATH@} -c "$rest" # Actual execution
> +		"${SHELL:-@SHELL_PATH@}" -c "$rest" # Actual execution

I think this is the right thing to do (at least I could not think of a
case that would be harmed by it, and it certainly fixes your case). It
looks like filter-branch would need a similar fix?

I think this still isn't resilient to weird meta-characters in the
@SHELL_PATH@, but as this is a build-time option, I think it's OK to let
people who do

  make SHELL_PATH='}"; rm -rf /'

hang themselves.

-Peff
