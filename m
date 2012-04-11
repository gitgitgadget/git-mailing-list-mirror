From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH v3 1/4] git-cherry-pick: add allow-empty option
Date: Tue, 10 Apr 2012 20:44:20 -0400
Message-ID: <20120411004419.GA19616@neilslaptop.think-freely.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334072868-9435-1-git-send-email-nhorman@tuxdriver.com>
 <1334072868-9435-2-git-send-email-nhorman@tuxdriver.com>
 <7v62d7qzu9.fsf@alter.siamese.dyndns.org>
 <20120410181317.GA17776@hmsreliant.think-freely.org>
 <7vfwcbpem5.fsf@alter.siamese.dyndns.org>
 <20120410200019.GC17776@hmsreliant.think-freely.org>
 <7v8vi3pbtf.fsf@alter.siamese.dyndns.org>
 <20120410203944.GA12139@hmsreliant.think-freely.org>
 <7v4nsrpa4i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 02:44:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHlfq-0004yd-Ak
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 02:44:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755768Ab2DKAoc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 20:44:32 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:54596 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951Ab2DKAob (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 20:44:31 -0400
Received: from neilslaptop.think-freely.org ([2001:470:8:a08:4a5d:60ff:fe96:79da] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SHlfc-0007pJ-2O; Tue, 10 Apr 2012 20:44:26 -0400
Content-Disposition: inline
In-Reply-To: <7v4nsrpa4i.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195140>

On Tue, Apr 10, 2012 at 02:09:17PM -0700, Junio C Hamano wrote:
> Neil Horman <nhorman@tuxdriver.com> writes:
> 
> > ...  What do you say to my proposal regarding the splitting of the device
> > dependent on how we were executed?  It seems we can't use a single advice string
> > in this case, as no matter which we choose there is a use case in which it fails
> > to make sense.
> 
> When your cherry-pick got --allow-empty, it should pass --allow-empty to
> its inner invocation of commit if it is picking an originally empty
> commit, and this advice will not trigger because commit will happily
> commit the no-change change.
> 
> When your cherry-pick got --allow-empty but not --keep-unnecessary-commit,
> its inner invocation of commit must not pass --allow-empty if it is _not_
> picking an originally empty commit.  Then the inner commit will fail if it
> auto resolves to no change, and the user sees the advice.  The current
> advice text is appropriate for this case.
> 
> When your cherry-pick did not get either of these flags, its inner
> invocation of commit must not pass --allow-empty.  The user sees the
> advice when the auto resolved result matches HEAD from the commit invoked
> by cherry-pick.  The current advice text is fine for this case, as we say
> "possibly", not "we definitely know it was due to conflict resolution".
> 
> Or your cherry-pick may have failed due to a conflict, regardless of the
> options like --allow-empty or --keep-unnecessary-commit given to it, and
> the user may have run commit after resolving the conflict.  The current
> advice text is fine for this case, too, as we say "possibly", and it
> indeed is what just happened.
> 
> So I do not think you need to change anything with respect to the advice
> message.
> 
> Am I missing some other cases?
> 
No, you covered all the cases, but I disagree with your assertion that the advice
is correct (or at least optimal) in any of these cases. If a cherry-pick without
any options is preformed and the commit is empty (regardless of the reason), the
advice given is that git commit --allow-empty should be used.  With the addition
of these new options, thats not true any longer.  Instead of using git commit
--allow-empty, you can use git cherry-pick --allow-empty.

Given your description above though, I'm ok rolling this back.  Regardless of my
disagreement, git commit --allow-empty still works just as well after the
addition of these options, so while I still think its awkward to give git commit
advice on the result of a git cherry-pick operation,  its not any more
problematic than the issues you've pointed out with my change.  I'll roll this
back in my next version and will look for a way to provide better advice in the
future.

Regards
Neil

> 
