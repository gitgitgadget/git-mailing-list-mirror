From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH v5 2/4] git-cherry-pick: Add keep-redundant-commits option
Date: Tue, 17 Apr 2012 23:37:23 +0200
Message-ID: <20120417213723.GA19908@ecki>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334342707-3326-1-git-send-email-nhorman@tuxdriver.com>
 <1334342707-3326-3-git-send-email-nhorman@tuxdriver.com>
 <20120415104212.GC6263@ecki>
 <20120416153827.GC13366@hmsreliant.think-freely.org>
 <20120416221018.GB5606@ecki>
 <7v3982pdoj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Neil Horman <nhorman@tuxdriver.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 23:57:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKGOp-0003Qo-N5
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 23:57:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968Ab2DQV5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 17:57:18 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:12194 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751683Ab2DQV5R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 17:57:17 -0400
Received: from [127.0.0.1] (p5B22CC82.dip.t-dialin.net [91.34.204.130])
	by bsmtp.bon.at (Postfix) with ESMTP id 230A913004F;
	Tue, 17 Apr 2012 23:57:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v3982pdoj.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195810>

On Tue, Apr 17, 2012 at 08:42:52AM -0700, Junio C Hamano wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
> 
> > On Mon, Apr 16, 2012 at 11:38:27AM -0400, Neil Horman wrote:
> > ...
> > Except that the outcome is not the same. With and without your changes,
> > git cherry-pick <empty-commit> fails. But with your changes, git
> > cherry-pick <commit-will-become-empty> will succeed and do nothing,
> > while before it would have failed exactly like git cherry-pick
> > <empty-commit>.
> >
> > So I am not arguing whether failing or skipping is the better default
> > behavior. But the legacy behavior is consistent between the empty-commit
> > and commit-will-become-empty cases.
> 
> Is that particular "consistency" a good one, though?  If you had an empty
> commit in the original range, it is a lot more likely that it was an error
> that you would want to know about.  You may be the kind of person who
> value an empty commit in your history, using it as some kind of a mark in
> the history, and in that case you would want to know that it is being
> discarded.  On the other hand, if a commit that did something in the
> original context turns out to be unnecessary in the replayed context, that
> is not something you would ever want to keep in the replayed context, and
> erroring out and forcing you to say "yeah, I admit I do not want it" would
> just be annoying.

Yeah, that makes sense.

> So "consistency" between the two would actually be a mistake that we may
> want to "break", I would think.

Agreed. But we should document the change in the commit message and
maybe add a comment, because it is really strange to read

 if (!empty && index_empty)
 	return "it's all good"

 if (empty)
 	return "oh noes!"

without an explanation as to why empty and index_empty are so different.
Neil, what do you think?
