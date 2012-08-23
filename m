From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 04/17] Name local variables more consistently
Date: Thu, 23 Aug 2012 04:39:18 -0400
Message-ID: <20120823083918.GB6963@sigill.intra.peff.net>
References: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
 <1345709442-16046-5-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Aug 23 10:39:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Swu-0003XJ-Av
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 10:39:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650Ab2HWIjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 04:39:23 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45955 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752169Ab2HWIjV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2012 04:39:21 -0400
Received: (qmail 19247 invoked by uid 107); 23 Aug 2012 08:39:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 23 Aug 2012 04:39:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Aug 2012 04:39:18 -0400
Content-Disposition: inline
In-Reply-To: <1345709442-16046-5-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204136>

On Thu, Aug 23, 2012 at 10:10:29AM +0200, mhagger@alum.mit.edu wrote:

> From: Michael Haggerty <mhagger@alum.mit.edu>
> 
> Use the names (nr_heads, heads) consistently across functions, instead
> of sometimes naming the same values (nr_match, match).

I think this is fine, although:

> --- a/builtin/fetch-pack.c
> +++ b/builtin/fetch-pack.c
> @@ -521,7 +521,7 @@ static void mark_recent_complete_commits(unsigned long cutoff)
>  	}
>  }
>  
> -static void filter_refs(struct ref **refs, int nr_match, char **match)
> +static void filter_refs(struct ref **refs, int nr_heads, char **heads)
>  {
>  	struct ref **return_refs;
>  	struct ref *newlist = NULL;
> @@ -530,12 +530,12 @@ static void filter_refs(struct ref **refs, int nr_match, char **match)
>  	struct ref *fastarray[32];
>  	int match_pos;

This match_pos is an index into the "match" array, which becomes "head".
Should it become head_pos?

And then bits like this:

> -			while (match_pos < nr_match) {
> -				cmp = strcmp(ref->name, match[match_pos]);
> +			while (match_pos < nr_heads) {
> +				cmp = strcmp(ref->name, heads[match_pos]);

Would be:

  while (head_pos < nr_heads)

which makes more sense to me.

-Peff
