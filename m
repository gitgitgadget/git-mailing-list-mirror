From: Jeff King <peff@peff.net>
Subject: Re: How to add custom metadata to Git commit object
Date: Mon, 30 May 2016 14:30:16 -0400
Message-ID: <20160530183016.GB17253@sigill.intra.peff.net>
References: <959E96F7-0FF3-4336-B098-58836136DB08@jetbrains.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
X-From: git-owner@vger.kernel.org Mon May 30 20:30:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7RxI-0000KX-C4
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 20:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161828AbcE3SaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 14:30:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:46126 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161799AbcE3SaU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 14:30:20 -0400
Received: (qmail 28054 invoked by uid 102); 30 May 2016 18:30:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 30 May 2016 14:30:19 -0400
Received: (qmail 16317 invoked by uid 107); 30 May 2016 18:30:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 30 May 2016 14:30:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 May 2016 14:30:16 -0400
Content-Disposition: inline
In-Reply-To: <959E96F7-0FF3-4336-B098-58836136DB08@jetbrains.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295922>

On Mon, May 30, 2016 at 08:58:08PM +0300, Kirill Likhodedov wrote:

> Is it possible to add custom metadata to Git commit object?  Such
> metadata should be ignored by Git commands, but could be used by a
> 3-party tool which knows the format and knows where to look.

Yes. The recommended place to stick this is in a "trailer" at the bottom
of the commit message, like:

  Rename-detection-hint: foo.java -> bar.java

or whatever scheme is useful to your tool.

> I assume that this should be possible, given that Git objects are
> actually patches, and patches can contain additional details. But can
> this be done with the help of Git commands?

Git objects aren't actually patches. Try:

  git cat-file commit HEAD

to see what an actual commit object looks like. You will see that there
are user-invisible headers before the commit message, too, but we do not
usually recommend people to add new headers here, as their semantics
would be unclear to git. For example, when rebasing such a commit,
should the header be preserved or not? It depends on its meaning.
Whereas commit messages are always preserved.

> There are git-notes, which could be used for the purpose, but they are
> visible to the user via standard Git command, and could be used by the
> user for other purposes, so they are not very suitable for the task.

Notes would work for this, too, but their main advantage is that they
can be created _after_ a commit has already been made (whereas anything
in the commit object itself will influence its sha1 id).

-Peff
