Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0724E1F667
	for <e@80x24.org>; Tue, 22 Aug 2017 15:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751816AbdHVPy2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 11:54:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59842 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751796AbdHVPy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 11:54:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5561DB02F3;
        Tue, 22 Aug 2017 11:54:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bO1beaUrFW6r2HNPzI1IqV3ISnQ=; b=tZ/8/m
        hGztiGuj3XLO6o6wSz/E0w6MbpeyWCKxg8TwMY2RdLR54FeISXITpHlePkNrgV+A
        FjM5ynjkBxWrS/ydp2uZ/s4kXqFqPCqmGx6T9bRU9Uh9BeOX/P61uKGUmjAg2OoW
        Op3dm6XYmX4QaF8Nuifghlatqf5at3YBsxlDI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p98io5+yIKcTcHw3DWnkkGG+5W9aZ65W
        g0zYIQ9Er6lReLCWliHf1b8RI69eoCL0MtPthEad52FRZPlZbXdbXqcWp1kdxlqO
        5RdmcLQVSQ3kTVhMmMntsnkDvkNw/rdXTPknlC7ShI3nOZFZxsEOJKkCny3pcydA
        hsMOtbqJ398=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4CC08B02F2;
        Tue, 22 Aug 2017 11:54:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A1C56B02EE;
        Tue, 22 Aug 2017 11:54:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC PATCH 0/5] Add option to autostage changes when continuing a rebase
References: <20170726102720.15274-1-phillip.wood@talktalk.net>
        <xmqqa83rrrdu.fsf@gitster.mtv.corp.google.com>
        <xmqqa83qq2uf.fsf@gitster.mtv.corp.google.com>
        <xmqq60eeq24l.fsf@gitster.mtv.corp.google.com>
        <8cdda835-0b4f-6ffb-31bf-6192999818be@talktalk.net>
        <6a71f802-b20c-f6bc-7bb5-8d81db3353d8@talktalk.net>
        <xmqqpocloqcp.fsf@gitster.mtv.corp.google.com>
        <a3b7af29-8b3a-5253-21da-957920212a6e@talktalk.net>
        <xmqqinhg5ysf.fsf@gitster.mtv.corp.google.com>
        <d1eaed1c-5e62-0a93-f65d-06be43812617@talktalk.net>
Date:   Tue, 22 Aug 2017 08:54:23 -0700
In-Reply-To: <d1eaed1c-5e62-0a93-f65d-06be43812617@talktalk.net> (Phillip
        Wood's message of "Tue, 22 Aug 2017 11:54:44 +0100")
Message-ID: <xmqqefs34mz4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B9BF97C-8752-11E7-AC7B-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

>> In other words, instead of
>> 
>> 	git add -u && git rebase --continue
>> 
>> you would want a quicker way to say
>> 
>> 	git rebase --continue $something_here 
>
> Exactly
> ...
> rebase --continue -a
>
> behaves like commit -a in that it commits all updated tracked files and
> does not take pathspecs.

Hmph, but what 'a' in "commit -a" wants to convey is "all", and in
the context of "rebase" we want to avoid saying "all".  A user can
be confused into thinking "all" refers to "all subsequent commits" 
not "all paths conflicted".

Besides, with the $something_here option, the user is explicitly
telling us that the user finisished the resolution of conflicts left
in the working tree.  There is nothing "auto" about it.

> Did you have any further thoughts on what checks if any this new option
> should make to avoid staging obviously unresolved files?

The more I think about this, the more I am convinced that it is a
very bad idea to give such a $something_here option only to "rebase".

The standard flow for any operation that could stop in the middle
because the command needs help from the user with conflicts that
cannot be mechanically resolved is

 (1) write out conflicted state in the working tree, and mark these
     paths in the index by leaving them in higher stages
     (i.e. "ls-files -u" would list them);

 (2) the user edits them and marks the ones that are now resolved;

 (3) the user tells us to "continue".

and this is not limited to "rebase".  "cherry-pick", "am", and
"revert" all share the above, and even "merge" (which is a single
commit operation to which "continue" in its original meaning---to
tell us the user is done with this step and wants us to go on
processing further commits or patches---does not quite apply) does.

And "rebase" is an oddball in that it is the only command that we
could deduce which files in the working tree should be "add"ed, i.e.
"all the files that are different from HEAD".  All others allow
users to begin in a dirty working tree (they only require the index
to be clean), so your 

	git [cherry-pick|am|revert] --continue $something_here

cannot be "git add -u && git [that command] --continue".  Blindly
taking any and all files that have modifications from HEAD will
produce a wrong result.

You cannot even sanely solve that by first recording the paths that
are conflicted before giving control back to the user and limit the
"add" to them, i.e. doing "git add" only for paths that appear in
"git ls-files -u" output would not catch additional changes the was
needed in files that did not initially conflict (i.e. "evil merge"
will have to modify a file that was not involved in the mechanical
part of the conflict), because out of the files that are dirty in
the working tree, some are evil merge resolutions and others are
ones that were dirty from the beginning.

The only reason "git rebase" can get away without having to worry
about all of the above is because it insists that the working tree
is clean before it begins.  In the ideal world, however, we would
want to lift that and allow it to start in a working tree that has
an unfinished local modification that does not interfere with the
rebase, just like all other operations that could stop upon a
conflict.  And when that happens, your $something_here option to
"git rebase --continue" will have to worry about it, too.

So...
