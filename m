Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE453C433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 11:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhLTLxc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 06:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhLTLxb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 06:53:31 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9083CC061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 03:53:30 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id m21so9986337edc.0
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 03:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=1YSAodaEP9uCygiMVsHiqwGYwHz3i31eM3eNDeMY0yc=;
        b=MFRq1ikgKczDVwvZcj3jIBd8ho254SehsqYMzDFJGvpPg0JkgwqU0sbKpWRb/MSeqq
         0XP8tk1LrUw3YNBI9PGxIyom3OJS7D0ZVEmr5Bu+ZxFadKlRxJwKluqxlouTdB70Amxq
         2mX01ZoaUgWuipFYD9w/Gca3nMhWYTNX+KKZljYIWnel2W3/nSDJ0BREky+5nuntrMLh
         3Bk5HcxX86nYRdyg6UszLa+MsooYD7H0fScDy2f3xug1j290ZQ7AYeancvaJPPpLqKIx
         cQzGE6rm3qSg78fkQHBRl9GIW9GxX0WJ4OMgAct4sY4xPgwX8Y/chp9Eh6PRrHMQ84RD
         Yj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=1YSAodaEP9uCygiMVsHiqwGYwHz3i31eM3eNDeMY0yc=;
        b=sxpOZbiqVXvoHgFH+pctCeKPeV7TulA4TY6NiOFKoqxjFTfQpl/U3SiLQJrkZ1UwJn
         sK4Uu0jRv0X/bmcSgZTOzR+CE1QXOx+Y9E+ciBVEUSNB0aSA8J7muZiRjs7SSy8S08Ip
         t6JyUNfrqX+xZaulwFuZxh3oJTmQEjc7woxKVU1PCE9JTIailtKJ1nx7BJu+FFVnwSjD
         k7I00QTXvRUK4ug8mICswBgQ0yqYAeu6RiWjMqDLnUJlVDTZHVXhBlargK2QnvjlcQuB
         93pLVN2ZDulPNZk5TnKnt1UyJFKfh9lWwSo5v9zq6W9ZOcM6TwDqoYXTe1om4nx6SDOk
         RDaA==
X-Gm-Message-State: AOAM531Xou1MdWm5sxTggnhnXFqMKxEpnLZKQs1JMineXDBakri4YcCV
        uR5YFMU5SWIoQj8b4YESVpe+Y57Eq4A=
X-Google-Smtp-Source: ABdhPJyo+ZoAneMsoKsHoeoGxP8NfokxJxqKFKKjSU5+co7vOCt/9ezXqoUFnV9LQAqAwobzneqTyQ==
X-Received: by 2002:a17:907:1c11:: with SMTP id nc17mr12507672ejc.246.1640001208654;
        Mon, 20 Dec 2021 03:53:28 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gb35sm3066844ejc.36.2021.12.20.03.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 03:53:28 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mzHEN-000NaW-Pl;
        Mon, 20 Dec 2021 12:53:27 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, jonathantanmy@google.com,
        steadmon@google.com, chooglen@google.com, calvinwan@google.com,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        <rsbecker@nexbridge.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Review process improvements
Date:   Mon, 20 Dec 2021 12:22:32 +0100
References: <YbvBvch8JcHED+A9@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <YbvBvch8JcHED+A9@google.com>
Message-ID: <211220.86fsqnwkzs.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 16 2021, Emily Shaffer wrote:

