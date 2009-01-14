From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: git merge and cherry-pick and duplicated commits?
Date: Wed, 14 Jan 2009 14:47:03 +0100
Message-ID: <81b0412b0901140547u2fbd2feh89fc80f64b9bab81@mail.gmail.com>
References: <2729632a0901131840v5c7ce0c7l3f87c03caabf68de@mail.gmail.com>
	 <5EA96780-EF4C-4B31-9C60-6ABAF21663FA@silverinsanity.com>
	 <2729632a0901132221r746144a1y9628615be1c6ad04@mail.gmail.com>
	 <200901140941.17110.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: skillzero@gmail.com, git@vger.kernel.org
To: "Thomas Rast" <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jan 14 14:49:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN66f-0001Qb-4I
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 14:48:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756267AbZANNrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 08:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754891AbZANNrH
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 08:47:07 -0500
Received: from rv-out-0506.google.com ([209.85.198.232]:37813 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754404AbZANNrD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 08:47:03 -0500
Received: by rv-out-0506.google.com with SMTP id k40so533978rvb.1
        for <git@vger.kernel.org>; Wed, 14 Jan 2009 05:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=+27iOM+lO5xVAYIMnZJBVydHtJAnb6IEGWsJGjDHTf4=;
        b=Lt02mDfmFodd0v9whbiUrkA9oj9O5Qp4KERmyadGuxHALAbZe+0MtX4HtJ5YbK2R4W
         Gb5U21ZVSnAxLYu/DVX9+GKLD5lt+qTbdVhc6xxAQttQx4e09sLUALz6MF1Ot4d2hFA3
         a/zCZTcWEwYBSAE+sHj1J46XMWlwuD3HjSq4A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=rmgfUMcxLc9zgLA5cPM6n5QyfIsQI41tHiG/j6suldpK9nQVoFteBfEYOfhrMPS04R
         ehjbRuo6fje0N+E05tHkiS7MuuyA+dOvluz6f1oZANqXO92pdJ0ZPd61lEBxQd8jx/6H
         +49Ks01qX/0IxP6ckdQ+/pr5hGREREvl8GWP0=
Received: by 10.114.25.19 with SMTP id 19mr103749way.89.1231940823204;
        Wed, 14 Jan 2009 05:47:03 -0800 (PST)
Received: by 10.114.179.4 with HTTP; Wed, 14 Jan 2009 05:47:03 -0800 (PST)
In-Reply-To: <200901140941.17110.trast@student.ethz.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105628>

2009/1/14 Thomas Rast <trast@student.ethz.ch>:
> skillzero@gmail.com wrote:
>> That's what I was somewhat disappointed by. Even though the result of
>> the commit had a different hash, I assumed git would keep some kind of
>> internal per-commit hash so it could tell later that two commits were
>> the same and not re-apply them.
>
> I think there's an important misunderstanding here: merging A into B
> does *not* have anything to do with commits, or history for that
> matter, beyond the differences from $(git merge-base A B) to A and
> B.[*]
>
> Along the same lines, nothing is ever re-applied during merging.
> git-merge just figures out that you made the same change on both
> sides, so it must have been a good change, so it must go into the end
> result.  *How* you arrived at the same change---say, by
> cherry-picking, or by getting the same result in that region from
> otherwise different commits, or even from several commits---does *not*
> matter in any way.

Yes, merge only considers what bytes (aka contents of
trees-directories and blobs-files) do the branches to be merged
have, compares them (by comparing their hashes) and if there
are differences tries to mix them together according to the merge
rules described somewhere in Documentation.

So this all is really just about what the branches contain, not
how they got it. It is the conflict resolution algorithm which uses
the history to find the best possible source blob or tree which was
changed by conflicting branches so the "mix" can be prepared as
close as possible to what would we do if we went looking for the
pieces manually.
