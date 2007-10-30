From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 10/10] push: teach push to be quiet if local ref is strict
 subset of remote ref
Date: Tue, 30 Oct 2007 14:00:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0710301306210.7357@iabervon.org>
References: <1193593581312-git-send-email-prohaska@zib.de>
 <11935935812741-git-send-email-prohaska@zib.de> <1193593581114-git-send-email-prohaska@zib.de>
 <1193593581486-git-send-email-prohaska@zib.de> <11935935812185-git-send-email-prohaska@zib.de>
 <11935935822846-git-send-email-prohaska@zib.de> <11935935821136-git-send-email-prohaska@zib.de>
 <11935935823045-git-send-email-prohaska@zib.de> <11935935821800-git-send-email-prohaska@zib.de>
 <11935935823496-git-send-email-prohaska@zib.de> <11935935821192-git-send-email-prohaska@zib.de>
 <7vfxztm2dx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 19:01:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImvP9-0000eI-4R
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 19:01:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754328AbXJ3SA0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 14:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754620AbXJ3SA0
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 14:00:26 -0400
Received: from iabervon.org ([66.92.72.58]:50136 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754267AbXJ3SAY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 14:00:24 -0400
Received: (qmail 30746 invoked by uid 1000); 30 Oct 2007 18:00:22 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Oct 2007 18:00:22 -0000
In-Reply-To: <7vfxztm2dx.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62719>

On Tue, 30 Oct 2007, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
> 
> > git push now allows you pushing a couple of branches that have
> > advanced, while ignoring all branches that have no local changes,
> > but are lagging behind their matching remote refs. This is done
> > without reporting errors.
> >
> > Thanks to Junio C. Hamano <gitster@pobox.com> for suggesting to
> > report in the summary that refs have been ignored.
> 
> I do not think this is a good idea at all.  Furthermore, I never
> suggested anything about summary.  You are robbing the
> information from the pusher which ones are pushed and which ones
> are left behind.

I think this case should be a warning rather than an error, though. It is 
certainly true that the user isn't intending to update those remote refs, 
because there is no local change to update them with. And it is also true 
that those local refs being stale is no impediment to updating the refs 
which are not stale, which is what the user does intend to do. I can't see 
a workflow which would be hurt by this change, because we know that, if 
the user follows the instructions and then tries the push again, it will 
have no effect.

If the concern is robbing the user of information, we should simply 
provide the information, rather than interrupting the user's work to make 
them act on the information before completing the essentially independant 
operation they're attempting.

In any case, it's misleading to suggest that the user "pull first", 
because we know that there would be no effect to pushing again after 
merging. In this case, it would be more accurate to suggest that the user 
"pull instead". Perhaps the message should be
"%s: nothing to push to %s, but you are not up-to-date and may want to 
pull"

	-Daniel
*This .sig left intentionally blank*
