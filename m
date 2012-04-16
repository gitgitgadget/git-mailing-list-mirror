From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH v5 2/4] git-cherry-pick: Add keep-redundant-commits option
Date: Tue, 17 Apr 2012 00:10:18 +0200
Message-ID: <20120416221018.GB5606@ecki>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334342707-3326-1-git-send-email-nhorman@tuxdriver.com>
 <1334342707-3326-3-git-send-email-nhorman@tuxdriver.com>
 <20120415104212.GC6263@ecki>
 <20120416153827.GC13366@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 00:30:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJuR8-0004hT-Gz
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 00:30:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755274Ab2DPWaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 18:30:12 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:49948 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751474Ab2DPWaL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 18:30:11 -0400
Received: from [127.0.0.1] (p5B22C2B7.dip.t-dialin.net [91.34.194.183])
	by bsmtp.bon.at (Postfix) with ESMTP id 5F042A7EBB;
	Tue, 17 Apr 2012 00:31:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20120416153827.GC13366@hmsreliant.think-freely.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195715>

On Mon, Apr 16, 2012 at 11:38:27AM -0400, Neil Horman wrote:
> > 
> > I find it a bit strange, that if we cherry-pick a commit that was
> > already empty, we _do_ call git commit (and error out), but if we find a
> > commit that is made empty, we do _not_ call git commit and quietly
> > succeed (in not doing anything). But I suppose that is the legacy
> > behavior?
>
> Correct, more or less.  The legacy behavior is to call git commit unilaterally.
> [...] The only change is that if we do not specify
> keep-redundant-commits, we check to see if the commit is made empty in
> git-cherry-pick and skip it if it is.  We could, instead of returning prior to
> calling git-commit, use that test to override the keep_empty option below, so
> that we don't pass --allow-empty to git-commit instead.  That would preserve the
> prior code path, but for no real advatage, as the outcome is the same, and this
> way saves us having to fork the git-commit command, which I think is
> adventageous.

Except that the outcome is not the same. With and without your changes,
git cherry-pick <empty-commit> fails. But with your changes, git
cherry-pick <commit-will-become-empty> will succeed and do nothing,
while before it would have failed exactly like git cherry-pick
<empty-commit>.

So I am not arguing whether failing or skipping is the better default
behavior. But the legacy behavior is consistent between the empty-commit
and commit-will-become-empty cases.  And if we change the behavior for
one, why not also for the other?
