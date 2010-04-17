From: Jeff King <peff@peff.net>
Subject: Re: Rename similarity scoring for file pair
Date: Sat, 17 Apr 2010 07:03:56 -0400
Message-ID: <20100417110356.GA28623@coredump.intra.peff.net>
References: <t2ua2cc2dbc1004121112h64f5b61ela57f5fa83abf51f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Debayan Banerjee <debayanin@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 17 13:04:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O35pF-0004lt-S4
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 13:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757038Ab0DQLEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 07:04:31 -0400
Received: from peff.net ([208.65.91.99]:48929 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756972Ab0DQLEa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 07:04:30 -0400
Received: (qmail 17156 invoked by uid 107); 17 Apr 2010 11:04:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 17 Apr 2010 07:04:32 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Apr 2010 07:03:56 -0400
Content-Disposition: inline
In-Reply-To: <t2ua2cc2dbc1004121112h64f5b61ela57f5fa83abf51f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145133>

On Mon, Apr 12, 2010 at 11:42:59PM +0530, Debayan Banerjee wrote:

> I was going through this thread
> <http://markmail.org/message/mge2spy7uqle5ghy#query:diffcore-rename.c%20algorithm+page:1+mid:ji7jkzypzqpml2xn+state:results>
> trying to understand how the similarity scoring for modified files
> works. I see that the algorithm uses two hashes, one for each file,
> and proceeds to compare the 2 hashes to determine percentage
> similarity.
> I think I have an algorithm which uses only one hash and has a worst
> case space complexity of O(N) where N is the number of lines
> inserted/deleted/moved.

That looks pretty similar to the algorithm that Andy Chup proposed. I
did some work towards integrating it, but never completed it. See these
threads for details:

  http://thread.gmane.org/gmane.comp.version-control.git/61975

  http://thread.gmane.org/gmane.comp.version-control.git/62655

So yes, it's an interesting way to go. But it needs somebody to:

  1. Implement it in C and integrate it into diffcore-rename (I did
     that, but there were some problems, see below).

  2. Confirm that the quality of results is similar to the current
     algorithm. In my case, the results were different, and I suggested
     some tweaks to improve them (see the second thread above). I don't
     remember if I ever followed up.

  3. Confirm that we really do get a speed improvement on the slow
     cases, and don't slow down or significantly bloat memory usage for
     the fast cases.

If you're interested in working on it, I'd be happy to help with
discussion and code review.

-Peff
