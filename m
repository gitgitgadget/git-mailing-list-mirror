Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6A5C433E2
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 01:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC3EC2080C
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 01:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="h+QZlA6d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgH1BCP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 21:02:15 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51662 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH1BCO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 21:02:14 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9C76FF842B;
        Thu, 27 Aug 2020 21:02:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hsZ3GD35g5a+oL9ni3etmBrk0X8=; b=h+QZlA
        6dKOZpGkJSCYxYrqlJRavYqealxBKy7TYvS6N2AbuLDue5ZHfeFLoQkERi1wncer
        3/C03ptJ8IsfcZkKknfT9NjfLk6jYPSQ83xNsMoM9kG4tJLWCxfGwEe5W71YvQ5l
        8mN1IlF9YjjBHsb+uiYvaLEiQnRkWYEFix1nA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wHrV1jypRAVAjgZLh4P1/Lx+tYAMxvyJ
        tW+L/Y0URBwezxBh8fPb+6Q3hSZ6+D5c3jKqlXcPQiDLFIbB7lKWNIpp5jFZgkiW
        rF0tLiwkNnUQZR8pxxZiXRtaJTti2aikZu3MALPRH8bzDv24u3g8EQbPAMKoXbhM
        DGYswhnxl7M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 954C7F842A;
        Thu, 27 Aug 2020 21:02:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D3990F8427;
        Thu, 27 Aug 2020 21:02:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Drew DeVault" <sir@cmpwn.com>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        <git@vger.kernel.org>
Subject: Re: [PATCH] send-email: do not prompt for In-Reply-To
References: <C585M18ZSR87.2CMIKK2VKMC1S@homura>
Date:   Thu, 27 Aug 2020 18:02:07 -0700
In-Reply-To: <C585M18ZSR87.2CMIKK2VKMC1S@homura> (Drew DeVault's message of
        "Thu, 27 Aug 2020 19:05:50 -0400")
Message-ID: <xmqqsgc7oa5s.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19023ECA-E8CA-11EA-A2E1-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Drew DeVault" <sir@cmpwn.com> writes:

> Oh, and I should mention the fact that this breaking change is less
> severe than we initially thought, only breaking an edge case - when --to
> is not specified - so it's likely to have a pretty small impact. We'll
> find out when someone emails us to complain, I suppose.

I agree that it is likely that only very small population even gets
bittn by this "in-reply-to gets prompted" issue, because it is
unlikely for users not to give "to:" address in one way or another
and let the prompt logic to ask them.

Which means that it is OK to stop at step (0) in the long transition
sequence I outlined in a previous message from me.  

That is, introduce a configuration variable that can be set to 'no'
by those who do not want to be prompted for "in-reply-to:" when they
did not give "to:" and let the prompt logic to ask "to:", document
the variable well [*1*], and make sure the default behaviour when
the variable is not set is the same as now.

That way, we do not even need to debate if it is true that most
users do not want in-reply-to (i.e. step (1)).  That's the kind of
thing that is very hard to establish.

The minority who wants to use an updated behaviour can just set the
configuration once and the problem is behind them.  The minority who
wants to keep the current behaviour do not have to do anything.  And
there is no impact to the majority of people either way.

I hate having to go through a multi cycle compatibility-breaking
transition, because it would consume unnecessary resources from this
list (i.e. developer attention is the most scarce common resource
that must be shared across topics here), and we would avoid that
cost altogether because the affected population seems to be small
enough that it is not worth going through the rigmarole of flipping
the default.  That alone is a big plus.

It seems like we managed to cut down the scope quite a bit.  

Thanks.


[Footnote]

*1* As a part of "document the variable well", we can include a
message tweak for the prompt that asks for "in-reply-to:" to say
something like "if you never want to be prompted for in-reply-to:,
you can set this variable" when the variable is not set at all.
Those who did set the variable but still are getting the prompt are
explicitly opting into keeping the current behaviour by setting it
to 'yes', so they do not have to see that extra part of the message.
