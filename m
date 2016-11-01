Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD1F820229
	for <e@80x24.org>; Tue,  1 Nov 2016 18:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932382AbcKASQW (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 14:16:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51883 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753831AbcKASQV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 14:16:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B75C64B71A;
        Tue,  1 Nov 2016 14:16:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=u4qUU79oRW/tvQUTnUXDCUbYZrw=; b=Dh66sM
        koQchKmZ7VlY1XvGk7S6AARtGoXCsgsXGGKAPK/cR2FyCk5GMs5ZyffbkkMpmqAB
        lY1OwNfRhh6iUxf6Swr8R6YDPurJQ75uYwWEFSB4wpFNcyk9Gdoh9ecFL6iRLNWG
        oEoUVBvbunFnRvOZXt88jRDBgC7fHKVvcgljI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SX1QpBTATrR7to6Tq9d7BVj/54b45bjU
        KSdBM4w2Z8fQuU6CxveOe5PhLxKUY206etPRT4EXmfOLp1vgDLBO8KRheDl6iUvY
        CeqQv5442CxpMzOdS4d8BGJKkz+0IQP3Iwzj3L6wAyhNbyGg8A5rKiD7YyrC1LRR
        c9XcqNBxTyY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AD4774B717;
        Tue,  1 Nov 2016 14:16:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2D04D4B715;
        Tue,  1 Nov 2016 14:16:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/4] sequencer: use trailer's trailer layout
References: <cover.1477698917.git.jonathantanmy@google.com>
        <cover.1477698917.git.jonathantanmy@google.com>
        <602ae84920300cdbb439eca8098c5e092ca322f7.1477698917.git.jonathantanmy@google.com>
        <xmqqeg2wqa1e.fsf@gitster.mtv.corp.google.com>
        <a416ab9b-ff1f-9a71-3e58-60fd4f8a6b8e@google.com>
Date:   Tue, 01 Nov 2016 11:16:18 -0700
In-Reply-To: <a416ab9b-ff1f-9a71-3e58-60fd4f8a6b8e@google.com> (Jonathan Tan's
        message of "Tue, 1 Nov 2016 10:38:43 -0700")
Message-ID: <xmqqtwbroykt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 49CF1D82-A05F-11E6-A476-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>>>  9:I want to mention about Signed-off-by: here.
>> ...
>> This seems a bit weird.
>
> This is because the "I want to mention" block has 100% trailer lines
> (since its only line contains a colon). We could forbid spaces in
> trailer field names, but as you said [1], it might be better to allow
> them since users might include them.

That merely means that the implementation of the wish expressed in
[1] was overly loose and needs a bit of tightening, isn't it?

> The original sequencer.c interpreted this block as not a trailer
> block, because it only accepted alphanumeric characters or '-' before
> the colon (and no spaces) - hence the difference in behavior.

That sounds more sensible to me.  Would there be an easy way to
still allow misspelled "Thanks to:" but not be fooled by an obvious
nonsense like this example, without going deep into natural language
processing?  If not, we may want to tighten it back.

>
> [1] <xmqqbmyhr4vt.fsf@gitster.mtv.corp.google.com>
