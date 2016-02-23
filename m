From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [RFC/PATCH 1/1] format-patch: add an option to record base tree
 info
Date: Tue, 23 Feb 2016 17:17:40 +0800
Message-ID: <20160223091740.GA3830@wfg-t540p.sh.intel.com>
References: <1456109938-8568-1-git-send-email-xiaolong.ye@intel.com>
 <1456109938-8568-2-git-send-email-xiaolong.ye@intel.com>
 <xmqqmvqt8jgz.fsf@gitster.mtv.corp.google.com>
 <20160223014741.GA21025@wfg-t540p.sh.intel.com>
 <xmqqio1f3oi9.fsf@gitster.mtv.corp.google.com>
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
X-From: linux-kernel-owner@vger.kernel.org Tue Feb 23 10:18:01 2016
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1aY96V-0002Nq-PX
	for glk-linux-kernel-3@plane.gmane.org; Tue, 23 Feb 2016 10:18:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085AbcBWJRv (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 23 Feb 2016 04:17:51 -0500
Received: from mga03.intel.com ([134.134.136.65]:49112 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751949AbcBWJRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Feb 2016 04:17:45 -0500
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP; 23 Feb 2016 01:17:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,488,1449561600"; 
   d="scan'208";a="657714706"
Received: from liquan1-mobl1.ccr.corp.intel.com (HELO wfg-t540p.sh.intel.com) ([10.254.214.237])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Feb 2016 01:17:41 -0800
Received: from wfg by wfg-t540p.sh.intel.com with local (Exim 4.86)
	(envelope-from <fengguang.wu@intel.com>)
	id 1aY96C-0001pS-HN; Tue, 23 Feb 2016 17:17:40 +0800
Content-Disposition: inline
In-Reply-To: <xmqqio1f3oi9.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287035>

Hi Junio and All,

CC more relevant people. FYI this thread starts here:

        http://thread.gmane.org/gmane.comp.version-control.git

On Mon, Feb 22, 2016 at 10:54:38PM -0800, Junio C Hamano wrote:
> Fengguang Wu <fengguang.wu@intel.com> writes:
> 
> > Hi Junio,
> >
> > On Sun, Feb 21, 2016 at 08:19:56PM -0800, Junio C Hamano wrote:
> >> Xiaolong Ye <xiaolong.ye@intel.com> writes:
> >> 
> >> > It would be helpful for maintainers or reviewers to know the base tree
> >> > info of the patches created by git format-patch. Teach git format-patch
> >> > a --base-tree-info option to record these info.
> >> >
> >> > Signed-off-by: Xiaolong Ye <xiaolong.ye@intel.com>
> >> > ---
> >> 
> >> I have a mixed feeling about this one, primarily because this was
> >> already tried quite early in the life of "format-patch" command.
> >> 
> >>     http://thread.gmane.org/gmane.comp.version-control.git/9694/focus=9757
> >> 
> >> Only the name is different (it was called "applies-to" and named a
> >> tree object).
> >
> > Either commit or tree object will work for us. We can use it in
> > v2 if you prefer tree object.
> 
> Sorry, I think you misunderstood.  By only the name is different, I
> didn't mean to say that the tree object name should be shown as the
> old proposal did.  What I meant but didn't explicitly say, as I
> thought it was sufficient to point at an old discussion thread, was
> that this was already tried and rejected.  This round uses different
> name but does essentially the same thing as the old proposal, and I
> do not think I heard anything new that supports this patch against
> earlier rejection by Linus.  That is what gave me a mixed feeling.

I can understand the rejection by Linus in development process POV.

However we are facing a new situation: in test robot POV, IMHO there
are values to test exactly the same tree as the patch submitter.
Otherwise the robot risks

- false negative: failing to apply and test some patches
- false positive: sending wrong bug reports due to guessed wrong base tree

> >> Is it your goal to insist on one exact commit the patch is applied
> >> to?
> >
> > Right. Our goal is fully automated patch testing, where the base tree
> > info is required for *reliably* avoid reporting false positives.
> >
> > A clean git-apply does not guarantee the resulted code is logically
> > consistent and hence testable by 3rd party. For a 3rd party tester to
> > provide useful and trustable test reports, he must apply the patch to
> > exactly the same base as the patch submitter.
> 
> The patch submitter (or you as a third party tester) is not in the
> position to dictate the integrator to apply the patch to one
> specific commit and use it from there.  The integrator would pick an
> appropriate base that would be different from the commit where the
> patch was taken from, apply it there, and merge the result to the
> tip of the mainline, or apply the patch directly to the tip of the
> mainline.  Even if the integrator picked the commit the patch was
> taken from, the result would not be used alone without any other
> changes, i.e. before getting merged into the integration branch.

Yeah. Per my understanding the base commit info will be mainly parsed
by test robots instead of integrators.

> So in that sense, any test that is done by the patch submitter and
> the third party tester would not be what will be released to the
> wild *anyway*.  The resulting code will be exercised in a context
> that *is* different from the context the original author had.

That's right. But no worry, when the patch is merged by maintainer,
we'll test it once again in the maintainer tree.

Pre-merge patch testing is useful in 2 ways:

- shift left testing to early review stage

- maintainer trees are typically not rebaseable. When errors are
  discovered there, it's a bit too late: the error will likely remain
  in git history for ever. Which will hurt bisects.

> I can see that recording the exact commit object name allows you to
> claim that you identified the exact commit to apply the patch, and
> that you tested the exact tree contents.  It however is unclear what
> the value of such a claim would be to the project or to the
> integrator.

The value of base commit info is: providing a solid ground to the
tester, to reliably avoid false positive/negatives.

> So I dunno.

FYI, the 0day test robot will be able to work better if provided the
base commit info. It'll work a bit more sophisticated than simply
relying on the base commit info: if it's sure about the tree the patch
is targeted for (or the maintainer would apply to), it'll use that as
base tree[*]; otherwise it'll fall back to using the base commit info
included in the patchset.

[*] For examples,

        [PATCH -mm] ...
        [PATCH net] ...

For such patches we are sure they are targeted for the well known
mm/net trees.

Anyway the worst case of not adopting the discussed patch is, the 0day
test robot continue to work in current heuristic way.

Thanks,
Fengguang
