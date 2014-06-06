From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH 2/5] implement submodule config cache for
	lookup of submodule names
Date: Fri, 6 Jun 2014 07:20:40 +0200
Message-ID: <20140606052040.GA77405@book.hvoigt.net>
References: <20140605060425.GA23874@sandbox-ub> <20140605060750.GC23874@sandbox-ub> <20140605174610.GS21803@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Fri Jun 06 07:21:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsmaJ-0000TN-UB
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 07:21:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608AbaFFFU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 01:20:56 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.94]:42382 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227AbaFFFUz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 01:20:55 -0400
Received: from [77.20.146.74] (helo=book.hvoigt.net)
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Wsma7-0001Oc-0B; Fri, 06 Jun 2014 07:20:47 +0200
Content-Disposition: inline
In-Reply-To: <20140605174610.GS21803@odin.tremily.us>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250888>

On Thu, Jun 05, 2014 at 10:46:10AM -0700, W. Trevor King wrote:
> On Thu, Jun 05, 2014 at 08:07:50AM +0200, Heiko Voigt wrote:
> > +The caller can look up information about submodules by using the
> > +`submodule_from_path()` or `submodule_from_name()` functions.
> 
> That's for an already-known submodule.  Do we need a way to list
> submodules (e.g. for 'submodule foreach' style operations) or is the
> preferred way to do that just walking the tree looking for gitlinks?
> The cases where .gitmodules would lead you astray (e.g. via sloppy
> commits after removing a submodule) are:
> 
> * Listing a submodule that wasn't in the tree anymore.  Easy to check
>   for and ignore.
> 
> * Not listing a submodule that is in the tree.  You'd need to walk the
>   tree to check for this, but it's a pretty broken situation already,
>   so I'd be fine just ignoring the orphaned gitlink.

Currently there is no need to list the submodules in a .gitmodule file.
We currently always begin from the gitlink and try to do things. If we
have enough information thats fine we go ahead, if not we stop (or
skip?) the submodule. So for already initialized submodules it is even
ok to not have a .gitmodules entry at all and we can still go ahead with
most operations. Here we should not be too picky, I think.

The only use-case I can think of is for checking whether .gitmodules
contains any extra unneeded values. But on the other hand that is not
so easy. Since .gitmodules are just config files they can contain user
defined values. That is ok.

So in summary: Yes the preferred way to list submodules is via iterating
the gitlinks and I do not think we need a way to iterate through the
.gitmodules file (at least not for the use-cases we currently need this
for).

Cheers Heiko
