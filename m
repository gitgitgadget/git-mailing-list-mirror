From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: use "spurious .sp" XSLT if
	DOCBOOK_SUPPRESS_SP is set
Date: Wed, 1 Apr 2009 09:06:36 -0400
Message-ID: <20090401130636.GA29113@coredump.intra.peff.net>
References: <7vljql4586.fsf@gitster.siamese.dyndns.org> <1238575834-17838-1-git-send-email-chris_johnsen@pobox.com> <20090401103442.GD26181@coredump.intra.peff.net> <DDA1F213-D15C-49B3-90CB-557F9A465A6A@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org
To: Chris Johnsen <chris_johnsen@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 15:08:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp0B5-0006gO-IX
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 15:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754406AbZDANGu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 09:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754224AbZDANGu
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 09:06:50 -0400
Received: from peff.net ([208.65.91.99]:42818 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752206AbZDANGt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 09:06:49 -0400
Received: (qmail 17452 invoked by uid 107); 1 Apr 2009 13:07:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 01 Apr 2009 09:07:04 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Apr 2009 09:06:36 -0400
Content-Disposition: inline
In-Reply-To: <DDA1F213-D15C-49B3-90CB-557F9A465A6A@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115390>

On Wed, Apr 01, 2009 at 07:19:08AM -0500, Chris Johnsen wrote:

>> In the course of your SVN research, did you find the fixes between
>> 1.73.1 and 1.74.3 that fixed the spacing issue? If so, I wonder if it's
>> worth backporting that fix to DOCBOOK_FIX_LIST_SPACING.
>
> I guess you are referring to an issue different from the one created by 
> using the "spurious .sp" simpara template, but I am not familiar with 
> another one. If not, then I am confused. The new patch to avoid using the 
> "spurious .sp" template fixes the list spacing in pu's git-cvsimport.1 
> when I generate it here (using docbook-xsl 1.74.0). For example, the extra 
> blank line after "Problems related to timestamps:" goes away and a new 
> blank line is inserted before "Problems related to branches:".

Sorry, I should have been more clear (it seems we have enough docbook
problems to cause confusion in referring to them :) ).  What I meant is:

  The original issue which caused me to investigate this, namely the
  extra blank line before a list and the missing blank line after the
  list, is present in 1.73 but not in 1.74 (I tested only with 1.74.3,
  but your statement above leads me to believe it is fixed in 1.74.0).

  Is it worth including a fix in our docbook templates to make it look
  right for people on 1.73?

> My poking around in the docbook SVN repo was largely limited to the  
> manpages/block.xsl file since that is where the normal simpara template 
> lives. If this other issue is list specific, it seems likely that fixes 
> would be in manpages/lists.xsl. It looks like there have only been around 
> ten commits to that lists.xsl since 1.73.1, but none of them jumped out at 
> me as likely culprits unless the spacing you mean is indentation or 
> "bullet"-to-text spacing (though my brain is tired right now).

Hmm. I think part of the fix is actually in param.xsl, which contains:

    <!-- * squeeze multiple .sp instances into a single .sp-->
    <substitution oldstring=".sp&#10;.sp" newstring=".sp"/>

in 1.74, but not 1.73.

I am torn on whether it makes sense to try backporting this. Debian
stable, at least, will be on 1.73 for quite a long time. On the other
hand, the problem is relatively minor (it is ugly, but you can still
read the text) and I'm not sure we want to get into pulling random fixes
from upstream docbook-xsl; it could turn into a huge time sink.

-Peff
