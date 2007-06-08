From: linux@horizon.com
Subject: Re: [PATCH/RFC] filter-branch: support skipping of commits more easily
Date: 7 Jun 2007 22:11:57 -0400
Message-ID: <20070608021157.18066.qmail@science.horizon.com>
To: git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Fri Jun 08 04:12:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwTxN-0007gP-Vn
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 04:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763802AbXFHCMA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 22:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763753AbXFHCMA
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 22:12:00 -0400
Received: from science.horizon.com ([192.35.100.1]:19719 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1760152AbXFHCMA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 22:12:00 -0400
Received: (qmail 18069 invoked by uid 1000); 7 Jun 2007 22:11:57 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49424>

> I think that is fine; in effect, by saying "skip" B, you are
> squashing B-C into C'.
> 
> Does this mean that, given
> 
>           C---D---E
>          /   /
>         A---B
> 
> and if commit-filter says "skip" on D, the written history would
> look like this?
> 
>           C'------E'
>          /       /
>         A'--B'--'
> 
> The new commit E' would become an evil merge that has difference
> between D and E in the original history?
> 
> I am not objecting; just trying to get a mental picture.

I think, for compatibility with the existing git path limiter,
it should delete D from the history only if:
1) Told to skip D, and
2) Told to skip B or C (or both).

So you could get A--B--E' or A--C--E' or even A--E', but D would only
be deleted if it wasn't needed as a merge marker.

That's probably a little more complex to implement, but it feels like
The Right Thing.
