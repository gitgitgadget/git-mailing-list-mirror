From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] push -s: skeleton
Date: Fri, 9 Sep 2011 11:22:48 -0400
Message-ID: <20110909152248.GA28480@sigill.intra.peff.net>
References: <7vfwk82hrt.fsf@alter.siamese.dyndns.org>
 <7vbouw2hqg.fsf@alter.siamese.dyndns.org>
 <20110908193555.GC16064@sigill.intra.peff.net>
 <7vy5xywyk8.fsf@alter.siamese.dyndns.org>
 <20110908210217.GA32522@sigill.intra.peff.net>
 <CAJo=hJsQvRN3Z0xJg9q37Km1g_1qUdJKNQ6n8=a9mv3YjugyVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Sep 09 17:22:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R22uv-0001hD-HX
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 17:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755306Ab1IIPWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 11:22:51 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58281
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755286Ab1IIPWu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 11:22:50 -0400
Received: (qmail 31195 invoked by uid 107); 9 Sep 2011 15:23:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 09 Sep 2011 11:23:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Sep 2011 11:22:48 -0400
Content-Disposition: inline
In-Reply-To: <CAJo=hJsQvRN3Z0xJg9q37Km1g_1qUdJKNQ6n8=a9mv3YjugyVw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181077>

On Thu, Sep 08, 2011 at 03:07:25PM -0700, Shawn O. Pearce wrote:

> A notes tree per ref is ugly when you have a lot of branches. Its a
> problem when you merge commits from say "maint" over to "master" 2
> days after they were initially pushed. Ideally the notes tree for
> master also includes what you brought over.

I agree you can end up with a lot of refs if you have a lot of branches,
and that may get a bit unwieldy.  I don't see how the merge thing is a
problem, though. If you do the merge at a client, then those commits
will hit master by push, and you'll get entries in the cert tree for
master. If you do the merge locally, then there's not going to be a
signature on those commits hitting the master ref, no matter what the
storage scheme.

> However, maybe it is reasonable for a protocol extension to support
> "auto-notes-merge" on a refs/notes/ ref if the client asks for it in
> the send-pack/receive-pack command stream? Clients could push notes
> and have the server automatically merge the client's pushed commit
> into the notes tree, either by fast-forward or by performing an
> automatic notes merge, with concat being applied to non-identical
> notes on the same SHA-1. This would allow the client to prepare his
> local certificate, and push that notes tree, while still working
> around the race on the server side.
> 
> If the server doesn't support the protocol extension, the client can
> still push his signed notes, he just may run into a race with another
> concurrent user pushing into the same repository. Which then means
> that an upgrade of the server is really only important/necessary if
> you have "central repository" model that a lot of users push into. If
> you use the traditional workflow that GitHub encourages of per-user
> repositories, you would never have a race on the server, and wouldn't
> need the upgraded server binary with "auto-notes-merge".

I like this approach, as the protocol extension provides the minimal
building block that can be used to implement this, or any other
notes-related scheme.

-Peff
