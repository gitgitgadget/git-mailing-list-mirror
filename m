Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 121BD20189
	for <e@80x24.org>; Wed, 22 Jun 2016 17:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbcFVRV6 (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 13:21:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62018 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750777AbcFVRV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 13:21:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 70E8A25935;
	Wed, 22 Jun 2016 13:21:56 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=klqoQauZcwf5d1AxrkDJ88Dt21o=; b=Owy6/q
	Tbii2mbYuGNImypuO3KOxe5Uddblk4ljmmmer5ifFWCjYTirz+fM5Zz+6gJH8msU
	WteJlKLGmDqXo/UcaASrkGPeF4enK9U27hSz4P0Epc4f+XbiFvwnAjv8UMl9eKME
	o0o+D364Or7RrdkEB1CwkGR43gGqwIQd60Ykk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VvljCsEJLDzYQqcwVpoq53ZuoUIv4Vb1
	2sKojQoLjj6n+1wvhPeVB5cMvm97JLcSdNGzCuEcYOmNSLCuS14qBTLA5lufUGsg
	23JKXu3g2vkr1d6SATJvD2uNyr0/pqeL3ApBmEaxKyOzzRh+FXw7onkbc5meiUiH
	jJbsHnWlTTQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A48625934;
	Wed, 22 Jun 2016 13:21:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EA29325931;
	Wed, 22 Jun 2016 13:21:55 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Make find_commit_subject() consistent with --format=%s
References: <901b24554eb4d0381d74ceb31f7bd08709d5eb25.1466512959.git.johannes.schindelin@gmx.de>
	<cover.1466587806.git.johannes.schindelin@gmx.de>
Date:	Wed, 22 Jun 2016 10:21:53 -0700
In-Reply-To: <cover.1466587806.git.johannes.schindelin@gmx.de> (Johannes
	Schindelin's message of "Wed, 22 Jun 2016 11:34:19 +0200 (CEST)")
Message-ID: <xmqq1t3pnnpq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D1A595B2-389D-11E6-AA54-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> In an intermediate iteration of my rebase--helper patches, I
> accidentally generated commits with more than one empty line
> between the header and the commit message. When using
> find_commit_subject() to show the oneline, it turned up empty, even
> if the output of `git show --format=%s` looked fine.

Much easier to read with s/this developer/I/g ;-)

> Turned out that the pretty-printing machinery helpfully skipped any
> blank lines before the commit message.
>
> In the first iteration of this patch, I failed to notice that
> the skip_empty_lines() function used by the pretty printing (which is
> declared static, and therefore I originally did not use it in order to
> keep the patch as minimal as possible) skips also blank lines.

By the way, I think skip_empty_lines() is misnamed, and I think your
use of "blank lines" in the previous paragraph indicates that you
agree ;-) It probably was OK back when it was a file-local static
helper in pretty.c, but it becomes a part of the global API with
1/2, renaming it to skip_blank_lines() may be a good thing to do
there at the same time.

I could do the tweaking while queuing if you too think it should
happen; that way we'd save one roundtrip ;-).

> To make things truly consistent, I now just make the skip_empty_lines()
> function public, and then use it.

Thanks.  Interdiff looks sensible.
