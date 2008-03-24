From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: faster egit history page and a pure java "gitk"
Date: Mon, 24 Mar 2008 14:06:54 +0000
Message-ID: <200803241406.54759.robin.rosenberg@dewire.com>
References: <20080324092726.GQ8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Roger C. Soares" <rogersoares@intelinet.com.br>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 24 15:08:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdnLI-0007dx-Gl
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 15:08:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757430AbYCXOHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 10:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757131AbYCXOHV
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 10:07:21 -0400
Received: from [83.140.172.130] ([83.140.172.130]:1106 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1757418AbYCXOHU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 10:07:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id BB4C0802659;
	Mon, 24 Mar 2008 15:07:18 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f5EwaNulGRmC; Mon, 24 Mar 2008 15:07:17 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id C7A44800784;
	Mon, 24 Mar 2008 15:07:17 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <20080324092726.GQ8410@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78038>

Den Monday 24 March 2008 09.27.26 skrev Shawn O. Pearce:
> OK, so I decided a few weeks back that the history page was not fast
> enough.  I think I've spent the past 3 weeks writing true revision
> machinary for jgit, and now connecting it up to a UI visualizer.
>
>   git://repo.or.cz/egit/spearce.git plotter
>
> The history page has been completely replaced.  I saw Roger has
> some patches against the current history page.  :-|
The page was very messy. It was my first attempt at anything ui in
Eclipse at all. Like a child drawing his first picture of a person :)

> There are huge benefits to this infrastructure:
>
>  * Fast as snot.  We are literally just 10-20 ms slower than C Git
>    on the same hardware, same repository, for the same tree.  That
>    is pretty damn good, given that we are in Java.

On what repo is that measured?

As for Java speed, it is some two to three times slower than C on array 
intensive stuff. On just about anything else the difference is less.

The "Micro-optimize pack index v2 findOffset routine" commit suprises me
a little. The rearranged ObjectId layout does not. Could we do even better
using two long's and one int?

>  * Faster than gitk.  Yes, really.  My plot algorithm is not nearly
>    as good as Paulus' work, but I think its better than what we
>    have right now.
gitk has to talk to externa processess and parse things so I'm not surprised
we'd come to it some day.

>  * Nearly instant results without path limiter(s).  If the graph
>    doesn't require parent rewrites we are able to show results
>    almost immediately, and fill in the rest incrementally from
>    the background job.
>
>  * Lower memory usage.  By massive amounts.  I can't even begin to
>    tell you how much different it is.  Histories that we could not
>    show before can now be shown in <20M.  Our memory usage is much
>    lower than that of gitk.
This probably is related to speed too because the gc got to do a lot
of work.

>  * Multiple path limiters.  You can select more than one resource
>    (or directory!) at once and get the combined history for
>    all of them at once.  This is basically the same path limiter
>    algorithm that C Git/gitk rely upon for the same sort of query.
>    It is still limited to a single-repository, but I think we could
>    easily extend it to allow multiple-repository unions.  :-)
You mean submodules, real and "virtual" ?

>  * Common AWT and SWT drawing.  Most of the UI visualization code
>    is implemented in shared code that has no AWT or SWT specifics
>    about it.  This makes the renderer completely portable.  I have
>    both an AWT and an SWT implementation running (compare from the
>    command line "jgit glog HEAD" to the history view in Eclipse).
Sweet. Needs some polishing though. At least under Linux and small screens
with lots of pixels.

>  * Faster "RevCommit" class.  This class mostly replaces the older
>    "Commit" class.  Accessing data out of a RevCommit can be much
>    quicker than out of a Commit, plus a RevCommit gets the encoding
>    of the author, committer and message correct more of the time.
>    The downside is you can only get a RevCommit from a RevWalk,
>    or one of its subclasses.

Very impressive work Mr Shawn. I'll walk through and publish.

-- robin
