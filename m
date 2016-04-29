From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] http: expand http.cookieFile as a path
Date: Fri, 29 Apr 2016 13:16:31 -0400
Message-ID: <20160429171631.GA29571@sigill.intra.peff.net>
References: <20160429062357.12647-1-computersforpeace@gmail.com>
 <20160429062357.12647-2-computersforpeace@gmail.com>
 <20160429141212.GB26643@sigill.intra.peff.net>
 <xmqqziscz6ej.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brian Norris <computersforpeace@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 19:16:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awC1u-00076v-QU
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 19:16:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752454AbcD2RQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 13:16:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:59246 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752272AbcD2RQe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 13:16:34 -0400
Received: (qmail 18188 invoked by uid 102); 29 Apr 2016 17:16:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Apr 2016 13:16:33 -0400
Received: (qmail 23838 invoked by uid 107); 29 Apr 2016 17:16:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Apr 2016 13:16:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Apr 2016 13:16:31 -0400
Content-Disposition: inline
In-Reply-To: <xmqqziscz6ej.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293029>

On Fri, Apr 29, 2016 at 10:11:48AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I'm not sure if it's a good idea to go into so much detail about
> > expand_user_path() here. There are a lot of options that use the same
> > rules, and we probably don't want to go into a complete explanation
> > inside each option's description. Is there a canonical definition of how
> > we do expansion in config.txt that we can just reference (and if not,
> > can we add one)?
> 
> We have a dedicated section for various value-types used in the
> configuration variables already, because we needed to describe how
> booleans and scaled integers can be spelled, and the pathname type
> would fit there.
> 
>  Documentation/config.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 59d7046..1bf42a6 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -169,6 +169,11 @@ thing on the same output line (e.g. opening parenthesis before the
>  list of branch names in `log --decorate` output) is set to be
>  painted with `bold` or some other attribute.
>  
> +pathname::
> +	A variable that takes a pathname value can be given a
> +	string that begins with "~/" or "~user/", and the usual
> +	tilde expansion happens to such a string.
> +
>  
>  Variables
>  ~~~~~~~~~

Yeah, this is what I had in mind. My only reservation would be that we
need to make sure it is clear that this applies only to keys marked as
taking a "pathname" type in the documentation. I'm suspect there are
ones that are logically paths but do not currently do the expansion, but
the wording above makes it sound like any pathname-like thing does.

Alternatively, it might be worth going through the list to make sure all
paths use git_config_pathname() internally. Brian asked earlier if the
"no expansion" was an intentional policy, but it's not. It's just that
pathname expansion came much later, and config keys were ported over to
it one by one as people found it useful to do so.

-Peff
