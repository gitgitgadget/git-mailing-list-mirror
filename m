Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8C4A211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 02:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbeLECOk (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 21:14:40 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50720 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbeLECOk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 21:14:40 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EE53E30555;
        Tue,  4 Dec 2018 21:14:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=20Xc+Qa3ihLRYXUC+5NqzRWzjBM=; b=MkK7pn
        vUBoSwUT6r9N9Z+G4MSOBGt7Z0VHBVeGJNRDuIccpnjh7Nb819eZi5LFHNYnKaOw
        R/x/bqox7/SNoDmhzZllC29Me7yCBGIxoFyx8f4lK2nanZJAksIiNNBfpdj+Z8cb
        UxFGsEyi8YxiqvRkNEkykCSdWNqDljGkDRDm8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=m0z+/cUljSfWLXsgQZAsuauBj+XMqTaP
        rcYaqveZ0aykdqCe9edIXlqw90FrO+PdStqeEDFoSkslAtsqlz7cgIUuLZACcdBh
        vaCmmBYGWN2yfT+51/C7tEePL4BiDvEcVo6tfcoyJkH0LcG9A5ue5rZ2Ye/uUa4H
        KqtjvqfShOQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E35D730554;
        Tue,  4 Dec 2018 21:14:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E72F830553;
        Tue,  4 Dec 2018 21:14:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Stefan Xenos <sxenos@google.com>
Subject: Re: [PATCH v3 07/14] checkout: split into switch-branch and restore-files
References: <20181127165211.24763-1-pclouds@gmail.com>
        <20181129215850.7278-1-pclouds@gmail.com>
        <20181129215850.7278-8-pclouds@gmail.com>
        <CABPp-BHQ68pkvO8yXYuy=0D6ne8u=5CUMDqiN0jtRrxCL55n2g@mail.gmail.com>
        <CACsJy8BTs+WKzTTEF2XVTT-LVJk_exYCz_hN+hXU1Dw+oquBpA@mail.gmail.com>
Date:   Wed, 05 Dec 2018 11:14:32 +0900
In-Reply-To: <CACsJy8BTs+WKzTTEF2XVTT-LVJk_exYCz_hN+hXU1Dw+oquBpA@mail.gmail.com>
        (Duy Nguyen's message of "Tue, 4 Dec 2018 17:21:37 +0100")
Message-ID: <xmqqtvjsen3r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 82676E78-F833-11E8-A94E-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> My single biggest worry about this whole series is that I'm worried
>> you're perpetuating and even further ingraining one of the biggest
>> usability problems with checkout: people suggest and use it for
>> reverting/restoring paths to a previous version, but it doesn't do
>> that:
>
> ...
>
>  git restore-files --from=master~10 Documentation/

The "single biggest worry" could be due to Elijah not being aware of
other recent discussions.  My understanding of the plan is

 - "git checkout" will learn a new "--[no-]overlay" option, where
   the current behaviour, i.e. "take paths in master~10 that match
   pathspec Documentation/, and overlay them on top of what is in
   the index and the working tree", is explained as "the overlay
   mode" and stays to be the default.  With "checkout --no-overlay
   master~10 Documentation/", the command will become "replace paths
   in the current index and the working tree that match the pathspec
   Documentation/ with paths in master~10 that match pathspec
   Documentation/".

 - "git restore-files --from=<tree> <pathspec>" by default will use
   "--no-overlay" semantics, but the users can still use "--overlay"
   from the command line as an option.

So "restore-files" would become truly "restore the state of
Documentation/ to match that of master~10", I would think.

>> Also, the fact that we're trying to make a simpler command makes me
>> think that removing the auto-vivify behavior from the default and
>> adding a simple flag which users can pass to request will allow this
>> part of the documentation to be hidden behind the appropriate flag,
>> which may make it easier for users to compartmentalize the command and
>> it's options, enabling them to learn as they go.
>
> Sounds good. I don't know a good name for this new option though so
> unless anybody comes up with some suggestion, I'll just disable
> checkout.defaultRemote in switch-branch. If it comes back as a new
> option, it can always be added later.

Are you two discussing the "checkout --guess" option?  I am somewhat
lost here.

>> > +-f::
>> > +--force::
>> > +       Proceed even if the index or the working tree differs from
>> > +       HEAD.  This is used to throw away local changes.
>>
>> Haven't thought through this thoroughly, but do we really need an
>> option for that instead of telling users to 'git reset --hard HEAD'
>> before switching branches if they want their stuff thrown away?
>
> For me it's just a bit more convenient. Hit an error when switching
> branch? Recall the command from bash history, stick -f in it and run.
> Elsewhere I think both Junio and Thomas (or maybe only Junio) suggests
> moving the "git reset" functionality without moving HEAD to one of
> these commands, which goes the opposite direction...

Isn't there a huge difference?  "checkout --force <other-branch>"
needs to clobber only the changes that are involved in the switch,
i.e. if your README.txt is the same between master and maint while
Makefile is different, after editing both files while on master, you
can not "switch-branch" to maint without doing something to Makefile
(i.e. either discard your local change or wiggle your local change
to the context of 'maint' with "checkout -m").  But you can carry
the changes to README.txt while checking out 'maint' branch.
Running "git reset --hard HEAD" would mean that you will lose the
changes to README.txt as well.

>> > +--orphan <new_branch>::
>> > +       Create a new 'orphan' branch, named <new_branch>, started from
>> > +       <start_point> and switch to it.  The first commit made on this
>>
>> What??  started from <start_point>?  The whole point of --orphan is
>> you have no parent, i.e. no start point.  Also, why does the
>> explanation reference an argument that wasn't in the immediately
>> preceding synopsis?
>
> I guess bad phrasing. It should be "switch to <start_point> first,
> then prepare the worktree so that the first commit will have no
> parent". Or something along that line.

It should be a <tree-ish>, no?  It is not a "point" in history, but
is "start with this tree".

I may have more comments on this message but that's it from me for
now.
