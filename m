From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 1/2] git_remote_cvs: Honor DESTDIR in the Makefile
Date: Sun, 16 Aug 2009 14:03:01 -0700
Message-ID: <20090816210300.GB23522@gmail.com>
References: <7v7hx35ym1.fsf@alter.siamese.dyndns.org> <1250455088-23457-1-git-send-email-davvid@gmail.com> <alpine.DEB.1.00.0908162251360.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, johan@herland.net, git@vger.kernel.org,
	barkalow@iabervon.org, mhagger@alum.mit.edu
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Aug 16 23:03:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mcmsl-0005yA-Kq
	for gcvg-git-2@lo.gmane.org; Sun, 16 Aug 2009 23:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755692AbZHPVDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2009 17:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754732AbZHPVDG
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 17:03:06 -0400
Received: from mail-pz0-f196.google.com ([209.85.222.196]:43896 "EHLO
	mail-pz0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753387AbZHPVDE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2009 17:03:04 -0400
Received: by pzk34 with SMTP id 34so1662560pzk.4
        for <git@vger.kernel.org>; Sun, 16 Aug 2009 14:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=CZZlYVDDh2mQcolnuCsteA0J8LnuCueuWK7ogXeS69E=;
        b=FWtvxQm2Hz0bh6u6iSEjMFjIX8zNUEbAXK0tFqgej1o8B7A87WFluwiH8BfcH8fbwi
         TGyBLMPuNtnPqCFBuGaOBIXr9T3ySZawWwrYAxSSYm4ARs17Ndwyuqg1XikSV4dBxkae
         mbsCNG4xv6J8LxxyeMz/WL4fDJ9zWfhtLTTBw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KmVcyJ8nliLAORQzki5a94au/W2q4aFKPJ8NQ0PuIYOtVrc4tvR6BSXpq4Y60LCPKV
         iyxFxn3eitrpzZpdY+uJO1jqYPkeinm455dsl78spdCBqR9qifNHcsKnhuiVXxuCl9fZ
         GAbne0uYgRZvBBdNk1MtkUCRSGEQvUIVshZ/s=
Received: by 10.115.75.9 with SMTP id c9mr819840wal.60.1250456586092;
        Sun, 16 Aug 2009 14:03:06 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id d20sm8641775waa.47.2009.08.16.14.03.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 16 Aug 2009 14:03:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0908162251360.8306@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126076>

On Sun, Aug 16, 2009 at 10:55:29PM +0200, Johannes Schindelin wrote:
> Hi,
> 
> On Sun, 16 Aug 2009, David Aguilar wrote:
> 
> > diff --git a/git_remote_cvs/Makefile b/git_remote_cvs/Makefile
> > index 8dbf3fa..f52c096 100644
> > --- a/git_remote_cvs/Makefile
> > +++ b/git_remote_cvs/Makefile
> > @@ -3,6 +3,15 @@
> >  #
> >  pysetupfile:=setup.py
> >  
> > +# Setup the DESTDIR for Python.
> > +ifeq ($(DESTDIR),)
> > +PYTHON_DESTDIR = /
> 
> Hmm.  I think this would break on msysGit.  Not that anybody worked on 
> getting Python to compile on msysGit.
> 
> (Just to make sure you understand the issue: on msysGit, we set prefix to 
> "" (and I think DESTDIR somehow ends up taking on the same value).  Now, 
> when DESTDIR is set to "/" and something wants to be copied to 
> $(DESTDIR)/something, the latter expands to //something, which tells MSys 
> not to expand //something to the correct Windows path.


I see.  Hmm.. setup.py is a real pain.

I'll see if we rework this so that we end up passing "" to
--root instead of /.  I'm going to be gone for a few hours so
probably won't be able to try it out until tonight.

Another thing to consider --

Debian once submitted a bug against another Python app asking
that we not place modules in site-packages unless we
plan on having other applications importing those modules.

The more appropriate place for them if we don't plan on that is
$(prefix)/share/git-core/git_remote_cvs or something like that.

I guess that's another thing to think about.

-- 
		David
