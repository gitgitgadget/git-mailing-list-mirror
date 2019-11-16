Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE9C71F4B5
	for <e@80x24.org>; Sat, 16 Nov 2019 03:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfKPDrZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 22:47:25 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60253 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbfKPDrY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 22:47:24 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6EAFF21E38;
        Fri, 15 Nov 2019 22:47:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ToS4khojCVlAzbIcOGn2Dmv4xf4=; b=rX4OsB
        9MXUQnABrwRWNX7iQH25ABbsT6P0JLwIfBhcsVty+dKekEfk9hwkw/dVkaKYypk5
        txoY5OyzKCkgCf6lSsHII3h3QEtOOeK6rW1sS7zH6dkmI1HC6nw8J7/t6j6YPv2N
        8hnVRSo1L5QIIIq3kYIcBlpq3n08OQ4K7aFvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ICo9xtrK4DD8zi5Aq5uX8CZfEHp9ijm8
        3YwP693ou/cJHUkbV/zFuOYVrxAvDdtnZTWGqJTOxTQZkAgi4d+DjgaylfbeCmga
        lnsGtyOUHQTKEDbqo4RmdkYczX5L+5F4kGUpgutnUL2EVh9a8+hX801BA4P5CmUG
        g3hJwsJs93o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 66B8D21E36;
        Fri, 15 Nov 2019 22:47:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C6C5E21E35;
        Fri, 15 Nov 2019 22:47:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     Jeff King <peff@peff.net>, Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: rev-list and "ambiguous" IDs
References: <CAGyf7-EXOUWYUZXmww2+NyD1OuWEG18n221MPojVSCCu=19JNA@mail.gmail.com>
        <20191114055906.GA10643@sigill.intra.peff.net>
        <ab4dcc9c-4416-aef8-c8c4-38bb5ec97990@virtuell-zuhause.de>
        <20191115034941.GB20863@sigill.intra.peff.net>
        <917e2664-6059-c190-30fd-02f3cf7aa5dc@virtuell-zuhause.de>
Date:   Sat, 16 Nov 2019 12:47:20 +0900
In-Reply-To: <917e2664-6059-c190-30fd-02f3cf7aa5dc@virtuell-zuhause.de>
        (Thomas Braun's message of "Sat, 16 Nov 2019 00:38:27 +0100")
Message-ID: <xmqqmucw4h4n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CB71A9FC-0823-11EA-BD9B-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Braun <thomas.braun@virtuell-zuhause.de> writes:

>> But if I choose another prefix that has no commits at all, it's
>> ambiguous under either, because the "committish" rule has no way to
>> decide:
>> 
>>   $ git show abcd2
>>   error: short SHA1 abcd2 is ambiguous
>>   hint: The candidates are:
>>   hint:   abcd22f55e tree
>>   hint:   abcd238df0 tree
>>   hint:   abcd2b1cc8 blob
>>   
>>   $ git log abcd2
>>   error: short SHA1 abcd2 is ambiguous
>>   hint: The candidates are:
>>   hint:   abcd22f55e tree
>>   hint:   abcd238df0 tree
>>   hint:   abcd2b1cc8 blob
>
> I would have expected that git log did just tell me that it could not
> find something commitish, instead it told me that there are multiple
> candidates, all of them being no commit.

With this, I 100% agree with.   The latter should instead say

    $ git log abcd2 [--]
    error: bad revision 'abcd2'

just like the case where no object has abcd2 as prefix.

When we ask for commit-ish or any specific type in general, there
are a few possible cases.

 - There is only one such object that has the prefix and is
   compatible with the type.  We handle this correctly---yield that
   object and do not complain about ambiguity.

 - There are two or more such objects, or there is no such object.
   We show all objects that share the prefix, regardless of the
   type, which is way suboptimal.

An improvement can be localized to sha1-name.c::get_short_oid(), I
would think.  We know what type we want (e.g. GET_OID_COMMITTISH)
in the function, so we should be able to teach collect_ambiguous() 
to discard an object with the given prefix but of a wrong type.

