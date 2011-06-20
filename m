From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 6/6] RFC - Notes merge: die when asked to merge a
 non-existent ref.
Date: Mon, 20 Jun 2011 09:29:53 +0200
Message-ID: <201106200929.53566.johan@herland.net>
References: <201106151253.57908.johan@herland.net>
 <201106200003.46490.johan@herland.net>
 <20110620071607.GB15246@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Yann Dirson <ydirson@free.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 20 09:30:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYYw2-0005pw-EO
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 09:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275Ab1FTH36 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 03:29:58 -0400
Received: from smtp.getmail.no ([84.208.15.66]:64092 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753144Ab1FTH35 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 03:29:57 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LN200EIJVHVRO70@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 20 Jun 2011 09:29:55 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 7569D1EA5739_DFEF6F3B	for <git@vger.kernel.org>; Mon,
 20 Jun 2011 07:29:55 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 91D4B1EA2E6C_DFEF6F2F	for <git@vger.kernel.org>; Mon,
 20 Jun 2011 07:29:54 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LN200DTWVHUBF00@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 20 Jun 2011 09:29:54 +0200 (MEST)
User-Agent: KMail/1.13.7 (Linux/2.6.39-ARCH; KDE/4.6.3; x86_64; ; )
In-reply-to: <20110620071607.GB15246@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176054>

On Monday 20 June 2011, Jeff King wrote:
> On Mon, Jun 20, 2011 at 12:03:46AM +0200, Johan Herland wrote:
> > > +	if (!peel_to_type(o.remote_ref, 0, NULL, OBJ_COMMIT))
> > > +		die("'%s' does not point to a commit", o.remote_ref);
> > 
> > Hmm. I'm not sure requiring the remote ref to always point to a
> > _commit_ is the right solution here. In previous discussions on the
> > notes topic, some people (Peff?) expressed a need/interest for
> > history-less notes refs (i.e. a notes tree where we don't keep track
> > of its development, but only refer to the latest/current version).
> > Obviously, there are two ways to implement history-less notes refs:
> > (a) making the notes ref point to a notes commit without any parents
> > (i.e. each notes commit is a root commit), or (b) making the notes ref
> > point directly at the notes _tree_ object (i.e. no commit object at
> > all).
> > 
> > I can't remember off the top of my head whether our earlier discussions
> > on this topic resulted in us excluding support for option (b), but if
> > we didn't, it should be possible to merge notes refs where one or both
> > refs point directly at a tree object, and your above line would break
> > this.
> 
> [...]
> 
> I don't think there is any real reason for somebody to need a bare tree
> of notes. There is a certain elegance that refs can point directly to
> trees in git, but the overhead of a single commit object to wrap it is
> just not a big deal.
> 
> I didn't test, but I doubt that "git merge" will handle bare trees; this
> would provide analagous behavior for notes-merging.  But maybe I'm
> wrong.

You're not wrong. "git merge" when trying to merge a tree object:

  $ git merge ee314a3
  error: ee314a3: expected commit type, but the object dereferences to tree type
  fatal: 'ee314a3' does not point to a commit

So I guess there's no reason to allow notes trees with no commit object.

Yann: Please disregard my complaint on the above two lines.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
