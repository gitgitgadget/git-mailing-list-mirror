Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1457FC433FE
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 18:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiJJS6f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 14:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiJJS6a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 14:58:30 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C82220EC
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 11:58:29 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 30E97143342;
        Mon, 10 Oct 2022 14:58:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/FnZR7Im1EpMtguNE+w84CnLqzvdr78XyA3vDl
        tUMTQ=; b=DLPpMLvZSOEdycoXOoSff7+BXs+CgFCA0iohJZhgP68Iedf6XZGeev
        dk9dXXg8tIw6gHIcRndV22AY6Tw8MWJQkXtDwpeUjsOS3hrYWztvCAP1LbOeA6tW
        6no0/KSoPpBl9zskaoke8UhtSwry/nOHnJW6Mf4mZ5PD5aH5vK++A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 20FC4143341;
        Mon, 10 Oct 2022 14:58:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 85262143340;
        Mon, 10 Oct 2022 14:58:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Daniel Sonbolian via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Daniel Sonbolian <dsal3389@gmail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] git.c: fix, stop passing options after --help
References: <pull.1357.git.git.1665418677535.gitgitgadget@gmail.com>
Date:   Mon, 10 Oct 2022 11:58:27 -0700
In-Reply-To: <pull.1357.git.git.1665418677535.gitgitgadget@gmail.com> (Daniel
        Sonbolian via GitGitGadget's message of "Mon, 10 Oct 2022 16:17:57
        +0000")
Message-ID: <xmqq35bv33qk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 86CFC228-48CD-11ED-BB0F-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Daniel Sonbolian via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Daniel Sonbolian <dsal3389@gmail.com>
>
> Since commit c6b6d9f7d8a when passing --help option

When referring to an old work, use

    $(git show -s --pretty=reference $that_commit)

I suspect that 2c6b6d9f (help: make option --help open man pages
only for Git commands, 2016-08-26) is what you meant (the author
CC'ed).

> to a Git command, we try to open that command man page, we
> do it for both commands and concepts, it is done by
> converting the entered command to a help command
> for the given Git command, for example:
>
> 	"git commit --help -i" into "git help --exclude-guides commit -i"
>
> But the options after --help option are also
> passed to the new command (-i option from the example)

"new command" meaning the "git help" command?

> which can lead to unexpected output, because the
> help command will try to execute those extra options.

Meaning "git commit --help -i" becomes "git help ... commit -i", and
because the command line parser of "git help" accepts dashed options
after "commit", it works just like "git help ... -i commit" does?

It is a request to read the help information for "git commit" using
the "--info" backend, right?  Similarly, "git commit --help -m"
would do the manpage and "git commit --help -w" would show the
manpage in the browser?

It sounds like a sensible behaviour to me (even though relying on
the behaviour of "git help" that takes dashed options after "commit"
makes me feel somewhat dirty).  So ...

> This fixed by building the argv statically, meaning

... I am not sure what you are fixing.  Puzzled...
