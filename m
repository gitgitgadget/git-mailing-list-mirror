Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B08AC433B4
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 02:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45013613BF
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 02:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237183AbhD1Ctq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 22:49:46 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54266 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235839AbhD1Ctq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 22:49:46 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F25FB1235AD;
        Tue, 27 Apr 2021 22:49:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Rq4Qxl0KtylY
        1Yl3YWX7kgBy08OFNvdSO34xu487wBg=; b=Shr83dRGizXDHd51ExJjTYM5IMYj
        0FvMnzylMFAkPPfgdC9RSwj78K0GXUwKkmeLB590qwKP/x7A2a2WAeSSrJZOpa2y
        F1RpcgJlmTrqOR/lr/BdTl0/oaWchypk5eYj3pR8ffWeEh6zlZX/YAbg5ddVs54A
        yAU6EA6y2fuRG1M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EA4F11235AC;
        Tue, 27 Apr 2021 22:49:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 242A61235AA;
        Tue, 27 Apr 2021 22:48:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Albert Cui via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Albert Cui <albertqcui@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Ed Maste <emaste@freebsd.org>
Subject: Re: [PATCH v3] hooks: propose project configured hooks
References: <pull.908.v2.git.1616723016659.gitgitgadget@gmail.com>
        <pull.908.v3.git.1619228290023.gitgitgadget@gmail.com>
