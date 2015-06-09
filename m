From: Jeff King <peff@peff.net>
Subject: Re: On undoing a forced push
Date: Tue, 9 Jun 2015 10:25:51 -0400
Message-ID: <20150609142550.GB7894@peff.net>
References: <20150609121221.GA14126@lanh>
 <5576F2DC.7040603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 16:26:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2KTX-0004Ep-RJ
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 16:26:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753647AbbFIOZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 10:25:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:43368 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753452AbbFIOZy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 10:25:54 -0400
Received: (qmail 9248 invoked by uid 102); 9 Jun 2015 14:25:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Jun 2015 09:25:54 -0500
Received: (qmail 15322 invoked by uid 107); 9 Jun 2015 14:25:57 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Jun 2015 10:25:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Jun 2015 10:25:51 -0400
Content-Disposition: inline
In-Reply-To: <5576F2DC.7040603@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271183>

On Tue, Jun 09, 2015 at 07:36:20PM +0530, Sitaram Chamarty wrote:

> > This patch prints the latest SHA-1 before the forced push in full. He
> > then can do
> > 
> >     git push <remote> +<old-sha1>:<ref>
> > 
> > He does not even need to have the objects that <old-sha1> refers
> > to. We could simply push an empty pack and the the remote will happily
> > accept the force, assuming garbage collection has not happened. But
> > that's another and a little more complex patch.
> 
> If I am not mistaken, we actively prevent people from downloading an
> unreferenced SHA (such as would happen if you overwrote refs that
> contained sensitive information like passwords).
> 
> Wouldn't allowing the kind of push you just described, require negating
> that protection?

No, this has always worked. If you have write access to a repository,
you can fetch anything from it with this trick. Even if we blocked this,
there are other ways to leak information. For instance, I can push up
objects that are "similar" to the target object, claim to have the
target object, and then hope git will make a delta between my similar
object and the target. Iterate on the "similar" object and you can
eventually figure out what is in the target object.

This is one of the reasons we do not share objects between public and
private forks at GitHub.

-Peff
