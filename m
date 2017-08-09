Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54BF31F991
	for <e@80x24.org>; Wed,  9 Aug 2017 16:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753093AbdHIQv0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 12:51:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64264 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752439AbdHIQvZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 12:51:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E0F05ADEB8;
        Wed,  9 Aug 2017 12:51:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7o2c1vZQKpsgP+D6mFyI2YO4G0M=; b=rvYWZL
        kmsaynQBgD0+x6vrpEk8G3pD6uwAZrqJ/ccDN8MS/iyQ+YzicGVEDRd7bHzKLKpA
        8VWlb1iNHrc6BN5fNAWSpikixQHKoVaChE4ZTIisW2p0R2Liydtb8L7qUbepz2J9
        OzsnlzwwaE+dwl04vqIz3qkmbgcZjcXALfgGk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UYOuVykYXYk9Bmplli8XyMmCcQGOpCCz
        VjEfh1ALQtf1UavDo4m+lWMCa+NhF919ZT41T5ACcLlEik6S8lRLJ78d1wv72VNC
        sXPlz6kbRhTfDDXU+1r9zqQYrUX9rqNbKM3odUGff6HlxwFaFFiAlHiDh/CWFfTo
        Fxj7oHvZLGw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D65E4ADEB7;
        Wed,  9 Aug 2017 12:51:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 30EA4ADEB5;
        Wed,  9 Aug 2017 12:51:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin Koegler <martin.koegler@chello.at>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH] Convert size datatype to size_t
References: <1502222450-20815-1-git-send-email-martin@mail.zuhause>
        <xmqq8tit8efv.fsf@gitster.mtv.corp.google.com>
        <20170809071906.GA19310@mail.zuhause>
        <20170809072613.GA20347@mail.zuhause>
Date:   Wed, 09 Aug 2017 09:51:17 -0700
In-Reply-To: <20170809072613.GA20347@mail.zuhause> (Martin Koegler's message
        of "Wed, 9 Aug 2017 09:26:13 +0200")
Message-ID: <xmqqa8387khm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F7761E68-7D22-11E7-B4E1-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Koegler <martin.koegler@chello.at> writes:

> On Wed, Aug 09, 2017 at 09:19:06AM +0200, Martin Koegler wrote:
>> On Tue, Aug 08, 2017 at 11:04:20PM -0700, Junio C Hamano wrote:
>> > As https://travis-ci.org/git/git/jobs/262463159 shows, unfortunately
>> > it turns out that things are not so simple X-<.  On Linux32, size_t
>> > is uint, which is the same size as ulong, but "%lu" is not appropriate
>> > for showing a size_t value.
>> > 
>> > So you are correct to say in the comment under three-dashes that
>> > there is much more to change in the codebase.
>> 
>> I'll post a new version fixing the *printf issues.
>
> What is the correct format specifier for size_t?
> Linux has %zu (C99). Is that OK for the GIT codebase?

I haven't double checked, but IIRC we cast to uintmax_t and use
PRIuMAX.
