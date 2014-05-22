From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git reset for index restoration?
Date: Thu, 22 May 2014 15:18:23 -0700
Message-ID: <xmqq1tvlmp8w.fsf@gitster.dls.corp.google.com>
References: <1400775763.1933.5.camel@stross>
	<CABPp-BHtYnput7SiAbnqUjpDibTi5o_2MAXfSj17fCdKSC7Hjg@mail.gmail.com>
	<1400782642.18134.8.camel@stross>
	<20140522183930.GB1167@sigill.intra.peff.net>
	<1400785669.18134.21.camel@stross>
	<20140522190959.GA18785@sigill.intra.peff.net>
	<20140522193030.GA22383@sigill.intra.peff.net>
	<xmqqha4hmr9d.fsf@gitster.dls.corp.google.com>
	<1400795586.18134.40.camel@stross>
	<xmqqd2f5mq5h.fsf@gitster.dls.corp.google.com>
	<1400796077.18134.41.camel@stross>
	<xmqq61kxmphw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 23 00:18:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnbJo-0004KQ-Ti
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 00:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987AbaEVWS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 18:18:29 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50611 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751899AbaEVWS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 18:18:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C1B9119E98;
	Thu, 22 May 2014 18:18:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=44jSlr3jXVXHdGQiTgZrI0PsrJU=; b=V8ok1M
	QfcbM4pI4uue07GGrlfo5pBva/o5Gb5HQUF26ZHC+9dNxN1piC/imntxl4MmP5aW
	VeQp7k/v6po7eTpFOQIWhoHwJA7+kd8kO/kwXP0525ryFhZe0kg18P9FPaoY9PNR
	hmCJKnKK7eBT1SyJsjyv/5AlbP3mPUE/+n2iQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AxYqxnr86DrWlix/kSQhLseEfjby8W7D
	VcDqL57lX+cpGidRt5m7OMiTxvysewYf/lNGKJ8T9cdMy8oLtMGfumG6ghP774nP
	VwIb6MFV7qb0GUXhA+tK3QYTbeK6cSg/Xu+ULMb/UQ01OlCPxq50tV6yhzWUL1te
	LLAPb8+Yh0o=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B837119E97;
	Thu, 22 May 2014 18:18:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9E4D919E93;
	Thu, 22 May 2014 18:18:24 -0400 (EDT)
In-Reply-To: <xmqq61kxmphw.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 22 May 2014 15:12:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FDC2BFBE-E1FE-11E3-888C-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249952>

Junio C Hamano <gitster@pobox.com> writes:

> David Turner <dturner@twopensource.com> writes:
>
>>> Yes.  As I said, that should not usually be a problem for those who
>>> do the real work (read: commit), at which time write-tree will fully
>>> populate the cache-tree.
>>
>> Git commit does not in fact populate the cache-tree.
>
> If that is the case, we must have broken the write-tree codepath
> over time.
>
> Of course, "git commit foo" will need to prepare a temporary index
> where only the entry "foo" is different from the HEAD version, write
> the tree to create a commit, but we do not write out the main index
> as a tree after updating the same entry "foo" in it (there may be
> other changes relative to HEAD), so its cache-tree is only
> invalidated at "foo" when we updating the entry and we do not spend
> extra cycles to repopulate it.
>
> But at least my understanding has been that "git commit" (no partial
> commit, write the whole index as a commit) which uses the "git
> write-tree" machinery knows which subtree has what tree object name
> and populates the cache-tree fully.

... and the "incrementally repair" Peff talks about would be to
cover more cases where we may know (either because we have already
computed it to write out a subtree, or we have just read from a
known tree to populate a part of the index and we know the paths in
the index that correspond to that subtree are exactly the same ones
as found in the tree we read from) parts of the cache-tree can be
updated with tree object names for subtrees, but we don't do
anything right now.  "git commit foo" (where "foo" is a directory)
may be able to say "The cache-tree entry for 'foo' can be updated
with the tree object of the new HEAD:foo because we know they must
match in the main index", for example.
