From: Mike Crowe <mac@mcrowe.com>
Subject: Re: [PATCH] push: add recurseSubmodules config option
Date: Mon, 30 Nov 2015 19:00:21 +0000
Message-ID: <20151130190021.GA29232@mcrowe.com>
References: <1447680294-13395-1-git-send-email-mac@mcrowe.com>
 <xmqqa8pv8hkx.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 20:00:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3Tge-0001va-Sv
	for gcvg-git-2@plane.gmane.org; Mon, 30 Nov 2015 20:00:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754209AbbK3TA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2015 14:00:28 -0500
Received: from avasout05.plus.net ([84.93.230.250]:50515 "EHLO
	avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753984AbbK3TA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2015 14:00:27 -0500
Received: from deneb ([80.229.24.9])
	by avasout05 with smtp
	id nv0M1r0020BmcFC01v0NZr; Mon, 30 Nov 2015 19:00:25 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=MryvkDue c=1 sm=1 tr=0
 a=E/9URZZQ5L3bK/voZ0g0HQ==:117 a=E/9URZZQ5L3bK/voZ0g0HQ==:17 a=0Bzu9jTXAAAA:8
 a=-An2I_7KAAAA:8 a=kj9zAlcOel0A:10 a=qtqOOiqGOCEA:10 a=EE54PDY9XPneVaKS8jcA:9
 a=CjuIK1q_8ugA:10
Received: from mac by deneb with local (Exim 4.84)
	(envelope-from <mac@mcrowe.com>)
	id 1a3TgT-0007iE-KK; Mon, 30 Nov 2015 19:00:21 +0000
Content-Disposition: inline
In-Reply-To: <xmqqa8pv8hkx.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281809>

On Monday 30 November 2015 at 10:31:26 -0800, Junio C Hamano wrote:
> Mike Crowe <mac@mcrowe.com> writes:
> 
> > diff --git a/builtin/push.c b/builtin/push.c
> > index 3bda430..dfced74 100644
> > --- a/builtin/push.c
> > +++ b/builtin/push.c
> > @@ -9,6 +9,7 @@
> >  #include "transport.h"
> >  #include "parse-options.h"
> >  #include "submodule.h"
> > +#include "submodule-config.h"
> >  #include "send-pack.h"
> >  
> >  static const char * const push_usage[] = {
> > @@ -20,7 +21,7 @@ static int thin = 1;
> >  static int deleterefs;
> >  static const char *receivepack;
> >  static int verbosity;
> > -static int progress = -1;
> > +static int progress = -1, recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
> 
> One variable per line, please.  Especially when the two variables do
> not have anything to do with each other, and do not have any logical
> similarity between them.

I wouldn't normally have done that either, but I was mirroring the
equivalent code in fetch.c. I will change it.

> > @@ -452,22 +453,15 @@ static int do_push(const char *repo, int flags)
> >  static int option_parse_recurse_submodules(const struct option *opt,
> >  				   const char *arg, int unset)
> >  {
> > -	int *flags = opt->value;
> > +	int *recurse_submodules = opt->value;
> >  
> > -	if (*flags & (TRANSPORT_RECURSE_SUBMODULES_CHECK |
> > -		      TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND))
> > +	if (*recurse_submodules != RECURSE_SUBMODULES_DEFAULT)
> >  		die("%s can only be used once.", opt->long_name);
> 
> The usual convention thoughout Git user experience is "the last one
> wins" (both in the configuration and in the command line options).
> Is there a good reason to deviate from that here?

I was aiming to retain the existing behaviour, which was to complain if
conflicting options were supplied on the command line. Making the last one
win would have been rather simpler. I can change this too, unless someone
knows why complaining about conflicting options would be useful.

Note that I previously sent an updated patch as
<1447758356-7727-1-git-send-email-mac@mcrowe.com> but I believe that your
criticisms still apply.

Thanks for the review.

Mike.
