From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/4] format-patch: introduce --base=auto option
Date: Fri, 01 Apr 2016 09:06:20 -0700
Message-ID: <xmqqlh4xjoub.fsf@gitster.mtv.corp.google.com>
References: <1459388776-18066-1-git-send-email-xiaolong.ye@intel.com>
	<1459388776-18066-4-git-send-email-xiaolong.ye@intel.com>
	<xmqqtwjmo84r.fsf@gitster.mtv.corp.google.com>
	<20160401135207.GB2915@yexl-desktop>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, fengguang.wu@intel.com, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Ye Xiaolong <xiaolong.ye@intel.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 18:06:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am1af-0006uJ-Nd
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 18:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759260AbcDAQGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 12:06:24 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:53504 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759253AbcDAQGX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 12:06:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 11E684E54A;
	Fri,  1 Apr 2016 12:06:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4u6Q7ht9PXBjn8G0eZUUsytbj30=; b=a+STBP
	1x5ycAGfAfugjIXc2abdhNjPG6KlNBHoW/MjFPaJMtDDQEtI8+DwPJ+45rZ2ugmY
	AUIOOkYym+TGLB7zLuXaLkXbeG8CbktWqjKt2f1CU7E23BUAQfsxLYJ1IxqmfBAW
	+EaSTBBFhUttubXiEzNT5Q97GCFjFRExj34pE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G/jdfqM67eMxYbOJ8mgCdSHq16T/F5Ks
	sf/FteU72DB669dkleIIj1hZ4qqkNuWTRtSC6zFnxh7xF/1/zwFQKnkVu3I0uP0x
	BRPWx93wIKgzmnKDBHIKt0N2yJwCSYUFJ8aDHDZ9xV0rInKBro49GKTUOOZjtxrn
	tstK6/LNxvQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0735D4E549;
	Fri,  1 Apr 2016 12:06:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5B2EC4E546;
	Fri,  1 Apr 2016 12:06:21 -0400 (EDT)
In-Reply-To: <20160401135207.GB2915@yexl-desktop> (Ye Xiaolong's message of
	"Fri, 1 Apr 2016 21:52:07 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ACF3B664-F823-11E5-9E11-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290555>

Ye Xiaolong <xiaolong.ye@intel.com> writes:

> On Thu, Mar 31, 2016 at 10:43:48AM -0700, Junio C Hamano wrote:
>>Xiaolong Ye <xiaolong.ye@intel.com> writes:
>>
>>> Introduce --base=auto to record the base commit info automatically, the base_commit
>>> will be the merge base of tip commit of the upstream branch and revision-range
>>> specified in cmdline.
>>
>>This line is probably a bit too long.
>
> How about simplifying it to "the base_commit is the merge base of upstream and
> specified revision-range."?

What I meant was not that profound.  I just wanted you to wrap your
lines a bit shorter so that quoting in the discussion thread like
this would not make the result overlong to fit on a 80-column
terminal ;-)

>>> +			base = base_list->item;
>>> +			free_commit_list(base_list);
>>
>>What should happen when there are multiple merge bases?  The code
>>picks one at random and ignores the remainder, if I am reading this
>>correctly.
>
> If there is more than one merge base, commits in base_list should
> be sorted by date, if I am understanding it correctly, so
> base_list->item should be the lastest merge base commit, it should
> be enough for us to used as base commit.

By definition, when there are multiple merge bases, there is no
latest one among them.

When the history involves criss-cross merges, there can be more than
one 'best' common ancestor for two commits.  For example, with this
topology (note that X is not a commit; it merely denotes crossing of
two lines):

       ---1---o---A
      /    \ /
  ---O      X
      \    / \
       ---2---o---o---B

both '1' and '2' are merge-bases of 'A' and 'B'.  And the timestamps
on one (be it committer or author timestamp) being later than those
of the other do not make it any more suitable than the other one.
