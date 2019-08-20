Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CAB01F461
	for <e@80x24.org>; Tue, 20 Aug 2019 17:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbfHTRxe (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 13:53:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57647 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfHTRxd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 13:53:33 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DB0A21637CC;
        Tue, 20 Aug 2019 13:53:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xDcKwgfVAn6CEdshNESpt604Z8k=; b=V+TvKu
        FSz5TjP7zPdoJb+0A8WBb+J2oZFdk2x+dFjChrS9pDyx0r5LGipwDOQkL5csAufF
        Q9woYJ0uA861hHxw8jN6JVpXReLiXOfODpyaA8TG8xDf+JzfgIJ44tmMiTYq1drd
        tuj69d7r0bTDrxWTyR1li44Ee+fgjHkMS1sC4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fpuiTqtami+BNu6pr4VtjwTQn1SS02Ex
        xVuuC5Gdmi/yAYxKqxL6z7fqqT20wx5Ia7owM2aE10oIwiufOF4kw0CKvgWMzRcV
        moNTEKu2qBaYszJlS01uIkyOgIfAg8Wxs4CYQ2tjo03cq9BUuZWA7lPrrqZ8MIiW
        WNXQVg78ftQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D2A651637CB;
        Tue, 20 Aug 2019 13:53:28 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3D6401637C9;
        Tue, 20 Aug 2019 13:53:28 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        martin.agren@gmail.com, newren@gmail.com, t.gummerer@gmail.com
Subject: Re: [PATCH v3 0/6] rebase -i: support more options
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
        <20190820034536.13071-1-rohit.ashiwal265@gmail.com>
        <71c313d7-e08d-f62f-c52e-aabca0d97002@gmail.com>
Date:   Tue, 20 Aug 2019 10:53:27 -0700
In-Reply-To: <71c313d7-e08d-f62f-c52e-aabca0d97002@gmail.com> (Phillip Wood's
        message of "Tue, 20 Aug 2019 14:56:06 +0100")
Message-ID: <xmqqsgpvvi3s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A3EDECE-C373-11E9-9F07-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Rohit
>
> On 20/08/2019 04:45, Rohit Ashiwal wrote:
>> I've tries to incorporated all the suggestions.
>
> It is helpful if you can list the changes to remind us all what we
> said. (as a patch author I find composing that is helpful to remind me
> if there's anything I've forgotten to address)
>
> Also there are a couple of things that were discussed such as
> splitting up the author and passing it round as a <name, email, date,
> tz> tuple and testing a non-default timezone which aren't included -
> that's fine but it helps if you take a moment to explain why in the
> cover letter.
>
>>
>> Some points:
>>    - According to v2.0.0's git-am.sh, ignore-date should override
>>      committer-date-is-author-date. Ergo, we are not barfing out
>>      when both flags are provided.
>>    - Should the 'const' qualifier be removed[2]? Since it is leaving
>>      a false impression that author should not be free()'d.
>
> The author returned by read_author_ident() is owned by the strbuf that
> you pass to read_author_ident() which is confusing.
>
> Best Wishes
>
> Phillip

I've looked at this round, but will push out v2 for today's
integration cycle, mostly due to lack of time, but there do not seem
to be great difference between the iterations.

The "ignore-date" step conflicts semantically with b0a31861
("sequencer: simplify root commit creation", 2019-08-19) but in a
good way.  Without the clean-up b0a31861 makes, we need to munge the
timestamp in two places, but with it, there is only one place that
needs to modify the timestamp for the feature (in try_to_commit()).

You may want to see if these "more options" topic can take advantage
of the "simplify root commit creation" by building on top of some
form of it (I do not know offhand if b0a31861 ("sequencer: simplify
root commit creation", 2019-08-19) must build on other two patches
to fix "rebase -i" or it can be split out as an independent
clean-up), and if it is feasible, work with your student to make it
happen, perhaps?

Thanks.

