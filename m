Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7C9C43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D29222C2
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xm73SzgD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfLSWBP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 17:01:15 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52306 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfLSWBP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 17:01:15 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A215D9891A;
        Thu, 19 Dec 2019 17:01:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iEkzhV44fI8GbrzwxdOk7Vt5rHc=; b=Xm73Sz
        gDA5EkyQ3nU5uPtqLr+gvRFOjmqT4wvG45UC+aJgdY5goKMIdnQntP6WeM3TErhn
        1xT0JquKnOW6y0idCFt7LREB3OwYd99wkI0nkc1IwS940rF73Z2LIX8fkD86MJe0
        6jmKAnqZMES7VmgT8QEgbLlQ1MVMtDSDbB9vQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ls3I9NOyAJo4SQ8KkJLhBhdEBAsok+7z
        aR/LZJWwgIpE29Q1U6ogkT59p6diGXQaxJ8N+yeJ/w9m9E4qhAoFYahgYHmy1I/H
        /f9WmUiqAoA4j5pawYD3jAaB5wVVlC8Tc3WK8vFpzy4fmTcFP6cPRGGayjFot0Lt
        tQzYlgWx2Lw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9A31F98918;
        Thu, 19 Dec 2019 17:01:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C678698915;
        Thu, 19 Dec 2019 17:01:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ed Maste <emaste@freebsd.org>
Cc:     Eric Wong <e@80x24.org>, git mailing list <git@vger.kernel.org>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH] sparse-checkout: improve OS ls compatibility
References: <20191219015833.49314-1-emaste@FreeBSD.org>
        <20191219024518.GA3411@dcvr>
        <xmqqpngkb2ye.fsf@gitster-ct.c.googlers.com>
        <CAPyFy2BubWbyq6tQmHYxquikn2+uHz+48VSfQ308BYiuE=SSWQ@mail.gmail.com>
Date:   Thu, 19 Dec 2019 14:01:09 -0800
In-Reply-To: <CAPyFy2BubWbyq6tQmHYxquikn2+uHz+48VSfQ308BYiuE=SSWQ@mail.gmail.com>
        (Ed Maste's message of "Thu, 19 Dec 2019 15:56:39 -0500")
Message-ID: <xmqqtv5w9dqy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1199C864-22AB-11EA-99B0-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ed Maste <emaste@freebsd.org> writes:

>> Note that the helper function's name no longer reflects what it does
>> with such a change, so it needs to be renamed.  Together with style
>> fix, perhaps
>>
>>         ls_no_dot () {
>>                 (cd "$1" && printf "%s\n *)
>>         }
>>
>> is what we want,
>
> I believe the tests should pass or be skipped when run as root, so I
> think we should either require (something like) SANITY for these
> tests, or make the change above. I'm happy with either option; I'll
> send a v2 based on the approach above for consideration.

OK, after thinking about it a bit more, I think "Your ls is broken"
was completely missing the point.  What we want in the callers of
this helper is to list the contents of a directory, and "ls" is one
possible (and easiest, if there were no "oops, sometimes -A is enabled
 implementation by default" complication) implementation.

And "ls_no_dot" is a misnomer from that point of view.  We are not
even using "ls", so perhaps we should just call it "list_files" or
something?

Thanks.
