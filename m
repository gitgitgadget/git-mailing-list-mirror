From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Loosening "two project merge" safety
Date: Thu, 21 Apr 2016 15:29:08 -0700
Message-ID: <xmqqtwiur3yj.fsf@gitster.mtv.corp.google.com>
References: <20160421192500.23563-1-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Yaroslav Halchenko <yoh@onerussian.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Joey Hess <id@joeyh.name>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 00:29:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atN64-0003Aa-D6
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 00:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbcDUW3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 18:29:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57508 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751659AbcDUW3L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 18:29:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2905B15C14;
	Thu, 21 Apr 2016 18:29:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0C2Cd15R5LpJJaYiIT1BHYGIsok=; b=gGizb4
	aZk8Vo0rXzOhlAQfGKwdAtxCUYIfoA1U+diW7YefhrMR4s+mswa7ATqieaYEyPGx
	vHwN3z0sHN4ZxsK/FUvcq0vVzLeii5QLWKSPFcq/wAYHbYrgopI/b7KvsgRHmSoe
	U+yAiqMW1/mKyOXBVK9LkASE8vYwR1xJ1jl8A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vlxzQ0FPCJaR594wMxkqLkPDOA3EUQhU
	AgebX7OMkZxIGOsJiKbSdh4Yp/LV+EuQQBM9kVJU9GnMd061HmOejOCGW56nt2Tl
	zqGZmQ393tKBniDfjimQTbCiY2XpHc4IBhb3YuOrumx4UE0aSd1L4UXY3uay2sdk
	4F9Z9d5+NVk=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2215615C13;
	Thu, 21 Apr 2016 18:29:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 939B515C11;
	Thu, 21 Apr 2016 18:29:09 -0400 (EDT)
In-Reply-To: <20160421192500.23563-1-gitster@pobox.com> (Junio C. Hamano's
	message of "Thu, 21 Apr 2016 12:24:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 775855DA-0810-11E6-B1ED-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292157>

Junio C Hamano <gitster@pobox.com> writes:

> Yaroslav Halchenko gave a vague "forcing 'git merge' users to always
> give --allow-unrelated-histories option when they create crap/insane
> merges are not nice", which I couldn't guess the validity due to
> lack of concrete use case.  Just in case it is substantiated, here
> is a series to selectively and safely loosen the safety for specific
> use cases and users.
>
> Junio C Hamano (4):
>   t3033: avoid 'ambiguous refs' warning
>   pull: pass --allow-unrelated-histories to "git merge"
>   merge: GIT_MERGE_ALLOW_UNRELATED_HISTORIES environment
>   merge: introduce merge.allowUnrelatedhistories configuration option

I've queued the first two on 'pu'.

I do not think the Kernel folks do not mind the latter two too much,
but I am holding onto them for now.  Unless the original "Gaah" did
not come from Linus, I might even have said that this additional
safety should be opt-in for people who know what they are doing
(i.e. those who want the safety would set the new configuration),
but I am undecided right now.

>
>  Documentation/git-merge.txt     | 14 +-------------
>  Documentation/git.txt           |  7 +++++++
>  Documentation/merge-config.txt  |  7 +++++++
>  Documentation/merge-options.txt |  8 ++++++++
>  builtin/merge.c                 |  6 ++++++
>  builtin/pull.c                  | 11 +++++++++++
>  t/t3033-merge-toplevel.sh       | 31 ++++++++++++++++++++++++++++++-
>  t/t5521-pull-options.sh         | 28 ++++++++++++++++++++++++++++
>  8 files changed, 98 insertions(+), 14 deletions(-)
