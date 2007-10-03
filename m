From: David Kastrup <dak@gnu.org>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 03 Oct 2007 10:20:49 +0200
Message-ID: <85641oy5ge.fsf@lola.goethe.zz>
References: <7v1wdcch06.fsf@gitster.siamese.dyndns.org>
	<7v1wd1d0le.fsf@gitster.siamese.dyndns.org>
	<7vfy11yyxk.fsf@gitster.siamese.dyndns.org>
	<20070927023633.GA28902@coredump.intra.peff.net>
	<20071002041652.GA32133@coredump.intra.peff.net>
	<7vsl4up0tf.fsf@gitster.siamese.dyndns.org>
	<20071002050820.GA4261@coredump.intra.peff.net>
	<20071002051332.GA4462@coredump.intra.peff.net>
	<86ejge6o8b.fsf@lola.quinscape.zz>
	<20071002161114.GC6828@coredump.intra.peff.net>
	<86ve9p32cp.fsf@lola.quinscape.zz>
	<alpine.LFD.0.999.0710021916080.3579@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Oct 03 10:42:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icznk-000630-Kl
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 10:41:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752936AbXJCIlo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 04:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753013AbXJCIlo
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 04:41:44 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:37891 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936AbXJCIlm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 04:41:42 -0400
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1Iczmi-0004YF-5d; Wed, 03 Oct 2007 04:40:48 -0400
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id B88381C4CE13; Wed,  3 Oct 2007 10:20:49 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.999.0710021916080.3579@woody.linux-foundation.org> (Linus Torvalds's message of "Tue\, 2 Oct 2007 19\:28\:19 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59809>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> [ This is the discussed stupid approach - just sort the dang hash array, 
>   so that we can use a linear scan over the src/dst ]
>
> On Tue, 2 Oct 2007, David Kastrup wrote:
>> 
>> This does not actually require an actual merge _sort_ AFAICS: do the
>> "sort file.hashed" step using qsort.  The comparison step does not
>> actually need to produce merged output, but merely advances through
>> two hash arrays and generates statistics.
>> 
>> This should already beat the pants off the current implementation,
>> even when the hash array is sparse, simply because our inner loop then
>> has perfect hash coherence.
>
> Sadly, that's not the case. It *does* seem to beat the current 
> implementation, but it's not "beat the pants off".

Part of the reason is that it is not actually what I had in mind.  Why
create the hash array as a hash array?  Filling the hash array in
basically random order, then sort+compressing it is what is causing
much of the costs.  My idea was to just fill the "hash array"
linearly.  It is quite pointless (and certainly very inefficient with
regard to cache poisoning) to do it in hash order when we are going to
sort it anyway.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
