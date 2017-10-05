Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D70E72036D
	for <e@80x24.org>; Thu,  5 Oct 2017 01:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751303AbdJEBbG (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 21:31:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58909 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751223AbdJEBbF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 21:31:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 394D4A8897;
        Wed,  4 Oct 2017 21:31:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tBWB6F9ZUeh/vMAj+/7QX6AN6qQ=; b=ejMMEb
        Qjrpg/3xzAuFmwynZFFr5dMDJghUqc00zPp9/Qz8orzsfy+HyJUJhFHYHBQY1h24
        LhObzhtnGG1N2C8/y5K8/+8UCXpj8nv0yUDm1gvdNWybtG3sxS4PTKJbivxwTBIX
        TNcPG8W0pDRa5hT5bgkf3Dyynf0FmkkV06y3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uwtchB6+WDOrWgJ02Q9DAhCrKABtZRFS
        VjgAq7LntJYpiBSOmJdjMc6zNphqu9FT4GZaqAdbX4dd2tRlAHbzQSKQJfsY9/LO
        +h1nIU45qO+4VnNr6L2moRvVv14SUNrGj0eSGHy14H8fchJd7jVQhl1FZd8tYt4J
        9hgB1TV02qQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 29C9AA8896;
        Wed,  4 Oct 2017 21:31:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 96061A8895;
        Wed,  4 Oct 2017 21:31:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Robert Dailey <rcdailey.lists@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6ge?= =?utf-8?Q?rshausen?= 
        <tboegi@web.de>, Git <git@vger.kernel.org>
Subject: Re: Line ending normalization doesn't work as expected
References: <CAHd499B5hM9ixnsnwWwB2uyDT10dRQpN473m5QjxH9raHtFXiw@mail.gmail.com>
        <958c9b03-062c-0bea-3b25-939a36659f32@web.de>
        <CAHd499AD5Kgbp-vxXTnEPkb-Mb5oEeXhaRO5kGniDdqmXwd2QQ@mail.gmail.com>
        <88c57b88-ef2c-d7db-15e2-12791d4cb201@web.de>
        <xmqq8tgrhdt0.fsf@gitster.mtv.corp.google.com>
        <CAHd499BCMOcur6NRbKfwd81zpnyzoiVCY54d=UmGpAhbD7AVTA@mail.gmail.com>
        <20171004165947.GN19555@aiede.mtv.corp.google.com>
Date:   Thu, 05 Oct 2017 10:31:03 +0900
In-Reply-To: <20171004165947.GN19555@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Wed, 4 Oct 2017 09:59:47 -0700")
Message-ID: <xmqqbmlm9y94.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DA8C7970-A96C-11E7-99C9-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> I suspect what we are dancing around is the need for some command like
>
> 	git checkout --renormalize .
>
> which would shorten the sequence to
>
> 	git checkout --renormalize .
> 	git status; # Show files that will be normalized
> 	git commit; # Commit the result
>
> What do you think?  Would you be interested in writing a patch for it?
> ("No" is as always an acceptable answer.)

I actually think what is being requested is the opposite, i.e. "the
object registered in the index have wrong line endings, and the
safe-crlf is getting in the way to prevent me from correcting by
hashing the working tree contents again to register contents with
corrected line endings, even with 'git add .'".

So I would understand if your suggestion were for

	git checkin --renormalize .

but not "git checkout".  And it probably is more familiar to lay
people if we spelled that as "git add --renormalize ." ;-)


