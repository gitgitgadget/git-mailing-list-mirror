From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] specifying ranges: we did not mean to make ".." an empty set
Date: Thu, 23 Aug 2012 13:56:52 +0200
Message-ID: <874nntq0sb.fsf@thomas.inf.ethz.ch>
References: <7vd32i5y8w.fsf@alter.siamese.dyndns.org>
	<20120823082916.GA6963@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 23 13:57:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4W2E-0003Cb-Fl
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 13:57:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757598Ab2HWL5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 07:57:09 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:29796 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752279Ab2HWL44 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2012 07:56:56 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 23 Aug
 2012 13:56:45 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 23 Aug
 2012 13:56:52 +0200
In-Reply-To: <20120823082916.GA6963@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 23 Aug 2012 04:29:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204147>

Jeff King <peff@peff.net> writes:

> On Wed, Aug 22, 2012 at 03:59:43PM -0700, Junio C Hamano wrote:
>
>> Either end of revision range operator can be omitted to default to HEAD,
>> as in "origin.." (what did I do since I forked) or "..origin" (what did
>> they do since I forked).  But the current parser interprets ".."  as an
>> empty range "HEAD..HEAD", and worse yet, because ".." does exist on the
>> filesystem, we get this annoying output:
>> 
>>   $ cd Documentation/howto
>>   $ git log .. ;# give me recent commits that touch Documentation/ area.
>>   fatal: ambiguous argument '..': both revision and filename
>>   Use '--' to separate filenames from revisions
>> 
>> Surely we could say "git log ../" or even "git log -- .." to disambiguate,
>> but we shouldn't have to.
>> 
>> Helped-by: Jeff King <peff@peff.net>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> Hmm, for some reason I had no recollection of the original thread at
> all. And yet reading the archives, I apparently had quite a bit to say.
> Reading again with fresh eyes, I still think this is sane.
>
> I don't think assigning any revision magic to ".." besides "the empty
> range" makes sense at all for the reasons you gave in the original
> thread. And the empty range is a pointless no-op. So I don't see any
> real argument in favor of disambiguating towards the revision.

I don't think that ".." is really a no-op.  It is true that HEAD..HEAD
does not itself result in any revisions, but it *could* be used as a
silly shorthand to introduce ^HEAD into the objects being walked.  This
can make a difference if it then excludes other objects, too.

I would argue that such use is misguided, and I am in favor of the
patch, but in theory it is possible.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
