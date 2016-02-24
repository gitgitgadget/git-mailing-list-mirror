From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [RFC/PATCH 1/1] format-patch: add an option to record base tree
 info
Date: Wed, 24 Feb 2016 11:13:09 +0800
Message-ID: <20160224031309.GA17763@wfg-t540p.sh.intel.com>
References: <1456109938-8568-1-git-send-email-xiaolong.ye@intel.com>
 <1456109938-8568-2-git-send-email-xiaolong.ye@intel.com>
 <xmqqmvqt8jgz.fsf@gitster.mtv.corp.google.com>
 <20160223014741.GA21025@wfg-t540p.sh.intel.com>
 <xmqqio1f3oi9.fsf@gitster.mtv.corp.google.com>
 <20160223091740.GA3830@wfg-t540p.sh.intel.com>
 <xmqq1t8319z0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Xiaolong Ye <xiaolong.ye@intel.com>, git@vger.kernel.org,
	ying.huang@intel.com, philip.li@intel.com, julie.du@intel.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Christoph Hellwig <hch@lst.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	LKML <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Wed Feb 24 04:13:42 2016
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1aYPtV-0007Oj-Kq
	for glk-linux-kernel-3@plane.gmane.org; Wed, 24 Feb 2016 04:13:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755351AbcBXDNc (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 23 Feb 2016 22:13:32 -0500
Received: from mga02.intel.com ([134.134.136.20]:55730 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751957AbcBXDNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Feb 2016 22:13:31 -0500
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP; 23 Feb 2016 19:13:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,492,1449561600"; 
   d="scan'208";a="658259188"
Received: from wfg-t540p.sh.intel.com ([10.239.197.212])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Feb 2016 19:13:10 -0800
Received: from wfg by wfg-t540p.sh.intel.com with local (Exim 4.86)
	(envelope-from <fengguang.wu@intel.com>)
	id 1aYPsz-0004fo-U5; Wed, 24 Feb 2016 11:13:09 +0800
Content-Disposition: inline
In-Reply-To: <xmqq1t8319z0.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287162>

On Tue, Feb 23, 2016 at 11:51:31AM -0800, Junio C Hamano wrote:
> Fengguang Wu <fengguang.wu@intel.com> writes:
> 
> >> >> I have a mixed feeling about this one, primarily because this was
> >> >> already tried quite early in the life of "format-patch" command.
> >> >> 
> >> >>     http://thread.gmane.org/gmane.comp.version-control.git/9694/focus=9757
> >> >> 
> >> >> Only the name is different (it was called "applies-to" and named a
> >> >> tree object).
> >> >
> >> > Either commit or tree object will work for us. We can use it in
> >> > v2 if you prefer tree object.
> >> 
> >> Sorry, I think you misunderstood.  By "only the name is different", I
> >> didn't mean to say that the tree object name should be shown as the
> >> old proposal did.  What I meant but didn't explicitly say, as I
> >> thought it was sufficient to point at an old discussion thread, was
> >> that this was already tried and rejected.  This round uses different
> >> name but does essentially the same thing as the old proposal, and I
> >> do not think I heard anything new that supports this patch against
> >> earlier rejection by Linus.  That is what gave me a mixed feeling.
> >
> > I can understand the rejection by Linus in development process POV.
> >
> > However we are facing a new situation: in test robot POV, IMHO there
> > are values to test exactly the same tree as the patch submitter.
> > Otherwise the robot risks
> >
> > - false negative: failing to apply and test some patches
> > - false positive: sending wrong bug reports due to guessed wrong base tree
> 
> I always get negatives and positives confused, so let me think aloud
> with an example.  Let's say that somebody worked on adding a new
> feature based on v4.2 codebase and sent in a patch series.  The
> series touched files in quiescent part of the system, these files
> are identical between v4.2 and the current codebase at v4.5-rc5, and
> the series applies cleanly to a "wrong" base tree at the tip of
> 'master'.  But it turns out that the series uses an old API that was
> removed in the meantime.  The test robot may say "the result of
> applying the series does not even build" and the developer would
> complain to you saying "You tested with a wrong version".
> 
> I've already said that I can see the value this approach has for
> you.  By having the developer state which commit the series was
> based on, it will shield you from such a complaint, because you
> would not use closer-to-tip 'master' as the base, but instead use
> v4.2 codebase for the test.
> 
> As I said, what is unclear to me is what value this apporach gives
> to the project.

Problem arises when a developer based his work on a maintainer's topic
branch. The robot doesn't know that and tests the patch on v4.5-rc5,
which may trigger a false error because the patch depends on some
changes in that maintainer's topic branch. In that case, the error
report will be pure noise.

Thanks,
Fengguang
