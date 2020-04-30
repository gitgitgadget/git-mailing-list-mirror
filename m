Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED20AC4724C
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 18:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB4282073E
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 18:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QPzidfUi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgD3SJG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 14:09:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65337 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgD3SJG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Apr 2020 14:09:06 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 84D675047E;
        Thu, 30 Apr 2020 14:09:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1funpha3O2aai/HxDtFhmk7OlRs=; b=QPzidf
        UizLS8zcwkDjaq2oTXvhUwINv9x2uAenY0wqOSaMfEQTlJj81LIL8a8hMu3Ei6bP
        /heSaNVceFwNb401bSLMgb+genU0OYOfaaQnigKwZPbWXA104f7ujW/9E2m6+fQD
        MRjOjMZ6ZNSQzSY46S7QROLVv4e6lNeVjJ/YE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aPhmCiq10nzdrSsdyT1x0bthTQlZvLEH
        PvxGK+CGU4ge7Ede+xTPYR1NRHUD4bGPa3ZesIN9GCeQBMK6z7UllVvx4LzT0TEh
        U9x8j+pokHtCTzwqccegZwAEtsxgtSJe04UM3wY9iFb34g/aOoU/sefQMVP5PRan
        2PRkKFJOB6g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D2FC50479;
        Thu, 30 Apr 2020 14:09:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DD61350476;
        Thu, 30 Apr 2020 14:09:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     douglas.fuller@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH] doc: fix quoting bug in credential cache example
References: <63f35287c9ced4d674f938bedd439aefa6c46f41.camel@gmail.com>
Date:   Thu, 30 Apr 2020 11:09:02 -0700
In-Reply-To: <63f35287c9ced4d674f938bedd439aefa6c46f41.camel@gmail.com>
        (douglas fuller's message of "Thu, 30 Apr 2020 10:36:47 -0400")
Message-ID: <xmqqr1w4sv5t.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ACDE089C-8B0D-11EA-ACEF-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

douglas.fuller@gmail.com writes:

> Unquoted semicolons are considered shell argument separators, quote
> them so the example works correctly.

I think what you wanted to do might make sense, but the above
justification is totally incorrect.

>  # or you can specify your own shell snippet
> -!f() { echo "password=`cat $HOME/.secret`"; }; f
> +"!f() { echo password=`cat $HOME/.secret`; }; f"

This is one of the examples shown, each shows possible value that
can be given to credential.helper variable.  Reproducing them fully:

    # run "git credential-foo"
    foo

    # same as above, but pass an argument to the helper
    foo --bar=baz

    # the arguments are parsed by the shell, so use shell
    # quoting if necessary
    foo --bar="whitespace arg"

    # you can also use an absolute path, which will not use the git wrapper
    /path/to/my/helper --with-arguments

    # or you can specify your own shell snippet
    !f() { echo "password=`cat $HOME/.secret`"; }; f

These are examples of values, and how they may have to be quoted in
various environments is not discussed here.  

We will not want a patch that says that the second example is wrong
because "spaces separate arguments in shell and a string with a
space in it must be quoted", i.e.

    $ git -c credential.helper="foo --bar=baz" frotz

and does this

     # same as above, but pass an argument to the helper
    -foo --bar=baz
    +"foo --bar=baz"

because the quoting convention would be different depending on where
it appears.  In a .git/config file, i.e.

    [credential]
	helper = foo --bar=baz

is perfectly fine without quoting.

    $ git -c credential.helper='!f() { echo "password=`cat ...`"; }; f' frotz

would be how you would pass a one-shot config from shell.

Now, the reason why I said what you did is correct but the
justification is wrong is because the semicolon does pose a problem
in the .git/config file.  In fact

    [credential]
	helper = !f() { echo "password=`cat ...`"; }; f

would *NOT* work, because semicolon introduces a comment in the
configuration file.

For this particular case, you can just do

    [credential]
	helper = !echo password=`cat $HOME/.secret`

without any quoting issues, though.

Having said all that, I think we should clarify what these sample
strings are in the introductory text in the examples.  

I've always thought that they are illustrating possible values and
how to express that value in the context the values appear in is up
to the readers who learn what values to write in this document (and
they learn from manual for shell to learn the shell quoting
convention and manual for 'git config' to learn the config quoting
convention).  Hence my initial reaction to your patch was "shell?
Quoting for shell is outside the scope of the explanation here".

On the other hand, for anybody who assumes that these examples are
literally showing what you write after "[credential] helper = " in
the configuration file, the example clearly is wrong and dq may be
needed (but yours is also wrong, in that it loses double quotes
around the argument to echo; if ~/.secret file had a tab in it, the
helper will now yield a wrong password and you won't be able to log
in).

