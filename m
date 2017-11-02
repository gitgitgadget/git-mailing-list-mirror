Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECF4F2055E
	for <e@80x24.org>; Thu,  2 Nov 2017 01:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933083AbdKBBxE (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 21:53:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55554 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751423AbdKBBxD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 21:53:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BCE2FACBF6;
        Wed,  1 Nov 2017 21:53:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XuI0d3mMZlp1luyvmvHzYFVhbks=; b=mSnOzy
        NUe/6QYp0YHb99mI6jWSiogFZjKfuhCtFfi9TwjVTDrPIPQ7f9uOk6ryERAfP4/r
        jBFgmdOE8X/rFQwvrXFeqQLY/K61s6dtIqqzER71jmq+92kb/aK74Hi3Seh8dOQa
        pMZWg6Gv81I599jqep2oNoFDFFqwCi6YYx+j8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=j8NUY/uSc/mWIUZScLvRT3Phs8nTZX8K
        vmaXBEUDuGGeRdx87qJeiebNVF/HJW+BzbFGXiXiyyxhXv0VG2dsWmoTj4rpc4kO
        px4gR3jJs+xRFiZm3+y7By4YefdV1buLPYJ7cOyilV0Z06glRcNwVfjNLBiIyTpa
        A4AmaPK5WLY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B5405ACBF2;
        Wed,  1 Nov 2017 21:53:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 38868ACBF0;
        Wed,  1 Nov 2017 21:53:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Kevin Daudt <me@ikke.info>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/7] builtin/describe.c: describe a blob
References: <20171028004419.10139-1-sbeller@google.com>
        <20171031003351.22341-1-sbeller@google.com>
        <20171031003351.22341-7-sbeller@google.com>
        <xmqqinevzvel.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYO=4SWzfKY6bU8Spn5Ubw39ghOH6wanFhFEsKD8q9vrA@mail.gmail.com>
        <xmqq4lqewu2b.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYC4=rDSWC7WCGVL4n4OC8BpvMJFwxx+LV9GqoGnSHFSA@mail.gmail.com>
Date:   Thu, 02 Nov 2017 10:53:00 +0900
In-Reply-To: <CAGZ79kYC4=rDSWC7WCGVL4n4OC8BpvMJFwxx+LV9GqoGnSHFSA@mail.gmail.com>
        (Stefan Beller's message of "Wed, 1 Nov 2017 13:58:54 -0700")
Message-ID: <xmqqinetsayr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8F79FA24-BF70-11E7-8362-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> But now we have a path as well, the notation of
> <commit-ish> COLON <path>
> is not a unique description of the blob, because
> * there can be multiple <commit-ish>s depending on the tags and walking
> * in boilerplate code cases, we might even have the blob at different
>   places (e.g. pristine copies of a license file in subdirectories)
>
> When calling for a tree-ish, we also accept commits and tags
> plus walking directions.

I think you are confused --- that is not what "-ish" suffix is used
in our conversation on objects.

The reason why we say "-ish" is "Yes we know v2.15.0 is *NOT* a
commit object, we very well know it is a tag object, but because we
allow it to be used in a context that calls for a commit object, we
mark that use context as 'this accepts commit-ish, not just
commit'".

But what you call "walking direction", e.g. "HEAD:Makefile", names a
"BLOB".  It is not "this is something like BLOB, no, we very well
know it is not a blob but the context allows such a non-blob to be
fed in place of a blob, so we take that even though it is not a
blob".  Because it is.

