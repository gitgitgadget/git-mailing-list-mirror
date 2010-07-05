From: jeffpc@josefsipek.net
Subject: Re: [PATCH] guilt: Make sure the commit time is increasing
Date: Mon, 5 Jul 2010 14:52:38 -0400
Message-ID: <20100705185238.GS22659@josefsipek.net>
References: <1278296639-25024-1-git-send-email-tytso@mit.edu>
 <20100705025900.GQ22659@josefsipek.net>
 <67D0ABD4-BD1A-4B7A-B3EC-F48F21B5DD01@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Mon Jul 05 20:52:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVqme-0001hu-N6
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 20:52:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075Ab0GESwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 14:52:39 -0400
Received: from josefsipek.net ([141.212.112.63]:37735 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751387Ab0GESwj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 14:52:39 -0400
Received: by josefsipek.net (Postfix, from userid 1000)
	id 7203F7EDB; Mon,  5 Jul 2010 14:52:38 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <67D0ABD4-BD1A-4B7A-B3EC-F48F21B5DD01@mit.edu>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150285>

On Mon, Jul 05, 2010 at 07:06:45AM -0400, Theodore Tso wrote:
> On Jul 4, 2010, at 10:59 PM, jeffpc@josefsipek.net wrote:
> > 
> > Am I understanding this right?  You want the timestamps to be monotonically
> > increasing?  
> 
> Yup, that's correct.  In more modern versions of git most (all?) of the places
> that depend on the committer time of the child commit to be greater than the
> committer time of its parents have been relaxed to accept up to a day's worth
> of clock skew, but in the interests of "be conservative in what you send",
> strictly increasing seemed like the best thing to do.

Alright, makes sense.

> > Is the +60 the most obvious choice?
> 
> It's somewhat arbitrary.  I figured a minute increase between commits was
> more aesthetically pleasing than a second, 5 minutes, or an hour, which
> were some other deltas that previous versions of my patch used while I
> was experimenting.

I think we might need a little bit more logic in this patch...

if I commit, and immediately after push 10 patches, wouldn't the HEAD end up
with a commit that's ~10 minutes in the future?

> > Can I get an example of how git can get confused?
> 
> This first one is explicitly my/guilt's fault (and it's when I learned that I
> was causing problems by how I was using guilt in the ext4 tree):
> 
> http://kerneltrap.org/mailarchive/git/2010/4/22/28928/thread
> 
> In this thread we see how the clock skew gets in the way of an optimization
> that speeds up "git tag --contains" by over two orders of magnitude, but it
> gets screwed over by extreme clock skew.  I suggested in that thread that 
> if git is going to depend on it, then maybe "git commit" should either warn
> or error out if the git committer timestamp goes backwards --- and that's when
> I decided maybe I should offer up a patch to guilt to fix this, either before or
> instead of fixing up "git commit" to throw a warning/error:

I do like the idea of git-commit warning/erroring, but I don't think that
guilt issuing a warning is necessary.  Afterall, it's only a timestamp
change.  It might be a bit of a shock for anyone looking at the timestamps
expecting them to be out of order (based on the patch times), but I think
it's better than warning all the time.

Jeff.

-- 
What is the difference between Mechanical Engineers and Civil Engineers?
Mechanical Engineers build weapons, Civil Engineers build targets.
