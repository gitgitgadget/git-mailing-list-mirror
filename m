Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5745C1F6DC
	for <e@80x24.org>; Thu, 26 Jan 2017 02:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752675AbdAZCiF (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 21:38:05 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56333 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752453AbdAZCiE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 21:38:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E1E5463193;
        Wed, 25 Jan 2017 21:37:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eu9XCvhHf9gphdUNOBzz/XWv9VA=; b=ZsDnRL
        2iMWb6iFXKJHtKML9BO+jF9jBP8KiuQ+O1Jv/Fm//RtWdu/u0LkrS8VWvnPd5zbM
        99xEjaUfmwxu0XeHLk+oMzDz0FTttu05q1FlgdBu8WHzqK4oEh2jVP3aXMZM/s33
        ev89X23bWhF11TOjjnTtlquWwn8bS1Vy3yr6I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JabaQwRdSAbuYPGZug7LwDtC/1o1RzfQ
        H4ry501qMVd2maXJAdfjlmxWmqCCvoS2S+7W5D0TIKNqQbQ1Dl54vqmzNCA1RL0c
        6X/yjZEt5Bo8dmH+WdPiQxCYWBPxlpadRN3dOiIagxFcifNmf9mxN1s3GjvB8H0Q
        sez2xZ7syZA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D98DF63192;
        Wed, 25 Jan 2017 21:37:57 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4872163191;
        Wed, 25 Jan 2017 21:37:57 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] gpg-interface: Add some output from gpg when it errors out.
References: <20170125030434.26448-1-mh@glandium.org>
        <xmqqtw8m7ncp.fsf@gitster.mtv.corp.google.com>
        <20170125235410.byxwmo7o7zdszzot@glandium.org>
Date:   Wed, 25 Jan 2017 18:37:55 -0800
In-Reply-To: <20170125235410.byxwmo7o7zdszzot@glandium.org> (Mike Hommey's
        message of "Thu, 26 Jan 2017 08:54:10 +0900")
Message-ID: <xmqq8tpy7dh8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 72322644-E370-11E6-9FEF-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Hommey <mh@glandium.org> writes:

> On Wed, Jan 25, 2017 at 03:04:38PM -0800, Junio C Hamano wrote:
> ...
>> Overall I think this is a good thing to do.  Instead of eating the
>> status output, showing what we got, especially when we know the
>> command failed, would make the bug-hunting of user's environment
>> easier, like you showed above.
>> 
>> The only thing in the design that makes me wonder is the filtering
>> out based on "[GNUPG:]" prefix.  Why do we need to filter them out?
>
> The [GNUPG:] lines are part of the status-fd protocol. They show details
> that don't really seem interesting to the user. In fact, they even
> contain the signed message (yes, in my case, it turns out gpg was
> actually still signing, but returned an error code...).

OK, that detail was what was missing in the proposed log message.
Without that "why do we filter?", readers cannot correctly assess
why it is a good idea.  I wasn't arguing against filtering it; I
just wanted to make sure "git log" readers (and "git show" user
after "git blame" identifies this change in the history) will know
how we decided to filter lines with the prefix.  

With that information recorded in the log (or in-code comment, or
both), if it turns out that some lines with the prefix are useful
(or some other lines without the prefix are not very useful), they
can tweak the filtering criteria as appropriate, with confidence
that they _know_ for what purpose the initial "filter lines with the
prefix" was trying to serve, and their update is still in the same
spirit as the original, only executed better.

Thanks.
