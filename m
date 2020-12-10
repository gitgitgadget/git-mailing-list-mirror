Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B467C4361B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 06:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C903122D02
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 06:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732338AbgLJGqI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 01:46:08 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61556 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730364AbgLJGqH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 01:46:07 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E0E7DA1FB1;
        Thu, 10 Dec 2020 01:45:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4vz7gB4PbaQlZRM/524AuIEJuGk=; b=lnyc9I
        cmMLDmDa22f74Y0JK9iJP2/I0DtuDfYyOXamiOVHi/2qAiBellK6fk6cvJkeNli+
        8sWRoym3btZbk0P0bY5UOyef/O+1TMr/5TYnRAYIfid/J6LEXfztq4aKAlSHkzoi
        gpdKYZbRJFoyEvAm9gb+fsuRB+qcVNlEqkZ60=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=f2+4xAJL0wWD1l83zsYK3+aHZwtHRvIo
        TpUYq34aHAkbNDwXCUBVWgAFsAiWbsHtN9TPpKKTb4c79te3hxbRw7NsWyZRqTaX
        uwLiAnm6ffqLMzrInJTkIgIAb4jG8Fml40hpmTsEjcXtYVakLVY8GP7vDapEbKBL
        d3yNPox46Fs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D7742A1FAE;
        Thu, 10 Dec 2020 01:45:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 57A80A1FAD;
        Thu, 10 Dec 2020 01:45:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?Q?V=C3=ADt?= Ondruch <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v2 02/14] pull: improve default warning
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
        <20201204061623.1170745-3-felipe.contreras@gmail.com>
        <CABPp-BFdjj=+4jk0vo=kpNc6ug1=UgtKfXJZkseyyxut2VB=Uw@mail.gmail.com>
        <CAMP44s1eTc4+tbULbyz5ENgbcN4tOVBA3Z-4GS4yMpciUD_1Hw@mail.gmail.com>
        <CABPp-BFwWBLdFPsKi3o9hznFtAeWWfhNAyuymPS4BhMAHpnSfw@mail.gmail.com>
        <CAMP44s1=aZL7BMKSjzKJ7qYqg-usScwzRUJmaOhsCGvQ4ieYow@mail.gmail.com>
        <CABPp-BF4rXBOKsn8bG6y3QUEtNVV9K2Pk5NmwrU5818CqhRt_Q@mail.gmail.com>
        <CAMP44s2L24jhCG9ps72--ZiJkXUovR726jCf8JTLHAs0jV7Whg@mail.gmail.com>
        <CABPp-BGdNt8TBMTE9zvaicF5AtvyTBhpiJXqkuZc7mBLGbw0Qw@mail.gmail.com>
        <xmqqeek2cc14.fsf@gitster.c.googlers.com>
        <CAMP44s2XFQoda_PMULWha-rj9HhNfEddO5fikmswk9=AWN4RCw@mail.gmail.com>
        <xmqqpn3lbhxn.fsf@gitster.c.googlers.com>
        <CAMP44s2nmVnXiBA8S=vHBZznuRNKKe=xGOEBJ80MYhA_XCqNkg@mail.gmail.com>
        <xmqqlfe99yvy.fsf@gitster.c.googlers.com>
        <CA+P7+xp=UGd0iK8uLxnqH0iycrxo--8on3d0Z+jsuyhpV-fVew@mail.gmail.com>
        <xmqq360h8286.fsf@gitster.c.googlers.com>
        <CAMP44s3KCoDfRXzarJw5AE7UsY-=eP6GbHzdDcdrs2rsw5tL+w@mail.gmail.com>
        <xmqqy2i86ok1.fsf@gitster.c.googlers.com>
        <CAMP44s13YFZeOMz6V5sPdOnLXD-v3aQZiP7vvXXNfQLZP4Puwg@mail.gmail.com>
        <CABPp-BGZcmHhge7JnM12baL_86yV-+7z4kkvFwUUrP+db8QD8Q@mail.gmail.com>
