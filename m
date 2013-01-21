From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] Hiding some refs in ls-remote
Date: Mon, 21 Jan 2013 18:01:08 -0500
Message-ID: <20130121230108.GB17156@sigill.intra.peff.net>
References: <1358555826-11883-1-git-send-email-gitster@pobox.com>
 <20130119165042.GB12307@sigill.intra.peff.net>
 <7vpq0zn2za.fsf@alter.siamese.dyndns.org>
 <7vip6rjyn3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, spearce@spearce.org, mfick@codeaurora.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 00:01:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxQMu-00006i-D7
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 00:01:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875Ab3AUXBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 18:01:11 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41776 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752418Ab3AUXBK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 18:01:10 -0500
Received: (qmail 20381 invoked by uid 107); 21 Jan 2013 23:02:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 Jan 2013 18:02:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Jan 2013 18:01:08 -0500
Content-Disposition: inline
In-Reply-To: <7vip6rjyn3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214169>

On Sun, Jan 20, 2013 at 02:08:32PM -0800, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Jeff King <peff@peff.net> writes:
> >
> >>> 	[uploadPack]
> >>> 		hiderefs = refs/changes
> >>
> >> Would you want to do the same thing on receive-pack? It could benefit
> >> from the same reduction in network cost (although it tends to be invoked
> >> less frequently than upload-pack).
> > ...
> > As I said, I view this primarily as solving the cluttering issue.
> > The use of hiderefs to hide these refs that point at objects I do
> > not consider belong to my repository from the pushers equally makes
> > sense as such, I think.
> 
> Now that raises one question.  Should this be transfer.hiderefs that
> governs both upload-pack and receive-pack?  I tend to think the
> answer is yes.

Yes, that is what I was getting at (and it should have individual
hiderefs for each side that override the transfer.*, in case somebody
wants to make the distinction).

> It may even make sense to have "git push" honor it, excluding them
> from "git push --mirror" (or "git push --all" if some of the
> branches are hidden); I haven't thought things through, though.

That is harder, as that is something that happens on the client. How
does the client learn about the transfer.hiderefs setting on the remote?
It has to be out-of-band, at which point calling it by the same name has
little benefit.

-Peff
