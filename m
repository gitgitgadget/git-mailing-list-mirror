From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC/GSoC 00/17] A barebones git-rebase in C
Date: Mon, 14 Mar 2016 11:43:23 -0700
Message-ID: <xmqq8u1kaoj8.fsf@gitster.mtv.corp.google.com>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
	<CACsJy8BmiqFJ1tN6-uAWqXMUyvGRdWP2DVfgwE56Y1K9KHCsfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Tan <pyokagan@gmail.com>, Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>, sam.halliday@gmail.com
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 19:43:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afXSk-0000bf-Mm
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 19:43:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147AbcCNSn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 14:43:27 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63054 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750853AbcCNSn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 14:43:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 385A74BED5;
	Mon, 14 Mar 2016 14:43:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=znzkjy0k/Wbkqa/f/9zc34U/UDQ=; b=tIdYI1
	eGEklcnJ+L1DRImB0JieMInYRUNLUNlSJWz+wqIa8qBNS926qebmlTE5oFkGX40R
	vHGp/17Lvz7nEYZ8yOat/hzYAxqGKkZEnnnuyNIP9jEqLjd0FdkaoiYL1butHdzB
	uBTuhRfzU+aJakQgUrKjOIQuDu2Pex7OiPquM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w1uJXZAcBKmKG8oQKsZbXkBs1xUYdGL6
	XoocD3y9uVJectQAjIAjXdx1MOPL/6ppBQEneg70nV0XKRKAzKuMctBhixB1w4A4
	M6P+NmNtBzy2VxP2+DqfnvQZOiV7B6XUyhypJL3KVNEOmwndULXfeNtL39gy7h0v
	dSB7wjzRTuM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2E0514BED4;
	Mon, 14 Mar 2016 14:43:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9DE5E4BED3;
	Mon, 14 Mar 2016 14:43:24 -0400 (EDT)
In-Reply-To: <CACsJy8BmiqFJ1tN6-uAWqXMUyvGRdWP2DVfgwE56Y1K9KHCsfQ@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 14 Mar 2016 19:15:45 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A24425D6-EA14-11E5-A530-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288801>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, Mar 12, 2016 at 5:46 PM, Paul Tan <pyokagan@gmail.com> wrote:
>> So, we have around a 1.4x-1.8x speedup for Linux users, and a 1.7x-13x speedup
>> for Windows users. The annoying long delay before the interactive editor is
>> launched on Windows is gotten rid of, which I'm very happy about :-)
>
> Nice numbers :-) Sorry I can't look at your patches yet. Just a very
> minor comment from diffstat..
>
>>  rebase-am.c                        | 110 +++++++++++
>>  rebase-am.h                        |  22 +++
>>  rebase-common.c                    | 220 ++++++++++++++++++++++
>>  rebase-common.h                    |  48 +++++
>>  rebase-interactive.c               | 375 +++++++++++++++++++++++++++++++++++++
>>  rebase-interactive.h               |  33 ++++
>>  rebase-merge.c                     | 256 +++++++++++++++++++++++++
>>  rebase-merge.h                     |  28 +++
>>  rebase-todo.c                      | 251 +++++++++++++++++++++++++
>>  rebase-todo.h                      |  55 ++++++
>
> topdir is already very crowded. Maybe you could move all these files
> to "rebase" subdir.

I think that makes sense.  I do not expect people depending on being
able to say "git rebase--am" and have it do something useful, so
they won't belong to builtin/, but rebase/{am,common,...}.[ch] makes
sense.

While this series is still in the rough-outline phase, we can review
the patches without such movement, though ;-)
