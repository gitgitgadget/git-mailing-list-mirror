From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH v5 2/4] git-cherry-pick: Add keep-redundant-commits option
Date: Tue, 17 Apr 2012 06:43:40 -0400
Message-ID: <20120417104340.GA11462@hmsreliant.think-freely.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334342707-3326-1-git-send-email-nhorman@tuxdriver.com>
 <1334342707-3326-3-git-send-email-nhorman@tuxdriver.com>
 <20120415104212.GC6263@ecki>
 <20120416153827.GC13366@hmsreliant.think-freely.org>
 <20120416221018.GB5606@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Apr 17 12:44:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SK5tB-0007LQ-Gu
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 12:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753340Ab2DQKny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 06:43:54 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:47988 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520Ab2DQKny (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 06:43:54 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SK5sr-00067i-2m; Tue, 17 Apr 2012 06:43:46 -0400
Content-Disposition: inline
In-Reply-To: <20120416221018.GB5606@ecki>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195752>

On Tue, Apr 17, 2012 at 12:10:18AM +0200, Clemens Buchacher wrote:
> On Mon, Apr 16, 2012 at 11:38:27AM -0400, Neil Horman wrote:
> > > 
> > > I find it a bit strange, that if we cherry-pick a commit that was
> > > already empty, we _do_ call git commit (and error out), but if we find a
> > > commit that is made empty, we do _not_ call git commit and quietly
> > > succeed (in not doing anything). But I suppose that is the legacy
> > > behavior?
> >
> > Correct, more or less.  The legacy behavior is to call git commit unilaterally.
> > [...] The only change is that if we do not specify
> > keep-redundant-commits, we check to see if the commit is made empty in
> > git-cherry-pick and skip it if it is.  We could, instead of returning prior to
> > calling git-commit, use that test to override the keep_empty option below, so
> > that we don't pass --allow-empty to git-commit instead.  That would preserve the
> > prior code path, but for no real advatage, as the outcome is the same, and this
> > way saves us having to fork the git-commit command, which I think is
> > adventageous.
> 
> Except that the outcome is not the same. With and without your changes,
> git cherry-pick <empty-commit> fails. But with your changes, git
> cherry-pick <commit-will-become-empty> will succeed and do nothing,
> while before it would have failed exactly like git cherry-pick
> <empty-commit>.
> 
> So I am not arguing whether failing or skipping is the better default
> behavior. But the legacy behavior is consistent between the empty-commit
> and commit-will-become-empty cases.  And if we change the behavior for
> one, why not also for the other?
> 

Ah, I see what you're saying.  Yes, hadn't thought of that, Ok, I'll change the
logic to just toggle the addition of the --allow-empty flag to git commit.
Neil
