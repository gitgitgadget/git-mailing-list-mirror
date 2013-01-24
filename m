From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] git-cvsimport.txt: cvsps-2 is deprecated
Date: Thu, 24 Jan 2013 20:13:30 +0000
Message-ID: <20130124201330.GT7498@serenity.lan>
References: <7va9s0n8gv.fsf@alter.siamese.dyndns.org>
 <20130122234554.GI7498@serenity.lan>
 <7vobgglpv4.fsf@alter.siamese.dyndns.org>
 <20130123092858.GJ7498@serenity.lan>
 <7vsj5rhlfs.fsf@alter.siamese.dyndns.org>
 <20130123211237.GR7498@serenity.lan>
 <7vip6ndveb.fsf@alter.siamese.dyndns.org>
 <20130124191845.GS7498@serenity.lan>
 <7v7gn2bb5w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>,
	Chris Rorvick <chris@rorvick.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 21:20:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyTHM-0005kL-5w
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 21:20:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190Ab3AXUTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 15:19:39 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:35211 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932123Ab3AXUTd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 15:19:33 -0500
X-Greylist: delayed 350 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Jan 2013 15:19:33 EST
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 6F4BFCDA5D2;
	Thu, 24 Jan 2013 20:13:41 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KifOyjUrOyhB; Thu, 24 Jan 2013 20:13:40 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 62D41CDA60D;
	Thu, 24 Jan 2013 20:13:33 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7v7gn2bb5w.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214451>

On Thu, Jan 24, 2013 at 12:04:11PM -0800, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > git-cvsimport relies on version 2 of cvsps and does not work with the
> > new version 3.  Since cvsps 3.x does not currently work as well as
> > version 2 for incremental import, document this fact.
> >
> > Specifically, there is no way to make new git-cvsimport that supports
> > cvsps 3.x and have a seamless transition for existing users since cvsps
> > 3.x needs a time from which to continue importing and git-cvsimport does
> > not save the time of the last import or import into a specific namespace
> > so there is no safe way to calculate the time of the last import.
> 
> Isn't the whole "and git-cvsimport does not save the time..."  part
> something that can be fixed in the new cvsimport that reads the
> output from cvsps3?

Yes it can be fixed there (and I have patches to do that) - my argument
here is that there cannot be a seamless upgrade for people who are
currently using git-cvsimport incrementally.  If you don't have that
file then how do you create it to reflect the current state of your
repository?

> To me, it sounds more like
> 
>     cvsps2 + cvsimport has an unfixable bugs and there have been an
>     effort to rewrite cvsps2 from scratch.  The resulting cvsp3
>     currently is unusable with cvsimport, especially when importing
>     the history incrementally, and it isn't expected that it will
>     ever be usable with cvsimport again.

cvsps3 isn't a re-write, it's cvsps2 with a lot of things ripped out and
a fast-export mode added.  And in fast-export mode it cannot inspect the
Git repository in the same way that git-cvsimport does.

>     There are other tools that analyse the original history better
>     and emits more correct output when used to convert the whole
>     history, and hopefully cvsps3 + fast-import would become one of
>     them.  Suggest users to use them instead of cvsimport when they
>     are not doing an incremental import.

Yes.  The consensus seems to be that cvs2git is the most correct.

> By the way, do we want to make any recommendation to the distro
> folks which cvsps they should ship?  It appears that not shipping
> cvsps2 would be a major regression if cvsps3 does not plan to
> support incrementals, so shipping both might be the safest way for
> them to support their users with different needs.

I agree.  cvsps is only one binary and a man page so I don't think it
would be too hard to ship both.


John
