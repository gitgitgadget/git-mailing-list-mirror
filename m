From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] notes: do not accept non-blobs as new notes
Date: Wed, 9 May 2012 13:37:01 -0400
Message-ID: <20120509173701.GB30487@sigill.intra.peff.net>
References: <1336482692-30729-1-git-send-email-pclouds@gmail.com>
 <20120508160334.GA26838@sigill.intra.peff.net>
 <CACsJy8DHotHhF0ADDwjUZx5m8SGjXFuXV9fY=mfHmswyZxzeSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 09 19:37:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSAp6-0005Qc-O7
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 19:37:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755967Ab2EIRhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 May 2012 13:37:05 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37987
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754518Ab2EIRhE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 13:37:04 -0400
Received: (qmail 18600 invoked by uid 107); 9 May 2012 17:37:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 09 May 2012 13:37:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 May 2012 13:37:01 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8DHotHhF0ADDwjUZx5m8SGjXFuXV9fY=mfHmswyZxzeSQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197483>

On Wed, May 09, 2012 at 03:19:14PM +0700, Nguyen Thai Ngoc Duy wrote:

> > At the same time, is there any reason not to allow experimentation in
> > this area? We don't know what other people might be putting in their
> > private notes trees, and the current interface does allow this.
> >
> > Is this fixing some important problem that justifies making such
> > experimentation harder?
> 
> I was actually thinking about tree notes when I made this patch. I
> decided that if new git supports tree notes while old git does not,
> the old git should refuse to operate on tree notes so it won't cause
> any unintentional damages (e.g. appending a blob note to a tree note).
> It's too late to fix released git though, I don't know what to do in
> that case.

Hmm. I was thinking that we supported arbitrary sha1s as note values via
the command-line interface. But we don't; that is only the internal C
API, and it is quite difficult to do anything useful with non-blob notes
via the command-line interface. As you noticed, you can trick it into
doing so with "-C", but even "-c" has disastrous results (unless you
like dumping the binary tree object into your editor).

So the support from the command-line tool is pretty awful. And your
patches affected only that, not the internal API, which I find a more
likely candidate for people experimenting. So I take back my original
questions; I think using the command-line tool as-is on non-blob notes
is just crazy, and we are better to rigorously enforce that instead of
dumping binary junk on the user's terminal.

The slim possibility that somebody is using "git notes add -C" in
conjunction with parsing the output of "git notes list" to store trees
is probably not worth worrying about (it took me a long time to even
figure out if you _could_ have a usable workflow).

-Peff