Date:   Wed, 28 Apr 2021 11:48:57 +0900
In-Reply-To: <pull.908.v3.git.1619228290023.gitgitgadget@gmail.com> (Albert
        Cui via GitGitGadget's message of "Sat, 24 Apr 2021 01:38:09 +0000")
Message-ID: <xmqqtunrceee.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 48369CE2-A7CC-11EB-B38A-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Albert Cui via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/technical/project-configured-hooks.txt b/Doc=
umentation/technical/project-configured-hooks.txt
> new file mode 100644
> index 000000000000..eb18eb6aa1b4
> --- /dev/null
> +++ b/Documentation/technical/project-configured-hooks.txt
> @@ -0,0 +1,528 @@
> +Project Configured Hooks
> +------------------------
> +
> +// The '+' in Gerrit URL frightens asciidoctor.
> +:chrome-os: https://chromium.googlesource.com/chromiumos/docs/+/HEAD/c=
ontributing.md#Upload-changes
> +:repohook-read: https://android.googlesource.com/platform/tools/repoho=
oks/+/refs/heads/master/rh/config.py
> +:repohook-config: https://android.googlesource.com/platform/tools/repo=
hooks/+/refs/heads/master#config-files
> +
> +Background
> +~~~~~~~~~~
> +
> +Context
> +^^^^^^^
> +
> +Git has linkgit:githooks[hooks] functionality to allow users to
> +execute commands or scripts when certain Git events occur. Some use ca=
ses
> +include:
> +
> +* The `pre-commit` hook event:
> +* The `commit-msg` hook event: the project may want to enforce a certa=
in commit
> +* The `pre-push` hook: the project may want to verify that pushes are =
going to
> +the correct central repository to prevent leaks.
> +
> +A common thread between these use cases is to enforce certain behavior=
 across
> +many developers working in the same code base, encouraging best practi=
ces and
> +healthy code quality.

I suspect that this point has already been raised, but as all of you
who thought about the hooks already know, it is not appropriate to
characterize local hooks as a means to satisfy "the project may want
to enforce" listed above.  It ultimately is up to the project's
pre-receive (or update) hook to reject history with house style
violations, mistakenly added password files, commit log messages
with swearwords, etc.  Presenting local hooks as if they can be used
as an enforcement mechanism is misleading to our readers.

A more understandable description that is easier for readers to
accept would be that local hooks can be used to help developers
prevent their later pushes from getting rejected, by duplicating
(possibly a subset of) the checks the server end uses to judge their
contribution.  You'll address that in the next section, so the above
description that is misleading should be aligned with the next
section that deals with "local checks vs receiving end checks",
perhaps?

As local checks must perform (possibly a subset of) checks done on
the receiving end, it probably is a good idea to address how you
would plan to manage the "duplication" of the checks.  Anything you
implement only on the client side "hooks" will not be enforced (they
only stay "advisory" at best), unless the same or stricter checks
are done on the receiving end.

> +A large motivation for this change is providing projects a method to e=
nable
> +...
> +local hook execution. We think there are still benefits to local check=
s:

Yes, noticing problems early before it gets too late would save
developer's frustration and work that needs to be redone.  I do not
think you'd need to say more than that two lines---the need for
enforcing house style, accidental leakage of secrets, etc., is not
"there are still benefits to do them locally".

> +* Helps developers catch issues earlier: typically developers need to =
push to
> +the remote to trigger server-side checks. Local hooks can be run anyti=
me the
> +developer wants.

Yes, exactly.  So, perhaps the introduction section should say how
the checks in the entire change flow helps the project (i.e. house
style, leak prevention, etc.), and the ultimate place of validation
and rejection is at the receiving side when developers push.  Then
the "local vs server" section should say why is it good to have
local checks at all (i.e. catch issues early), how local hooks
should check (possibly a subset of) rules eventually enforced at the
receiving end when the developer pushes, and how the duplication is
managed (if any).

> +In the ideal world, developers and project maintainers use both local =
and
> +server-side checks in their workflow. However, for many smaller projec=
ts, this
> +may not be possible: server-side checks may be too expensive, either m=
onetarily
> +or in terms of time investment, to run. The number of local solutions =
to this
> +use case speaks to this need (see <<prior-art, Prior Art>>). Bringing =
this
> +natively to Git can give all these developers a well-supported, secure
> +implementation opposed to the fragmentation we see today.

I personally do not find this convincing.

At least, as a document that gives an official recommendation to the
users that comes from this project, I would prefer not to see the
"However, ... to run" part.  I also do not see how one can claim
that the number of "local solutions" speak to the need.  It can
happen when there are many folks who do not understand that a rule
not enforced is a rule that people would deem not worth honoring.
Depending on the local hooks for any enforcement is akin to
depending on obscurity for your security needs.

> +Security Threat Model
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +=3D=3D=3D=3D Principles
> +
> +1. It is unreasonable to require users to audit hook code themselves.
> +
> +    * Users do not have time
> +    * Users, in general, are unfamiliar with system exploits / securit=
y
> +    * Users may be unfamiliar with a hook=E2=80=99s implementation lan=
guage
> +    * Hooks may be compiled binaries and unauditable
> +
> +2. It is reasonable for users to make a trust decision based on where =
a hook comes from.
> +
> +    * Society functions on the basis of trust relationships formed bet=
ween different
> +    agents --- this is the basis for being able to accomplish more tha=
n one person
> +    can personally accomplish. The complexity is giving users the powe=
r to make that
> +    trust decision.
> +    * Git users are already making trust decisions based on repository=
 origin.

The above only deals with the case where malicious project attacks
their developers.

But an earlier parts of the document gave (too much---if you ask me)
stress on how wonderfully local hooks can enforce projects' wish on
developers' behaviour, so there is another threat you would want to
cover (if you want to keep that claim in the document, that is): a
disobedient developer may bypass the hooks and attacks the project
by pushing contents the project do not want to see.  That's a threat
going the other way, a "malicious" developer attacking the project.

> +* [Minimum Feature] A repository owner can update a hook, at which poi=
nt users who have
> +installed it can decide whether to upgrade or uninstall it
> +
> +    ** A good enhancement soon after would be to allow users to indica=
te at hook
> +    installation time that they want to accept all updates of this sam=
e hook
> +    from the same origin.

That would be a useful usability feature when this eventually
becomes widespread use.

> +2. Adversary intercepts requests for a repository and inserts maliciou=
s hooks
> +(person-in-the-middle-type attacks). Mitigation:
> +
> +    ** Only receive hooks suggestions over HTTPS / SSH
> +
> +    ** Include the hook origin (domain name) in the command to install=
 a hook

Signed scripts?

You may use HTTPS/SSH origin to identify the project, but using
something like GPG keys and allowing project developers to give
acceptance based on the signer may give us more flexibility.  A
clone whose contents largely came from insecure means (e.g. http://
cdn perhaps?) could still offer hook scripts as long as they are
signed by keys project participants trust, for example.

I do not know if that would be an effective remedy for the
"shiny new evil maintainer" problem, though.


> +4. Adversary exploits an old security issue with a hook that has since=
 been
> +patched. Mitigation:
> +
> +    ** Allow users to opt-into hooks getting auto-updated

I am not sure what threat you are "mitigating" against here.  If
the suggested update to hooks come in-band as some Git object tied
to the upstream repository (either as part of the main history, or a
separate refspace), an adversary that is capable of downgrading a
hook can feed a maliciously modified Makefile just as easily, no?


> +*hook command*: A user script or executable which will be run on one o=
r more
> +hook events.
> \ No newline at end of file

Oops.
