Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AAD41F462
	for <e@80x24.org>; Thu,  6 Jun 2019 16:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbfFFQH5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 12:07:57 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63378 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729405AbfFFQH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 12:07:57 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0A5FF724F1;
        Thu,  6 Jun 2019 12:07:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ULBQhmTuMkt9iP9E9aX0WjGrj1A=; b=d0lYlh
        VP+em6uE3qeQu7Fw5qOyiMjsoM7xlkpUI+Nsqlc++UjfuGlhnKObkmlvfKTrtf34
        NJogdqtKuXoySBQhsOS9SacBqzOKaRgrHy9To2tvF7JEbYL3vYJnRXbhmkEZrNyH
        8hp74852tINGmZ46sZ50xzhH2a6KCyDeh7hTI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LTdFuEI9ATQt8bdBGmTWRItUacUfF+Lk
        Qu+udWC9jcwFSgFzMWZBWidcZrwe9WrHNiixUlim/xQ6tRQruFX86F9IZQP6psu6
        Xd9ugRgwirzkPd9spyF3LrSWIXUxuo33Hn7ZBTqY6gbGTevjvDdKfaNTaHZQYM1h
        9jT9qmi/3d4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 02409724F0;
        Thu,  6 Jun 2019 12:07:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2923C724EF;
        Thu,  6 Jun 2019 12:07:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 00/11] [RFC] Create 'core.size=large' setting to update config defaults
References: <pull.254.git.gitgitgadget@gmail.com>
        <xmqqftonsr6a.fsf@gitster-ct.c.googlers.com>
        <741a4e37-e5d6-829a-75ee-b9bc3f3b17b2@gmail.com>
Date:   Thu, 06 Jun 2019 09:07:46 -0700
In-Reply-To: <741a4e37-e5d6-829a-75ee-b9bc3f3b17b2@gmail.com> (Derrick
        Stolee's message of "Thu, 6 Jun 2019 08:23:45 -0400")
Message-ID: <xmqqv9xir92l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3ADFF0D4-8875-11E9-A367-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>>  - perhaps we may eventually want to allow end users (via their
>>    ~/.gitconfig) and system administrators (via /etc/gitconfig)
>>    define such a macro setting (e.g. setting macro.largeRepoSetting
>>    sets pack.usebitmaps=true, pack.useSpars=true, etc.) *after* we
>>    figure out what we want to do to the other points in this list.
>>
>>  - even if we do not allow end users and system administrators futz
>>    with custom macros, can we specify the macros we ship without
>>    casting them in code?
>
> Are you suggesting that we allow some config values to be pulled from
> the repo contents?

Not at all.  As far as the configuration is concerned, what project
ships is tainted data that should not be used blindly.

What I had in mind is parallel to the idea of pushing "static struct
userdiff_driver builtin_drivers[]" out of the compiled-in code and
instead have a text file shipped in /usr/share/git/ somewhere.  So,
instead of having "core.size==large means these other four variables
are set to these values" in the code, we invent a general mechanism
to read such "macro" specification out of a text file, and that
would be the only code change---the specific "core.size==large
affects X, Y and Z" would not be in the code, but would be in the
text file we ship and read by the mechanism.

If the list of allowed "meta" configuration variables and the
configuration variables whose default each of them affects can be
expressed in our usual ".gitconfig" file format, then the system
administrators can add their own in /etc/gitconfig, too, to help
their users.

That is what I meant by the last item.  Note that I was "wondering
if it makes sense" and what I wrote above in this message is merely
clarifying what I meant---I am not making further/more arguments to
claim it is a good idea (at least not yet).

Thanks.
