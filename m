Return-Path: <SRS0=VPsx=4V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18D3C3F2D1
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 20:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D3F21775
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 20:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eG0Ua8KX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbgCDUj4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Mar 2020 15:39:56 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52547 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgCDUj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Mar 2020 15:39:56 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 022204B429;
        Wed,  4 Mar 2020 15:39:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ALLMNY/3YXno28Z8NLyAjPWbP44=; b=eG0Ua8
        KX/icxIp1QPyJRt8PGi6+J23XN7cvGXy2bUu7dt6J0UeD4cUViQRvTCtKZyswTCc
        zxseFLkjh+itP9LCLyFfJvuSxy9c7dGekHtKvsr9sRzPGvPc+Tu4GBi5B7i99JEs
        u0tDWUjIMKBZBmSM0ZNCt6D5D1OePVquQecWA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mbVH3r+P2lHcSznyoWC7qmsqkG3sxzXH
        6ZKG+fImcyiftWRzIlyoOD0dnv+r8AVQ+zVRAuNi6EmJeq0s2UYl1kGxIr/aoCUC
        i7BHhsBmzm7v1LbAyy3JeKAdGRTBtmg9w0bqtvwKUEQrFlSYgLLBBX1kYAoP0Pd4
        92YQXl6T8CY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EDB694B428;
        Wed,  4 Mar 2020 15:39:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5BFA44B427;
        Wed,  4 Mar 2020 15:39:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 0/7] New execute-commands hook for centralized workflow
References: <20200304113312.34229-1-zhiyou.jx@alibaba-inc.com>
Date:   Wed, 04 Mar 2020 12:39:51 -0800
In-Reply-To: <20200304113312.34229-1-zhiyou.jx@alibaba-inc.com> (Jiang Xin's
        message of "Wed, 4 Mar 2020 19:33:05 +0800")
Message-ID: <xmqqv9nj4zxk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4CA04936-5E58-11EA-A13C-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> It would be more convenient to work in a centralized workflow like what
> Gerrit provided for some cases.  For example, a read-only user may run
> the following `git push` command to push commits to a special reference
> to create a code review, instead of updating a reference directly.
>
>     git push -o reviewers=user1,user2 \
>         -o oldoid=89c082363ac950d224a7259bfba3ccfbf4c560c4 \
>         origin \
>         HEAD:refs/for/<branch-name>/<session>
>
> The `<branch-name>` in the above example can be as simple as "master",
> or a more complicated branch name like "foo/bar".  The `<session>` in
> the above example command can be the local branch name of the clien-
> side, such as "my/topic".
>
> To support this kind of workflow in CGit, add a filter and a new
> handler.  The filter will check the prefix of the reference name, and
> if the command has a special reference name, the filter will add a
> specific tag (`exec_by_hook`) to the command.  Commands with this
> specific tag will be executed by a new handler (an external hook named
> "execute-commands") instead of the internal `execute_commands` function.

I do not claim to be great at naming, but you are worse ;-)

 - Any hook is about executing command(s), so "execute-commands"
   hook does not give any information to users.

 - IIUC, this is only about what happens when accepting a push and
   is not called at any other time.  Naming your hook without
   "receive" anywhere in its name would mean other people won't be
   able to add hook that "executes" commands upon cues other than
   receiving a push.

I can guess why you chose that name, because I know there is a
function called execute_commands() in "git receive-pack", but that
is not somethhing you can expect your end users, who are not
intimate to our codebase, to know.

> We can use the external "execute-commands" hook to create pull requests
> or send emails.

You can create pull requests or send emails out of the post-receive
hook, so that is not a convincing justification why we want a new
hook.

Now, I understand that Gerrit-style "notice a push to for/<target>,
take over the whole operation that happens after receiving the pack
data and do something entirely different, such as attempting to run
a merge with refs/heads/<target> and update refs/heads/<target>
instead, or fail the push if automerge fails" is not easy to arrange
within the current "pre-receive" + "post-receive" framework (by the
way, we should start considering to deprecate "update", and
"post-update" hooks as these "*-receive" hooks were added to replace
them, perhaps we should leave a #leftoverbits mark here).  And I
think it is reasonable to add a new hook that takes over the whole
flow in "git receive-pack" to do so.

I just do not think "the execute-commands hook" is a good name for
it.  Perhaps "divert-receive" (as it diverts large portion of what
receive does) or something?  I dunno.

How do Gerrit folks deal with the "we pushed to the server, so let's
pretend to have turned around and fetched from the same server
immediately after doing so" client-side hack, by the way?  

A vanilla "git push" on the client side does not know a push to
refs/for/master would result in an update to refs/heads/master on
the server side, and it would not know the result of the munging
done on the server side (whether it is to rebase what is received on
top of 'master' or to merge it to 'master') anyway, the
remote-tracking branch refs/remotes/origin/master on the client side
would be left stale.  If we wanted to help them pretend to have
fetched immediately after, I think we need to extend the protocol.
Right now, after accepting "git push", the server end will say, for
each proposed update for a ref, if the push updated successfully or
not, but to support the "push to for/<target>, get heads/<target>
updated" interaction, the reporting of the result (done in the
report() function in builtin/receive-pack.c) needs to be able to say
what ref (it may be a ref that "git push" did not think it pushed
to) got updated to what value (it may be an object the client does
not yet have---and we may have to actually turn around and fetch
from them internally if we want to keep the illusion).


