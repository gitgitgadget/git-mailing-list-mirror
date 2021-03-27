Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950F6C433DB
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 18:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68A1961965
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 18:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhC0SFJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 14:05:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54866 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbhC0SEe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 14:04:34 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CB7AFB5A6A;
        Sat, 27 Mar 2021 14:04:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Tps4WpD9Yl6sN3HXuBb8gX9EJvI=; b=kTmHS8
        0cdvZy4cOFv6bArrsZjxJj9AR9GTSvna0+iRD21hVRbsjTw8H8SSNo9uY6s02kNn
        3sYRqdBOHz/pgjpxVaZkP67kfgwus6iE7ZL+ZHiUQqJ60eQF9zLlMlFzW2zEP+iM
        QrR7nJvDZ8kCd7R8Dn4BfhziugcpqEqat+RaM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PHMCpjKZfuyMTkcQnBDt/wBGcdDKdNru
        rfbwMBfBpIlrhLUYGgGdYQUQ5UmhnqWE0jq+/C9LjOKXMvkVT3dDrBnJSBqF2jus
        x2AlFnY0CsuPyW3WXUYkvXxuPeuokm3F/Cki0blXM3CSEfL6Fo7o/WPUq+lof8UW
        HsYjzFTBEGY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C3E7FB5A69;
        Sat, 27 Mar 2021 14:04:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4AF44B5A68;
        Sat, 27 Mar 2021 14:04:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v4] [GSOC]trailer: pass arg as positional parameter
References: <pull.913.v3.git.1616673200809.gitgitgadget@gmail.com>
        <pull.913.v4.git.1616775185562.gitgitgadget@gmail.com>
Date:   Sat, 27 Mar 2021 11:04:31 -0700
In-Reply-To: <pull.913.v4.git.1616775185562.gitgitgadget@gmail.com> (ZheNing
        Hu via GitGitGadget's message of "Fri, 26 Mar 2021 16:13:05 +0000")
Message-ID: <xmqqk0psqxqo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E24E451E-8F26-11EB-BB08-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -252,6 +252,16 @@ also be executed for each of these arguments. And the <value> part of
>  these arguments, if any, will be used to replace the `$ARG` string in
>  the command.
>  
> +trailer.<token>.cmd::
> +	The command specified by this configuration variable is run
> +	with a single parameter, which is the <value> part of an
> +	existing trailer with the same <token>.  The output from the
> +	command is then used as the value for the <token> in the
> +	resulting trailer.
> +	The command is expected to replace `trailer.<token>.cmd`.
> +	When both .cmd and .command are given for the same <token>,
> +        .cmd is used and .command is ignored.

Christian, because ".cmd" is trying to eventually replace it, I find
it a bit disturbing that the description we give here looks a lot
smaller compared to the one for ".command".  I am afraid that we may
have failed to reproduce something important from the description of
the ".command" for the above; care to rend a hand or two here to
complete the description?

As I cannot grok what the description for ".command" is trying to
say, especially around this part:

    When this option is specified, the behavior is as if a special
    '<token>=<value>' argument were added at the beginning of the command
    line, where <value> is ...

and

    If some '<token>=<value>' arguments are also passed on the command
    line, when a 'trailer.<token>.command' is configured, the command will
    also be executed for each of these arguments.

I cannot quite judge if what we came up with in the above
description is sufficient.

> -* Configure a 'sign' trailer with a command to automatically add a
> +* Configure a 'sign' trailer with a cmd to automatically add a
>    'Signed-off-by: ' with the author information only if there is no
>    'Signed-off-by: ' already, and show how it works:
>  +
> @@ -309,7 +319,7 @@ $ git interpret-trailers --trailer 'Cc: Alice <alice@example.com>' --trailer 'Re
>  $ git config trailer.sign.key "Signed-off-by: "
>  $ git config trailer.sign.ifmissing add
>  $ git config trailer.sign.ifexists doNothing
> -$ git config trailer.sign.command 'echo "$(git config user.name) <$(git config user.email)>"'
> +$ git config trailer.sign.cmd 'echo "$(git config user.name) <$(git config user.email)>"'
>  $ git interpret-trailers <<EOF
>  > EOF

This change would definitely be needed when the support for
".command" is removed after deprecation period.  As it does not take
any argument, .cmd and .command should behave identically, so making
this change now, without waiting, may make sense.

> @@ -333,14 +343,14 @@ subject
>  Fix #42
>  ------------
>  
> -* Configure a 'see' trailer with a command to show the subject of a
> +* Configure a 'see' trailer with a cmd to show the subject of a
>    commit that is related, and show how it works:
>  +
>  ------------
>  $ git config trailer.see.key "See-also: "
>  $ git config trailer.see.ifExists "replace"
>  $ git config trailer.see.ifMissing "doNothing"
> -$ git config trailer.see.command "git log -1 --oneline --format=\"%h (%s)\" --abbrev-commit --abbrev=14 \$ARG"
> +$ git config trailer.see.cmd "test -n \"\$1\" && git log -1 --oneline --format=\"%h (%s)\" --abbrev-commit --abbrev=14 \"\$1\"|| true "
>  $ git interpret-trailers <<EOF
>  > subject

This, too, but until ".command" is removed, wouldn't it be better
for readers to keep both variants, as the distinction between $ARG
and $1 needs to be illustrated?

Besides, the examples given here are not equivalent.  The original
assumes that ARG is there, or it is OK to default to HEAD; the new
one gives no output when $ARG/$1 is not supplied.  It would confuse
readers to give two too-similar-but-subtly-different examles, as
they will be forced to wonder if the difference is something needed
to transition from .command to .cmd (and I am guessing that it is
not).

Rewriting both to use "--pretty=reference" may be worth doing.  As
can be seen in these examples:

git show -s --pretty=reference \$1
git log -1 --oneline --format=\"%h (%s)\" --abbrev-commit --abbrev=14 \$1

that it makes the result much easier to read.

Thanks.  Do not send a reroll prematurely; I want to see area
expert's input at this point.


