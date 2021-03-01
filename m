Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87188C433DB
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 23:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3991660200
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 23:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238117AbhCAX2o (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 18:28:44 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51288 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244856AbhCAWdI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 17:33:08 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2C61C124C69;
        Mon,  1 Mar 2021 17:32:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Jb/imksTsHuCKxa/jh5oL2EEu+8=; b=lKICFr
        eiZpOpRgTMsvcYdsJYBqwyVn2MBa5R3xAkJYIFmZq5pmlGgU4key9g/hmGHlc2yb
        gIUDJnULRsrKh+z6wHbqU6CALHj3JBONjMuUMDiw7uKsA16lUfzgUT9xXwdzipht
        xK8y42EJylllVbf1rtkD52/i22m6Rtbzf6RWY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=APbypXhTFgjJvYyC8UmprKW60EbyG+W8
        Pl7rqZtlBlYcBdi7hC7aailQcnpj4S3QFqhpSYaP30QUiL0hNP+EXgCS9z/YpJ5k
        6zRcLx0O2zqCOnRBWZ84XyEox5Tf88OS7BMiEhm6TwTZ8eoiipGS0mNuakOt2AM3
        Cwsg2SwC8wI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 13342124C68;
        Mon,  1 Mar 2021 17:32:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2293A124C67;
        Mon,  1 Mar 2021 17:32:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     20210217072904.16257-1-charvi077@gmail.com,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 2/6] commit: add amend suboption to --fixup to create
 amend! commit
References: <20210301084512.27170-1-charvi077@gmail.com>
        <20210301084512.27170-3-charvi077@gmail.com>
        <CAPig+cQAG3p6rhGHzBNGPUxMXQbbLZgiw-uUpizNiEWY9wm-3A@mail.gmail.com>
Date:   Mon, 01 Mar 2021 14:32:18 -0800
In-Reply-To: <CAPig+cQAG3p6rhGHzBNGPUxMXQbbLZgiw-uUpizNiEWY9wm-3A@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 1 Mar 2021 17:15:05 -0500")
Message-ID: <xmqqlfb6mrnx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FC24F972-7ADD-11EB-B5D2-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +               if (len && fixup_message[len] == ':') {
>> +                       fixup_message[len++] = '\0';
>> +                       fixup_commit = fixup_message + len;
>> +                       if (starts_with("amend", fixup_message))
>> +                               fixup_prefix = "amend";
>> +                       else
>> +                               die(_("unknown option: --fixup=%s:%s"), fixup_message, fixup_commit);
>
> I haven't read ahead in the series yet, but I presume you're making
> this code extra generic because you plan to support additional `fixup`
> options (such as `reword`), but I wonder if the cognitive overhead is
> warranted or you could get by with something simpler, such as:
>
>     if (skip_prefix(msg, "amend:", &arg) ||
>         skip_prefix(msg, "reword:", &arg)) {
>         ...
>     }

You still need to compute "len" because you'd want to tell between
--fixup="HEAD^{/^area: string}" and --fixup=bogus:HEAD (the latter
would want to say "no such variant 'bogus' for --fixup", but the
colon in the former is not the end of the name of variant.

So, skip_prefix() would not buy us much, I guess.

But the use of starts_with() in the original patch is bogus, I
think.  fixup_message[] by the time the comparison is made is
NULL terminated at where the colon was originally, so we should be
doing !strcmp() to reject "--fixup=amendo:HEAD~2" with "no, 'amendo'
is not a valid variant name for --fixup option".

> Also, am I misreading when I think that the use of starts_with() could
> be replaced with a simple strcmp() since you've already inserted a
> '\0' immediately after the final alphabetic character?

Correct.

