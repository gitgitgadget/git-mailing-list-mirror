Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07550202A2
	for <e@80x24.org>; Tue, 17 Oct 2017 01:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757672AbdJQBTW (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 21:19:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62914 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756692AbdJQBTU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 21:19:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D200AF498;
        Mon, 16 Oct 2017 21:19:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BT8RLEVck44r+qp+lyQG+tARWO4=; b=inHP6f
        evqo9gxsReQH4jGOd4fiuYkFS2Da1Zii3WSR6bO6dSnGDiXo8rym0gyLIeB1NH/Q
        Jq9QKuG7giE5MRRiW9ByMVtIh3x/PKR80+opj4GGsfWfB+s5gZOtDn8Nbl8GAbp1
        NlY7O6xHqifaGoqKLrz+8iA1KiU5RELl1/Y8o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=U8MML07M5SsbuoI8v/lB0lO1WPq4KpOu
        ihixNVboLxLVUqKHzRn852Na699etAeSRxx8wGLdhB7NhpW8WH1XfdukkYORZxwj
        z52UaM3PsJq0pu0r6KKl3TYi/far2FbAtC5DdhHGGAfKdHzpPXOQ66J5IewERsdk
        ZAFz9OHsTLQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 03405AF497;
        Mon, 16 Oct 2017 21:19:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 52B7BAF493;
        Mon, 16 Oct 2017 21:19:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 00/25] object_id part 10
References: <20171015220712.97308-1-sandals@crustytoothpaste.net>
        <xmqq8tgbu9bt.fsf@gitster.mtv.corp.google.com>
        <20171016234912.6r7fqkxugn43wji5@genre.crustytoothpaste.net>
Date:   Tue, 17 Oct 2017 10:19:18 +0900
In-Reply-To: <20171016234912.6r7fqkxugn43wji5@genre.crustytoothpaste.net>
        (brian m. carlson's message of "Mon, 16 Oct 2017 23:49:13 +0000")
Message-ID: <xmqqfuair2p5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 332AC85A-B2D9-11E7-9603-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Mon, Oct 16, 2017 at 11:15:34AM +0900, Junio C Hamano wrote:
>> With a hope that this might help other reviewers, here is the
>> interdiff between "the previous one merged with v2.15-rc1" and "this
>> round applied on v2.15-rc1 directly".  
>> 
>> The changes all looked sensible to me.  Thanks.
>
> Is there a reasonably straightforward tool or workflow to generate
> interdiffs?  If so, I can include them in the future.

To me, it was straightforward to do:

    $ git checkout master^0
    $ git merge bc/object-id
    ... free conflict resolution thanks to rerere ...
    $ git commit -a -m 'old one'
    $ OLD=$(git describe)
    $ git checkout master^0
    $ git am bc-object-id.mbox
    $ git diff $OLD

If you had a copy of my 'pu' branch, then you would have had a merge
commit that merges your previous version of the topic to it, and you
can feed that to contrib/rerere-train.sh to tell your rerere database
how I resolved the conflicts there, which may apply to the reproduction
of the above procedure yourself.
    
