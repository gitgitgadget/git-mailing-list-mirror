From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH 2/3] gitweb: Cache $parent_commit info in git_blame()
Date: Wed, 10 Dec 2008 12:05:30 -0800 (PST)
Message-ID: <710873.22344.qm@web31806.mail.mud.yahoo.com>
References: <200812101615.55340.jnareb@gmail.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 21:07:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAVKc-0005mP-LU
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 21:06:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753967AbYLJUFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 15:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753607AbYLJUFc
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 15:05:32 -0500
Received: from web31806.mail.mud.yahoo.com ([68.142.207.69]:43186 "HELO
	web31806.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753232AbYLJUFc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Dec 2008 15:05:32 -0500
Received: (qmail 25497 invoked by uid 60001); 10 Dec 2008 20:05:30 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:X-Mailer:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=Qej88PZl/+zh7ln/q3xDZJymj/82d1wXav2znLHDJi03/xSrL0HiAxU1Dh31fZrLcwRKLvs9ZJ2OyAHtyaPgiSvPOKbz26GnXgNFojnGmIRu2/v0QpWIR44XtcYYfSzZClP59XHudv+2O2IunTP0mr5jaTwQxpWEEvh1scSA7kc=  ;
Received: from [71.132.209.19] by web31806.mail.mud.yahoo.com via HTTP; Wed, 10 Dec 2008 12:05:30 PST
X-Mailer: YahooMailWebService/0.7.260.1
In-Reply-To: <200812101615.55340.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102709>


--- On Wed, 12/10/08, Jakub Narebski <jnareb@gmail.com> wrote:
> > Have you tested this patch that it gives the same
> commit chain
> > as before it?
> 
> The only difference between precious version and this patch
> is that
> now, if you calculate sha-1 of $long_rev^, it is stored in 
> $metainfo{$long_rev}{'parent'} and not calculated
> second time.

Yes, I agree a patch to this effect would improve performance
proportionally to the history of the lines of a file.  So it's a
good thing, as most commits change a contiguous block of size more
than one line of a file.

"$parent_commit" depends on "$full_rev^" which depends on "$full_rev".
So as soon as "$full_rev" != "$old_full_rev", you'd know that you need
to update "$parent_commit".  "$old_full_rev" needs to exist outside the
scope of "while (1)".  I didn't see this in the code or in the patch.

> But I have checked that (at least for single example file)
> the blame output is identical for before and after this patch.

I've always tested it on something like "gitweb.perl", etc.

    Luben
