From: Jeff King <peff@peff.net>
Subject: Re: Can't diff against the 00000000 revision
Date: Tue, 12 Jan 2016 10:37:58 -0500
Message-ID: <20160112153757.GB8041@sigill.intra.peff.net>
References: <jwv4meiygrc.fsf-monnier+gmane.comp.version-control.git@gnu.org>
 <20160112153239.GA8041@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Stefan Monnier <monnier@iro.umontreal.ca>
X-From: git-owner@vger.kernel.org Tue Jan 12 16:38:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ11K-0002Nl-Am
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 16:38:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760109AbcALPiB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 10:38:01 -0500
Received: from cloud.peff.net ([50.56.180.127]:52285 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753305AbcALPiA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 10:38:00 -0500
Received: (qmail 3711 invoked by uid 102); 12 Jan 2016 15:38:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jan 2016 10:38:00 -0500
Received: (qmail 15086 invoked by uid 107); 12 Jan 2016 15:38:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jan 2016 10:38:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jan 2016 10:37:58 -0500
Content-Disposition: inline
In-Reply-To: <20160112153239.GA8041@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283823>

On Tue, Jan 12, 2016 at 10:32:39AM -0500, Jeff King wrote:

> > I currently work around the problem by adding a dummy empty branch, but
> > being able to use the revision 00000000 as a known reference to an empty
> > tree would come in really handy, and since it's already used at various
> > places in Git (post-receive hook and "git show" output, at least), it
> > would seem like a natural extension.
> 
> The empty tree also has a name:
> 
>   $ git hash-object -t tree /dev/null
>   4b825dc642cb6eb9a060e54bf8d69288fbee4904

By the way, the empty tree and empty blob objects are baked-in to git,
so you can always rely on diffing against them. IOW, it is fine to
write:

  while read old new ref; do
	if test "$old" = "0000000000000000000000000000000000000000"; then
		old=4b825dc642cb6eb9a060e54bf8d69288fbee4904
	fi
	git diff-tree $old $new | whatever_checks_you_want_to_do
  done

in your post-receive hook.

-Peff
