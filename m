Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7597DC433DB
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 19:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EECC61A07
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 19:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237667AbhCXTLz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 15:11:55 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53743 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237753AbhCXTLe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 15:11:34 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 81170134BCC;
        Wed, 24 Mar 2021 15:11:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yKFi3YOXIUcWUD459GhOHwAcvN0=; b=fRGS8i
        pUQph09lQVCId56KWJ/AeMBD1D6O4+HBndZEodQ8Dj48h3IjKqZAilZkVuQJjrKZ
        imxEvZzeVMJ27TYZVSURmhi8IBAKFWZAScwGTU1cV/i7BUOi0f7hFM0zFne3IXBo
        1qqgemcKrH+/lLtxsTCd2nc5O7tCfACJeKjVE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=e8rPNgTAYLsfXe+lhMZMkR2mMNufDEbD
        gqiZ18QyJJajftVCPCxVKflV136fD3gKF010l/csWcLmmovhR5159UHxwLiPyCLq
        IOahju96pgK0Jm8K3dm407PYW3IhHxhPUsk+bquxXDmtlNJnEk/JdVj+ivbdQQwP
        BfDOjWc5fIM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 79E50134BCB;
        Wed, 24 Mar 2021 15:11:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 879E7134BCA;
        Wed, 24 Mar 2021 15:11:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v8 04/37] hook: include hookdir hook in list
References: <20210311021037.3001235-1-emilyshaffer@google.com>
        <20210311021037.3001235-5-emilyshaffer@google.com>
        <87lfashj03.fsf@evledraar.gmail.com> <YFt9MQsJAJsjWqo2@google.com>
Date:   Wed, 24 Mar 2021 12:11:29 -0700
In-Reply-To: <YFt9MQsJAJsjWqo2@google.com> (Emily Shaffer's message of "Wed,
        24 Mar 2021 10:56:01 -0700")
Message-ID: <xmqq1rc4z7ry.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BE2032E6-8CD4-11EB-9549-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

>> > @@ -40,10 +40,15 @@ static int list(int argc, const char **argv, const char *prefix)
>> >  
>> >  	list_for_each(pos, head) {
>> >  		struct hook *item = list_entry(pos, struct hook, list);
>> > -		if (item)
>> > +		item = list_entry(pos, struct hook, list);
>> > +		if (item) {
>> > +			/* Don't translate 'hookdir' - it matches the config */
>> 
>> Let's prefix comments for translators with /* TRANSLATORS: .., see the
>> coding style doc. That's what they'll see, and this is useful to them.
>> 
>> Better yet have a note here about the first argument being 'system',
>> 'local' etc., which I had to source spelunge for, and translators won't
>> have any idea about unless the magic parameter is documented.
>
> It's not a comment for translators. It's a comment for someone helpful
> who comes later and says "oh, none of this is marked for translation,
> I'd better fix that."

Then, it is not limited to "hookdir", is it?  Resurrecting the
elided part back here:

Not just we do not want "hookdir" placed inside _(),

 			printf("%s: %s\n",
+			       (item->from_hookdir
+				? "hookdir"
+				: config_scope_name(item->origin)),
 			       item->command.buf);

we do not want the "%s: %s\n" to be placed inside _() and get munged
into "%2$s: %1$s\n" for languages that want the order swapped, for
example.

So perhaps the comment should be about the entire output, i.e.
"don't translate the output from this helper, as it is meant to be
machine parseable", or something?

