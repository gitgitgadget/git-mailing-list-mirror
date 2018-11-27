Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CD7A1F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 05:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbeK0QT4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 11:19:56 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58309 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbeK0QT4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 11:19:56 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D5E811BBE6;
        Tue, 27 Nov 2018 00:23:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0XxL5sUqziAWQ207uklwBfqMeNg=; b=BtmNsM
        afw5bP2Rt2sPvGshzyclp7rl115oZgk6p96b32uz5dWQasfA2uN52mz8QXulC7YD
        O6xutrRIxO0Ghyex3UDSVJQE8YZQ0iUEmllL+ucZZuzPUSreMUndO3oXZ3/C+aZY
        payW8mprEkPDEriVFcVCmn59xTrkjG4CzDAqo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lR5O9d5hxqK8gMMcbm/CkhjDzePihk1f
        vfM33qaYG7knWZTXbIho5zKij0CYCIPRMdITMzX/S6uQunlnNtzRfndtcrTDIEUs
        amM9PDeQOyi6tQBXh7l6kntjiOikjtRega/OMnwfIKqY7PSxDM6EvTw9U1KHHT/B
        DacJyWaKIAo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 05D7011BBE5;
        Tue, 27 Nov 2018 00:23:11 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 74DF511BBE4;
        Tue, 27 Nov 2018 00:23:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Steven Penny <svnpenn@gmail.com>
Cc:     tboegi@web.de, git@vger.kernel.org
Subject: Re: [PATCH v1/RFC 1/1] 'git clone <url> C:\cygwin\home\USER\repo' is working (again)
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com>
        <20181126173252.1558-1-tboegi@web.de>
        <xmqqtvk3tj45.fsf@gitster-ct.c.googlers.com>
        <CAAXzdLX4jU7+i1W1A_Q1LpPFa1D4FYVPW5rcMnqr_tDHEJn+tw@mail.gmail.com>
Date:   Tue, 27 Nov 2018 14:23:09 +0900
In-Reply-To: <CAAXzdLX4jU7+i1W1A_Q1LpPFa1D4FYVPW5rcMnqr_tDHEJn+tw@mail.gmail.com>
        (Steven Penny's message of "Mon, 26 Nov 2018 20:49:38 -0600")
Message-ID: <xmqqlg5ft7pe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 87ADDDF2-F204-11E8-A091-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Steven Penny <svnpenn@gmail.com> writes:

> If you strip the drive, you can still navigate within the same drive:
>
>     $ cd 'C:\Users'
>     $ pwd
>     /cygdrive/c/Users
>
>     $ cd '\Windows'
>     $ pwd
>     /cygdrive/c/Windows
>
> but you can no longer traverse drives:
>
>     $ cd '\Testing'
>     sh: cd: \Testing: No such file or directory

Sorry, but I fail to see the point the last example wants to make.
If it were

    $ cd /cygdrive/d/Testing
    $ cd /cygdrive/c/Users
    $ cd ../../d/Testing

and the last step fails, then I would suspect it would make sense to
treat /cygdrive/$X exactly like how we would treat $C:, because

    $ cd C:Users
    $ cd ../D:Testing

would not make sense, either, which is an indication that these two
are quite similar.  On the other hand, if "cd ../../d/Testing" above
does not fail and does what non-DOS users would expect, then that
strongly argues that treating /cygdrive/$X any specially is a mistake.

> So a good first question for me would be: why are we stripping "C:" or similar
> in the first place?

Sorry, but I do not see the connection to this question and the
above example.  The reason why we strip C: is because the letter
that comes after that colon determines if we are talking about
absolute path (in other words, the current directory does not play a
role in determining which directory the path refers to), unlike the
POSIX codepath where it is always the first letter in the pathname.

C:\Users is a directory whose name is Users at the top level of the
C: drive. C0\Users tells us that in the current directory, there is
a directory whose name is C0 and in it, there is a filesystem entity
whose name is Users.  So the colon that follows an alpha (in this
case, C:) is quite special, compared to other letters (in this
example, I used '0' to contrast its effect with ':').  So it is very
understandable why we want to have has_dos_prefix() and
skip_dos_prefix().

> I would say these could be merged into a "win.h" or similar. Cygwin typically
> leans toward the "/unix/style" while MINGW has been more tolerant of
> "C:\Windows\Style" and "C:/Mixed/Style" paths, i dont see that changing.

I'd defer to Windows folks to decide if a unified win.h is a good
idea.

Thanks.
