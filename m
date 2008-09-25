From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-submodule: remove unnecessary exits when calling
	resolve_relative_url
Date: Thu, 25 Sep 2008 07:54:07 -0700
Message-ID: <20080925145407.GM3669@spearce.org>
References: <200809221808.31730.johan@herland.net> <17c3c33dd7aa6803d7ac046f3e4dc0d5bb4c7234.1222341013.git.davvid@gmail.com> <48DB81DE.6070600@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Aguilar <davvid@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org, johan@herland.net, mlevedahl@gmail.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Sep 25 16:56:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KisG3-0007JR-KW
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 16:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752733AbYIYOyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 10:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752729AbYIYOyJ
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 10:54:09 -0400
Received: from george.spearce.org ([209.20.77.23]:43028 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447AbYIYOyI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 10:54:08 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 071A03835F; Thu, 25 Sep 2008 14:54:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <48DB81DE.6070600@viscovery.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96774>

Johannes Sixt <j.sixt@viscovery.net> wrote:
> David Aguilar schrieb:
> > resolve_relative_url calls die() when no remote url exists so these calls to
> > exit can be removed.
> ...
> > @@ -155,7 +155,7 @@ cmd_add()
> >  	case "$repo" in
> >  	./*|../*)
> >  		# dereference source url relative to parent's url
> > -		realrepo=$(resolve_relative_url "$repo") || exit
> > +		realrepo=$(resolve_relative_url "$repo")
> >  		;;
> 
> Did you test it? The command inside $(...) is run in its own sub-process,
> therefore, the die() does not exit the caller, just the sub-process, and
> the || exit *is* required.
> 
> BTW, I think that || exit is sufficient; you don't need to add another
> error message - the one that resolve_relative_url() prints is sufficient.

Exactly.

I think we just need a "|| exit" after each of these
$(resolve_relative_url) calls.  The original patch that
started this discussion just needs a "|| exit".

die with an additional message is just too verbose.


-- 
Shawn.
