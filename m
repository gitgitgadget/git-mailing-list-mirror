From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Branch Name Case Sensitivity
Date: Fri, 28 Feb 2014 21:31:29 +0700
Message-ID: <CACsJy8B7fFBJ5ZbJDjGj4G6mx1byitC7BU4oJ3C0zq7cuv4fvA@mail.gmail.com>
References: <CAJHY66EQD280QgXBCoZU4y_aqSEu3A1hXzeW7X-rtT6vMZ92oA@mail.gmail.com>
 <xmqqvbw0xrl6.fsf@gitster.dls.corp.google.com> <530FA0C1.3000109@web.de>
 <530FBB1D.3050505@gmail.com> <CAJHY66FtC03YbJrbVn+adsePkYnVD2RGH1TGkzz2pKNBoee_iQ@mail.gmail.com>
 <53105343.2040703@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Lee Hopkins <leerhop@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Feb 28 15:32:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJOTv-0008Ho-3M
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 15:32:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129AbaB1OcC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 09:32:02 -0500
Received: from mail-qa0-f46.google.com ([209.85.216.46]:44882 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580AbaB1OcB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 09:32:01 -0500
Received: by mail-qa0-f46.google.com with SMTP id i13so708132qae.33
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 06:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2KdXiboewlKhMhqpxMP7+SgMjwdfv8l7fNcMK+GFs/4=;
        b=tr7/0U5PaA29PN2lrVf/bueFHMaSTqYNBDGangz56PoWbhi+p4lE0P9+WYIUmkmnlI
         TRFJ2JTmtbIO+DqcEr9n2wn+AiJAkkEQm1DIh0yMWc6UjmtYQ58rkeuOt2SrbaeLuYlf
         8sp3e3mM513eI8LaoF2ZuVv7xn4PFmGKT1a6WzXS2hlTCMvEzchSusnc9vgQkPHVS8NL
         C9omF1zduTRxwQn7OKkAo9NF4CoUjj8qTpOyEiP0IxjdkfDCeGzqvsBa8Sq5ENYb4VwN
         18tML0A6i5gPxyKnfEHEhrjTC5dgQaKCC6ZLq9TJ4I3RL+EWsJPR/elbAmbycFkAinro
         guSw==
X-Received: by 10.224.112.6 with SMTP id u6mr3964081qap.78.1393597920397; Fri,
 28 Feb 2014 06:32:00 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Fri, 28 Feb 2014 06:31:29 -0800 (PST)
In-Reply-To: <53105343.2040703@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242966>

On Fri, Feb 28, 2014 at 4:13 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 02/28/2014 12:38 AM, Lee Hopkins wrote:
>> [...] Based Michael Haggerty's response, it seems that always
>> using loose refs would be a better workaround.
>
> No, I answered the question "what would be the disadvantages of using
> only packed refs?".  Now I will answer the question "what would be the
> disadvantages of using only loose refs?":
>
> 1. Efficiency.  Any time all of the references have to be read, loose
> refs are far slower than packed refs.
>
> 2. Disk space and inode usage: loose refs consume one inode and one disk
> sector (typically 4k) each, whereas packed refs consume only one inode
> in total, and many packed refs can fit into each disk sector.
>
> After all, there is a reason that we have both packed refs and loose
> refs.  The basic idea is to use packed refs for the bulk of references,
> especially "cold" references like tags that only change infrequently,
> but to store "hot" references as loose refs so that they can be modified
> cheaply.

Could we have a staging place for new refs in between? Case
sensitivity is just another limitation we hit because we rely on
filesystem. We already have problems with having both refs foo and
foo/bar at the same time. Not all repos are super busy and need the
top efficiencies of loose refs.

And about rewriting packed-refs every time, I don't think that's a big
problem for "normal" repos. linux-2.6 index file is 4MB(*) and it's
rewritten on nearly every worktree-related operation and nobody
complains (out loud anyway). Assuming an average ref takes 100 bytes,
that's about 41k refs.

(*) it's 3MB with index-v4 but I don't think v4 is popular
-- 
Duy
