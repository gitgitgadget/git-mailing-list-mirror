From: Charles Bailey <charles@hashpling.org>
Subject: Re: Be more careful about updating refs
Date: Thu, 17 Jan 2008 09:15:58 +0000
Message-ID: <20080117091558.GA8341@hashpling.org>
References: <alpine.LFD.1.00.0801151546560.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801151600140.2806@woody.linux-foundation.org> <7vodblpmyc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 10:16:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFQrb-000167-IF
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 10:16:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472AbYAQJQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 04:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753341AbYAQJQM
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 04:16:12 -0500
Received: from pih-relay06.plus.net ([212.159.14.133]:53750 "EHLO
	pih-relay06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753295AbYAQJQK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 04:16:10 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay06.plus.net with esmtp (Exim) id 1JFQqx-0001al-4Q; Thu, 17 Jan 2008 09:16:03 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m0H9FxkD008704;
	Thu, 17 Jan 2008 09:15:59 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m0H9Fwbl008703;
	Thu, 17 Jan 2008 09:15:58 GMT
Content-Disposition: inline
In-Reply-To: <7vodblpmyc.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70839>

On Wed, Jan 16, 2008 at 11:52:43AM -0800, Junio C Hamano wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > On Tue, 15 Jan 2008, Linus Torvalds wrote:
> >> 
> >> This makes write_ref_sha1() more careful: it actually checks the SHA1 of 
> >> the ref it is updating, and refuses to update a ref with an object that it 
> >> cannot find.
> >
> > Side note: this breaks some tests, because those tests do things like
> >
> > 	git update-ref refs/heads/master 1111111111111111111111111111111111111111 &&
> > 		test 1111111111111111111111111111111111111111 = $(cat .git/refs/heads/master)
> >
> > ...
> > (Pet peeve on mine: people fixing assert()'s by changing the source-code, 
> > without ever asking themselves whether maybe the assert itself was the 
> > bug).
> 
> The rules for the plumbing used to be that refs can point at
> anything that get_sha1() accepts.  We did not even require it to
> be parse_object() happy let alone it being parse_commit() kosher.
> 
> You changed the world order.  I agree that the world order was
> changed in a good way, but saying that the original test did not
> check the right thing or it was a bug is not quite fair.  At
> worst, we can say that it was very sloppily written by assuming
> that the commands involved in the particular test would not care
> about corrupted repositories whose refs point at nonexistant
> bogus objects.
> 
> I'll squash the following to your patch.

I'm assuming that this original patch and the test update turned into
the following commit in master:

c3b0dec509fe136c5417422f31898b5a4e2d5e02 is first bad commit

I just thought I should warn you that this seems (git bisect tells me
so) to have caused a failure in t9301-fast-export.sh on my Mac OS X
10.4.11 machine although I haven't yet had the time to investigate
why.

Charles.
