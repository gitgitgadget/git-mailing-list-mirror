From: Corey Thompson <cmtptr@gmail.com>
Subject: Re: git-p4 out of memory for very large repository
Date: Fri, 23 Aug 2013 07:48:56 -0400
Message-ID: <20130823114856.GA8182@jerec>
References: <20130823011245.GA7693@jerec>
 <52170C6A.4080708@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Fri Aug 23 13:49:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCprg-0004hZ-Pn
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 13:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755397Ab3HWLtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 07:49:12 -0400
Received: from mail-gh0-f180.google.com ([209.85.160.180]:36916 "EHLO
	mail-gh0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753683Ab3HWLtM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 07:49:12 -0400
Received: by mail-gh0-f180.google.com with SMTP id f18so90597ghb.39
        for <git@vger.kernel.org>; Fri, 23 Aug 2013 04:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=lc9D/EWRNuzfwsgW4vMVkMW57v9Y4zJHCyl/Psf6iIM=;
        b=lBg9LPTiI1qopO0QTHdjFYGNq76Q+wgPo3t0vSZzQpWeoTXcnvduqAxL2pevpxzxF2
         DBNWF8Ae4eDC/XNes6WMDaTWUNqicLziDGSn7K+ucC/3KAft8WhkhoobuT/as8H5l4/q
         VjJCy/cgvALdA7fokl8ThGQlbuYOixj6g5cY+EYOfK59EypJc8aU7+Apwea8v6iPqwkD
         98zXDlffO9WGj9qnZC0tVY1QPX0n//yUBxUvg60byXCwBxly2rCfjK9KOTdG3sNBqp5y
         hIwNmlAlf2aCFNHJCjSQhibAhRXESvuZ48qTbJtBlCeeMXxkv+dK7PV5NUGcfvjbGAyF
         U/aQ==
X-Received: by 10.236.141.105 with SMTP id f69mr37389yhj.92.1377258551229;
        Fri, 23 Aug 2013 04:49:11 -0700 (PDT)
Received: from jerec (c-71-59-19-88.hsd1.ga.comcast.net. [71.59.19.88])
        by mx.google.com with ESMTPSA id 48sm19798018yhq.11.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 23 Aug 2013 04:49:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <52170C6A.4080708@diamand.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232805>

On Fri, Aug 23, 2013 at 08:16:58AM +0100, Luke Diamand wrote:
> On 23/08/13 02:12, Corey Thompson wrote:
> >Hello,
> >
> >Has anyone actually gotten git-p4 to clone a large Perforce repository?
> 
> Yes. I've cloned repos with a couple of Gig of files.
> 
> >I have one codebase in particular that gets to about 67%, then
> >consistently gets get-fast-import (and often times a few other
> >processes) killed by the OOM killer.
> 
> What size is this codebase? Which version and platform of git are you using?
> 
> Maybe it's a regression, or perhaps you've hit some new, previously
> unknown size limit?
> 
> Thanks
> Luke
> 
> 
> >
> >I've found some patches out there that claim to resolve this, but
> >they're all for versions of git-p4.py from several years ago.  Not only
> >will they not apply cleanly, but as far as I can tell the issues that
> >these patches are meant to address aren't in the current version,
> >anyway.
> >
> >Any suggestions would be greatly appreciated.
> >
> >Thanks,
> >Corey
> >--
> >To unsubscribe from this list: send the line "unsubscribe git" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Sorry, I guess I could have included more details in my original post.
Since then, I have also made an attempt to clone another (slightly more
recent) branch, and at last had success.  So I see this does indeed
work, it just seems to be very unhappy with one particular branch.

So, here are a few statistics I collected on the two branches.

branch-that-fails:
total workspace disk usage (current head): 12GB
68 files over 20MB
largest three being about 118MB

branch-that-clones:
total workspace disk usage (current head): 11GB
22 files over 20MB
largest three being about 80MB

I suspect that part of the problem here might be that my company likes
to submit very large binaries into our repo (.tar.gzs, pre-compiled
third party binaries, etc.).

Is there any way I can clone this in pieces?  The best I've come up with
is to clone only up to a change number just before it tends to fail, and
then rebase to the latest.  My clone succeeded, but the rebase still
runs out of memory.  It would be great if I could specify a change
number to rebase up to, so that I can just take this thing a few hundred
changes at a time.

Thanks,
Corey
