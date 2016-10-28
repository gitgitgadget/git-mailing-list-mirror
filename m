Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C65C203BD
	for <e@80x24.org>; Fri, 28 Oct 2016 02:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942209AbcJ1Cu4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 22:50:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62897 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933375AbcJ1Cuz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 22:50:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B2D5471A5;
        Thu, 27 Oct 2016 22:50:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r8CzSaarliUTJEMPggrUWhirR0o=; b=Pa5Gvk
        KMIgk0X6WNE7TcS98lVR/s772i1NZWS/W8Ci/MSU1HdMVTXvq+HiAMfxSqslFhRw
        zDLGgWPK2DjZCIRHcs23P3qTbYkOWG7prMJZLVEG1rB+rdCBtaINR/fbSAie1gXM
        MAjvo91wUgPGVDcC9oyf8ejmWKcbILCAek6u8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=T4RWxrb4IXVoWcDOMwCpMPZuLsv3MqfL
        nwainNcVhjeTX7VjeD7+YpVr0UQgpdIWoplA7cnw4JCs4drQPQzif2H4e+UXq+dF
        WPTvsWnrxnz0hNNaplabABT9DNJolYNVRkHpSEa7Ewv9aLAKJTuNVNQp3SjHqVca
        s34HhyOC98s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 62DE9471A4;
        Thu, 27 Oct 2016 22:50:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D0B89471A3;
        Thu, 27 Oct 2016 22:50:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC PATCH 0/5] recursively grep across submodules
References: <20161027223834.35312-1-bmwill@google.com>
        <xmqqk2ct4bmr.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYm1txscyBpmfJQceCLFrZAN09y-2nV1zCjE2a1+_jrLA@mail.gmail.com>
Date:   Thu, 27 Oct 2016 19:50:51 -0700
In-Reply-To: <CAGZ79kYm1txscyBpmfJQceCLFrZAN09y-2nV1zCjE2a1+_jrLA@mail.gmail.com>
        (Stefan Beller's message of "Thu, 27 Oct 2016 17:59:36 -0700")
Message-ID: <xmqq1sz1425w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 57E22C4C-9CB9-11E6-9BCB-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> Just a few brief comments, before reading the patches carefully.
>>
>>  * It is somewhat surprising that [1/5] is even needed (in other
>>    words, I would have expected something like this to be already
>>    there, and my knee-jerk reaction was "Heh, how does 'git status'
>>    know how to show submodules that are and are not initialized
>>    differently without this?"
>
> The issue with much of the existing code is that it is submodule centric,
> i.e. it is written to not care about the rest.
>
> git status for example just calls "git submodule summary" to
> parse and display the submodule information additionally.
> It doesn't integrate submodules and treats them "just like files".

Oh, I know all that after/while writing the above "it is somewhat
surprising" and reading what wt-status.c does.  It was just that it
was somewhat surprising ;-)

> My reaction to 1/5 was that the implementation is sound,
> but the design may need rethinking.
>
> Instead of asking all these question, "Is a submodule
> * initialized
> * checked out (== have a working dir)
> * have a .git dir (think of deleted submodules that keep the
>   historical git dir around)
> (* have commit X)
> we would want to either extend the submodule-config API
> to also carry these informations just like
> name/path/sha1/url/shallow clone recommendation.

I think you are going in a wrong direction with all the above.

Unless you are imagining "git grep" to initialize and checkout a
submodule that is not checked out on-demand, I do not think you have
any reason to even look at ".gitmodules" for the purpose of "I want
to grep both in superproject and submodules that are checked out."

You only need to detect .gitlink that exists in the index of the
superproject, and then there would be only two cases:

 * $path has an empty directory (not even .git in there).  The user
   is not interested in that submodule.

 * $path has ".git", either a directory (old layout or we are
   dealing with the repository that originated the submodule) or a
   "gitdir:" file that points into .git/modules of the repository of
   the superproject.  The user is interested in the submodule.

If $path has ".git" and nothing else, the only explanation is that
the user removed the working tree files in the submodule.  If your
grep is looking at working tree files, it is correct not to find
anything in there.  If it is working with "--cached", go look at the
index of the submodule repository (either the ".git" directory, or
the stashed-away repository in .git/modules/ in the superproject).
If it is working with a tree-ish, again, go look at the object store
in that submodule repository.

>>  * It is somewhat surprising that [4/5] does not even use the
>>    previous ls-files to find out the paths.  Also it is a bit
>>    disappointing to see that the way processes are spawned and
>>    managed does not share much with Stefan's earlier work, i.e.
>>    run_processes_parallel().  I was somehow hoping that it can be
>>    extended to support this use case, but apparently there aren't
>>    much to be shared.
>
> I think there are 2 issues here:

There is no issue here.  I was just giving my impressions (i.e.
"somewhat surprising").

> * git-grep already has its own thread pool

I know.  I was expecting that the previous "ls-files" that recurses
will be used to feed into that thread pool, but I didn't find that
in my cursory look at the patch, hence "somewhat surprising".

I hate it when people become overly defensive and start making
excuses when given harmless observations.



