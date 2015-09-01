From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv4 3/3] submodule: implement `clone` as a builtin helper
Date: Tue, 1 Sep 2015 15:05:06 -0400
Message-ID: <20150901190506.GA8254@sigill.intra.peff.net>
References: <1441131869-29474-1-git-send-email-sbeller@google.com>
 <1441131869-29474-4-git-send-email-sbeller@google.com>
 <CAPig+cRxQdquKZXdmpiZjj8JFB2wdCE4UcbW6qYUwvtZsVw=ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 21:05:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWqrt-0007rP-7z
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 21:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754270AbbIATFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 15:05:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:53262 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752813AbbIATFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 15:05:09 -0400
Received: (qmail 14671 invoked by uid 102); 1 Sep 2015 19:05:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Sep 2015 14:05:09 -0500
Received: (qmail 4314 invoked by uid 107); 1 Sep 2015 19:05:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Sep 2015 15:05:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Sep 2015 15:05:06 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cRxQdquKZXdmpiZjj8JFB2wdCE4UcbW6qYUwvtZsVw=ug@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277030>

On Tue, Sep 01, 2015 at 02:52:54PM -0400, Eric Sunshine wrote:

> > +       /* Redirect the worktree of the submodule in the superproject's config */
> > +       if (strbuf_getcwd(&sb))
> > +               die_errno(_("unable to get current working directory"));
> > +
> > +       if (!is_absolute_path(sm_gitdir)) {
> > +               if (strbuf_getcwd(&sb))
> > +                       die_errno(_("unable to get current working directory"));
> 
> Why does this need to call getcwd() on 'sb' when it was called
> immediately above the conditional and its value hasn't changed?

Even weirder, the next code is:

> 
> > +               strbuf_addf(&sb, "/%s", sm_gitdir);
> > +               free(sm_gitdir);
> > +               sm_gitdir = strbuf_detach(&sb, NULL);
> > +       }
> > +
> > +
> > +       strbuf_addf(&sb, "/%s", path);

So if it _was_ an absolute path, we are adding "/$path" to nothing
(having just detached the strbuf in the conditional above). That seems
weird.

-Peff
