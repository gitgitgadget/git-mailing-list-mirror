Return-Path: <SRS0=E3tc=7P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC49C433E0
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 17:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18E45206C3
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 17:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tc7RP8fH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgFBRIo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 13:08:44 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58999 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgFBRIn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 13:08:43 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 021DACB427;
        Tue,  2 Jun 2020 13:08:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ucKISUK/nM+o
        SZupE2KH+y9Gk7Q=; b=tc7RP8fHfIw2I+I0cd9yedY1hQVYqi4dNIi3AgvcMslD
        dztEgUdfaiUlet+ZpcfKxbuz+XI89NlzdZR2heFiupkCSHdb9gxTASQo7Y/D3VDz
        hb5eoHnNkA0Lf6WNjQC5kMnS/bm1WgguWugaTQ6HngKMSPbV9QrSPmK1noY54Fo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Qc3zPY
        f+EVFJzI2MQDGz/dBSpN5m0Sm3L0bnXZgx1hMLwvNF9e5ZhcnMcDyF04mjcit/xl
        Iazso3f+cj9L/Cg6gdDoNDFg72CNvnJST2Q/v/E4Cg8cG2OmCiK2kbcRvDEfvouW
        VV9dc4/caYu7ovZXuQy+GDiQJQ04wRDDV+PTg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ED388CB426;
        Tue,  2 Jun 2020 13:08:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2E188CB425;
        Tue,  2 Jun 2020 13:08:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PoC PATCH 00/34] An alternative modified path Bloom filters implementation
References: <20200529085038.26008-1-szeder.dev@gmail.com>
        <20200601232504.GA42750@syl.local>
Date:   Tue, 02 Jun 2020 10:08:37 -0700
In-Reply-To: <20200601232504.GA42750@syl.local> (Taylor Blau's message of
        "Mon, 1 Jun 2020 17:25:04 -0600")
Message-ID: <xmqqeeqxtmy2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B3FEE826-A4F3-11EA-80F2-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Fri, May 29, 2020 at 10:50:04AM +0200, SZEDER G=C3=A1bor wrote:
>> Sigh...  but better late than never, right?
>
> Yes, indeed. I think that there is a balance here: I'm thrilled that yo=
u
> are choosing to spend your time working on and improving the
> changed-path Bloom filter implementation.
>
> Of course, it couldn't have hurt to have these ideas earlier when the
> list was more focused on reviewing Garima's original patches. But,
> nothing is set in stone, and it seems like there are some re-usable
> ideas and clean-ups below.

Yes, I had the same impression as you did, unlike some folks who
sounded as if they felt offended seeing a comment that sabotages
existing work.  It could have been presented in a more useful ways
(i.e. instead of risking to appear suggesting total replacement,
which I do not think was the intention, massaged to build on top of
what is already there as improvements), though.

> I think you're right to draw the "laying the ground work" line here.
> Could these first fourteen patches be applied cleanly to master? They
> all look mostly like improvements to me, especially the second patch.

Again, I concur.

Thanks.
