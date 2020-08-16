Return-Path: <SRS0=m/NF=B2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A05DC433DF
	for <git@archiver.kernel.org>; Sun, 16 Aug 2020 16:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C64D20866
	for <git@archiver.kernel.org>; Sun, 16 Aug 2020 16:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="c6Y6WaIT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgHPQ4E (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Aug 2020 12:56:04 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60427 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgHPQ4D (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Aug 2020 12:56:03 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BEB24F7B95;
        Sun, 16 Aug 2020 12:56:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MLAb3QD0DC0aOgF5tiUCsQwFKR0=; b=c6Y6Wa
        ITzMLObjVg8M8ojw3BqZP+1Ly0q3y+ozbHcjaDsFizp0RXrDpmY4BoKCN1/Rxwcg
        /3WQ/7ko1qro+bCWSqCFy3NTZmFhdS0asyLMoAD4lputgK2pVYyY87L0u61cIvm9
        9In1nIz5/7tp52L19dAauPEeZm2YjjBQBK9yw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BCEGugHkKXqu/Da0intX0zdiknRW9hVr
        QXB1b58ekDot1faLklcAs1f9hy1H7Kr7+UdSYfFKd9whUH8/cSwzZkuYKu7KVQ5p
        ZqZTHq70DNcpErKJKzKjXNnWFVj+7jDrBxLCOID1OBU7oLuAgdHP/UrH0rJO4IkS
        ZLF//YY3Ie8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B7085F7B94;
        Sun, 16 Aug 2020 12:56:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 02EDFF7B91;
        Sun, 16 Aug 2020 12:55:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Johannes Altmanninger <aclopte@gmail.com>, git@vger.kernel.org,
        sandals@crustytoothpaste.net, solly.ucko@gmail.com
Subject: Re: rebase -i: quick/inline reword
References: <87sggab031.fsf@osv.gnss.ru>
        <20200816001401.1144752-1-aclopte@gmail.com>
        <xmqq364n5f0b.fsf@gitster.c.googlers.com> <87imdipymt.fsf@osv.gnss.ru>
Date:   Sun, 16 Aug 2020 09:55:57 -0700
In-Reply-To: <87imdipymt.fsf@osv.gnss.ru> (Sergey Organov's message of "Sun,
        16 Aug 2020 15:24:10 +0300")
Message-ID: <xmqqy2me4jj6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5BE05CA0-DFE1-11EA-8062-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

>> I only looked at its description but the UI the tool does it with
>> looks quite obvious and intuitive.  From its source, the "merge"
>> operation does not seem to handle merging a side branch that renamed
>> files, but that should be OK most of the time, I presume.
>
> From the docs:
>
> No merge commits may occur between the target commit and HEAD, as
> rewriting them is not supported. 

I didn't read the documentation that deeply, but it's irrelevant
that the tool can handle only a single strand of pearls.

You need a merge machinery to implement even a cherry-pick of a
single parent commit; an obvious way to implement cherry-pick of
commit C on HEAD is to perform three-way merges between C and HEAD,
pretending as if C^1 is their sole common ancestor.

Our cherry-pick uses the merge-recursive machinery to do so, and
because the sequencer inherited the idea and implementation, "git
rebase -i" does the same.  They instead use their own written in
Python to merge at the tree-level and farms the content-level merge
out to "git merge-file".

The "recursive" part of the "merge-recursive" machinery we use does
not help cherry-pick at all (as we use only one "common"), but it
handles renames.  They can do the same in their merge_trees(), but
they currently don't.

But as I said, that should be OK most of the time, I would think.

>> Nice.
>
> Yeah, it is!

That part is still true ;-)
