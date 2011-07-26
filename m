From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/5] setup_revisions: remember whether a ref was positive
 or not
Date: Tue, 26 Jul 2011 17:16:06 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1107261713040.1534@s15462909.onlinehome-server.info>
References: <1311517282-24831-1-git-send-email-srabbelier@gmail.com> <1311517282-24831-4-git-send-email-srabbelier@gmail.com> <7vy5znscst.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 26 17:16:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QljMl-0007hL-KE
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 17:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752848Ab1GZPQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 11:16:12 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:59421 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752225Ab1GZPQK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 11:16:10 -0400
Received: (qmail invoked by alias); 26 Jul 2011 15:16:07 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp062) with SMTP; 26 Jul 2011 17:16:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18/m5RfwtQ/Y5UsTNvYC4jxJDUWUw1sBWWrEDaJRV
	RdImkf6vsqH6rF
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <7vy5znscst.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177891>

Hi,

On Sun, 24 Jul 2011, Junio C Hamano wrote:

> Sverre Rabbelier <srabbelier@gmail.com> writes:
> 
> >  void add_pending_object(struct rev_info *revs, struct object *obj, const char *name)
> >  {
> > -	add_pending_object_with_mode(revs, obj, name, S_IFINVALID);
> > +	add_pending_object_with_mode(revs, obj, name, S_IFINVALID, 0);
> >  }
> 
> This seems utterly broken.  For example, fmt-merge-msg.c adds "^HEAD" 
> and of course the flags on the object is UNINTERESTING. Has all the 
> callers of add_pending_object() been verified? Why is it passing an 
> unconditional 0 and not !!(obj->flags & UNINTERESTING) or something?
> 
> If the excuse is "this is only to help fast-export and other callers of 
> add_pending_object() does not care", that is a sloppy attitude that 
> breaks maintainability of the code (because it forgets to add "in the 
> current code nobody looks at the new 'flags' field" to that excuse, and 
> also does not have any comments around this code that says so); it is 
> questionable if such a hack belongs to a patch that touches object.h.

I hope you appreciate our effort not to hack this into the 'mode' 
variable. That variable is exactly in the spirit you mentioned, so I 
figured we'd be fine with a similar approach.

Now that you have made clear that it is not fine, would you please care to 
enlighten me how you would prefer the change to look like that makes the 
argument parsing in revision.c remember which _refs_ (as opposed to 
_commits_) were marked uninteresting?

Thank you very much,
Johannes
