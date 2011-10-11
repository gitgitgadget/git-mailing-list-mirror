From: Jeff King <peff@peff.net>
Subject: Re: Re* [PATCH v3 19/22] resolve_ref(): emit warnings for
 improperly-formatted references
Date: Tue, 11 Oct 2011 18:54:34 -0400
Message-ID: <20111011225434.GA24142@sigill.intra.peff.net>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
 <1316121043-29367-20-git-send-email-mhagger@alum.mit.edu>
 <20111011161652.GA15629@sigill.intra.peff.net>
 <7vr52jfm8i.fsf@alter.siamese.dyndns.org>
 <7vmxd7flkw.fsf@alter.siamese.dyndns.org>
 <7v39ezffq5.fsf_-_@alter.siamese.dyndns.org>
 <20111011203903.GA23069@sigill.intra.peff.net>
 <7vpqi3dxkr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lars Hjemli <hjemli@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	cmn@elego.de, A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 00:54:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDlDf-000252-OC
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 00:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662Ab1JKWyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 18:54:37 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57883
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751491Ab1JKWyg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 18:54:36 -0400
Received: (qmail 5638 invoked by uid 107); 11 Oct 2011 22:54:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 11 Oct 2011 18:54:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Oct 2011 18:54:34 -0400
Content-Disposition: inline
In-Reply-To: <7vpqi3dxkr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183342>

On Tue, Oct 11, 2011 at 02:31:48PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > But in the code, it is spelled RENAMED-REF (with a dash). And as far as
> > I can tell, does not actually create a reflog. And it's not documented
> > anywhere, so I suspect nobody is using it. Maybe it is worth switching
> > that name.
> 
> Or even better get rid of it?

Fine by me. I'm not sure anyone is even aware that it exists. Just to
double-check, I grepped the list archives, and the biggest mention of it
was its presence causing a weird bug:

  http://thread.gmane.org/gmane.comp.version-control.git/143737

Googling turns up only confusion, nobody actually using it or
recommending that it be used.

OTOH, it does actually serialize branch renames, since we take a lock on
it. Maybe that's important. Cc'ing Lars. Certainly renaming it would be
the conservative choice.

-Peff

PS I mentioned above that it does not actually create a reflog. Digging
in the code more, I think it is capable of it, but my git.git clone had
RENAMED-REF, but no reflog. I would have thought core.logAllRefUpdates
would turn it on, but maybe there is a funny interaction with things not
in refs/.