> In the first half of January, I'd like to have a review out to the list
> adding a kernel-style MAINTAINERS file with a few areas of interest. To
> that file, I'd like to add "R:" ("CC me!") lines to subsystem mailing
> lists and interested individuals. My hope is that that will make it easy
> for someone to either add themselves as an "R:" or to subscribe to the
> subsystem list, and then be able to filter their mail based on "stuff
> I'm CC'd to" or "stuff sent to git-partial-clone@linux.dev" - and then
> be able to review every patch in that list. I'd like to create lists on
> topics where it makes sense, too.
>
> Since the Git codebase isn't modularized into subsystems as plainly as
> the kernel is, I don't think that the MAINTAINERS list needs to be
> machine-parseable yet, although it would be a nice goal. Maybe over time
> we will decide we'd rather organize the codebase differently and
> implement a machine-parseable MAINTAINERS list to incorporate into a
> sendemail-validate hook, or something. So I envision lines looking
> something like this (just examples, sorry for directly calling people
> out ;) ):
>
>   Submodules
>   submodule.[ch], git-submodule.sh, builtin/submodule.c,
>     Documentation/git-submodule.txt, anything else adding a feature invol=
ving
>     submodules
>   R: git-submodules@example.com
>   R: emilyshaffer@google.com
>
>   Config improvements
>   Documentation/config/*, config.[ch], builtin/config.c, changes which ad=
d new
>     config options
>   R: emilyshaffer@google.com
>   R: avarab@gmail.com
>
> It would be extremely useful to hear other suggestions from the mailing
> list about subsystems which deserve a MAINTAINERS line and possibly a
> subsystem mailing list.

Konstantin commented on some of this, and not to pile on, but I'd also
not like to see such a MAINTAINERS file in git.git for those sorts of
things.

I think this makes sense for linux.git as different subsystems have
different mailing lists that are used for patch review, coordination
etc. Linus then pulls from those and other subsystem maintainers. There
seem to be on the order of 100 of those split-outs now:

    $ git grep -h -o linux-.*@.*kernel.org MAINTAINERS|sort -u|wc -l
    77

Whereas the only cases that really applies to in git.git (and I think it
might be useful to have a MAINTAINERS for these) are:

    # but not all of po/, see caveats in po/README etc.
    po/ -> https://github.com/git-l10n/git-po/
    # Pulled from their respective upstreams
    {gitweb,git-gui}/
    # Anyhing else I'm missing? Maybe {sha1dc,sha1collisiondetection}/*?
=20=20=20=20
But (and I know you just used me as an example, but it applies in
general) I'd really not like to be CC'd on any change to config.[ch]
just because I touched some code in those files that's clearly unrelated
to whatever change is now being proposed.

We should be leaning into helper scripts like
contrib/contacts/git-contacts (and I'm aware of some out-of-tree "better
git-contacts", but have not used them myself).

I.e. we almost always have a better and more accurate version of this
information in the commit history.

E.g. in the side-thread Randall asked to be CC'd on NonStop changes. I
think he should (and as does he), but I really don't see how it's
necessary to have a MAINTAINERS for such use-cases. If I'm editing what
little NonStop-specific code we have in tree, it should be impossible to
miss Randall as an interested party when findings someone to CC through
the usual means.

What are those "usual means"? I think they're different for most list
regulars, but my personal worklow is (and I think some version of this
applies to most regulars):

1. As I'm preparing a patch series I'll need to run some of "git log",
   "git blame", "git log -G<relevant-string>", "git log -L:<funcname>:<file=
>"
   etc. just to understand the code I'm modifying.

   As I'm doing that I take notes (usually these make it into draft commit
   messages, noting prominent commits whose behavior is being changed). The
   authors likewise make the draft CC list.

   This is basically an approximation of what a script like "git-contacts"
   tries to do, but I manually filter it. So e.g. I won't CC a person who
   just tree-wide renamed a function I'm changing, even if that's the last
   edit to the exact line I'm changing.

2. I apply (sometimes on the fly) some fuzzy filtering to prune the above l=
ist.
   Mostly this is to remove people from CC that I know to be inactive/gone,=
 but
   I'll also lean towards removing people I know to be CC'd a lot already, =
unless
   the change really is highly relevant to them in particular.

This is manual for me now through a combination of not having bothered
to automate it, and from having peeked a bit at some of automated
tooling and concluded "it looks like I'd need to manually filter this
anyway". E.g. I think "git contacts" can produce some rather na=C3=AFve
output.

But leaning into that approach would be a much better
direction. E.g. the "filter out inactive" could be mostly/entirely done
via some configured heuristic in such a tool, together with downloading
the LKML archive to see how long it's been since someone last posted
something.

I can also imagine a MAINTAINERS being very useful for cases that aren't
evident from scouring the commit logs, or for which it's nice to be
explicit about.

E.g. I've often chimed in on changes to do withn how/whether something
can/should be marked for translation. I added the i18n subsystem
initiall, so for those cases interested parties would probably find me
anyway, but I wouldn't mind being explicit about that. Ditto for people
we consider the authority on certain subsystems, such as (this may not
be any one person currently), refs, the index, SHA1<->SHA256 interop
etc.
