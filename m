From: Jeff King <peff@peff.net>
Subject: Re: Save notes state when releasing
Date: Fri, 20 Sep 2013 06:34:01 -0400
Message-ID: <20130920103401.GB21684@sigill.intra.peff.net>
References: <CAC9WiBh3ha61M789DL==Nch30P_mvGwDLODqNzwaAbmHtyhPkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 20 12:34:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMy2S-0003HU-2D
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 12:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754366Ab3ITKeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Sep 2013 06:34:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:44909 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754195Ab3ITKeL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Sep 2013 06:34:11 -0400
Received: (qmail 10412 invoked by uid 102); 20 Sep 2013 10:34:11 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 20 Sep 2013 05:34:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Sep 2013 06:34:01 -0400
Content-Disposition: inline
In-Reply-To: <CAC9WiBh3ha61M789DL==Nch30P_mvGwDLODqNzwaAbmHtyhPkQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235065>

On Fri, Sep 20, 2013 at 07:38:17AM +0200, Francis Moreau wrote:

> I'm using notes in my project. I'm wondering if it's possible to save
> the state of the notes when I'm releasing/tagging a new version of my
> project so I can restore the saved notes state if I checkout back the
> old release.
> 
> Therefore I would be able to inspect notes (which may have been
> removed or modified after the release) as they were when the release
> happened.

The notes are stored as git trees, so you can point a "tag" ref at a
particular state, just as you would with a normal branch. The "git tag"
command expects to create refs under "refs/tags", whereas "git notes"
expects to find notes under "refs/notes". The simplest thing is to just
use "git update-ref" rather than "git tag" to create the pointer. Like:

  $ git update-ref refs/notes/v1.0 refs/notes/commits

and then you can always view the v1.0 notes as:

  $ git --notes=v1.0 log

You can even set the notes.displayRef config to always show v1.0 notes
when they are available for a commit. Though if they are a subset of the
current notes, you would expect to see duplicates. Depending on what you
are storing in your notes, you may want to clean out your notes tree
after the release.

-Peff
