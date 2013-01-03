From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFD] annnotating a pair of commit objects?
Date: Thu, 03 Jan 2013 10:59:38 +0100
Message-ID: <50E5568A.5060909@alum.mit.edu>
References: <7vr4m2ycij.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 11:07:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqhhZ-0006Qv-Tv
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 11:07:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753166Ab3ACKGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2013 05:06:47 -0500
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:63878 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753093Ab3ACKGp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jan 2013 05:06:45 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Jan 2013 05:06:45 EST
X-AuditID: 12074412-b7f216d0000008e3-b5-50e5568e15e1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 98.EB.02275.E8655E05; Thu,  3 Jan 2013 04:59:42 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r039xeKv028861
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 3 Jan 2013 04:59:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vr4m2ycij.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsUixO6iqNsf9jTAYCObRdeVbiaLht4rzBY/
	WnqYHZg9nvXuYfS4eEnZ4/MmuQDmKG6bpMSSsuDM9Dx9uwTujK2b9jIX/FSo6Pl1h7GB8YR4
	FyMnh4SAicTxNbvZIWwxiQv31rN1MXJxCAlcZpT4df8IM4RzjEniU1sPG0gVr4C2xJMf21hB
	bBYBVYmnv7cxgdhsAroSi3qawWxRgQCJxUvOsUPUC0qcnPmEBcQWEVCTmNh2CMxmFjCSmLnm
	ByOILSxgIfH78V2wXiEBU4k5z86D2ZwCZhIXb8yEqteReNf3gBnClpfY/nYO8wRGgVlIVsxC
	UjYLSdkCRuZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbpmermZJXqpKaWbGCGhK7SDcf1JuUOM
	AhyMSjy8rPVPAoRYE8uKK3MPMUpyMCmJ8uYEPw0Q4kvKT6nMSCzOiC8qzUktPsQowcGsJMJ7
	PQeonDclsbIqtSgfJiXNwaIkzvtzsbqfkEB6YklqdmpqQWoRTFaGg0NJglc0FGioYFFqempF
	WmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPChW44uB0QqS4gHamwbSzltckJgLFIVoPcVozHGr
	4eZTRo7704GkEEtefl6qlDivAUipAEhpRmke3CJY0nrFKA70tzCvNkgVDzDhwc17BbSKCWjV
	qzePQVaVJCKkpBoY12s2P5yWJqYnwR80hfF4++K2iuRrk2bccPrQ6F9yP+HJP7tF+kXH7Viu
	mohlvlWvLUuwmtoulhw8lStPdMrmUzL2ny96H9rBZcdU578ibM69GPPFa45sm7Ir 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212578>

On 01/03/2013 08:03 AM, Junio C Hamano wrote:
> I'd like a datastore that maps a pair of commit object names to
> another object name, such that:
> 
>  * When looking at two commits A and B, efficiently query all data
>    associated with a pair of commits <X,Y> where X is contained in
>    the range A..B and not in B..A, and Y is contained in the range
>    B..A and not in A..B.
> 
>  * When <X,Y> is registered in the datastore, and X is rewritten to
>    X' and/or Y is rewritten to Y', the mapping is updated so that it
>    can be queried with <X',Y'> as a new key, similar to the way a
>    notes tree that maps object X can be updated to map object X'
>    when such a rewrite happens.
> 
> The intended use case is to "go beyond rerere".  Given a history of
> this shape:
> 
>     o---o---o---I      mainline
>    / 
>   O---o---X---o---A    topic A
>    \
>     o---Y---o---o---B  topic B

If we ignore rewriting for a moment, the information that you want to
record is essentially the merge M of X and Y, no?  Namely, X and Y
conflict logically with each other (though perhaps not textually) and
you, the human, want to record how to reconcile them:

     o---o---o---I      mainline
    /
   O---o---X---o---A    topic A
    \       \
     \       M
      \     /
       o---Y---o---o---B  topic B

However, you don't necessarily want to go to the trouble to make a
branch to point at M, nor to do the bookkeeping manually that would be
required to take the information stored in M into account when merging A
and B later.

Suppose we had M; how could we make use of it in future merges?

> [...] and can create a merge J without semantic adjustment.
> 
>     o---o---o---I---J      mainline
>    /               /  
>   O---o---X---o---A        topic A
>    \
>     o---Y---o---o---B      topic B

That would become

     o---o---o---I---J      mainline
    /               /
   O---o---X---o---A        topic A
    \       \
     \       M
      \     /
       o---Y---o---o---B  topic B


> When I later merge topic B to the integration branch, however, [...]
> to notice that we need to be careful when creating the merge K:
> 
>     o---o---o---I---J---K  mainline
>    /               /   /
>   O---o---X---o---A   /    topic A
>    \                 /
>     o---Y---o---o---B      topic B

When doing this merge, I think your goal is equivalent to discovering
that M includes part of the merge of J and B, and adding M as an
(implicit or explicit) third parent to the merge:

     o---o---o---I---J-------K  mainline
    /               /    .  /
   O---o---X---o---A    .  /    topic A
    \       \          .  /
     \       M.........  /
      \     /           /
       o---Y---o---o---B        topic B

How could M be stored?  Assuming that these type of premerge merges are
sparse, then Jeff's analysis seems good.  Concretely, one could simply
store pointers to M from both X and Y; e.g.,

* Add a note to X with the information "when merging this commit with Y,
use premerge M"

* Add a note to Y with the information "when merging this commit with X,
use premerge M"

Then, when merging, create the set J..B, scan all of the commits on B..J
for these "premerge" notes (O(|B..J|)), and for each one, look in the
set J..B to see if it is present.  The effort should scale like

    O( |J..B| + |B..J| * lg(|J..B|) )

where, of course J and B could be exchanged for either aesthetic or
performance reasons.  (One would also need a mechanism for preventing M
from being garbage-collected.)

Incidentally, this is just the sort of thing I have been thinking about
using to implement a kind of "incremental merge"; I've started writing
up my thoughts on my blog [1,2,3] (including how to make pretty pictures
of merge conflicts).

Michael

[1]
http://softwareswirl.blogspot.de/2012/12/the-conflict-frontier-of-nightmare-merge.html
[2]
http://softwareswirl.blogspot.de/2012/12/mapping-merge-conflict-frontier.html
[3]
http://softwareswirl.blogspot.de/2012/12/real-world-conflict-diagrams.html

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
