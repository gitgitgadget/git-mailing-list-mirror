Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB331211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 01:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbeLFBlO (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 20:41:14 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53483 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbeLFBlO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 20:41:14 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 27BC02D018;
        Wed,  5 Dec 2018 20:41:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=I0aAsOjzM6ARUcDpKg7G5lUx4ow=; b=myBFnQ
        21RSHhIRcU6Cjwon04SZJMt4Mg1zLFwVQvtKcmJLqsQDP3qK77npRQihujpWBEE2
        MQIwLNM/p7EpZY0SDRxDWaIoWuVjhv2jwSUTBrwRpqXT6RbzdX7E+gT/ALr7LHlN
        aV09JEdeiorxP/6tSHzPr3B273F6589lV+KpE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XlYmn/CiYPbI1eAkTDeuJ2s3w1XXEFup
        sXII17SpWbsajv/V15Gf+fhZvGtNewcPe+9bNO9nNpD/CBrFxEA+ZjnHP+EXqIx2
        +shDfQSxYFOd4lgSmCDB6tpgkWJRdpHo6368SulhgcjoxcxCvmYf8u1Nia5vddbM
        fFiliw/FEkU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 20D312D017;
        Wed,  5 Dec 2018 20:41:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 002D12D016;
        Wed,  5 Dec 2018 20:41:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, stolee@gmail.com
Subject: Re: [PATCH 1/2] commit-graph, fuzz: Add fuzzer for commit-graph
References: <cover.1544048946.git.steadmon@google.com>
        <53e62baaa8769bf8e90991e32e0d123cc6629559.1544048946.git.steadmon@google.com>
        <xmqqmupja19b.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 06 Dec 2018 10:41:06 +0900
In-Reply-To: <xmqqmupja19b.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 06 Dec 2018 10:32:16 +0900")
Message-ID: <xmqqin07a0ul.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 012D8FB6-F8F8-11E8-800D-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +	if (graph_size < GRAPH_MIN_SIZE)
>> +		return NULL;
>> +
>
> The load_commit_graph_one() grabbed graph_map out of xmmap() so it
> is guaranteed to be non-NULL, but we need to check graph_map != NULL
> when we're calling this directly from the fuzz tests, exactly in the
> same spirit that we check graph_size above.  Besides, these are to
> make sure future callers won't misuse the API.

Insert "Please check graph_map != NULL here, too." before the above
paragraph.

>>  	data = (const unsigned char *)graph_map;
>
> And the reset of the function is the same as the original modulo
> jumping to the cleanup_fail label has been replaced with returning
> NULL.
>
> Looks good.

Of course, s/reset/rest/ is what I meant.
