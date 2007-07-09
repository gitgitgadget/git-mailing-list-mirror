From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v2] Make fetch-pack a builtin with an internal API
Date: Mon, 9 Jul 2007 02:37:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0707090142130.6977@iabervon.org>
References: <Pine.LNX.4.64.0707090104120.6977@iabervon.org>
 <7vwsxaw2xu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 08:37:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7msN-0000Oq-9r
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 08:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbXGIGhg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 02:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbXGIGhg
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 02:37:36 -0400
Received: from iabervon.org ([66.92.72.58]:2555 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751069AbXGIGhf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 02:37:35 -0400
Received: (qmail 30125 invoked by uid 1000); 9 Jul 2007 06:37:34 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Jul 2007 06:37:34 -0000
In-Reply-To: <7vwsxaw2xu.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51963>

On Sun, 8 Jul 2007, Junio C Hamano wrote:

> Are _identifiers with leading underscore Kosher thing to do, I
> wonder...  We do have ones with trailing ones (mostly qsort
> functions) and I think they are done that way for the sake of
> standards conformance.

I'm not sure; I inherited that bit of code from Julian. Do we have a 
standard idiom for a function that sets a bunch of static variables?

> diff --git a/fetch-pack.h b/fetch-pack.h
> new file mode 100644
> index 0000000..2bd05a8
> --- /dev/null
> +++ b/fetch-pack.h
> @@ -0,0 +1,16 @@
> +#ifndef FETCH_PACK_API
> 
> We seem to say "#ifndef FETCH_PACK_H" in such a case, though.

I was trying to convey that this is the C API to call fetch-pack directly, 
rather than something used by the builtin, or by the wrapper for calling 
the builtin. But the inclusion guard is probably not going to be noticed 
anyway, and I don't think it's worth making the header filename verbose.

> Nobody seems to call setup_fetch_pack() yet.  How complete is
> this patch meant to be?

It's part of a series that leads up to making fetch a builtin. I'm trying 
to get in bits that are bounded by logical APIs. The roadmap here is that 
transport.{c,h} from one of my other patches will get a function to fetch 
a set of refs, and it will (for a suitable URL format) call 
setup_fetch_pack() with the appropriate options and then call 
fetch_pack(). builtin-fetch will use this function to actually get objects 
once it has determined which ones it should get.

I think I've now got the whole series to a point where everything's 
submittable, if you'd like to see the whole thing. It's actually composed 
of 6 initial independant sub-series (mostly single patches) of which I've 
submitted 4 (three today and the one that modularizes the commit-walker 
infrastructure and removes the obsolete ones), and a final series of 3 
that implements fetch on top of the rest. How should I number this?

	-Daniel
*This .sig left intentionally blank*
