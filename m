From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: pull into dirty working tree
Date: Fri, 15 Jun 2007 12:46:22 +1200
Message-ID: <46a038f90706141746n1cb69258r23ba676bbcf7c425@mail.gmail.com>
References: <18031.64456.948230.375333@lisa.zopyra.com>
	 <alpine.LFD.0.98.0706132216300.14121@woody.linux-foundation.org>
	 <18033.14520.846510.640130@lisa.zopyra.com>
	 <alpine.LFD.0.98.0706140836450.14121@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Bill Lear" <rael@zopyra.com>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jun 15 02:46:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyzxN-0001kE-Ku
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 02:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755115AbXFOAqY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 20:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754813AbXFOAqX
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 20:46:23 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:50816 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753450AbXFOAqW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 20:46:22 -0400
Received: by wr-out-0506.google.com with SMTP id 76so672511wra
        for <git@vger.kernel.org>; Thu, 14 Jun 2007 17:46:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eRzVRAjA3ZlXRJl0iFP1G2RWvU5KtQ2Iph6o45SWnm5B/q9AzqbUkXpIiXQvCDYo73QkbyzADRau/9SeWxXllhaKA4qkBNMxqcNwDja2CVuIK24fU5sLH/hTcrLp/ltyblbfQt5pUqh/wcbQvia0SsR04CTPo+OnEO4TIA14R2k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DbYH0mhZpPRPftNDnwcn/7z3EJNW+/W98FD9t54QvEg6fPjsjsDP2jw7Mx9FPIk/ChrRel39pPVB3a8p4o1tW4arpFfiYnlNu70E6OsA0jw1BrPWI5ABZn8KOBCRyDIvPYjgldURZOHWXC+F8VMWLHBnZYua++o8z0cNCqfj98Y=
Received: by 10.90.54.4 with SMTP id c4mr2263064aga.1181868382114;
        Thu, 14 Jun 2007 17:46:22 -0700 (PDT)
Received: by 10.90.52.9 with HTTP; Thu, 14 Jun 2007 17:46:22 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.98.0706140836450.14121@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50228>

On 6/15/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> Well, the thing is, I actually pull into dirty trees all the time. So I
> can really see the point of wanting to have some dirty state (you're not
> ready to commit it yet), but still wanting to update your tree to some
> newer state..

Right now git merges/fforwards well with dirty state as long as the
same path is not touched on both sides. But there are several
situations where it could do better allowing those ops to go through
if they don't result in any conflict.

- For Fast Forwards on a dirty path - attempt the merge on a temp file
and refuse to complete the FF there is a conflict.
- For merges on a dirty path, attempt the merge. If both the tree
merge _and_ the subsequent with the dirty state are clean, then there
is no problem updating the checkout.

In both cases, we can still go ahead in the case of a conflict against
the local state and give the user the normal conflict markers (or
separate files of the patch doesn't apply at all. The situation where
I think it is valid to refuse to go ahead is in the "merge on dirty
path" where the tree merge results in a conflict. Too many states to
keep track of -- not for git but for the user.

cheers,


martin
