Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBD9C47247
	for <git@archiver.kernel.org>; Tue,  5 May 2020 17:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13E2620735
	for <git@archiver.kernel.org>; Tue,  5 May 2020 17:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ARQulAHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbgEER5s (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 13:57:48 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59894 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730093AbgEER5r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 13:57:47 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 74CB4C58BC;
        Tue,  5 May 2020 13:57:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3FRul3JJ0ecGC+mcvU5w/yXLTiI=; b=ARQulA
        Hyjv9IF82z6O0oJb+ho55M7t+IuDbpt5Dgm83GtY9pKUEhAhcoU+WLwLyuChY4wv
        R7yvnndp43xigGB86gzauFye/NWOSjqykyMf0CusIyGiptV3QD+8RD4/xldOFdzs
        UsyiAIUUa7yC35WbWz/0vb1JIrv3IO8Kw/bhw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LOI0e4fqry0qBoHddqhX/tW+IhzNXJL7
        dvNYHFauaS07NDoCGKwAe+ce0KIZhvWH2DrCK9Peldaz5B0WVZwymK/Ut0GlVT8i
        FC4XdaGjWycsxk3dAOCQaOAUJ/ueY6Ke2Q/z69KXAqHD02yDHOdCMeWyBENmq1er
        kixa6dCVqPA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6B8C4C58BA;
        Tue,  5 May 2020 13:57:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A8350C58B9;
        Tue,  5 May 2020 13:57:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] CI: limit GitHub Actions to designated branches
References: <20200504150105.GB11373@coredump.intra.peff.net>
        <cover.1588607262.git.congdanhqx@gmail.com>
        <73de97dfebfccabe9f1bf32ea41aea5008a949cd.1588607262.git.congdanhqx@gmail.com>
        <20200504162311.GE12842@coredump.intra.peff.net>
        <20200504215824.GC45250@syl.local>
        <20200504233634.GB39798@coredump.intra.peff.net>
        <20200505002055.GC64230@syl.local>
        <20200505164326.GA64077@coredump.intra.peff.net>
Date:   Tue, 05 May 2020 10:57:39 -0700
In-Reply-To: <20200505164326.GA64077@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 5 May 2020 12:43:26 -0400")
Message-ID: <xmqqo8r2b6y4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EA4BA172-8EF9-11EA-821D-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But that is missing the point of the exercise, no? The question of what
> gitster/git should do was a side conversation. The purpose of Dscho's
> original patch and Danh's followup was to allow anybody to choose which
> branches in their own fork. I.e.:
>
>>   * Actions is running on all branches, of all forks, all the time.
>
> This is how it works now, and is the exact thing we are trying to fix.

Thanks for clarifying and refocusing the discussion.  I am onboard.

It seems to me that there are only two and half approaches, then:

 - Branch-build is opt-in; only branches that match selected, known,
   and fixed patterns will be built (e.g. 'maint', 'maint-*',
   'master', 'next', 'pu', and 'for-ci/*').

 - Branch-build is opt-out; branches that match selected, known, and
   fixed patterns will be excluded (e.g., '*-wip').

 - If you do not want your branches want to be skipped, you need to
   tweak the commit at the tip (e.g. mark with '[skip ci]' log
   message, munging .github/workflows/ in the tree).

The last one is only there for completeness.  I do not think mucking
with the objects recorded in the history, whether it is a tweaked
log message or tweaked tree contents, is a good way to do this.

More random ideas...

Would it be too much hassle to use notes for a thing like this?
Perhaps push out with refs/notes/skip-ci note attached to a commit
you do not want to be built?  I have a feeling that it gives way
overkill flexibility with little gain (probably too cumbersome to
manage).

Does push into GitHub repository offer an ability to pass arbitrary
push option, to which actions that trigger "on: push" event can
react?

