From: Deskin Miller <deskinm@umich.edu>
Subject: Re: [RFC PATCH 1/4] Refactor builtin-verify-tag.c
Date: Thu, 27 Nov 2008 19:18:47 -0500
Message-ID: <20081128001847.GB29662@euler>
References: <1227497000-8684-1-git-send-email-deskinm@umich.edu> <1227497000-8684-2-git-send-email-deskinm@umich.edu> <alpine.DEB.1.00.0811241147490.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 28 01:20:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5r5g-00028K-2h
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 01:20:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752666AbYK1ASz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 19:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752548AbYK1ASz
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 19:18:55 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:27343 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449AbYK1ASy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 19:18:54 -0500
Received: by yx-out-2324.google.com with SMTP id 8so507095yxm.1
        for <git@vger.kernel.org>; Thu, 27 Nov 2008 16:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:sender;
        bh=hXcjHdXmjw/s3zQk6v4L8YnsxWrDzqDaLM3tGHj0Hu4=;
        b=xmRVIpnoI/s3Qm9Deqg57C0rAWRiu/2EXRkQa1Rze/314ZO30pQHp7N3klK7Bm1He8
         xFuUdA3TEPGLTQndeb1PfIejzCa3v5sv9g3Hfd+nuBNSf5fs6gVd64itc1wYpUiOvjyz
         PLVndPCW9/TSJ032afV6YoYQdq7TdzB1cEJlA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent:sender;
        b=dMsxeizG0BT1cP+3Wg3sYvK4KBdAmKEs1MDHnKiApCNtUOnGN1q1uJOjkteJNjyYer
         MmzusXHlawwcnzSMw8QtV/eLWBCfmPGsQqqNwG5xqzLaU9R4Wjd2zQXciX3FH3aDriCZ
         HntFg8oo8MmQj0hzYmxTznEFBfAwexnIrqnSQ=
Received: by 10.64.249.6 with SMTP id w6mr8042637qbh.16.1227831532429;
        Thu, 27 Nov 2008 16:18:52 -0800 (PST)
Received: from euler ([68.40.49.130])
        by mx.google.com with ESMTPS id p31sm803956qbp.18.2008.11.27.16.18.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 Nov 2008 16:18:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0811241147490.30769@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101848>

On Mon, Nov 24, 2008 at 12:04:59PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Sun, 23 Nov 2008, Deskin Miller wrote:
> 
> > builtin-verify-tag.c didn't expose any of its functionality to be used
> > internally.  Refactor some of it into new verify-tag.c and expose
> > verify_tag_sha1 able to be called from elsewhere in git.
> > 
> > Signed-off-by: Deskin Miller <deskinm@umich.edu>
> > ---
> >  Makefile             |    2 +
> >  builtin-verify-tag.c |   61 ++-------------------------------------
> >  verify-tag.c         |   77 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  verify-tag.h         |   10 ++++++
> >  4 files changed, 93 insertions(+), 57 deletions(-)
> >  create mode 100644 verify-tag.c
> >  create mode 100644 verify-tag.h
> 
> I'll comment on the output of "format-patch -n -C -C" instead, as that 
> makes it much easier to see what you actually did:

Didn't realise -C -C was the magic incantation; I'll remember it for the
future.

> >  Makefile                             |    2 +
> >  builtin-verify-tag.c                 |   61 ++-------------------------------
> >  builtin-verify-tag.c => verify-tag.c |   48 ++++-----------------------
> >  verify-tag.h                         |   10 +++++
> >  4 files changed, 23 insertions(+), 98 deletions(-)
> >  copy builtin-verify-tag.c => verify-tag.c (56%)
> >  create mode 100644 verify-tag.h
> >
> > [...] 
> > diff --git a/builtin-verify-tag.c b/verify-tag.c
> > similarity index 56%
> > copy from builtin-verify-tag.c
> > copy to verify-tag.c
> > index 729a159..c9be331 100644
> > --- a/builtin-verify-tag.c
> > +++ b/verify-tag.c
> > @@ -1,18 +1,12 @@
> >  /*
> > - * Builtin "git verify-tag"
> > + * Internals for "git verify-tag"
> 
> Agree.
> 
> >   *
> > - * Copyright (c) 2007 Carlos Rica <jasampler@gmail.com>
> > + * Copyright (c) 2008 Deskin Miller <deskinm@umich.edu>
> 
> Disagree.
> 
> Even if Carlos seemed to stop his work on Git entirely, which I find 
> disappointing, you are _not_ free to pretend his work is yours.  And given 
> this diff:
> [...] 
> I think pretty much all you did was deleting (and thereby you do not gain 
> any copyright).

I realised my mistake in altering the copyright information just after
sending out these patches.  I think I'd written the header first in
verify-tag.c before copying the code in; though I couldn't say what I
thought I'd be writing that would end up protected by copyright.  At any
rate, it was an honest mistake, and I apologise, Carlos, for my
unintended plagarism; I'll be sure to restore the proper copyright
notice for any subsequent versions.

> Except for one change: why on earth did you think it a good idea to 
> suppress telling the user the _name_ of the tag when an error occurs?
> 
> I, for one, would find it way less than helpful to read
> 
> 	Cannot verify a non-tag object of type blob.
> 
> than to read
> 
> 	refs/tags/dscho-key: cannot verify a non-tag object of type blob.
>
> Besides, I do not see where you warn that "tag <name> not found."  Changes 
> like this one need to be justified (by saying in the commit message where 
> the warning is already issued, and not letting the reviewer/reader leave 
> wondering).

The verify_tag_sha1 function is newly exposed to the rest of git, and
has a different signature from verify_tag, which could take a ref while
verify_tag_sha1 takes a sha1.  verify_tag still includes both the checks
you refer to before calling verify_tag_sha1, so the error output is
identical in all cases before and after applying this patch.

The OBJ_TAG check, however, is duplicated so that internal git calls to
verify_tag_sha1 can't pass in e.g. a blob sha1 which just happens to
contain the same contents as a signed tag.

Actually, I initially did not leave the OBJ_TAG check in verify_tag, but
relied on it checking the return value of verify_tag_sha1 to see if an
error occurred, and printing 'Failed to verify <name>' in that case, for
precisely the reason you point out, that the ref name is very useful in
this failure case.  However, I ultimately decided to duplicate the check
so that the error output would match up exactly.
 
> Please, next time you submit a patch like this, do the -C -C yourself.  
> Letting all the reviewers do it looks lousy on the overall time balance 
> sheet, and it may also lead to a potential reviewer preferring to do 
> something else instead.

Will do; thanks for reviewing in spite of my shortcomings.

> Now, Junio already said that he is not (yet) convinced that this change 
> should be in Git proper, rather than a hook, so it is up to you to decide 
> if you deem it important enough to try harder to convince people.
> 
> I, for one, would think that it may be a good change: AFAIK only hard-core 
> gits use hooks, everybody else avoids them.  So if we deem verifying 
> signatures important enough, we might want to have better support for it 
> than some example hooks.
> 
> So color me half-convinced.
> 
> Ciao,
> Dscho

Deskin Miller 