Date:   Wed, 09 Dec 2020 22:45:19 -0800
In-Reply-To: <CABPp-BGZcmHhge7JnM12baL_86yV-+7z4kkvFwUUrP+db8QD8Q@mail.gmail.com>
        (Elijah Newren's message of "Wed, 9 Dec 2020 11:05:11 -0800")
Message-ID: <xmqqy2i6w45c.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 457507D6-3AB3-11EB-B162-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Have I missed some subtlety here?  This whole email appears to me to
> be arguing against a strawman.  Reading Junio's other emails in this
> thread[1][2], it's pretty clear he thinks the current behavior is
> buggy and suggests how it should be changed.  From what I can tell,
> you appear to be arguing against doing nothing and against only
> accepting perfection, neither of which were positions I saw anyone
> take.  In fact, the positions you argue for at length appear to
> exactly match the ones he took[1][2].  What am I missing?
>
> [1] https://lore.kernel.org/git/xmqq360h8286.fsf@gitster.c.googlers.com/
> [2] https://lore.kernel.org/git/xmqqlfe99yvy.fsf@gitster.c.googlers.com/

I tend to agree that the endgame state I want is pretty similar to
what Felipe wants.  The seeming confusion is probably due to what
exactly I mean by "default" is different from what he means.

I view the proposed "for unconfigured users, pull dies, and tells
them to choose between rebase or merge before it can continue, when
faced with a non-ff history" as a safe fallback behaviour until the
users make their choice.

It is a safe fallback to disable the more dangerous half of the
command until the user gives enough information to the command to do
its job without damaging the resulting history; it is not something
the users would actively want to choose.  

And that is what I meant by the default behaviour.

And when we stop in such a manner, it is sensible to give an error
message telling them 

 - why we are stopping,

 - what they can do to move the immediate situation forward
   (i.e. command line option that lets them choose), and

 - what they can do to make their choice permanent so that they
   would never see the command stop when facing a non-ff history
   (i.e. the configuration variables).

Up to this point, I think both of us agree with the above.

We start to differ after this point.  I would want to see only
"rebase" and "merge in the "choice" in the above list.  Felipe, if I
understand correctly, wants to add the third one, "ff-only", which
means the more dangerous half of "pull" is disabled by default.

I do not want to include that choice, as it would mean the more
familiar pull.rebase=yes/no would no longer work, and we'd need to
introduce a new variable, like pull.mode=ff-only.  It would mean for
those who use "pull" to consolidate histories on their side and
other people's side, whether they use rebase or merge, would now
have two ways to do the same thing (i.e. pull.rebase=no or
pull.mode=merge).  That is just making the end user experience more
complex than necessary.

Without introducing pull.mode, the only thing the users cannot do,
as far as I can tell, is to explicitly ask for the behaviour of an
unconfigured user (i.e. error out when faced with non-ff history)
without being told about the way to use configuration variable to
permanently record their choice.  Other than that, the existing
pull.rebase=yes/no is perfectly adequate.  Felipe seems to think
otherwise and wants not just the "safe fallback behaviour", but can
explicitly be configured using pull.mode=ff-only (and if that is not
what Felipe thinks, perhaps we are already in agreement without
realizing it).

Thinking about it again, I guess pull.rebase=yes/no plus a new
advise entry can easily give what Felipe seems to want.  We teach
"git pull", when it is not told to rebase or merge (either via the
command line --[no-]rebase or via pull.rebase configuration) and
when it sees a non-ff history, to

 - error out with a message telling the user that we are stopping,
   because the two histories needs consolidating to conclude this
   pull, but the two available ways would give vastly different
   result.

 - check the advice.pullNonFF configuration (as usual, it defaults
   to true) and if true, further tell the user that

    (1) they can either run "git pull --rebase" or "git pull
        --no-rebase",

    (2) they can configure their choice permanently with
        pull.rebase=yes/no, and

    (3) they can leave "pull" in the half-disabled state but stop
        seeing this message by setting advice.pullNonFF to false.

The last part (i.e. advice.pullnonFF) is the only new thing I said
in the various discussions on this topic (simply because I just came
up with the idea).  Everything else I've already said it elsewhere.

I dunno.
