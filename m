From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/4] Prepare testsuite for a "git clone" that packs refs
Date: Sun, 15 Jun 2008 11:04:07 -0700 (PDT)
Message-ID: <m3bq22poby.fsf@localhost.localdomain>
References: <200806151602.03445.johan@herland.net>
	<200806151605.47214.johan@herland.net>
	<20080615175418.GB6127@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jun 15 20:06:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7wbC-0007Ly-TI
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 20:05:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758869AbYFOSEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 14:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758856AbYFOSEM
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 14:04:12 -0400
Received: from hu-out-0506.google.com ([72.14.214.233]:10132 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758753AbYFOSEK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 14:04:10 -0400
Received: by hu-out-0506.google.com with SMTP id 28so5985045hub.21
        for <git@vger.kernel.org>; Sun, 15 Jun 2008 11:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=CV9aMjbGojWz4Qf7a2GBjoDGaySTRh9jQ0vM5WPO0iU=;
        b=YoaW8l4RdscVwl4zEtv2fSQfrJ3nqXih3SsGwpgxsX0aJRkfiBPSzovqZO/mmYcdOi
         qNF/bho2M8L7bmL0n6QBTrR88cIbDn+IxDNKjC0GbxGzqTeiJszPSuJXzZ1oJr2FTKfC
         F+BIZxA5d8/BbCYDug6Zg0eNJxprKn2TOiu+8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=kZI8OIZnFGqIzQtBCXAOsrUeaSl8O4Qn9JIHAZ03i8lIohTTpGQe2ri3dqbO5OIdRD
         9rxK46l23Zn25fdxJkZdMk5a74b2N2IxGEEINhxnXLDjiUoml62nFnyfI9WJp/bxfoDo
         LTme1qsQQw6VHT0sF3AZBbRYgUFgUpIdBTIWk=
Received: by 10.67.106.13 with SMTP id i13mr4889941ugm.75.1213553048613;
        Sun, 15 Jun 2008 11:04:08 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.223.105])
        by mx.google.com with ESMTPS id e1sm6825194ugf.71.2008.06.15.11.04.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Jun 2008 11:04:07 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5FI45r1013148;
	Sun, 15 Jun 2008 20:04:05 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5FI42Gn013145;
	Sun, 15 Jun 2008 20:04:02 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080615175418.GB6127@sigill.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85105>

Jeff King <peff@peff.net> writes:

> On Sun, Jun 15, 2008 at 04:05:47PM +0200, Johan Herland wrote:
> 
> > .git/packed-refs. This patch therefore teaches t5515-fetch-merge-logic
> > to also remove the refs in question from the packed-refs file.
> > [...]
> > +			cat .git/packed-refs | \
> > +			while read sha1 refname
> > +			do
> > +				case "$sha1" in
> > +				^*) # remove peeled tags
> > +					;;
> > +				*)
> > +					case "$refname" in
> > +					refs/heads/*|\
> > +					refs/remotes/rem/*|\
> > +					refs/tags/*) # remove same as above
> > +						;;
> > +					*) # keep everything else
> > +						echo "$sha1 $refname"
> > +						;;
> > +					esac
> > +				esac
> > +			done > .git/packed-refs.new
> > +			mv .git/packed-refs.new .git/packed-refs
> 
> Might it not be simpler to just convert it to use plumbing to delete the
> refs? Something like piping for-each-ref into update-ref -d?

Or use git-for-each-ref with --shell option to generate code for
deleting refs?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
