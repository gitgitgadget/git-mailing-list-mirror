From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] diff text conversion filter
Date: Tue, 7 Oct 2008 11:46:46 -0400
Message-ID: <20081007154646.GB26531@coredump.intra.peff.net>
References: <20080928161106.GA30199@coredump.intra.peff.net> <vpqk5ctfyp6.fsf@bauges.imag.fr> <20080930164545.GA20305@sigill.intra.peff.net> <20081005214114.GA21875@coredump.intra.peff.net> <48E9B036.6090805@viscovery.net> <vpqtzbpwy9h.fsf@bauges.imag.fr> <20081007012044.GA4217@coredump.intra.peff.net> <48EAF902.3040402@viscovery.net> <20081007060014.GA7965@coredump.intra.peff.net> <vpqprmdlylq.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Oct 07 17:55:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnEmz-0005Uf-Vw
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 17:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753675AbYJGPqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 11:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753661AbYJGPqt
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 11:46:49 -0400
Received: from peff.net ([208.65.91.99]:4040 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753302AbYJGPqs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 11:46:48 -0400
Received: (qmail 2411 invoked by uid 111); 7 Oct 2008 15:46:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 07 Oct 2008 11:46:47 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Oct 2008 11:46:46 -0400
Content-Disposition: inline
In-Reply-To: <vpqprmdlylq.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97719>

On Tue, Oct 07, 2008 at 08:15:45AM +0200, Matthieu Moy wrote:

> One proposal: have a diff.<driver>.activate with several values:
> 
> * "always": activate the diff driver in any porcelain
> * "diff": activate it only for "git diff", as currently
> * "singlefile": Johannes's heuristic proposal
> 
> That way, one could say easily "activate exiftags filter all the time,
> but MS-Word only when I request a diff for a single file", and this
> leaves room for other values if the need be. Well, there's no room for
> "use MS-Word native diff tool in git-gui but antiword/catdoc +
> textconv in 'git log -p'" here, but do we want it?
> 
> Or is all that just overkill?

Actually, as soon as I read the first part of your mail I thought of the
"ms-word vs antiword" situation. The example you gave seems plausible.
And it seems to me that it is really a superset of the problem we are
discussing. That is, gitattributes is really just saying "this is a
'foo' type file". And if we have a mechanism flexible enough to say "in
this situation, this is how you handle 'foo' type files", then that
would work as the basis for implementing these heuristics.

For example, maybe you could set up some mapping like:

  git diff --diffdriver=foo,bar

where a file with gitattribute diff=x would look for the driver config
for x.foo, then x.bar, and then finally fall back to just x. Then you
could easily have (ignoring the fact that I'm not sure about the config
syntax for having _3_ section parts):

  git config diff.doc.graphical.command ms-word-diff-script
  git config diff.doc.textconv antiword

and then git-gui would be configured to diff with:

  git diff --diffdriver=graphical

whereas a regular "git diff" would always fall back to
"diff.doc.textconv". Make sense?

-Peff
