From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] update-index: add --swap to swap index and worktree
 content
Date: Wed, 17 Aug 2011 12:46:22 -0700
Message-ID: <20110817194621.GA352@sigill.intra.peff.net>
References: <1313158058-7684-1-git-send-email-pclouds@gmail.com>
 <7vippxgm6y.fsf@alter.siamese.dyndns.org>
 <20110816210108.GA13710@sigill.intra.peff.net>
 <7vbovpggva.fsf@alter.siamese.dyndns.org>
 <20110816222212.GA19471@sigill.intra.peff.net>
 <7vzkj9eza2.fsf@alter.siamese.dyndns.org>
 <20110816230654.GA21793@sigill.intra.peff.net>
 <CACsJy8Ad4xPz79jT3O64c3XsCeM8XETJ9bnjK0aisagrYN0CMA@mail.gmail.com>
 <20110817021727.GA29585@sigill.intra.peff.net>
 <CAOeW2eFx-ETS+1a5b2bUXeT8JJ0WGudKGyF6mxuqyK2OM35qQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 17 21:46:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qtm4P-0000Gj-PA
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 21:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890Ab1HQTq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Aug 2011 15:46:28 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58126
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752588Ab1HQTq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2011 15:46:28 -0400
Received: (qmail 14387 invoked by uid 107); 17 Aug 2011 19:47:07 -0000
Received: from 206.111.142.135.ptr.us.xo.net (HELO sigill.intra.peff.net) (206.111.142.135)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 17 Aug 2011 15:47:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Aug 2011 12:46:22 -0700
Content-Disposition: inline
In-Reply-To: <CAOeW2eFx-ETS+1a5b2bUXeT8JJ0WGudKGyF6mxuqyK2OM35qQA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179531>

On Wed, Aug 17, 2011 at 10:13:08AM -0400, Martin von Zweigbergk wrote:

> >> Two reasons. I already mentioned the ability to quickly checkout index
> >> for a quick test (though there could be more problems down that road).
> >
> > That's a good thought. However, in practice, I find I also need other
> > files from the index to do a successful test. So I end up just
> > committing what I think is right, and then afterwards do:
> 
> Maybe a stupid question, but "update-index --swap" would swap all
> files, right? So what "other files from the index" would there be?

Hmm. I hadn't really considered swapping everything. I suppose that
would work, though I do worry about getting into a confused state when
you have swapped one or more files individually, and then want to swap
the rest out for testing.

That is, there is no flag to say "this file was swapped", so there is no
way to say "swap all of the index files out, except those I have already
swapped". But if you were disciplined to only do:

  git update-index --swap
  $EDITOR foo.c
  make test
  git update-index --swap

and never:

  git update-index --swap foo.c
  $EDITOR foo.c
  git update-index --swap ;# oops, we put the WT foo.c back
  make test
  git update-index --swap

then it would work.

-Peff
