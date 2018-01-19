Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9C681F404
	for <e@80x24.org>; Fri, 19 Jan 2018 21:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754263AbeASVBs (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 16:01:48 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55275 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753427AbeASVBr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 16:01:47 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 78AACBEFEE;
        Fri, 19 Jan 2018 16:01:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BkJ4Xt89NoGNt0STXmC2b1DJvc4=; b=aNgbGE
        XNYcw3z9XjMuDLZi92oRteorvVRylkfoQv0MM22SvBHx9/WiDb0rHilEnRHnBNJA
        Ay6z8d8wbt9BOHQhkLdyRfNu86VDfvQrz4Livbu+ZOmT0jSYv+kpkITULlSybnCB
        jXMfrPU6GB8RNe6E0KAxqQLzfZmYjhdyDa1S0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ipHE/tetSP1NLTmGEkNxDdp7iPFhPR7X
        P41KOnOxd6nDKJ8kj/ce9KVNvh1o04FVjDWMsPI5XhlY/VvFdbMHQK5+0iP8Llzm
        xlcSb20ZU4/sZLbbt4jZ2ZNdr/DCjqQMoWj0a45O/m52ERkjlN3NnloHQL16C3IT
        oBkFmfzqmU0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 70C6DBEFED;
        Fri, 19 Jan 2018 16:01:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CE672BEFEC;
        Fri, 19 Jan 2018 16:01:45 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Gargi Sharma <gs051095@gmail.com>, git <git@vger.kernel.org>,
        =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Subject: Re: [PATCH] mru: Replace mru.[ch] with list.h implementation
References: <1516067185-1087-1-git-send-email-gs051095@gmail.com>
        <CAP8UFD0oBfmwx6r8rFMLzCyhEoy6QMQ-5RHJv=2WavYgE9FSMQ@mail.gmail.com>
Date:   Fri, 19 Jan 2018 13:01:44 -0800
In-Reply-To: <CAP8UFD0oBfmwx6r8rFMLzCyhEoy6QMQ-5RHJv=2WavYgE9FSMQ@mail.gmail.com>
        (Christian Couder's message of "Fri, 19 Jan 2018 19:26:37 +0100")
Message-ID: <xmqqefmlpnpj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F56AB188-FD5B-11E7-8FBD-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Tue, Jan 16, 2018 at 2:46 AM, Gargi Sharma <gs051095@gmail.com> wrote:
>> Replace the custom calls to mru.[ch] with calls to list.h. This patch is the
>> final step in removing the mru API completely and inlining the logic.
>
> You might want to say that this provides a significant code reduction
> which shows that the mru API is not a very useful abstraction anymore.
>
>> Another discussion, here
>> (https://public-inbox.org/git/CAOCi2DGYQr4jFf5ObY2buyhNJeaAPQKF8tbojn2W0b18Eo+Wgw@mail.gmail.com/)
>> was on what has to be done with the next pointer of packed git type
>
> I think using "pointer to a 'struct packed_git'" instead of "pointer
> of packed git type" would be clearer here, but anyway see below.
>
>> inside the
>> packed_git structure. It can be removed _given_ that no one needs to
>> access the list in order and can be sent as another patch.
>
> I don't think it's worth pointing to a discussion about a future
> improvement in the commit message. You could perhaps even remove all
> the above paragraph as this commit is valuable and self contained
> enough by itself.

True. 

If it is summarizing conclusion of the earlier discussion, that is a
different matter, though.

It is perfectly OK to have it under "---" line, even if it is merely
voicing author's opinion, by the way.  It can serve as a good
discussion (re-)starter.


>> ---

Missing sign-off?

>> Changes in v2:
>>         - Add a move to front function to the list API.
>>         - Remove memory leak.
>>         - Remove redundant remove operations on the list.
>>
>> The commit has been built on top of ot/mru-on-list branch.
>
> Nice!
>
>>  Makefile               |  1 -
>>  builtin/pack-objects.c | 12 ++++++------
>>  cache.h                |  9 +++++----
>>  list.h                 |  7 +++++++
>>  mru.c                  | 27 ---------------------------
>>  mru.h                  | 40 ----------------------------------------
>>  packfile.c             | 18 +++++++++---------
>>  sha1_file.c            |  1 -
>>  8 files changed, 27 insertions(+), 88 deletions(-)
>>  delete mode 100644 mru.c
>>  delete mode 100644 mru.h
>
> Very nice!

Yes, nice reduction.

>
> [...]
>
>> @@ -1030,8 +1029,9 @@ static int want_object_in_pack(const unsigned char *sha1,
>>                                 *found_pack = p;
>>                         }
>>                         want = want_found_object(exclude, p);
>> -                       if (!exclude && want > 0)
>> -                               mru_mark(&packed_git_mru, entry);
>> +                       if (!exclude && want > 0) {
>> +                               list_move_to_front(&p->mru, &packed_git_mru);
>> +                       }
>
> Style: we usually remove brackets when there is one line after the
> if(...) line. (See the 2 lines that you delete.)
>
> Otherwise the patch looks good to me.
>
> Thanks,
> Christian.
