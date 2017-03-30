Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49B0B20969
	for <e@80x24.org>; Thu, 30 Mar 2017 17:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933914AbdC3RYk (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 13:24:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56863 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933259AbdC3RYj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 13:24:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DEFA66C7F8;
        Thu, 30 Mar 2017 13:24:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AySawW8qZsuFpnL1c9qd99MU8PQ=; b=XCu9Xe
        MDTDpIfVDwa1C6z2tkztcky1siLZMO9r1ITkURyeDVhpzW3MFSoiqF/GL1SagN5p
        8eo86azUSXw823KFYvoEfgcEO9ZCTwuxPKbocMngS4ItN6UFIIoDtzrXgZA/fuXn
        M7b50iJcxGx9BYVdS0fgH7H+LexQ04AR4x7iQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Q1emJgImEzHg1WD3/nGffhXuYxkXY1//
        gFcg6I0jbU63fSgwu2JL+MaIsO7q01mjIRjfstNnJcYNK9JZrvt23OHRELJsUISr
        M6Hfe9fPQnQ9cT01hyWf6196c9UJzVyQfXLatQsJu8r1xUxdjzDseBUr49RPCJI4
        DzCrEw6bjNs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D67AC6C7F7;
        Thu, 30 Mar 2017 13:24:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 47F7C6C7F6;
        Thu, 30 Mar 2017 13:24:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/18] snprintf cleanups
References: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
        <xmqq60itc9pv.fsf@gitster.mtv.corp.google.com>
        <20170329034105.bfgh4tutgrmjp2lc@sigill.intra.peff.net>
        <xmqqr31gax0y.fsf@gitster.mtv.corp.google.com>
        <20170330062730.ycsok7skrjy5c6en@sigill.intra.peff.net>
Date:   Thu, 30 Mar 2017 10:24:36 -0700
In-Reply-To: <20170330062730.ycsok7skrjy5c6en@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 30 Mar 2017 02:27:30 -0400")
Message-ID: <xmqqr31e65kb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BFE3DD54-156D-11E7-8683-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Mar 29, 2017 at 09:05:33AM -0700, Junio C Hamano wrote:
>
>> > I think there are two things going on in your example.
>> >
>> > One is that obviously patch_id_addf() removes the spaces from the
>> > result. But we could do that now by keeping the big strbuf_addf(), and
>> > then just walking the result and feeding non-spaces.
>> >
>> > The second is that your addf means we are back to formatting everything
>> > into a buffer again....
>> 
>> You are right to point out that I was blinded by the ugliness of
>> words stuck together without spaces in between, which was inherited
>> from the original code, and failed to see the sole point of this
>> series, which is to remove truncation without adding unnecessary
>> allocation and freeing.
>> 
>> Thanks for straighten my thinking out.  I think the seeming
>> ugliness, if it ever becomes a real problem, should be handled
>> outside this series after the dust settles.
>
> Yeah, the no-spaces thing should almost certainly wait.
>
> There is still the minor question of whether skipping the strbuf
> entirely is nicer, even if you still have to feed it strings without
> spaces (i.e., what I posted in my initial reply).
>
> I'm OK either with the series I posted, or wrapping up the alternative
> in a commit message.

I do find the updated one easier to follow (if anything it is more
compact); I do not think it is worth a reroll, but it is easy enough
to replace the patch part of the original with the updated patch and
tweak "it's easy to fix by moving to a strbuf" in its log message to
something like "But it's easy to eliminate the allocation with a few
helper functions, and it makes the result easier to follow", so I am
tempted to go that route myself...
