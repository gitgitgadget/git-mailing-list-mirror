From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Fix signal handler
Date: Tue, 9 Feb 2010 18:49:05 -0500 (EST)
Message-ID: <alpine.LNX.2.00.1002091812290.14365@iabervon.org>
References: <4B684F5F.7020409@web.de> <20100202205849.GA14385@sigill.intra.peff.net> <4B71A2EE.8070708@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Wed Feb 10 00:49:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NezpT-0003GL-08
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 00:49:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653Ab0BIXtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 18:49:10 -0500
Received: from iabervon.org ([66.92.72.58]:57465 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754586Ab0BIXtI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 18:49:08 -0500
Received: (qmail 18310 invoked by uid 1000); 9 Feb 2010 23:49:05 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Feb 2010 23:49:05 -0000
In-Reply-To: <4B71A2EE.8070708@web.de>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139462>

On Tue, 9 Feb 2010, Markus Elfring wrote:

> 
> >
> > If you can demonstrate a practical problem and provide a patch, then I
> > am sure people would be happy to read it.
> >   
> 
> I need a few further clarifications on this issue to choose a potential fix.
> 
> I have noticed that the variable "show_early_output" gets a value
> assigned only at a few places in the source code. I wonder that the set
> pointer is only used by the function "limit_list" to call the function
> "log_show_early" on demand.
> http://git.kernel.org/?p=git/git.git;a=blob;f=revision.c;h=3ba6d991f6e9789949c314c2981dfc6b208a6f66;hb=HEAD#l683
> 
> I find that a simple flag would be sufficient. I see no need to handle
> different function pointers here. Do any objections exist to achieve the
> same effect with the data type "sig_atomic_t"?

In that particular instance, there's actually a comment that says it uses 
an int (which is almost certainly what sig_atomic_t is, but sig_atomic_t 
might not be defined on some actual platforms). Making the code match the 
comment, at least, would be good.

In particular, function pointers are more likely than other pointers to be 
not a machine word. I'm pretty sure that an IA64 machine could potentially 
have a race with a small window here.

As to whether to use int (as the comment says) or sig_atomic_t, I don't 
really have any idea which would have fewer problems.

	-Daniel
*This .sig left intentionally blank*
