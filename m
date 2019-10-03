Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A37C51F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 00:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfJCAw7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 20:52:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55213 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfJCAw7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 20:52:59 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D43A1B4FA;
        Wed,  2 Oct 2019 20:52:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KMy8HN+yUEotQoFHWqrbzupHmDE=; b=Zy4HU9
        LPP2YbRjXQBk2BP3nhn87iIT2JGk/cN1weRXN9pYDXxM5QUlzqYEPOsA6G9DoOUS
        k69cOH3J/pCB0sKDt0fBEiFemAqEE5inCss677cpik7jxJPQS/RSb0TxO3QJEepx
        eHCT2w55H+c53Z0yyjHJmQDoK4XnruUCMEEmg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bRqeEfsRuM20pq7IIUmeby18KWQGl/eB
        Qwyt7tSH9QDHkWIRwuCsmhRsWT+uOl7OEMP9jie/U3DVsVFucuW6y7TA8E37P0zB
        klykW1HNNNgGA1QSyJtf2vrke4UCJ0fUc3/9Xq7wF2rrOEPuesVknpUlkrPwv1Cb
        b3HcJVDs0lk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 049E11B4F9;
        Wed,  2 Oct 2019 20:52:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5B9951B4F8;
        Wed,  2 Oct 2019 20:52:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>,
        =?utf-8?B?Tmd1?= =?utf-8?B?eeG7hW4gVGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [BUG] incorrect line numbers reported in git am
References: <20191002184546.GA22174@generichostname>
        <xmqq8sq2ewzh.fsf@gitster-ct.c.googlers.com>
        <20191002201659.GB24697@generichostname>
Date:   Thu, 03 Oct 2019 09:52:55 +0900
In-Reply-To: <20191002201659.GB24697@generichostname> (Denton Liu's message of
        "Wed, 2 Oct 2019 13:16:59 -0700")
Message-ID: <xmqqmueid508.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 23612D96-E578-11E9-8FC4-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> On Thu, Oct 03, 2019 at 05:03:14AM +0900, Junio C Hamano wrote:
>> Denton Liu <liu.denton@gmail.com> writes:
>> 
>> > which is in the middle of the log message. I expect the line to be
>> > reported as something in the range of 198-203,...
>> 
>> That comes from not knowing who is complaining and what it is
>> reading.  In this case, "git apply" issues a warning because it is
>> fed .git/rebase-apply/patch file, which is the output of mailinfo
>> that parses header & log message out, leaves the message in a
>> separate 'msg' file in the same directory and stores the rest in
>> that 'patch' file.  And it is line 87 that has problems.
>
> In this case, I would still regard this as a bug since users would
> expect the line 87 to refer to their input file. I think most users
> don't even realise that a .git/rebase-apply/patch file exists. (I
> certainly didn't.)

In any case, if the error message required me to look anywhere
outside the patch file, it would make it impossible for me to work.

100% of the time, I just pipe the entire message from MUA to "git
am", and I wouldn't know which line it is complaining if it counted
the long run of mail headers like Received:, etc., because I do not
have such an entire message anywhere in a single file (only my MUA
has it, so I'd need to pipe it to "cat >tempfile" again after seeing
a failure).

> In fact, running `git am --show-current-patch` shows the whole mail, not
> only the 'patch' file so users would have no reason to expect the line
> numbers to refer to the 'patch' file.

Yeah, show-current-patch was a misguided attempt to hide useful
information from the users.
