From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Introduce <branch>@{upstream} as shortcut to the
 tracked branch
Date: Thu, 10 Sep 2009 18:18:46 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0909101817521.8306@pacific.mpi-cbg.de>
References: <20090907084324.GB17997@coredump.intra.peff.net> <alpine.DEB.1.00.0909071126040.8306@pacific.mpi-cbg.de> <20090909104550.GA20108@coredump.intra.peff.net> <7vzl93cncn.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0909100941330.8306@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0909101135590.8306@pacific.mpi-cbg.de> <20090910141618.GB4942@coredump.intra.peff.net> <20090910142628.GA7275@coredump.intra.peff.net> <alpine.DEB.1.00.0909101723260.8306@pacific.mpi-cbg.de> <alpine.DEB.1.00.0909101724520.8306@pacific.mpi-cbg.de>
 <20090910155547.GA12409@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 10 18:17:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlmKn-0006d7-3N
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 18:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090AbZIJQRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 12:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbZIJQRK
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 12:17:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:60871 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751222AbZIJQRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 12:17:09 -0400
Received: (qmail invoked by alias); 10 Sep 2009 16:17:11 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp069) with SMTP; 10 Sep 2009 18:17:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/SYM9yUonS+DpJDIiDVZJLVxAJmSjKMotgzladuO
	vmTE4XP0AFm7VA
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090910155547.GA12409@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128124>

Hi,

On Thu, 10 Sep 2009, Jeff King wrote:

> I wrote:
> 
> > +	ret = tracked_suffix(*string, *len);
> > +	if (ret) {
> > +		char *ref = xstrndup(*string, *len - ret);
> > +		struct branch *tracking = branch_get(*ref ? ref : NULL);
> > +
> > +		free(ref);
> > +		if (!tracking)
> > +			die ("No tracking branch found for '%s'", ref);
> > +		if (tracking->merge && tracking->merge[0]->dst) {
> > +			*string = xstrdup(tracking->merge[0]->dst);
> > +			*len = strlen(*string);
> > +			return (char *)*string;
> > +		}
> > +	}
> > +
> 
> I don't think it is a good idea to die for !tracking, but not for
> !tracking->merge. That leads to inconsistent user-visible results:
> 
>   $ git checkout HEAD^0
>   $ git rev-parse HEAD@{u}
>   fatal: No tracking branch found for 'HEAD'
>   $ git rev-parse bogus@{u}
>   bogus@{u}
>   fatal: ambiguous argument 'bogus@{u}': unknown revision or path not in the working tree.
>   Use '--' to separate paths from revisions
> 
> Shouldn't both cases say the same thing?
> 
> Also, your die message has two problems:
> 
>  1. It looks at ref immediately after it is free'd, spewing junk.
> 
>  2. Ref can be the empty string, which gives you the ugly:
> 
>        fatal: No tracking branch found for ''
> 
>     Should we munge that into HEAD (or "the current branch") for the
>     user?

All true, but I cannot take care of it today.

Ciao,
Dscho
