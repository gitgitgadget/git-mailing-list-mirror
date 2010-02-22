From: Bill Lear <rael@zopyra.com>
Subject: Re: 16 gig, 350,000 file repository
Date: Mon, 22 Feb 2010 16:20:08 -0600
Message-ID: <19331.792.84192.53690@blake.zopyra.com>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
	<20100214011812.GA2175@dpotapov.dyndns.org>
	<7vljer1gyg.fsf_-_@alter.siamese.dyndns.org>
	<201002181114.19984.trast@student.ethz.ch>
	<7vtytee7ff.fsf@alter.siamese.dyndns.org>
	<alpine.LFD.2.00.1002181456230.1946@xanadu.home>
	<19325.40682.729141.973125@blake.zopyra.com>
	<alpine.LFD.2.00.1002181556320.1946@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Feb 22 23:20:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Njgdd-00046c-Jc
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 23:20:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754694Ab0BVWUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 17:20:21 -0500
Received: from 75-27-130-60.lightspeed.austtx.sbcglobal.net ([75.27.130.60]:59454
	"HELO blake.zopyra.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1754554Ab0BVWUU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 17:20:20 -0500
Received: (qmail 12007 invoked by uid 500); 22 Feb 2010 22:20:18 -0000
In-Reply-To: <alpine.LFD.2.00.1002181556320.1946@xanadu.home>
X-Mailer: VM 8.1.0-beta under 23.1.1 (i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140721>

On Thursday, February 18, 2010 at 15:58:42 (-0500) Nicolas Pitre writes:
>On Thu, 18 Feb 2010, Bill Lear wrote:
>
>> I'm starting a new, large project and would like a quick bit of advice.
>> 
>> Bringing in a set of test cases and other files from a ClearCase
>> repository resulted in a 350,000 file git repo of about 16 gigabytes.
>> 
>> The time to clone over a fast network was about 250 minutes.  I could
>> not verify if the repo had been packed properly, etc.
>
>I'd start from there.  If you didn't do a 'git gc --aggressive' after 
>the import then it is quite likely that your repo isn't well packed.
>
>Of course you'll need a big machine to repack this.  But that should be 
>needed only once.

Ok, well they have a "big machine", but not big enough.  It's running
out of memory on the gc.  I believe they have a fair amount of memory:

% free
             total       used       free     shared    buffers     cached
Mem:      16629680   16051444     578236          0      28332   14385948
-/+ buffers/cache:    1637164   14992516
Swap:      8289500       1704    8287796

and they are using git 1.6.6.

Assuming we can figure out how to gc this puppy (is there any way on a
machine without 64 gigabytes?), there is still a question that
remains: how to organize a project that has a very large amount of
test cases (and test data) that we might not want to pull across the
wire each time.  Instead of shallow clone, as sort of slicing clone
operation?

We thought of using submodules.  That is, code (say) goes in a separate
repo 'src' and functional tests go in another, called 'ftests'.  Then,
we add 'ftests' as a submodule to 'src'.  Great.  However, we need to
be able to branch 'src' and 'ftests' together.  Example: I am working on
a new feature in a branch "GLX-473_incremental_compression".  I would like
to be able to create the branch in both the 'src' repo and the 'ftests'
repo at the same time, make changes, commit, and push to that branch for
both.  When developers check out the repo, they move to that branch, but
do NOT want the cloned ftests.  However, the QA team wants both the source
and the tests that I have checked in and pushed.

Is there an easy way to support this?


Bill
