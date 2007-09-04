From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Calculating tree nodes
Date: Tue, 4 Sep 2007 02:26:29 -0400
Message-ID: <20070904062629.GZ18160@spearce.org>
References: <9e4733910709031913q278cb9dbp441756afb28607c6@mail.gmail.com> <20070904025153.GS18160@spearce.org> <9e4733910709032026s7f94eed9h25d5165840cc38d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 08:26:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISRrz-0007I1-54
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 08:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbXIDG0e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 02:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbXIDG0e
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 02:26:34 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35927 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708AbXIDG0d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 02:26:33 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1ISRrq-0004lV-Ks; Tue, 04 Sep 2007 02:26:30 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B923F20FBAE; Tue,  4 Sep 2007 02:26:29 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <9e4733910709032026s7f94eed9h25d5165840cc38d2@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57533>

Jon Smirl <jonsmirl@gmail.com> wrote:
> Index is the key here, we may want other kinds of indexes in the
> future. It was the mail about auto-generating the Maintainers list
> that caused me to think about this. If file objects are a table with
> triggers, building a hierarchical index for the Maintainers field
> doesn't make sense.

There's nothing stopping us from creating additional indexes.

For example we have been kicking around this idea of a "note"
object that can be attached to commits.  Lightweight enough that one
could be attached to every commit, such as one way to implement the
"Signed-off-by" lines.  Notes can be looked up by commit SHA-1 using
a hash, giving near O(1) time to locate the note for any commit.

But we can also store the notes alongside the commits in the
packfile, so that if the data for the commit has been paged in
by the kernel then the note data is also most likely in memory,
and if not, is in the read-ahead queue.  Clustering the notes
alongside the commits makes access to them even faster, as we
don't need to consult an external hash to locate the position.

So I guess where I'm going is additional indexes can be implemented,
efficiently, without changing any of the core storage model in Git.
We just haven't made it easily user pluggable yet, because nobody
has really thought about the applications for such a function.
And code hasn't been posted for it (with the exception of the
notes prototypes).

-- 
Shawn.
