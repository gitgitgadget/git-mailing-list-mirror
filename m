From: Jeff King <peff@peff.net>
Subject: Re: git add --patch newfile doesn't add newfile to cache ?
Date: Wed, 22 Oct 2008 09:29:46 -0400
Message-ID: <20081022132946.GB17393@coredump.intra.peff.net>
References: <20081020143636.GB3988@gmx.de> <20081020235049.GA23120@coredump.intra.peff.net> <20081022131232.GL3988@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Marc Weber <marco-oweber@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 22 15:31:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ksdny-00036K-5d
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 15:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754829AbYJVN3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 09:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753765AbYJVN3t
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 09:29:49 -0400
Received: from peff.net ([208.65.91.99]:1045 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753509AbYJVN3s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 09:29:48 -0400
Received: (qmail 956 invoked by uid 111); 22 Oct 2008 13:29:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 22 Oct 2008 09:29:47 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Oct 2008 09:29:46 -0400
Content-Disposition: inline
In-Reply-To: <20081022131232.GL3988@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98867>

On Wed, Oct 22, 2008 at 03:12:32PM +0200, Marc Weber wrote:

> >  sub patch_update_cmd {
> > +	my @new = list_untracked();
> > +	if (@new) {
> > +		system(qw(git add -N), @new)
> > +			and die "git add reported failure";
> > +	}
> > +
>  
> 
> I've tried the patch. However I'm not fully satisified.
> I often use --patch to have another second look at each change to be
> committed. Your patch adds new files to the cache silently without
> giving the user the change to omit or edit the patch. But exatly that's
> the reason I'm using --patch. So maybe I can work on this in some days..
> Maybe I've also injected those lines into the wrong git version 
> (1.6.0.2.GIT)

Yes, you need to use the current 'master' branch for the "-N" feature.
The point of "-N" is to say "this is a file I want to track, but don't
add any contents yet." So it does your part 1:

>       1) when using git add --patch untracked-file the user should be
>          given the default patch view (only containing + lines)
>          so that he can use edit to only commit parts of the file in the
>          usual way. (I guess this is similar to having used git add -N
>          before, I haven't tried yet)

But not your part 2:

>       2) if he wants to skip the entire patch / file nothing should be
>          added to the index.

If you add _no_ contents, you still end up with the "this is a file I
want to track" part, but with no contents. And I agree it should stage
nothing, which is why this is an unsatisfactory solution (and why I
didn't clean up the patch and send it to Junio for inclusion).

-Peff
