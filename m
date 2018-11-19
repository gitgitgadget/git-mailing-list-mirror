Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CD571F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 04:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbeKSOho (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 09:37:44 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64384 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbeKSOho (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 09:37:44 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8882A2E2A0;
        Sun, 18 Nov 2018 23:15:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WPKE4i4g32KbgOESJM88UCd0/ig=; b=Hx/NYr
        2P5InQQRCL1Iu86A6vmeddM4xa8ekWcm9mDHuQORX1xMycPTaEvnHhweQqS6MAYp
        mHHgoULO8MQP7l7vv/KoSOPnY88B1uIXNr+0ZCNsA01iDMkPHnwmG5PeCtQoY/Qn
        XnCgOLPmoJtwUt0ErPoY/8L2PPzSwGjkrEgyw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pfwcaspwLxCCeUMsMYQeKvs7ZOiITU4z
        WO0LP3NN9U66jRbcQ2XmcU8fHW1F6QC5yRGIATZCwqtiSGjaZGB9vDOvFcJMiMPp
        +QIdm7R+tmDz7SmOido0OqipxiOmAnHbP8WiZLpS6V5oc3vS2XE6NpmZwiXg6ZcW
        G0kIAFUd+vE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 765E92E29F;
        Sun, 18 Nov 2018 23:15:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8270B2E298;
        Sun, 18 Nov 2018 23:15:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Xenos <sxenos@google.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Junio C Hamano <jch@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Carl Baldwin <carl@ecbaldwin.net>,
        Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH] technical doc: add a design doc for the evolve command
References: <20181115005546.212538-1-sxenos@google.com>
        <xmqqd0r4i29w.fsf@gitster-ct.c.googlers.com>
        <CAPL8Zisv-Q04Y_jQzMN7G9fG9rkWwxh4travnSw6cG0ZUFivkA@mail.gmail.com>
        <xmqqftvxertd.fsf@gitster-ct.c.googlers.com>
        <CAPL8ZisfhNqN3gh0E_=mwXuBPGRZ9fKgyQ=HWNFx_9m2job-=g@mail.gmail.com>
Date:   Mon, 19 Nov 2018 13:15:17 +0900
In-Reply-To: <CAPL8ZisfhNqN3gh0E_=mwXuBPGRZ9fKgyQ=HWNFx_9m2job-=g@mail.gmail.com>
        (Stefan Xenos's message of "Sun, 18 Nov 2018 19:33:33 -0800")
Message-ID: <xmqqwop9d7oq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B9E7C8CC-EBB1-11E8-A4AE-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Xenos <sxenos@google.com> writes:

> The scenario you describe would not produce an origin edge in the
> metacommit graph. If the user amended X, there would be no origin
> edges - just a replacement. If you cherry-picked Z you'd get no
> replacements and just an origin. In neither case would you get both
> types of parent.

OK, that makes things a lot simpler.

I can see why we want to record "commit X obsoletes commit Y" to
help the "evolve" feature, which was the original motivation this
started the whole discussion.  But it is not immediately obvious to
me how it would help to have "Z was cherry-picked from W" in
"evolve".

The whole point of cherry-picking an old commit W to produce a new
commit Z is because the developer wanted to use the change between
W^ and W in a context that is quite different from W^, so it would
make no sense to "evolve" anything that was built on top of W on top
of Z.

It is of course OK to build a different feature that can take
advantage of the cherry-pick information on top of the same meta
commit concept in later steps, and to ensure that is doable, the
initial meta commit design must be done in a way that is flexible
enough to be extended, but it is not clear to me if this "origin"
thing is "while this does not have much to do with 'evolve', let's
throw in fields that would help another feature while we are at it"
or "in addition to 'X obsoletes Y', we need the cherry-pick
information for 'evolve' feature because..." (and because it is not
clear, I am assuming that it is the former).  If we can design the
"evolve" thing with only the "contents" and "obsoletes", that would
allow us to limit the scope of discussion we need to have around
meta commit and have something that works earlier, wouldn't it?

Thanks.
