From: Jeff King <peff@peff.net>
Subject: Re: missing objects -- prevention
Date: Sun, 13 Jan 2013 07:30:36 -0500
Message-ID: <20130113123036.GA498@sigill.intra.peff.net>
References: <CAMK1S_jpofLRO02XTYryOP98g7rnrJXs7Mh2zvi=SoVUAs0dUw@mail.gmail.com>
 <20130111164202.GB5219@sigill.intra.peff.net>
 <CAMK1S_jN7=Antz-5D7yf0KV8m-YEy93tZP_zziTXPDzbdyjUrw@mail.gmail.com>
 <20130112131358.GB21875@sigill.intra.peff.net>
 <CAMK1S_iKARYqi_Dv90og0No7NN=WxFg+ixmRvnkvfdrcOi1r=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 13 13:31:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuMiS-00026p-LA
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:31:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754893Ab3AMMas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2013 07:30:48 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:59908 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754886Ab3AMMar (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:30:47 -0500
Received: (qmail 7656 invoked by uid 107); 13 Jan 2013 12:32:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 13 Jan 2013 07:32:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 13 Jan 2013 07:30:36 -0500
Content-Disposition: inline
In-Reply-To: <CAMK1S_iKARYqi_Dv90og0No7NN=WxFg+ixmRvnkvfdrcOi1r=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213338>

On Sun, Jan 13, 2013 at 06:26:53AM +0530, Sitaram Chamarty wrote:

> > Right, I meant if you have receive.fsckObjects on. It won't help this
> > situation at all, as we already do a connectivity check separate from
> > the fsck. But I do recommend it in general, just because it helps catch
> > bad objects before they gets disseminated to a wider audience (at which
> > point it is often infeasible to rewind history). And it has found git
> > bugs (e.g., null sha1s in tree entries).
> 
> I will add this.  Any idea if there's a significant performance hit?

Not usually; we are already resolving all of the sent deltas as a
precaution, anyway. I do notice after a push to GitHub there is
sometimes a second or two of pause from the server before the push
status is shown. But I haven't narrowed it down to fsck (versus
connectivity check, versus our post-receive hook).

So you may want to keep an eye on the effects (and if you have numbers,
please share :) ).

> That's always the hard part.  System admins (at the Unix level) insist
> there's nothing wrong and no disk errors and so on...  that is why I
> was interested in network errors causing problems and so on.

Yeah, I feel bad saying "well, this repo is totally corrupted, but it
couldn't possibly be git's fault, because that's not what its failure
modes look like". But luckily our Ops people are very understanding, and
most of the problems I have seen have turned out to be fs corruption
after all (the pack-refs things is the big exception).

> Thanks once again for your patient replies!

No problem. There aren't many people dealing with large-scale
server-side issues, so it's something that doesn't come up much on the
list. I'm happy to talk about it.

-Peff
