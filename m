From: David Kastrup <dak@gnu.org>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 02 Oct 2007 08:10:28 +0200
Message-ID: <86ejge6o8b.fsf@lola.quinscape.zz>
References: <7v1wdcch06.fsf@gitster.siamese.dyndns.org> <7v1wd1d0le.fsf@gitster.siamese.dyndns.org> <7vfy11yyxk.fsf@gitster.siamese.dyndns.org> <20070927023633.GA28902@coredump.intra.peff.net> <20071002041652.GA32133@coredump.intra.peff.net> <7vsl4up0tf.fsf@gitster.siamese.dyndns.org> <20071002050820.GA4261@coredump.intra.peff.net> <20071002051332.GA4462@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 02 08:10:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icay4-0000ot-P2
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 08:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709AbXJBGKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 02:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751596AbXJBGKp
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 02:10:45 -0400
Received: from main.gmane.org ([80.91.229.2]:45445 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751243AbXJBGKo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 02:10:44 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Icaxs-000099-JE
	for git@vger.kernel.org; Tue, 02 Oct 2007 06:10:40 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Oct 2007 06:10:40 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Oct 2007 06:10:40 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:W2KyJjpChwPrI8Az/EAEq8AIaqI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59661>

Jeff King <peff@peff.net> writes:

> On Tue, Oct 02, 2007 at 01:08:20AM -0400, Jeff King wrote:
>
>> One approach which I haven't tried but might be promising is to actually
>> keep each list sorted, and then do a "merge" of the two lists, comparing
>> as you go. We don't really need to do arbitrary lookups in the hash; we
>> just need to compare two hash tables at a time. My approach was to be
>> simple, but have O(HASH_SIZE) comparisons (where HASH_SIZE is on the
>> order of 2^17), and that's clearly just too big. But with a list merge,
>> it should be O(n), where n is the actual number of lines in the files
>> (or binary chunks for the binary case).
>
> BTW, I don't want to steal credit for this idea...it comes from thinking
> about what David Kastrup said earlier in the thread, though I think he
> was proposing sorting just inside buckets.

Yes: my proposal was about a microoptimization: work with the
basically existing data structures and put the already contained
information to best use.

I have not actually looked at the actual task that the structures are
going to be used in, and whether "reusing" the information is likely
to be worth the trouble.

When we are talking about buzzword compliance, "keep sorted" with the
meaning of "maintain sorted across modifications" has an O(n^2) or at
least O(nm) ring to it.  However, if it is possible to sort it just
once, and then then only merge with other lists...

I am actually quite a fan of merge sort and have even posted a small
and quite efficient version to this list once.  However, merge sorts
were really greatest at the time when cache memory was unusual to
have.  Nowadays, quicksort or similar could be faster due to better
locality of memory accesses.  I think the glibc qsort more or less
uses an array-based merge into a separate memory area (unless it runs
out of memory in which case it resorts to regular quicksort).

-- 
David Kastrup
