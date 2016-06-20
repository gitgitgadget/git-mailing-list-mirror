Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 368311FEAA
	for <e@80x24.org>; Mon, 20 Jun 2016 22:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbcFTWLn (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 18:11:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59597 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752898AbcFTWLj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 18:11:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1100425B38;
	Mon, 20 Jun 2016 18:11:26 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Gmq2oJUHZ8VHKex/nYxd4lq/x/w=; b=rVmTye
	M2kLKoczY4l8R1UneORGDVx2whts6H3oWY0TNi9cCDRyQpF0Q+pq0WaHSAgZFdr6
	t6d3YLYwciuP+ULorSGUrVo5G3GRfYbA0t+4ctq7wo97vyp3VENpzXGgMF6IL2hH
	E4mk44xDtfqeW0owai9GD3V2Ks0f+Tv3ntYZk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=thZrCaTvRWfBxHhazj4TsjP8k/uRDIzQ
	7tgaxUsmm61EAQVqpWngGOZFzeOOWs2u7GeVtcxgK9ttIcdTUMqOKNOldpNB/g4B
	TSDCztfeh8ZUKy8TJatYdmiCvNzESW8xtm/ZfxMETJbBvJnGGa9Za5Rc/DCdGRBw
	q94SeQOMj48=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0884B25B37;
	Mon, 20 Jun 2016 18:11:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8974125B36;
	Mon, 20 Jun 2016 18:11:25 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Norbert Kiesel <nkiesel@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 0/3] fix local_tzoffset with far-in-future dates
References: <CAM+g_NswH8fd8aFPEHfSLYnZWptNU2GX=xTWpehzjTJfJM_GfQ@mail.gmail.com>
	<CAGZ79kZL-ZY_0hZx9uA-ObPvMiD+EWvJYQa+OfCeQe2RLOPECA@mail.gmail.com>
	<CAM+g_NtNAWpLkbErL5-BUyH_3X4rYGfZwO0o-Hfu8zyam8pw7Q@mail.gmail.com>
	<20160620193928.GA3631@sigill.intra.peff.net>
	<20160620194648.GB3631@sigill.intra.peff.net>
	<20160620200011.GC3631@sigill.intra.peff.net>
	<20160620210901.GE3631@sigill.intra.peff.net>
Date:	Mon, 20 Jun 2016 15:11:23 -0700
In-Reply-To: <20160620210901.GE3631@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 20 Jun 2016 17:09:01 -0400")
Message-ID: <xmqqy45zse7o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EDE9ACBA-3733-11E6-ABF4-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I still don't know how that screwed-up timestamp got _into_
> a commit, so perhaps there is another bug lurking.  I couldn't convince
> git to parse anything beyond 2100, and committing with
> GIT_AUTHOR_DATE='@5758122296 +0000' works just fine.

Interesting.  The weirdest I could come up with was with

    GIT_AUTHOR_DATE='@5758122296 -9999

which gets turned into the same timestamp but with -10039 timezone
(simply because 99 minutes is an hour and 39 minutes).

>   [1/3]: t0006: rename test-date's "show" to "relative"
>   [2/3]: t0006: test various date formats
>   [3/3]: local_tzoffset: detect errors from tm_to_time_t

Thanks, will queue.
