Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD8AE208CD
	for <e@80x24.org>; Mon, 21 Aug 2017 22:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754190AbdHUWzY (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 18:55:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63453 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754158AbdHUWzV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 18:55:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B06B69315D;
        Mon, 21 Aug 2017 18:55:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LZizN8YBpwjW+AuWd9b/Erd6UxM=; b=dXSJ5+
        ZT2p5s2FJOiVcy/zyd+Szo18qgBgA3bw65DlbVNUC/FxLGOhKjcFHzu6kYY0wje5
        9s+PvWPkTvnxExpD7CURR0r+47j7oznl4KGw33/2CPOdX1TZSIbiBxSw59fS85r3
        VpQFEd3kAMnsLhZ5TV4Xrb3M3AtvWIgMUVfr8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CnBswcssgqKb/bXtVoTNYp7ZMnVK5OWT
        cfydkKrU0ZzoxBHYAZT9Ge13SphhHCFjpx0SiWYjxQ0PtXr7HFQtrAdCToNVoo1F
        +bHYsYGVr5ChVvwC6Xsa7/721jmrABSVEagukU7XG3duVaWKIu7R+vEqzczHArWv
        MAhfXAPOl6s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A7CC89315C;
        Mon, 21 Aug 2017 18:55:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DE05393159;
        Mon, 21 Aug 2017 18:55:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: Re: [PATCH v3 00/23] Move exported packfile funcs to its own file
References: <cover.1502220307.git.jonathantanmy@google.com>
        <cover.1503094448.git.jonathantanmy@google.com>
        <xmqqk2209fm8.fsf@gitster.mtv.corp.google.com>
        <xmqqd17q91y6.fsf@gitster.mtv.corp.google.com>
        <20170821114015.30e1ab23@twelve2.svl.corp.google.com>
Date:   Mon, 21 Aug 2017 15:55:11 -0700
In-Reply-To: <20170821114015.30e1ab23@twelve2.svl.corp.google.com> (Jonathan
        Tan's message of "Mon, 21 Aug 2017 11:40:15 -0700")
Message-ID: <xmqq60dg5y5s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CA5242AE-86C3-11E7-B22D-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> On Sat, 19 Aug 2017 23:40:33 -0700
> Junio C Hamano <gitster@pobox.com> wrote:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > I have to say that this was a painful topic to integrate.
>> >
>> > As you may know, the mk/use-size-t-in-zlib topic is being retracted
>> > and getting rerolled as a larger size_t series, most of which still
>> > needs help in reviewing.
>> >
>> > The jt/sha1-file-cleanup topic is the only one among the other four
>> > that are still not in 'next', and I think that topic, as well as the
>> > other three, are all good and serve as a good base to build on top.
>> > So I first rebuilt your patches on top of these four topics.  This
>> > took some time but it wasn't all that painful.
>> 
>> ... but it turns out that I screwed it up in at least one place,
>> making Linux32 build fail (Thanks Lars and folks who pushed hard to
>> arrange Travis to build all my pushes to 'pu').  I'm pushing out my
>> second attempt.  Let's see how it goes.
>
> Thanks.

It seems like a later pushout late Sunday night that had the second
attempt made it pass on Linux32 ;-)  Whew.

>>  (1) make sure that the topics this depends on are sound by
>>      re-reading them once again, and merge them quickly down to
>>      'master';
>
> I took a look and they look sound.
>
>  - rs/find-pack-entry-bisection resolves an issue first introduced in
>    commit 1f68855 ("[PATCH] Teach read_sha1_file() and friends about
>    packed git object store.", 2005-06-27), which already had that issue.
>  - jk/drop-sha1-entry-pos is some code deletion.
>  - rs/unpack-entry-leakfix ensures that delta_stack is freed. This
>    function does not (for example) expose the destination of delta_stack
>    to its caller, so it is correct that delta_stack should be freed
>    unless it points to the local buffer, just like in the success case.
>  - jt/sha1-file-cleanup (my patches) still looks OK to me.
>
> In your latest "What's cooking" (Aug 2017, #04; Fri, 18), you mentioned
> that the first 3 will be merged to master, and the 4th will be merged to
> next.

Yup, thanks for double checking.  I'll be merging them down
soon-ish.

Thanks.
