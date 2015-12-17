From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 10/10] dir: do not use untracked cache ident anymore
Date: Thu, 17 Dec 2015 10:33:27 -0800
Message-ID: <xmqq1talc4co.fsf@gitster.mtv.corp.google.com>
References: <1450196907-17805-1-git-send-email-chriscool@tuxfamily.org>
	<1450196907-17805-11-git-send-email-chriscool@tuxfamily.org>
	<xmqqd1u7fq5r.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD0Y252vmqxziy4Y8Bp3cw6fS0iOVFzZG+=wGt7K25V8Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 17 19:33:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9dMt-0004yv-PQ
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 19:33:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753882AbbLQSdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 13:33:32 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62020 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752673AbbLQSda (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 13:33:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 059F933082;
	Thu, 17 Dec 2015 13:33:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0WVFLnUJbADyN3mtALsJRL4BXKw=; b=cAYUcJ
	tUhh2/iFoWHV/Zu8TBYkhYhIF2/l5/MYRoI0L1KguTgiNsNydCmhekf71VkR7yvs
	sGi9t7E5G7AvQA2SYdEm0xT99gapMnyBd9yMTmY+oUlHaxpqy0BMEL5tzEHaLSCI
	E12ctDyRi42Yt5SXqQxCrwAGi/GmL5gS/uSY8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jQ4aeUp53PrGJiNBPfnuiB8eMG1C1JLk
	h0kPtKsqHtR7kg/pTgnTbNGRLGyzOoS3Oo9RAYrxf1EoQ4jPEvjbb1sPAQXNlLjK
	m4XLrp5YcHGfrfmw0JUzdX0f/KZPQZvd9e/0HTap0z6zqRn0bNeL+KX2oLNMj/2s
	lrD3qFtOtoI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F068533081;
	Thu, 17 Dec 2015 13:33:28 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 599B43307D;
	Thu, 17 Dec 2015 13:33:28 -0500 (EST)
In-Reply-To: <CAP8UFD0Y252vmqxziy4Y8Bp3cw6fS0iOVFzZG+=wGt7K25V8Yg@mail.gmail.com>
	(Christian Couder's message of "Thu, 17 Dec 2015 17:54:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AA812888-A4EC-11E5-9379-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282665>

Christian Couder <christian.couder@gmail.com> writes:

> In the "git worktree" documentation there is:
>
> "If you move a linked working tree to another file system, or within a
> file system that does not support hard links, you need to run at least
> one git command inside the linked working tree (e.g. git status) in
> order to update its administrative files in the repository so that
> they do not get automatically pruned."
>
> It looks like git can detect when a worktree created with "git
> worktree" has been moved and I wonder if it would be possible to
> detect if the main worktree pointed to by GIT_WORK_TREE as moved.

As I personally do not find "moving a working tree" a very
compelling use case, I'd be fine if cached information is not used
when the actual worktree and the root of the cached untracked paths
are different.

If you are going to change the in-index data of untracked cache
anyway (like you attempted with 10/10 patch), I think a lot more
sensible simplification may be to make the mechanism _always_ keep
track of the worktree that is rooted one level above the index, and
not use the cache in all other cases.  That way, if you move the
working tree in its entirety (i.e. $foo/{Makefile,.git/,untracked}
all move to $bar/. at the same time), the untracked cache data that
was in $foo/.git/index, which knew about $foo/untracked, will now
know about $bar/untracked when the index is moved to $bar/.git/index
automatically.
