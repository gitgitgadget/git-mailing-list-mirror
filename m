From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Git's database structure
Date: Wed, 5 Sep 2007 12:12:28 -0400
Message-ID: <9e4733910709050912i57ed7137o6abb02ee741d394b@mail.gmail.com>
References: <9e4733910709040823k731f0ffchba1f93bdb4a8373d@mail.gmail.com>
	 <7vtzqany0z.fsf@gitster.siamese.dyndns.org>
	 <9e4733910709041044r71264346n341d178565dd0521@mail.gmail.com>
	 <20070904212507.GA24434@thunk.org>
	 <9e4733910709041454i189e6629k78ddeb89797276b3@mail.gmail.com>
	 <46DE5861.4050201@op5.se>
	 <9e4733910709050641j34d58683ra72caa52c56cdf0f@mail.gmail.com>
	 <46DEC26E.7030809@op5.se>
	 <9e4733910709050837o61a2dedfpc5f72a239b1cb8e3@mail.gmail.com>
	 <Pine.LNX.4.64.0709051648400.3189@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Andreas Ericsson" <ae@op5.se>, "Theodore Tso" <tytso@mit.edu>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Julian Phillips" <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Wed Sep 05 18:12:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISxUZ-0005lR-TY
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 18:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756666AbXIEQMa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 12:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756488AbXIEQMa
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 12:12:30 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:8540 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756602AbXIEQM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 12:12:29 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2638697wah
        for <git@vger.kernel.org>; Wed, 05 Sep 2007 09:12:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cESrDBfDLhRLMmevOZvltnP0dfy5iu1wgoNoLKvELz7bCgqtXz2Z5YVS8ASyugEZh3H7yOhYF1xvbs3s+mmf1/6fGHEDEeCcSmaDeN0hbkHhgw1G0zzSi9Z0CE2iJfFqAW4IOc2UiCQfrQWep8NDwspzls/eaxaGizYa1nlQP0U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P4fUyjxIE4ezDnnWzWnrrU+b/OxD8xBZyR28zOw1sZRbIxPPmkyX3G7iSvIp+t6tud7Qq67pVetccHlop4CBCBXqdlpQnB1gPFJI/cXjx7bWz2f+KJd/khEhHqB2/zoch/xYGuPPri/0l1/opDn1Gg32x+XGFB1eXlJtcWjuuHs=
Received: by 10.114.200.2 with SMTP id x2mr1635611waf.1189008748663;
        Wed, 05 Sep 2007 09:12:28 -0700 (PDT)
Received: by 10.114.195.5 with HTTP; Wed, 5 Sep 2007 09:12:28 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0709051648400.3189@reaper.quantumfyre.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57719>

On 9/5/07, Julian Phillips <julian@quantumfyre.co.uk> wrote:
> On Wed, 5 Sep 2007, Jon Smirl wrote:
>
> > On 9/5/07, Andreas Ericsson <ae@op5.se> wrote:
> >> Jon Smirl wrote:
> >>>
> >>> The path name field needs to be moved back into the blobs to support
> >>> alternative indexes. For example I want an index on the Signed-off-by
> >>> field. I use this index to give me the SHAs for the blobs
> >>> Signed-off-by a particular person. In the current design I have no way
> >>> of recovering the path name for these blobs other than a brute force
> >>> search following every path looking for the right SHA.
> >>>
> >>
> >> Ah, there we go. A use-case at last :)
>
> But not a brilliant one.  You sign off on commits not blobs.  So you go
> from the sign-off to paths, then to blobs.  There is no need to go from
> blob to path unless you deliberately introduce such a need.

Use blame for an example. Blame has to crawl every commit to see if it
touched the file. It keeps doing this until it figures out the last
author for every line in the file. Worse case blame has to crawl every
commit in the data store.

> >>
> >> So now we have a concrete problem that we can formulate thus:
> >> "How can one create a database listing the relationship between 'signers'
> >> and blobs?"
> >>
> >> So the second question: Do you seriously argue that git should take a
> >> huge performance loss on its common operations to accommodate a need that
> >> I suspect very few people have?
> >
> > Why do you keep jumping to a performance loss? Both schemes will have
> > an index based on paths. The problem is how those indexes are
> > constructed, not the existence of the index. Moving the paths into the
> > blobs in no way prevents you from creating an index on that field.
>
> But moving the path into the blob _IS_ the perfomance hit.  You lose the
> ability to tell the two files have the same content _without even looking
> at the blob_.  This is one of the core parts of making git operations
> blindingly fast.  You can't throw that out, and then say that there is no
> performance hit.
>
> You keep talking about abstract database performance - but git is not an
> abstract database.  It has very specific common usage patterns, and is
> optomisied to handle them.
>
> >
> > The problem is that the SHAs have been intertwined with the tree
> > nodes. This blending has made it impossible to create other indexes on
> > the blobs.
> >
> > The path index in the flat scheme will probably look just like tree
> > nodes do today but these new tree nodes won't be intertwined with the
> > SHAs.
>
> And you will have to prove that diff/merge etc. don't become very much
> slower before you get buy in.
>
> --
> Julian
>
>   ---
> Many receive advice, few profit by it.
>                 -- Publilius Syrus
>


-- 
Jon Smirl
jonsmirl@gmail.com
