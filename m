From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC/PATCH 1/1] format-patch: add an option to record base tree info
Date: Tue, 23 Feb 2016 12:46:17 -0800
Message-ID: <3FAB2030-8106-4114-99A4-B04A8A0D22FB@zytor.com>
References: <1456109938-8568-1-git-send-email-xiaolong.ye@intel.com> <1456109938-8568-2-git-send-email-xiaolong.ye@intel.com> <xmqqmvqt8jgz.fsf@gitster.mtv.corp.google.com> <20160223014741.GA21025@wfg-t540p.sh.intel.com> <xmqqio1f3oi9.fsf@gitster.mtv.corp.google.com> <20160223091740.GA3830@wfg-t540p.sh.intel.com> <xmqq1t8319z0.fsf@gitster.mtv.corp.google.com> <87d1rnjil4.fsf@x220.int.ebiederm.org> <xmqqtwkzyxkv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Fengguang Wu <fengguang.wu@intel.com>,
	Xiaolong Ye <xiaolong.ye@intel.com>, git@vger.kernel.org,
	ying.huang@intel.com, philip.li@intel.com, julie.du@intel.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	LKML <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, ebiederm@xmission.com
X-From: linux-kernel-owner@vger.kernel.org Tue Feb 23 21:47:21 2016
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1aYJrc-0005oH-JO
	for glk-linux-kernel-3@plane.gmane.org; Tue, 23 Feb 2016 21:47:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755410AbcBWUrJ (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 23 Feb 2016 15:47:09 -0500
Received: from terminus.zytor.com ([198.137.202.10]:49020 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754469AbcBWUrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Feb 2016 15:47:07 -0500
Received: from [IPv6:2607:fb90:a517:964a:47f9:4721:4aa:c789] ([IPv6:2607:fb90:a517:964a:47f9:4721:4aa:c789])
	(authenticated bits=0)
	by mail.zytor.com (8.15.2/8.14.5) with ESMTPSA id u1NKkJ07012766
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 23 Feb 2016 12:46:20 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <xmqqtwkzyxkv.fsf@gitster.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287114>

On February 23, 2016 12:35:12 PM PST, Junio C Hamano <gitster@pobox.com> wrote:
>ebiederm@xmission.com (Eric W. Biederman) writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> It is valuable for a testing organization to say "We tested this
>>> series on top of version X.  We know it works, we have tested on a
>>> lot more hardware than the original developer had, we know this is
>>> good to go."  It is a valuable service.
>>>
>>> But that is valuable only if version X is still relevant, isn't it?
>>>
>>> Is the relevance of a version something that is decided by a
>>> developer who submits a patch series, or is it more of an attribute
>>> of the project and where the current integration is happening?
>>> Judging from the responses from Dan to this thread, I think the
>>> answer is the latter, and for the purpose of identifying the
>>> relevant version(s), the project does not even care about the exact
>>> commit, but it wants to know more about which branch the series is
>>> targetted to.
>>>
>>> With that understanding, I find it hard to believe that it buys the
>>> project much for the "base" commit to be recorded in a patch series
>>> and automated testing is done by applying the patches to that exact
>>> commit, which possibly is no-longer-relevant, even though it may
>>> help shielding the testing machinery from "you tested with a wrong
>>> version" complaints.
>>>
>>> Isn't it more valuable for the test robot to say "this may or may
>>> not have worked well with whatever old version the patch series was
>>> based on, but it no longer is useful to the current tip of the
>>> 'master'"?  If you consider what benefit the project would gain by
>>> having such a robot, that is the conclusion I have to draw.
>>>
>>> So I still am not convinced that this "record base commit" is a
>>> useful thing to do.
>>
>> So I don't know what value this has to the git project.
>
>Oh, don't worry, I wasn't talking about value this may have to the
>Git project at all.  "The value to the project" I mentioned in my
>response was all about the value to the kernel project.
>
>> The value of Fengguag's automated testing to the kernel project is to
>> smoke out really stupid things.
>
>I'll snip your bullet points, but as I wrote, I do understand the
>value of prescreening test.
>
>What I was questioning was what value it gives to that testing to
>use "the developer based this patch on this exact commit" added to
>each incoming patch, and have Fengguag's testing machinery test a
>patch with a base version that may no longer be relevant in the
>context of the project.  Compared to that, wouldn't "this no longer
>applies to the branch the series targets" or "this still applies
>cleanly, but no longer compiles because the surrounding API has
>changed" be much more valuable?
>
>In your other message, you mentioned the "index $old..$new" lines,
>and it is possible to use them to find a tree that the patch cleanly
>applies to, but it will not uniquely identify _the_ version the
>patch submitter used.  IMHO, finding such _a_ tree from the recent
>history of the branch that the patch targets and testing the patch
>on top of that tree (as opposed to testing the patch in the exact
>context the developer worked on) would give the project a better
>value.

Personally, as a maintainer, I would love to see the tree ID and ideally also the commit ID a series is based on.  The commit ID is in some ways less useful since it is non-recreatable (and therefore will never match for anything but the first patch of a series), but could be useful to the maintainer.

As far as putting in a bunch of metainformation that has to be manually or semimanually obtained, there are a lot of issues with that, as it way too easily turns into wrong information or potential information leaks that might make corporate contributors uncomfortable.
-- 
Sent from my Android device with K-9 Mail. Please excuse brevity and formatting.
