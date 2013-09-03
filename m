From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] git send-email: include [anything]-by: signatures
Date: Wed, 4 Sep 2013 00:01:49 +0300
Message-ID: <20130903210149.GA24480@redhat.com>
References: <20130826165747.GA30788@redhat.com>
 <20130831192250.GA3823@redhat.com>
 <20130903063535.GA3608@sigill.intra.peff.net>
 <20130903084454.GC18901@redhat.com>
 <xmqqmwntu96c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 23:00:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGxhi-0005qN-R7
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 23:00:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315Ab3ICU77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 16:59:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33017 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760601Ab3ICU76 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 16:59:58 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r83KxlE6020967
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 3 Sep 2013 16:59:47 -0400
Received: from redhat.com (vpn1-6-201.ams2.redhat.com [10.36.6.201])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id r83Kxj5r011573;
	Tue, 3 Sep 2013 16:59:46 -0400
Content-Disposition: inline
In-Reply-To: <xmqqmwntu96c.fsf@gitster.dls.corp.google.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233779>

On Tue, Sep 03, 2013 at 10:06:19AM -0700, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Tue, Sep 03, 2013 at 02:35:35AM -0400, Jeff King wrote:
> >> On Sat, Aug 31, 2013 at 10:22:50PM +0300, Michael S. Tsirkin wrote:
> >> 
> >> > On Mon, Aug 26, 2013 at 07:57:47PM +0300, Michael S. Tsirkin wrote:
> >> > > Consider [anything]-by: a valid signature.
> >> > > This includes Tested-by: Acked-by: Reviewed-by: etc.
> >> > > 
> >> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >> > 
> >> > Ping.
> >> > Any opinion on whether this change is acceptable?
> >> 
> >> I was left confused by your commit message, as it wasn't clear to me
> >> what a "signature" is. But the point of it seems to be that people
> >> mention others in commit messages using "X-by:" pseudo-headers besides
> >> "signed-off-by", and you want to cc them along with the usual S-O-B.
> >> 
> >> That seems like a reasonable goal, but I have two concerns.
> >> 
> >> One, I would think the utility of this would be per-project, depending
> >> on what sorts of things people in a particular project put in
> >> pseudo-headers.  Grepping the kernel history shows that most X-by
> >> headers have a person on the right-hand side, though quite often it is
> >> not a valid email address (on the other hand, quite a few s-o-b lines in
> >> the kernel do not have a valid email).
> >> 
> >> And two, the existing options for enabling/disabling this code all
> >> explicitly mention signed-off-by, which becomes awkward. You did not
> >> update the documentation in your patch, but I think you would end up
> >> having to explain that "--supress-cc=sob" and "--signed-off-by-cc"
> >> really mean "all pseudo-header lines ending in -by".
> >> 
> >> So I think it might be a nicer approach to introduce a new "suppress-cc"
> >> class that means "all pseudo-header tokens ending in -by" or similar.
> >> We might even want the new behavior on by default, but it would at least
> >> give the user an escape hatch if their project generates a lot of false
> >> positives.
> >> 
> >> -Peff
> >
> > I guess there's always cccmd, no?
> 
> I am having a hard time deciphering what this response means.  Are
> you suggesting that people can use cccmd to do what your patch
> wants to do, so the patch is not needed?
> 
> I tend to agree with Peff that it is a reasonable goal to allow more
> than just the fixed set of trailers to be used as a source to decide
> whom to Cc, and if it can be generic enough, it would make sense to
> supply users such support so that various projects do not have to
> invent their own.
> 
> The question of course is the first point Peff raised.  I am not
> sure offhand what the right per-project customization interface
> would be.  A starting point might be something like:
> 
> 	--cc-trailer=signed-off-by,acked-by,reviewed-by

tested-by, reported-by ...

> or even
> 
> 	--cc-trailer='*-by'
> 
> and an obvious configuration variable that gives the default for it.
> That would eventually allow us not to special case any fixed set of
> trailers like S-o-b like the current code does, which would be a big
> plus.

What bothers me is that git normally uses gawk based patterns,
but send-email is in perl so it has a different syntax for regexp.
What do you suggest?  Make a small binary to do the matching for us?

-- 
MST
