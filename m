From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Am able to delete a file with no trace in the log
Date: Tue, 02 Jun 2009 18:57:48 -0700
Message-ID: <7vfxeidqoz.fsf@alter.siamese.dyndns.org>
References: <EB2D87B9-3B03-431A-B204-C7799F9BA291@ausperks.net>
	<20090602213439.GA7584@coredump.intra.peff.net>
	<alpine.LFD.2.01.0906021439030.4880@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Graham Perks <gperks@ausperks.net>,
	Git List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 03 03:57:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBfjp-0006QU-03
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 03:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753113AbZFCB5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 21:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753040AbZFCB5r
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 21:57:47 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:45055 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507AbZFCB5r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 21:57:47 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090603015749.JXJF17135.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Tue, 2 Jun 2009 21:57:49 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id zDxo1b00J4aMwMQ03DxoBU; Tue, 02 Jun 2009 21:57:48 -0400
X-Authority-Analysis: v=1.0 c=1 a=vab_pU7WfN8A:10 a=vn0Xwkm_Dc8A:10
 a=Z4Rwk6OoAAAA:8 a=jmGJhQZHRjYCpRZOmIsA:9 a=cWPNHoY16ZfPMwwaDPgA:7
 a=tr0sDzFYvyyxpcS7Xjvcc8EdRgMA:4 a=jbrJJM5MRmoA:10
X-CM-Score: 0.00
In-Reply-To: <alpine.LFD.2.01.0906021439030.4880@localhost.localdomain> (Linus Torvalds's message of "Tue\, 2 Jun 2009 14\:55\:24 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120573>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> What happens is that "git log" with a filename will always simplify the 
> history to the side that matches. And yes, "matching" can and does include 
> "doesn't exist in child, doesn't exist in parent"
>
> Now, I admit that in this case the matching heuristic is dubious, and 
> maybe we should consider "does not exist in result" to not match any 
> parent. We already think that "all new" is special ("REV_TREE_NEW" vs 
> "REV_TREE_DIFFERENT"), so maybe we should think that "all deleted" is also 
> special ("REV_TREE_DEL")

Sorry, but I do not quite understand this comment.  REV_TREE_NEW can be
treated differently from REV_TREE_DIFFERENT but that only happens if you
know about --remove-empty option, and no scripted (and later converted to
C) Porcelain uses that option by default.

Also, and more on the topic of simplification, if one parent matches the
child (i.e. REV_TREE_SAME), the merge history is simplified by discarding
other parents, regardless of the nature of their differences, be they
REV_TREE_NEW or REV_TREE_DIFFERENT, so in that sense we do not even
special case REV_TREE_NEW at all for the purpose of merge simplification.
