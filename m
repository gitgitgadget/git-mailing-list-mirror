From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 04/12] t: stop using GIT_CONFIG to cross repo boundaries
Date: Mon, 24 Mar 2014 18:00:11 -0400
Message-ID: <20140324220011.GI13728@sigill.intra.peff.net>
References: <20140320231159.GA7774@sigill.intra.peff.net>
 <20140320231524.GD8479@sigill.intra.peff.net>
 <xmqqtxars0ph.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Tran <unsignedzero@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 23:00:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSCus-0002mu-Gr
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 23:00:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbaCXWAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 18:00:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:46163 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750790AbaCXWAN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 18:00:13 -0400
Received: (qmail 10384 invoked by uid 102); 24 Mar 2014 22:00:13 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Mar 2014 17:00:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Mar 2014 18:00:11 -0400
Content-Disposition: inline
In-Reply-To: <xmqqtxars0ph.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244886>

On Fri, Mar 21, 2014 at 02:26:02PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Some tests want to check or set config in another
> > repository. E.g., t1000 creates repositories and makes sure
> > that their core.bare and core.worktree settings are what we
> > expect. We can do this with:
> >
> >   GIT_CONFIG=$repo/.git/config git config ...
> >
> > but it better shows the intent to just enter the repository
> > and let "git config" do the normal lookups:
> >
> >   (cd $repo && git config ...)
> >
> > In theory, this would cause us to use an extra subshell, but
> > in all such cases, we are actually already in a subshell.
> 
> Sure; alternatively we could use "git -C $there", but this rewrite
> is fine by me.

The existing callers all pass actual $GIT_DIRs, so I initially wrote it
as "git --git-dir=$repo config ...". Doing it as "-C" is perhaps nicer,
as callers could potentially pass a shorter string to the repo root,
and not bother with adding "/.git". However, t0001 needs the actual
$GIT_DIR (because it looks for things like the refs/ directory in the
same function), and the other callers are just passing bare repos.

So I'm fine with any of them. Feel free to mark it up if you have a
preference.

-Peff
