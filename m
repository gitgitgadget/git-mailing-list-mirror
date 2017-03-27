Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E59F20958
	for <e@80x24.org>; Mon, 27 Mar 2017 00:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751753AbdC0AzZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Mar 2017 20:55:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53928 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751510AbdC0AzY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2017 20:55:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E76AF6F2A7;
        Sun, 26 Mar 2017 20:55:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sYzPvB2K2NZY/dJ4KSW8SzYjkO0=; b=oxqExZ
        OKtkpSGkqDWX7gVo4EVzHU0cehPvwaOzTVDYhPOYD7HUKW+SoI7VJZ6CvpKhKymo
        zNIWIzHGMKBIeHw1u8PXASY2A5SjU7+7upTK/aLQog7pCpJRjXqY4l1568XaiQj2
        jHDwAE1CPsSluYmvSnpAah3H/2RIjX50/Whbs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XiWCdk/eUiQHueKGymnIF6XuKdVsrReN
        lc6Tq7RxOHz+yOdRBGrsrNKBM4ZlMrVNIz/gIuyXE7otq6/3iLTJPhw+0tfCoqbj
        f/LJUAQVVbK7/HO/nU2Nnbu+VmP4UGfObhvf4QhZqkl1nvKr+7vrBSRWUMKQYtWO
        O3WnjAMaDso=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DE5276F2A6;
        Sun, 26 Mar 2017 20:55:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 38A1A6F2A4;
        Sun, 26 Mar 2017 20:55:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v2 2/3] sequencer: make commit options more extensible
References: <cover.1490194846.git.johannes.schindelin@gmx.de>
        <cover.1490285210.git.johannes.schindelin@gmx.de>
        <75e2c4fe839602af19811ed3e251eb583ff6c8ad.1490285210.git.johannes.schindelin@gmx.de>
        <xmqq7f3fa3oz.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1703250100340.3767@virtualbox>
Date:   Sun, 26 Mar 2017 17:55:16 -0700
In-Reply-To: <alpine.DEB.2.20.1703250100340.3767@virtualbox> (Johannes
        Schindelin's message of "Sat, 25 Mar 2017 01:01:55 +0100 (CET)")
Message-ID: <xmqqwpbb35e3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0B4BC2FE-1288-11E7-A984-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Making "flags" unsigned was a correct change, but this is now wrong,
>> as "allow" is made unsigned by accident.
> ...
>
> Your patch looks good, you could do even better by reverting that move
> (IIRC it was at the end of the line, and it was set to 0 by default).

I do not think the variable needs to be initialized to anything (it
is not looked at until it gets the result from allow_empty() call).

Anyway, the series is not yet in 'next', so you can replace it to
the shape you would have made it into if you noticed that "allow"
shouldn't be unsigned, while updating the log message to explain
what the change is about (instead of only attempting to justify the
past, which is not interesting in the context of understanding what
this change is about).

As this thing is about fixing a regression visible to end users, I
may get around to fixing things up myself, but I have other topics
to attend to, so...



