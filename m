Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B55A020756
	for <e@80x24.org>; Fri, 20 Jan 2017 18:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752179AbdATSQf (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 13:16:35 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55865 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751676AbdATSQe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 13:16:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 476165F558;
        Fri, 20 Jan 2017 13:16:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jfOCSYaLSf6Ya+scZ8n+jHg+wnk=; b=iXanyY
        kPLfS4NMBS+YwrvGp9v3aM//bgCCTVhDPBCRcu8FV2GQluukxAftFx6FuF/+lLv6
        72IPkNZzEZOCOGNkZTL48+gEA77CoIDIDb74Vk8HBvzbl2Sjla7aqdN4rGDJrgjB
        fDT0TIAaa96ZVSFK5E83X1EF0lHqDzvbEbro4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Xtt9uOcWhU1kKVckxTeKHvSMymboSUTw
        WXqbyzi3gGd4pp5tDuepNw1YXBVgQyaND3zgPf07js9jMCiQby3uqiMn8N9Bntoj
        716ZYDcsXRCsOlOKQcP3S43kkxzAKiLAA+L+EDiU/jDGdm+TlFpphFbvYgFE26ni
        FZS1REmazHY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3FA1C5F557;
        Fri, 20 Jan 2017 13:16:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9F9BE5F554;
        Fri, 20 Jan 2017 13:16:32 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC 1/2] grep: only add delimiter if there isn't one already
References: <20170119150347.3484-1-stefanha@redhat.com>
        <20170119150347.3484-2-stefanha@redhat.com>
        <xmqqtw8u28u1.fsf@gitster.mtv.corp.google.com>
        <20170120135612.GB17499@stefanha-x1.localdomain>
Date:   Fri, 20 Jan 2017 10:16:31 -0800
In-Reply-To: <20170120135612.GB17499@stefanha-x1.localdomain> (Stefan
        Hajnoczi's message of "Fri, 20 Jan 2017 13:56:12 +0000")
Message-ID: <xmqqlgu5y4u8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 92498E6E-DF3C-11E6-AC8B-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Hajnoczi <stefanha@redhat.com> writes:

> v2.9.3::Makefile may convey that the user originally provided v2.9.3:
> but is that actually useful information?

You are either asking a wrong question, or asking a wrong person
(i.e. Git) the question.  The real question is why the user added a
colon at the end, when "v2.9.3" alone would have sufficed.  What did
the user want to get out of giving an extra colon like "v2.9.3:"?

One answer I can think of is that it is a degenerate case of [2/2],
i.e. if "v2.9.3:t" were an appropriate way to look in the subtree
"t" of "v2.9.3", "v2.9.3:" would be the appropriate way to look in
the whole tree of "v2.9.3".

I understand, from your response to my comment in the thread for
[2/2], that the reason why "v2.9.3:t" was used in the example was
because you felt uncomfortable with using pathspec.  

That's superstition.

My only piece of advice to folks who feel that way is to learn Git
more and get comfortable.  You can do neat things like

   $ git grep -e pattern rev -- t ':!t/helper/'

that you cannot do with "rev:t", for example ;-)

All examples we saw so far are the ones that the user used the colon
syntax when it is more natural to express the command without it.  I
am hesitant to see the behaviour of the command changed to appease
such suboptimal use cases if it requires us to discard a bit of
information, when we haven't established it is OK to lose.

There may be a case

 (1) where the colon syntax is the most natural thing to use, AND
     script reading the output that used that syntax is forced to do
     unnecessary work because "git grep" parrots the colon
     literally, instread of being more intelligent about it
     (i.e. omitting or substituting with slash when the input is a
     tree object, not a tree-ish, as discussed in the thread).

 (2) where the colon syntax is the most natural thing, AND script
     reading the output WANTS to see the distinction in the input
     (remember, "git grep" can take more than one input tree).

We haven't seen either of the above two in the discussion, so the
discussion so far is not sufficient to support the change being
proposed in this RFC, which requires that it is safe to assume that
(1) is the only case where the input is a raw tree (or the input
contains a colon) and (2) will never happen.

So I am still mildly negative on the whole thing.
