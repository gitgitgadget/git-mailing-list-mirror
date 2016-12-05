Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F4E41FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 21:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752126AbcLEVy3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 16:54:29 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60453 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751847AbcLEVy3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 16:54:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DC6595648D;
        Mon,  5 Dec 2016 16:54:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IOCh8yQMe7DnDy4phrjoIgGZdLY=; b=VchFUN
        Tw4UczB2MqTmmJNQXcbpsIlw1xdsQsvER6i4P+hyW/bStbixGbfFdt9MtnHAI1pf
        YKANpvgvZctDTXeqsDufscfjBRoblF0daK+qr2eV2UVDCv6dVGI/PkxxO9S8gEOp
        moVAfFTWaE9bTqV+uhP61zuB3h+lIskbi0nNA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dy0bHmE0vCUCoxzzEHfvuI//YA5CPVzJ
        zQyygE985BDD8fumbKHAnzXDcqSiKeAqJBet53eUGb/aXrJAzzlL1NNuaIYKh9eI
        1JqPwg7gPAqHkgYVd4+zS5eiUXRV7A+ALsYX36T9LZMc1mUlQd4tyB0w75BaSrET
        H+2loY/FRyc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D34A85648A;
        Mon,  5 Dec 2016 16:54:27 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4A24856481;
        Mon,  5 Dec 2016 16:54:27 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     Git Users <git@vger.kernel.org>,
        Vinicius Kursancew <viniciusalexandre@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCHv1 1/2] git-p4: support git-workspaces
References: <20161202224319.5385-1-luke@diamand.org>
        <20161202224319.5385-2-luke@diamand.org>
        <xmqq8tru3xom.fsf@gitster.mtv.corp.google.com>
        <CAE5ih78Y_AbfgtW_6zMKLC8NzBxCKSagrgrjtfWZVOEwaAg6ZA@mail.gmail.com>
        <xmqq4m2i3w8b.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 05 Dec 2016 13:54:26 -0800
In-Reply-To: <xmqq4m2i3w8b.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 05 Dec 2016 13:24:36 -0800")
Message-ID: <xmqqzika2ga5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 64627892-BB35-11E6-85CB-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Luke Diamand <luke@diamand.org> writes:
> ...
>      if (os.path.exists(path + "/HEAD")
>          and os.path.exists(path + "/refs") and os.path.exists(path + "/objects")):
>          return True;
> +
> +    # secondary working tree managed by "git worktree"?
> +    if (os.path.exists(path + "/HEAD")
> +        and os.path.exists(path + "/gitdir")):
> +        return True
> +
>      return False

Wait a bit.  How is this expected to work?

I assume "path" is something like "$somewhere/.git" (either
absolute or relative), and by concatenating HEAD, refs and objects
under it the original checks form paths to expected directories,
because "$somewhere/.git" is a directory.

A worktree created with "git worktree add" gets ".git" that is a
file, and the contents of the file records the path to a
subdirectory "worktrees/$name" of the primary repository the
worktree is borrowing from, i.e. "$somewhere/.git/worktrees/$name".

So for this patch to work correctly, the caller, when in a "git
worktree" managed secondary working tree, MUST have found the ".git"
file at the root level of the working tree, MUST have read its
contents to learn that "$somewhere/.git/worktrees/$name" path, and
then feeding it to this function.  But doesn't such a caller already
know that it is a valid repository?  After all, it trusted the
contents of that ".git" file at the root level.

    ... goes and looks at the callers ...

Between the two call sites of isValidGitDir() in main(), the first
one (i.e. if ".git" in the current directory, made into abspath,
does not look like a repository, ask "rev-parse --git-dir" for one)
looks correct and I think it would grab the correct $GIT_DIR just
fine [*1*].  Isn't the real problem the second one, i.e. the one
that feeds a correct cmd.gitdir that we just obtained by asking
"rev-parse --git-dir" to the sloppy isValidGitDir() again.  The
latter second guesses "rev-parse --git-dir" and botches.

I have a feeling that adding more to isValidGitDir() like this patch
does is a step in the wrong direction.  The first fix would be not
to do the "if isValidGitDir() says no, then do something else" step
if you already asked "rev-parse --git-dir" and got a valid $GIT_DIR,
perhaps?

Stepping back even more.  

I wonder why the script needs to do os.environ.get("GIT_DIR") in the
first place to initialize cmd.gitdir field.  If it instead asked
"rev-parse --gitdir", the script would get the right answer that
already takes GIT_DIR environment into account.


[Footnote]

*1* This ends up asking "rev-parse --git-dir" only because
    isValidGitDir() is sloppy.  If you are in a secondary working
    tree whose ".git" is a file, the function would say "no", and
    that is the only thing that allows you to make a call to
    "rev-parse --git-dir" to obtain the correct result.

