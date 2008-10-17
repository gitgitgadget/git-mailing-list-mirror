From: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
Subject: Re: [PATCH] fix guilt-pop and push to fail if no relevant patches
Date: Fri, 17 Oct 2008 10:28:32 -0400
Message-ID: <20081017142832.GF27647@josefsipek.net>
References: <1222714293-9680-1-git-send-email-smoser@brickies.net> <alpine.DEB.1.00.0810170736240.27798@brickies>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Scott Moser <smoser@brickies.net>
X-From: git-owner@vger.kernel.org Fri Oct 17 16:30:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqqKq-0004hh-3D
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 16:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754625AbYJQO2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 10:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754545AbYJQO2d
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 10:28:33 -0400
Received: from josefsipek.net ([141.211.133.196]:54950 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754585AbYJQO2d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 10:28:33 -0400
Received: by josefsipek.net (Postfix, from userid 1000)
	id 7512D1C0254F; Fri, 17 Oct 2008 10:28:32 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0810170736240.27798@brickies>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98477>

On Fri, Oct 17, 2008 at 07:37:33AM -0400, Scott Moser wrote:
> Jeff,
>    Did you not like the patch below for some reason ?

I don't remember my train of thought, but I ended up making a simpler patch
to address the push-pushing-more-than-it-should bug. I completely missed the
part about the exit codes.

>    It seemed fairly straightforward to me that guilt-pop and guilt-push
> should exit failure if they did not do anything due to having nothing to
> do.

I'd actually say that it's not obvious, but...see below :)

> On Mon, 29 Sep 2008, Scott Moser wrote:
> > currently guilt-pop and guilt-push will exit with '0' if there are no more
> > relevant patches in the series (ie, if you've pushed or popped all of them)
> >
> > This means that you cannot do something like:
> >   while guilt-push; do
> >     guilt refresh || break
> >   done
> >
> > for reference, quilt does exit with non-zero in those cases:
> >   $ quilt push -a && quilt push
> >   File series fully applied, ends at patch my.patch
> >   $ echo $?
> >   1
> >
> >   $ quilt pop -a; quilt pop
> >   No patch removed
> >   $ echo $?
> >   2

Who am I to argue against compatibility.

...
> > diff --git a/guilt-push b/guilt-push
> > index 018f9ac..48f886b 100755
> > --- a/guilt-push
> > +++ b/guilt-push
[snipped long diff]

With my fix, this should be a 2-liner :)

Sorry for missing the return code part...

Josef 'Jeff' Sipek.

-- 
We have joy, we have fun, we have Linux on a Sun...
