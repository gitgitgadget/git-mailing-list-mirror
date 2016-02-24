From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [RFC/PATCH 1/1] format-patch: add an option to record base tree
 info
Date: Wed, 24 Feb 2016 10:55:19 +0800
Message-ID: <20160224025519.GB16562@wfg-t540p.sh.intel.com>
References: <1456109938-8568-1-git-send-email-xiaolong.ye@intel.com>
 <1456109938-8568-2-git-send-email-xiaolong.ye@intel.com>
 <xmqqmvqt8jgz.fsf@gitster.mtv.corp.google.com>
 <20160223014741.GA21025@wfg-t540p.sh.intel.com>
 <xmqqio1f3oi9.fsf@gitster.mtv.corp.google.com>
 <20160223091740.GA3830@wfg-t540p.sh.intel.com>
 <20160223103253.GE5273@mwanda>
 <20160223120015.GA10488@wfg-t540p.sh.intel.com>
 <20160223133135.GF5273@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Xiaolong Ye <xiaolong.ye@intel.com>, git@vger.kernel.org,
	ying.huang@intel.com, philip.li@intel.com, julie.du@intel.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Christoph Hellwig <hch@lst.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	LKML <linux-kernel@vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 03:56:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYPcU-0001o4-4Q
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 03:56:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679AbcBXCzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 21:55:50 -0500
Received: from mga01.intel.com ([192.55.52.88]:35094 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750899AbcBXCzs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 21:55:48 -0500
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP; 23 Feb 2016 18:55:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,492,1449561600"; 
   d="scan'208";a="658251356"
Received: from wfg-t540p.sh.intel.com ([10.239.197.212])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Feb 2016 18:55:20 -0800
Received: from wfg by wfg-t540p.sh.intel.com with local (Exim 4.86)
	(envelope-from <fengguang.wu@intel.com>)
	id 1aYPbj-0004ZX-Lx; Wed, 24 Feb 2016 10:55:19 +0800
Content-Disposition: inline
In-Reply-To: <20160223133135.GF5273@mwanda>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287161>

On Tue, Feb 23, 2016 at 04:31:35PM +0300, Dan Carpenter wrote:
> Blergh...  You want it machine readable and I want it human readable.  I

Yeah. It's kind of tasting which may differ among people. I'll leave
the judgments to Junio and others, and only add necessary comments to
your points.

> don't care so much about the cover letter but for the first patch then I
> really want something minimal (one line) and human readable.
> 
> base tree/branch: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> base commit: afd2ff9b7e1b367172f18ba7f693dfb62bdcb2dc
> base patch-id: a849260a843115dbac4b1a330d44256ee6b16d7b
> base patch-subject: Linux 4.4
> base tag: v4.4

The necessary lines for the robot are

        base commit:
        base patch-id:
or
        base tree-id:
        base patch-id:

The "base tree-id" will be useful if the submitted patchset is based
on a public (maintainer) commit.

The "base patch-id" will be useful if the submitted patchset is based
on another patchset someone (likely the developer himself) posted to
the mailing list.

> To me that looks like an unparseable wall of text.  My version of that
> is:
> 
> Applies-to: afd2ff9b7e1b+ origin
> 
> As a human all I really want to know is the tree to apply this to.  If
> it doesn't apply then I don't debug it, I just send an automatic note
> "This doesn't apply to staging-next.  Please redo."
> 
> I think that Applies-to is a better name and also that grepping for
> "^base " is less reliable than grepping for ^Applies-to.

Grep reliability should be the same, if you use "^base tree-id" and
"^base patch-id". If necessary, we can avoid white space by naming the
keys base-tree-id and base-patch-id.

> I used "origin" because that's the name in Next/Trees.  The + means
> private patches are applied.  That's what we already do in naming the
> kernel.  If the + matters, then I would include a cover letter.
> 
> I have no idea what a "base patch-id" is so that doesn't work at all.

It'll come from this command 

        man git patch-id

It'll be useful if the patchset's base commit is a private one -- not
in any public maintainer tree, however the developer may have posted
it to LKML before.

The "base patch-id" can more reliably track different versions of
patches than "base patch-subject", and do not have the risk of
information leaking in case it's a confidential patch.

> Including the tag is just duplicative since we already have the hash.

That's right. Just in case it's more human readable.

> In my email, I proposed that we list all the other private patches in a
> cover letter, but I think you are saying that we only need to know the
> most recent private patch?

Yes in test robot POV. However it's a general git feature, so I guess
there will be more potential use cases and requirements.

> Another idea would be to list them newest
> to oldest (git log order instead of email order) in the cover letter.
> 
> Btw, I always work against linux-next and Dave M is always getting
> annoyed with me for not marking which patches go to net and which go to
> net-next.  I don't use git format-patch, but I will probably start using
> "Applies-to: net" or "Applies-to: net-next".

As for now, I see the netdev ML has the convention

        [PATCH net]
        [PATCH net-next]

to tell Dave the target tree.

Thanks,
Fengguang
