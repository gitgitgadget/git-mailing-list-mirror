Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30A871F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 01:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731127AbeKTL3r (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 06:29:47 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64653 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeKTL3r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 06:29:47 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 91472124A21;
        Mon, 19 Nov 2018 20:03:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EtEnYpIbj01ql2puSXA5K30e5ko=; b=DH0yza
        x4EBRK+e5+vsyAkltY+9D+0QQ7oiFMVdGIVHxDhKEYO4/7rgeW9OP66w1HlwOUiR
        ceOoyn9ta4XcGBxnvqX56GMIgdLaSSWxIxuXXVN2z4/Vc5rKjijZ3oTB6X+ARp9O
        8tQZvUa8KO+HhxYgIwPRzt1kkJvSQ8oVAGqt8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wgpW0scg03YwSTkQqRmaBjhyclVwyz79
        nbIbTWtjpZSlrcb488vzChV48hDDxZLl06Dx294jrAKUyfJDq8pW0BFsiegYz+XR
        PYNeCbvEVhRWpD4BylSD5OhLhhzL9xqkoVOQJB4EuI/YRsqkSkzWo/Akak4yif3P
        iVT6r0LuUY4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 883B6124A1F;
        Mon, 19 Nov 2018 20:03:20 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DF860124A1E;
        Mon, 19 Nov 2018 20:03:19 -0500 (EST)
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
        <xmqqwop9d7oq.fsf@gitster-ct.c.googlers.com>
        <CAPL8ZisOH7vAPGSCv-RGZdYf56AjgvxXU6CQ9U7rir76u2ga0w@mail.gmail.com>
Date:   Tue, 20 Nov 2018 10:03:18 +0900
In-Reply-To: <CAPL8ZisOH7vAPGSCv-RGZdYf56AjgvxXU6CQ9U7rir76u2ga0w@mail.gmail.com>
        (Stefan Xenos's message of "Mon, 19 Nov 2018 12:14:09 -0800")
Message-ID: <xmqqmuq4d0h5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1216DED0-EC60-11E8-B245-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Xenos <sxenos@google.com> writes:

>> But it is not immediately obvious to me how it would help to have
>> "Z was cherry-picked from W" in "evolve".
>
> The evolve command would use it for handling the
> obsolescence-over-cherry-pick (OOCP) feature. If someone cherry-picks
> a commit and then amends the original, the evolve command would give
> you the option of applying the same amendment to the cherry-picked
> version.

Yeah, I missed that case when I was formulating my thought on how we
can start smaller and simpler to get the ball rolling.  And for
"this commit and anything built on top of it need to be adjusted
since that other commit, which this commit was made by cherry-picking
it, has been obsoleted" to work, the "origin" commit pointed at by
the meta commit must be made available.

> Are you claiming that this is undesirable, or are you claiming that
> this could be accomplished without origin parents?

I was trying to see if this is something we can leave out to limit
the initial scope.
