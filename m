From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Add support for parallel HTTP transfers
Date: Thu, 6 Oct 2005 16:07:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0510061550510.23242@iabervon.org>
References: <20051005214447.GF15593@reactrix.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 22:06:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENbwf-0006Z6-QD
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 22:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbVJFUCW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Oct 2005 16:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbVJFUCW
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Oct 2005 16:02:22 -0400
Received: from iabervon.org ([66.92.72.58]:62990 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751338AbVJFUCV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Oct 2005 16:02:21 -0400
Received: (qmail 30337 invoked by uid 1000); 6 Oct 2005 16:07:07 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Oct 2005 16:07:07 -0400
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20051005214447.GF15593@reactrix.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9780>

On Wed, 5 Oct 2005, Nick Hengeveld wrote:

> Add support for parallel HTTP transfers.  Prefetch populates a queue of
> objects to transfer and starts feeding requests to an active request
> queue for processing; fetch_object keeps the active queue moving
> while the specified object is being transferred.  The size of the active
> queue can be restricted using -r and defaults to 5 concurrent transfers.

Somewhat weirdly, the version of curl on my desktop doesn't actually have 
an implementation of curl_multi_info_read, although it's in the header 
file and documentation. So you'll want a version check somewhere, I think, 
which should probably just disable parallel transfers.

> ---
> 
> I could use extra eyes on this patch - it seems to be stable although I have
> seen periodic cases during testing where it detects an empty server response
> (from kernel.org?)  Are there implications to downloading a (potentially large)
> pack while objects contained in that pack have been prefetched and are in the
> transfer and/or active queue?

It should be fine to download objects and a pack that contains them at the 
same time, although there's currently a check in fetch.c which should be 
removed, so that it will call fetch() for an object if the object appears 
between the prefetch() and the fetch().

I should be able to review this over the weekend. What sort of performance 
are you getting at this point (in terms of bandwidth utilization)?

	-Daniel
*This .sig left intentionally blank*
