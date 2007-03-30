From: Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH] git-mailinfo fixes for patch munging
Date: Fri, 30 Mar 2007 17:32:10 -0400
Message-ID: <20070330213210.GL11029@redhat.com>
References: <20070330161845.GI11029@redhat.com> <7vmz1uzaxd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 30 23:34:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXOjg-0007HW-Mi
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 23:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbXC3Vdt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 17:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbXC3Vdt
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 17:33:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37088 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932398AbXC3Vdr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 17:33:47 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l2ULXivo026944;
	Fri, 30 Mar 2007 17:33:44 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l2ULXcGc021697;
	Fri, 30 Mar 2007 17:33:38 -0400
Received: from drseuss.boston.redhat.com (drseuss.boston.redhat.com [172.16.80.234])
	by mail.boston.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l2ULXcxN019456;
	Fri, 30 Mar 2007 17:33:38 -0400
Received: from drseuss.boston.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.boston.redhat.com (8.13.7/8.13.4) with ESMTP id l2ULWBcf016109;
	Fri, 30 Mar 2007 17:32:11 -0400
Received: (from dzickus@localhost)
	by drseuss.boston.redhat.com (8.13.7/8.13.7/Submit) id l2ULWBK0016108;
	Fri, 30 Mar 2007 17:32:11 -0400
X-Authentication-Warning: drseuss.boston.redhat.com: dzickus set sender to dzickus@redhat.com using -f
Content-Disposition: inline
In-Reply-To: <7vmz1uzaxd.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43501>

On Fri, Mar 30, 2007 at 02:19:42PM -0700, Junio C Hamano wrote:
> Don Zickus <dzickus@redhat.com> writes:
> 
> > Don't translate the patch to UTF-8, instead preserve the data as is.  Also
> > allow overwriting the primary mail headers (addresses Linus's concern).  
> >
> > I also revert a test case that was included in the original patch.  Now it
> > makes sense why it was the way it was. :)
> >
> > Cheers,
> > Don
> 
> Thanks.  Sign-off would have been nice.

Doh. Sorry.  Should I repost with fix below?

> This check_header is called from each multi-part boundary with
> overwrite=1, so if you have two parts and you have From: or
> Subject: in the multi-part header (not in-body), wouldn't they
> overwrite what we already have?  That is not desired, I would
> think.

Hmm.  I guess I never thought about that case.  You are right, that check
can be changed to a zero (because the rfc2822 are checked elsewhere).

> > @@ -614,6 +614,7 @@ static int find_boundary(void)
> >  
> >  static int handle_boundary(void)
> >  {
> > +	char newline[]="\n";
> >  again:
> >  	if (!memcmp(line+content_top->boundary_len, "--", 2)) {
> >  		/* we hit an end boundary */
> > @@ -628,7 +629,7 @@ again:
> >  					"can't recover\n");
> >  			exit(1);
> >  		}
> > -		handle_filter("\n");
> > +		handle_filter(newline);
> >  
> >  		/* skip to the next boundary */
> >  		if (!find_boundary())
> 
> These two hunks certainly do not hurt, but why?  Is this about
> the constness of the first parameter to handle_filter() and its
> call chain?

Yeah, I SEGFAULT'd when trying to convert_to_utf8() a fixed string. :-)

Cheers,
Don
