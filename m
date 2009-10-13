From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC PATCH v2 07/16] remote-helpers: Fetch more than one ref in
 a batch
Date: Mon, 12 Oct 2009 23:56:43 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0910122326130.32515@iabervon.org>
References: <1255400715-10508-1-git-send-email-spearce@spearce.org> <1255400715-10508-8-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 13 05:58:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxYX8-0006rR-BJ
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 05:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754598AbZJMD5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 23:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754201AbZJMD5W
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 23:57:22 -0400
Received: from iabervon.org ([66.92.72.58]:55782 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751004AbZJMD5V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 23:57:21 -0400
Received: (qmail 26644 invoked by uid 1000); 13 Oct 2009 03:56:43 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Oct 2009 03:56:43 -0000
In-Reply-To: <1255400715-10508-8-git-send-email-spearce@spearce.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130123>

On Mon, 12 Oct 2009, Shawn O. Pearce wrote:

> Some network protocols (e.g. native git://) are able to fetch more
> than one ref at a time and reduce the overall transfer cost by
> combining the requests into a single exchange.  Instead of feeding
> each fetch request one at a time to the helper, feed all of them
> at once so the helper can decide whether or not it should batch them.
> 
> Because 'fetch' was already released in 1.6.5 we introduce the new
> fetch-multiple capability/command to signal that the helper wants
> to use batch oriented approach to fetching refs.

In 1.6.5, there's no way to call a helper other than git-remote-curl, and 
no way to call git-remote-curl unless 1.6.5 was built with it. So I think 
the protocol is not set in stone quite yet. It's documentated for being an 
API, and it's supposed to be that, but it's not quite there in this 
version.

I think it should be generally a good idea to have a start signal and an 
end signal for a block of fetches (and, with the foreign stuff, it would 
be useful to have transport-helper tell the helper process when it was 
done making requests, so the helper process could tell the gfi process to 
exit and stop consuming the helper process's output). At worst, if the 
helper doesn't care, it can just ignore this information.

	-Daniel
*This .sig left intentionally blank*
