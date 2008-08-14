From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [PATCH 2/3] git-daemon: make the signal handler almost a no-op
Date: Thu, 14 Aug 2008 12:13:07 +0200
Message-ID: <20080814101307.GG9680@cuci.nl>
References: <20080813084330.30845.89753.stgit@aristoteles.cuci.nl> <20080813084331.30845.74788.stgit@aristoteles.cuci.nl> <7v1w0sjw47.fsf@gitster.siamese.dyndns.org> <20080814001858.GB14939@cuci.nl> <7v63q4ieqw.fsf@gitster.siamese.dyndns.org> <20080814074717.GC9680@cuci.nl> <7vljz0dmtj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 12:14:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTZqR-0002mo-1H
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 12:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098AbYHNKNK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 06:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752991AbYHNKNK
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 06:13:10 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:37465 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683AbYHNKNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 06:13:09 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 668415465; Thu, 14 Aug 2008 12:13:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vljz0dmtj.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92342>

Junio C Hamano wrote:
>"Stephen R. van den Berg" <srb@cuci.nl> writes:
>> Solution A is what you propose, but which I find less appealing because
>> any future magic to actually setup the handler needs to be maintained
>> and updated in two places.

>Well, A is attractive because it leaves the window open for us to later
>not rearming it unconditionally from child_handler().  I happen to think
>that the interface we will use to call "signal()" is much less likely to
>change than what we would do in child_handler().

Then that is the fundamental difference in maintainability-views.
I find it more likely that we change the interface to setup the signal
handler (in a future OS or by changing the way you invoke it), than 
that the actual work done by the signal handler is changed.

But since your view carries more weight here, I'll adapt the patch to
solution A.

>> Solution C is what follows your train of thought better, because it
>> future-proofs the setup as well as the handler.

>"setup", but "setup" and "rearm" as separate functions.  Perhaps "setup"
>may start using sigaction() with SA_RESETHAND cleared, and we can make
>"rearm" truly a no-op everywhere.

>From a portability standpoint using sigaction is worse than signal, and
rearming the handler even when it is not required is not a big deal.
-- 
Sincerely,
           Stephen R. van den Berg.

"Hold still, while I inject you with SQL."
