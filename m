Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B54951F6BD
	for <e@80x24.org>; Tue, 31 Jan 2017 19:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751749AbdAaTW2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jan 2017 14:22:28 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36113 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751698AbdAaTW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2017 14:22:26 -0500
Received: by mail-pf0-f195.google.com with SMTP id 19so29296295pfo.3
        for <git@vger.kernel.org>; Tue, 31 Jan 2017 11:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2qm1YkD4y5pfuH0jrl9RxqzEXKPwixZ0pNlMwsrVS6U=;
        b=paydD0L+dVF0akzegWlasDcmiwyqVi92JK2EWhk2V95JN1IYyojPiLVFx+Dts2MiAt
         KpDD5JhOB48Qq+zo/b5shqki0p0Bz99EaPVtzFqMSiJLhQDZYsGbZP6zGMarE5JVkRkn
         k6ywSJxJUWLBYEkA+rFy9EJ0YYGzJDsUtWo41kQjUDex4sCWBUi/W3apfU0uiJKuz3ii
         W4xMRV96bvUz7scjuGcOjLAnY9lIgc877Me3EHk3XjidovZ+2EQ+QKdOHDdZpmYm37wo
         p59EaX6gckqAOcTnnzZI7IdDt97XYrdskVxgfTXXBh3+bFvSgRjDBphPHxBpfL59ehcY
         h5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2qm1YkD4y5pfuH0jrl9RxqzEXKPwixZ0pNlMwsrVS6U=;
        b=qhnyuR+ajtB1GEtq6m0Wv5kyoaHb/b7udItn+i/bb3hipDEN17ngTLVgL2DogOrqG2
         WCpXS2oVOMlzxwOReNkC7Cb0kN1uGUbRGSpxVbrw2PtpJJQAFFniZHmCWFnAqZmtIa7n
         vZBINEr6QNkBN5jkUFz77/whjWYZgkAM7vpjSYEBuedFUUFLLW49mXkD6t8Qr9OR6kS9
         GgKd19W1H6skBjdzNSylAJ2YXmdE598h+1AlLjAEHPCtICZSfy503pUkZFrMKJlA0zNj
         xUnbIIQM+WxG65+kxqmUgTOx+Ak17hHHmuXLax5SoF4mOQix0HTmbhoCKhsFqC1x/cab
         45tA==
X-Gm-Message-State: AIkVDXKnt0GWLEHEaF0LX5srmcHHkqHMl2PhbyCVepi6G+FCABD6R35zJlEW6yEkUSZg/Q==
X-Received: by 10.84.194.37 with SMTP id g34mr41910605pld.105.1485890534136;
        Tue, 31 Jan 2017 11:22:14 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:a052:8a35:4bb5:b253])
        by smtp.gmail.com with ESMTPSA id l25sm43131118pfb.24.2017.01.31.11.22.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 31 Jan 2017 11:22:13 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 14/21] read-cache: touch shared index files when used
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
        <20161226102222.17150-15-chriscool@tuxfamily.org>
        <xmqqa8bhb32x.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD1EgOxcPi=tpiosKkYMcCZe+b6gwW0CKt2sE1NZ7gQv=A@mail.gmail.com>
        <xmqqo9zi35n6.fsf@gitster.mtv.corp.google.com>
        <CACsJy8AR6yNr0y+_JZDkW-HO_yHPkUx_6zbLGoviKQBOVcSg5A@mail.gmail.com>
        <xmqqvatouwsh.fsf@gitster.mtv.corp.google.com>
        <CACsJy8B_xe6RtszPrncvDdSYosNUQxvhcEQ3DO_WO0sepXqvvQ@mail.gmail.com>
        <xmqqlgu627uj.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD2LWGtNtdhtQTZXqsACBvK=jD25vt8M4HzBRBVS1sJ+=Q@mail.gmail.com>
        <xmqqefztsj4c.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD3KXOgVOhuMtws36XPiek56U4mQKdUs07hzKc-dC=ppmA@mail.gmail.com>
        <xmqqsho6amm7.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD3iWg5g-h209VDyg1U03Jmma8nTONyCYB-kN7GwspkL8Q@mail.gmail.com>
Date:   Tue, 31 Jan 2017 11:22:12 -0800
In-Reply-To: <CAP8UFD3iWg5g-h209VDyg1U03Jmma8nTONyCYB-kN7GwspkL8Q@mail.gmail.com>
        (Christian Couder's message of "Tue, 31 Jan 2017 15:06:22 +0100")
Message-ID: <xmqqy3xrqbkr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>> You are listing only the irrelevant cases.  The shared one may be
>> used immediately, and the user can keep using it for a while without
>> "touching".
>
> Now you are talking about a case where the shared index file can be
> used immediately and the user can keep using it.
> This is a different case than the case I was talking about (which is
> the case when the shared index file does not exist anymore).

Yes, as I said, you are listing irrelevant and uninteresting one.
If the shared index is already gone, reporting failure to touch it
is of no use---an attempt to read and use the split index that
depends on the shared index that is gone will fail anyway.

> In a previous email you wrote that if the file system is read only, it
> is a bad thing if we warn.

Yes, but you need to realize that "it is better not to bother users
with a report of failure to touch in read-only repository" and "we
ignore all failures".

IIUC, you attempt to touch the shared index even when you are
only reading the index, because you want to mark the fact that the
shared index is still being depended upon.  And I tend to agree that
it is OK not to report a failure for that case.  It is very similar
to a situation where you are asked to peek into your coworker's
repository, which you do not have write access to, and run "status".
The command first runs the equivalent of "update-index --refresh"
only in-core, and it attempts to write the updated index because
(1) it paid the cost of doing the refreshing already, and (2) if it
can write into the index, it will help future operations in the
repository.  But it does not report a failure to write the index
exactly because it is merely doing an opportunistic write.

And in the "we read from the split index, and we attempt to touch
the underlying shared one to update its timestamp" case, it is OK
not to report if we failed to touch.

But you also attempt to touch the shared index when you are actually
writing out a new split index file based on it, no?  The "you
created a ticking bomb" situation is where you fail to touch the
shared index for whatever reason, even when you managed to write the
new split index file.

We agreed that read-only operation should not nag, so it won't
trigger when you are peeking somebody else's repository to help him.
As I said, it is an uninteresting and irrelevant case---when your
read-only peeking did not add new information to be preserved, it is
less severe problem that you fail to reset the expiration.  On the
other hand, if you added new information, i.e. wrote the split index
based on it, it is a good indication that the <split,shared> index
pair has information that is more valuable.  We must warn in that
case.

> Now if you want to talk about the case when the shared index file has
> not been removed, but just chowned to "root", then I wonder how is it
> different from the case when the file system is read only.

The difference is that your code has enough information to notice
the case where you know your touch failed, you know that you wanted
to write (and the write succeeded), and yet you do NOT know why your
touch failed.  That is the ticking bomb we need to warn the user
about.

