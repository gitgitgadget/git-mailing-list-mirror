From: "George Spelvin" <linux@horizon.com>
Subject: Re: Git commit generation numbers
Date: 21 Jul 2011 08:55:44 -0400
Message-ID: <20110721125544.26006.qmail@science.horizon.com>
References: <1311249789.9745.30.camel@drew-northup.unet.maine.edu>
Cc: anthonyvdgent@gmail.com, git@vger.kernel.org, linux@horizon.com,
	nico@fluxnic.net, torvalds@linux-foundation.org
To: david@lang.hm, drew.northup@maine.edu
X-From: git-owner@vger.kernel.org Thu Jul 21 14:55:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjsnA-0004yx-02
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 14:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752692Ab1GUMzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 08:55:47 -0400
Received: from science.horizon.com ([71.41.210.146]:49795 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751964Ab1GUMzq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 08:55:46 -0400
Received: (qmail 26007 invoked by uid 1000); 21 Jul 2011 08:55:44 -0400
In-Reply-To: <1311249789.9745.30.camel@drew-northup.unet.maine.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I have not read yet one discussion about how generation numbers [baked
> into a commit] deal with rebasing, for instance. Do we assign one more
> than the revision prior to the base of the rebase operation or do we
> start with the revision one after the highest of those original commits
> included in the rebase? Depending on how that is done
> _drastically_different_ numbers can come out of different repository
> instances for the same _final_ DAG. This is one major reason why, as I
> see it, local storage is good for generation numbers and putting them in
> the commit is bad. 

Er, no.  Whenever a new commit object is generated (as the result
of a rebase or not), its commit number is computed based on its
parent commits.  It is NEVER copied.

Just like the parent pointers themselves.  Remember, even though we talk
about "the same commit" after rebasing, it's really just an EQUIVALENT
commit according to some higher-level concept of similarity.  As far
as the core git engine is concerned, it's always a DIFFERENT commit,
with different parent hashes and a different hash itself.

This point hasn't been mentioned explicltly precisely because it's
so obvious; the history-walking code that the generation numbers are
for requires this property to function.
