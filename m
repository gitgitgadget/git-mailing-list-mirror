From: Jeff King <peff@peff.net>
Subject: Re: empty ident name trashes commit message
Date: Mon, 23 Jul 2012 14:46:34 -0400
Message-ID: <20120723184634.GA31905@sigill.intra.peff.net>
References: <CAMej=25=xj61pc+k42dv3byuBqUJzW21Sz+BXwoufqnKwV5Bbg@mail.gmail.com>
 <CAMej=270FDFxyVtKTC9v4KUSkSw+TBNOg+LbGfWOgmTe_xKiRQ@mail.gmail.com>
 <20120723172726.GA2463@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ramana Kumar <ramana@member.fsf.org>
X-From: git-owner@vger.kernel.org Mon Jul 23 20:46:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StNee-0007ha-2h
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 20:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754637Ab2GWSqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 14:46:40 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:59051 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751921Ab2GWSqi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 14:46:38 -0400
Received: (qmail 5608 invoked by uid 107); 23 Jul 2012 18:46:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 23 Jul 2012 14:46:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jul 2012 14:46:34 -0400
Content-Disposition: inline
In-Reply-To: <20120723172726.GA2463@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201957>

On Mon, Jul 23, 2012 at 01:27:26PM -0400, Jeff King wrote:

> On Sat, Jul 21, 2012 at 03:26:26PM +0100, Ramana Kumar wrote:
> 
> > If I forget to set user.email and user.name config options and do a commit
> > (possibly the --amend option also required to make this show up), then git
> > 1.7.11.2 will drops me into an editor for a commit message, then after that
> > complain with the fatal message:
> > 
> >    *** Please tell me who you are.
> > [...]
> 
> Hmm. I think this is an artifact of running --amend. In the normal case,
> we check the author ident beforehand. But in the --amend case, we take
> the existing author, but then fail trying to generate the committer
> ident. So we could probably do better by checking both explicitly
> beforehand.

It seems we already had such a check, but it was not done correctly.
This is fixed by patch 2 below.

> > The commit message I wrote is now lost. This is bad behaviour - the error
> > should happen before one writes the commit message, or the message should be
> > saved somewhere.
> 
> It's not lost. It's in .git/COMMIT_EDITMSG.
> 
> We could probably do a better job of informing the user of this when
> commit dies prematurely.

And patch 3 improves this situation.

  [1/3]: advice: pass varargs to strbuf_vaddf, not strbuf_addf
  [2/3]: commit: check committer identity more strictly
  [3/3]: commit: give a hint when a commit message has been abandoned

-Peff
