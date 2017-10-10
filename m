Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CA8B20372
	for <e@80x24.org>; Tue, 10 Oct 2017 00:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755596AbdJJAmg (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 20:42:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52555 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754280AbdJJAmf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 20:42:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4A524B2C17;
        Mon,  9 Oct 2017 20:42:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mlvrUdUnOL9QLWvyJQ1t4hQOmG8=; b=PJCBZw
        adUs8SQ2ttbCYFxnK+ak3AUhmn4itU5oTkcyGZRhFWiQC2zSrtGwj6NXeLk6eFA0
        VrN6iup7pfcl/aiSQctJ+aY47Yzgs6+k5V1teVNoFZsQpMTSlSKcvKwBmalzWswC
        xwdRCLPvupsPtHl8H7VE+1ykDZ+Tlntcc1190=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=W/2cdMnz6Tw/n1Y6NosO2/Y0Kgn9oP1i
        9ETXS7wKxSHDTDWMW6raIqkvn7BSyPhG5kdAo+X3EMwpsJes22EGDB+Q85HZriUH
        0xOvkl66Ykwe1z1by+YAFsWdL7bKWYwnRdLEpQT6FyodhGDn71kSk6N6TzwG2xPj
        1rCJN5A6b10=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 435B8B2C16;
        Mon,  9 Oct 2017 20:42:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B3EA7B2C15;
        Mon,  9 Oct 2017 20:42:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] submodule: spell out API of submodule_move_head
References: <20171009220615.27541-1-sbeller@google.com>
        <xmqqtvz7rh68.fsf@gitster.mtv.corp.google.com>
        <20171010002731.GM19555@aiede.mtv.corp.google.com>
Date:   Tue, 10 Oct 2017 09:42:33 +0900
In-Reply-To: <20171010002731.GM19555@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Mon, 9 Oct 2017 17:27:31 -0700")
Message-ID: <xmqqmv4zrfye.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E83105A6-AD53-11E7-A9FA-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> This is not a new issue (the removed comment did not mention this at
>> all), but is it correct to say that updates to "index and work tree"
>> was as if we did "git -C $path checkout new" (and of course, HEAD in
>> the $path submodule must be at 'old')?
>
> I don't understand the question.  This comment doesn't say it's like
> "git checkout" --- are you saying it should?

No, I am pointing out that this comment does not say what it's like
clearly enough.  s/is it correct/am I correct/ would have been less
prone to get misunderstood, I guess.

> The function is more like "git read-tree -m -u" (or --reset when
> SUBMODULE_MOVE_HEAD_FORCE is passed) than like "git checkout".

If it behaves like two-tree "read-tree -m -u", I'd say that the best
explanation an average developer would understand is that the update
done to "index and work tree" is like using 'git checkout' to switch
to the branch whose tip is 'new'.

> Perhaps what you are hinting at is that read-tree --recurse-submodules
> is not necessarily the right primitive to implement "git checkout"
> with.  But that's a separate issue from documenting the current
> behavior of the function.

No, you are way too ahead in this discussion.  I was merely saying
that what the comment says was unclear and does not allow me to get
that far due to lack of clear information ;-).

>> What should happen if 'old' does not match reality (i.e. old is NULL
>> but HEAD does point at some commit, old and HEAD are different,
>> etc.)?  Should the call be aborted?
>
> No.

... and that is because?

When does it make sense to do a two-tree "read-tree -m -u" giving
the 'old' that is very different from the real 'old' tree-ish that
corresponds to where your index started at?

