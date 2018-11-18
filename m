Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAB2E1F87F
	for <e@80x24.org>; Sun, 18 Nov 2018 23:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbeKSKBz (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 05:01:55 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65482 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbeKSKBz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 05:01:55 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 06E9311AABF;
        Sun, 18 Nov 2018 18:40:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RiVZ7E0ZUkelw0IOkFkQSj88xE0=; b=lIqye6
        sV5tNEvPgUZxwyKeln7zSlG4bii8DitG3yewGq8pM/vFPyW3aPyW0HaSKprlNKJK
        irzxFcGB4d1+KA158Us6eUOLNbaRXiwV1ZTXHkmkvKOd4xVF4LgrEvaG/OSq1Dhv
        POn79QixxkIBbty9p0duqGOzXrKdWYudV1/pM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qcWEZr9sqeUHWAQ4Zi2a92dV32wuQc3Q
        Gok71Fr9Mu5NekoJDIbwnHai52w611ds9lLgjiPNoUpvk+cZqOCNhtMurjZya0VA
        BO2ssBF5afeJ6Pr1GFkdT33Zg539yx6sp0MIJDeULebXzWqMLP1+ieS6jlgPkdqO
        3c6f7Jj2RGA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 005CF11AABE;
        Sun, 18 Nov 2018 18:40:12 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 72FE411AABC;
        Sun, 18 Nov 2018 18:40:11 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     tboegi@web.de, git@vger.kernel.org
Subject: Re: [PATCH/RFC v1 1/1] Use size_t instead of unsigned long
References: <20181117151139.22994-1-tboegi@web.de>
        <c09938cf-7631-ef89-d8fc-d952f9b121c8@gmail.com>
Date:   Mon, 19 Nov 2018 08:40:10 +0900
In-Reply-To: <c09938cf-7631-ef89-d8fc-d952f9b121c8@gmail.com> (Derrick
        Stolee's message of "Sun, 18 Nov 2018 15:18:52 -0500")
Message-ID: <xmqqwopadkf9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A540E24-EB8B-11E8-97C9-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> This needs to go on top of pu, to cover all the good stuff
>>    cooking here.
>
> Better to work on top of 'master', as the work in 'pu' will be
> rewritten several times, probably.

We may not be able to find any good moment to update some codepaths
with deep callchains that reaches a basic API function that take
ulong that way, as things are always in motion, but hopefully a lot
of areas that need changes are rather isolated.  

For example, the changes I see around "offset" (which is "ulong" and
the patch wants to change it to "size_t") in archive-tar.c in the
patch do not have any interaction with the changes in this patch
outside that single file, and I do not think any topic in-flight
would interact with this change badly, either.  I didn't carefully
look at the remainder of the patches, but I have a feeling that many
can be separated out into independent and focused set of smaller
patches that can be evaluated on their own.

