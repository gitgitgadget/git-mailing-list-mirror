From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] Try harder to find a remote when on a detached HEAD or
	non-tracking branch.
Date: Tue, 19 Jun 2012 21:31:50 +0200
Message-ID: <20120619193114.GA461@book.hvoigt.net>
References: <1340038866-24552-1-git-send-email-marcnarc@xiplink.com> <7vaa004j9f.fsf@alter.siamese.dyndns.org> <4FDFA030.7080408@xiplink.com> <7vmx402rru.fsf@alter.siamese.dyndns.org> <4FE08797.50509@xiplink.com> <7vipen191a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 21:32:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh49j-0006EK-Gl
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 21:32:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754659Ab2FSTb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 15:31:57 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.31]:39463 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753043Ab2FSTb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 15:31:56 -0400
Received: from [77.20.33.80] (helo=localhost)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Sh49X-0004gz-EO; Tue, 19 Jun 2012 21:31:51 +0200
Content-Disposition: inline
In-Reply-To: <7vipen191a.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200229>

Hi,

On Tue, Jun 19, 2012 at 10:55:13AM -0700, Junio C Hamano wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
> 
> > On 12-06-18 06:12 PM, Junio C Hamano wrote:
> > ...
> >> That reliance of "origin" is what made me think that "not guessing
> >> and blindly assuming" a wrong thing to do.
> >
> > I think git can do better than erroring out, though.
> >
> >> It is OK that your build usesdetached HEAD, but if that is the case
> >> shoudln't it be the one deciding which specific remote it wants to
> >> take the updated sources from, and telling Git to do so?
> >
> > Sure, but I feel it did that already when it cloned.  It seems reasonable for
> > the submodules to default to using the remote specified when the super-repo
> > was cloned.
> 
> I do not have a strong opinion either way, other than that I would
> prefer predictable behaviour over "works most of the time provided
> if the user does X, otherwise does this random thing".  And coming
> from that standpoint, erroring out when there needs a guess involved
> is certainly more predictable---it is a cop-out option for me in
> areas of the system I do not have strong preferences.
> 
> If you can work with submodule people (it is good that you Cc'ed
> Jens) to come up with a solution to make everything always use
> 'origin' when unconfigured in a consistent way, without breaking
> existing users who rely on the current behaviour, that would be
> good.  Or a solution with a predictable behaviour you come up with
> may end up being something more involved than "just use 'origin'
> when you do not know". As long as the end result can be easily
> explained to end users, I wouldn't have any objection.

Using the first configured remote as a fallback also sounds quite
arbitrary to me. Your current HEAD might have nothing to do with that
remote.

Before falling back to origin how about guessing the remote from the
first branch thats contained in HEAD?

To me that sounds quite natural. The first branch could be ambiguous so
we would have to come up with some ordering. Maybe a depth search and
first parents first? Or a breadth first search with younger generations
first and then first parents first?

Would that work for your use case Marc?

Cheers Heiko
