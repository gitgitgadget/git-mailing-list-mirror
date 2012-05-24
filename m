From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] Avoid sorting if references are added to ref_cache in
 order
Date: Thu, 24 May 2012 23:00:29 +0200
Message-ID: <4FBEA16D.4040204@alum.mit.edu>
References: <1337861810-9366-1-git-send-email-mhagger@alum.mit.edu> <20120524174906.GC3161@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Fick <mfick@codeaurora.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 24 23:07:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXfG0-0001jK-KB
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 23:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932979Ab2EXVHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 17:07:36 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:63347 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754487Ab2EXVHf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 May 2012 17:07:35 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 May 2012 17:07:34 EDT
X-AuditID: 1207440d-b7f336d00000097b-c3-4fbea1701196
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 84.C0.02427.071AEBF4; Thu, 24 May 2012 17:00:32 -0400 (EDT)
Received: from [192.168.69.140] (p4FC0D6A9.dip.t-dialin.net [79.192.214.169])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q4OL0T5j004326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 24 May 2012 17:00:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <20120524174906.GC3161@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsUixO6iqFuwcJ+/wa31vBZdV7qZLBp6rzBb
	3H+/jsniR0sPswOLx+W+XiaPZ717GD0uXlL2+LxJLoAlitsmKbGkLDgzPU/fLoE743/XNpaC
	W1oVCy9NZW5g/KrYxcjJISFgInHs51dWCFtM4sK99WxdjFwcQgKXGSXOH2higXDOMkkcWvGe
	GaSKV0Bb4uHhW4wgNouAqsTknR1gcTYBXYlFPc1MXYwcHKICYRKrH2hAlAtKnJz5hAXEFhGQ
	lfh+eCNYK7NAhsTtudPZQWxhgSCJD+tmgtUICRRKLNm0DayGU8BKYvL6HewQ9WYSXVu7oHrl
	Jba/ncM8gVFgFpIVs5CUzUJStoCReRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrpFebmaJXmpK
	6SZGSDjz7mD8v07mEKMAB6MSDy9j9D5/IdbEsuLK3EOMkhxMSqK8rvOBQnxJ+SmVGYnFGfFF
	pTmpxYcYJTiYlUR4BSOBcrwpiZVVqUX5MClpDhYlcV61Jep+QgLpiSWp2ampBalFMFkZDg4l
	Cd7yBUCNgkWp6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aBIjS8GxipIigdobxpIO29x
	QWIuUBSi9RSjLseV3xOvMwqx5OXnpUqJ83aCFAmAFGWU5sGtgCWvV4ziQB8L82aBVPEAEx/c
	pFdAS5iAlmx5vBdkSUkiQkqqgbGT9XtYEp/zw+OyS25U2Zz85iTx6t3M22J8Cs7ZaZe/PZm4
	8oNVkH1Dz/IPkk8jwzjPPVGO3pdZtld65Yye7MxApVkbXrZl/lAWrRLeyzJ9lnhB 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198431>

On 05/24/2012 07:49 PM, Jeff King wrote:
> Thanks for a nice analysis and the patch; this definitely fixes the
> regression I was seeing.

And thanks for your feedback and for helping me reproduce your problem.

> The fix feels a little bit like a hack to me. The real problem is that
> there is a mismatch in how the ref code wants to receive chunks of refs,
> and how the packed-refs code wants to feed them. The optimal way to feed
> refs would be breadth-first, giving an entire single level (say,
> "refs/remotes/*", but not "refs/remotes/*/*") at once, and then sorting
> the result. And as far as I can tell, that is what read_loose_refs does.
>
> But the packed-refs file is read sequentially, and we end up inserting
> the refs in a depth-first way, which triggers this problem. Your fix
> relies on the fact that our depth-first feed happens in sorted order,
> and we can avoid the extra sorts. But I think the problem would still
> exist if we did a depth-first feed of unsorted refs.
>
> The packed-refs file is always in sorted order. The only other source of
> feed-one-at-a-time refs seems to be clone.c:write_remote_refs. It gets
> its refs from the mapped_refs, which eventually come from the remote
> side of the connection (and git tends to list refs in sorted order).
>
> So I think in practice we are OK, but would go quadratic again if we
> ever fed an unsorted list of refs. So the right thing is probably to
> apply this patch (which makes sense _anyway_, as it is even cheaper than
> sorting afterwards when we can avoid it), and be aware of the issue for
> any future unsorted provider, and deal with it if and when it ever
> happens.

I agree with you that this patch is a bit hacky, but it is simple, 
harmless, and it happens to do the right thing in the cases that are 
important in today's git.  See below for other approaches that could be 
used in combination with this one.

>> +	/* optimize for the case that entries are added in order */
>> +	if (dir->nr == 1 ||
>> +	    (dir->nr == dir->sorted + 1&&
>> +	     strcmp(dir->entries[dir->nr - 2]->name,
>> +		    dir->entries[dir->nr - 1]->name)<  0))
>> +		dir->sorted = dir->nr;
>
> Technically we would still be sorted if strcmp(...) == 0. But I guess it
> probably doesn't matter, as we shouldn't ever be adding duplicates here.

Yes, duplicate refs should be an exceptional case and needn't be handled 
efficiently.  sort_ref_dir() explicitly accepts the possibility of 
duplicate references, de-dups them if they are consistent with each 
other, or dies if they are inconsistent.  We shouldn't add a way to 
bypass that logic.  We could implement the 
duplicate-detection-and-checking code again in add_entry_to_dir(), but 
my choice was to leave it to sort_ref_dir() to deal with duplicates.


More general approaches:

The optimization implemented above is unsatisfying in the sense that it 
only works because refs are inserted in order.  What could be done to 
handle the general case (i.e., handling references that are added to the 
cache out of order)?

If quick, repeated iteration is thought to be important, then the 
canonical answer would be to use something like a balanced tree or a 
skip list.  These data structures are somewhat involved and have extra 
space and time overhead for the case of serial processing.

If ordered iteration is expected to be rare but lookups, adds, and 
deletes are expected to be frequent, then one could use a hash map, and 
sort the entries when needed as part of the iteration.  But a hash map 
discards the ordering that is already present when reading packed-refs 
and requires an extra sort every time that packed-refs is written.

Something that would help read_packed_refs() would be to keep track of 
the directory that it is currently working in.  This would effectively 
remove the need to access a directory while working in one of its 
subdirectories, thereby avoiding any need to repeatedly sort 
intermediate directories.  It would also avoid having to traverse the 
directories starting at the root for each new entry, which itself would 
save time independent of the time for sorting.  I have some patches that 
implement this change but they are stale.  I want to do some 
benchmarking first though to see whether the extra complication brings 
measurable benefits.

Finally, I did some work on the idea of keeping the refs within a 
directory *mostly* sorted.  (Probably this technique is already known, 
but I have never run into it.)  One would keep the first part of the 
array sorted, and append new references to the tail of the array 
unsorted.  Searching would be via a binary search over the sorted part 
of the array, and a linear search over the unsorted tail.  The trick is 
that every so often the tail should be sorted and merged into the head. 
  How often?  It is a tradeoff between the work of sorting and merging 
versus the work saved by avoiding linear searches through the tail.  I 
worked out the theory, and I think the optimum was to re-sort the array 
when the size of the unsorted tail reached the squareroot of the total 
size or something like that.  This method could reduce the cost of 
(lookup, add, lookup, add, ...) sequences, albeit not to the extent of a 
more optimal data structure.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
