From: David Aguilar <davvid@gmail.com>
Subject: Re: git-mergetool: wrap tools with 3 files only to use the BASE
 file instead of MERGED
Date: Thu, 11 Aug 2011 01:38:38 -0700
Message-ID: <20110811083835.GA29507@gmail.com>
References: <20110810160356.GA32126@ortolo.eu>
 <20110810161211.GC4076@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tanguy Ortolo <tanguy+debian@ortolo.eu>, git@vger.kernel.org,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Charles Bailey <charles@hashpling.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 11 10:38:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrQmq-0000pb-NQ
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 10:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753309Ab1HKIil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 04:38:41 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:34978 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709Ab1HKIii (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 04:38:38 -0400
Received: by iye16 with SMTP id 16so875849iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 01:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=hQq7olrIPIeZEBhqmU/tWK0hO7ayYaH672W934M0k5U=;
        b=hw7PLME0E10LPsaEpTJ1bPA7mou8pWR4tErSmeS2oDur6Elq0l4qG1TD12K8n2JFb1
         YZb82+6cPmYSZ53aodTBeC/+xG3gScBrNrH4SL+igFHpIxCq4iIf/qqcsrsZsVFGgern
         uP/9zsAagsG3ScVJMk7exWLDEe4tGiA5Xc3GA=
Received: by 10.231.56.160 with SMTP id y32mr11905791ibg.68.1313051918276;
        Thu, 11 Aug 2011 01:38:38 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id v16sm1351432ibf.8.2011.08.11.01.38.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 01:38:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110810161211.GC4076@elie.gateway.2wire.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179091>

On Wed, Aug 10, 2011 at 11:12:11AM -0500, Jonathan Nieder wrote:
> (+cc: some relevant people)
> Hi,
> 
> Tanguy Ortolo wrote[1]:
> 
> > git-mergetool ideally uses tools that work with 4 files: BASE, LOCAL,
> > REMOTE, which are the usual original and two new version of the file,
> > and MERGED, which is where the tool is supposed to write the result of
> > the merge.
> >
> > The problem is that most tools, at least graphical ones, specifically
> > meld, can only work with three files, as they save the result to the
> > original file.
> >
> > git-mergetool currently handles this situation by passing MERGED LOCAL
> > REMOTE to the tool. This could be fine, but unfortunately MERGE contains
> > the conflicts, formatted for manual resolution, so it is not really
> > appropriate as an original file.
> >
> > I think it would be better to wrap such merge tools by:
> > 1. passing them BASE LOCAL REMOTE;
> > 2. checking whether or not BASE hase been modified:
> >    * if it has, then copying it to MERGED,
> >    * if it has not, exiting with return code 1 (merge failed).
> > This check can be by either saving and comparing the mdate, or perhaps
> > the SHA-1 hash of the BASE file.
> >
> > If this sounds good enough, I can dive into git-mergetoo--lib and
> > implement it. In the meantime, here is an example of a custom merge tool
> > that wraps meld for that purpose.
> 
> I think you forgot to include the example.  Anyway, at first glance it
> sounds like a sensible idea.  David et al: thoughts?

I think it sounds like a good thing for certain tools.
Sebastian mentioned it being fine in ecmerge and bc3.
xxdiff also lets you specify the output file, so it
probably wouldn't need it either, I think.

If the patch touches individual tools that need it, e.g. meld,
I say go for it.

> Regards,
> Jonathan
> 
> [1] http://bugs.debian.org/637355

cheers,
-- 
					David
