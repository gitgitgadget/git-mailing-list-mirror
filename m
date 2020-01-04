Return-Path: <SRS0=9bkr=2Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AE5C32767
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 05:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1AF222C4
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 05:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=qrpff.net header.i=@qrpff.net header.b="irieF9pM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbgADFoA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jan 2020 00:44:00 -0500
Received: from bonobo.elm.relay.mailchannels.net ([23.83.212.22]:58309 "EHLO
        bonobo.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725730AbgADFoA (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 4 Jan 2020 00:44:00 -0500
X-Sender-Id: dreamhost|x-authsender|stevie@qrpff.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 1750F8C0EA8
        for <git@vger.kernel.org>; Sat,  4 Jan 2020 05:37:21 +0000 (UTC)
Received: from pdx1-sub0-mail-a62.g.dreamhost.com (100-96-92-234.trex.outbound.svc.cluster.local [100.96.92.234])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 6FABE8C1B87
        for <git@vger.kernel.org>; Sat,  4 Jan 2020 05:37:20 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|stevie@qrpff.net
Received: from pdx1-sub0-mail-a62.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.18.5);
        Sat, 04 Jan 2020 05:37:20 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|stevie@qrpff.net
X-MailChannels-Auth-Id: dreamhost
X-Abaft-Interest: 0418d2f069aaeae2_1578116240867_1694871737
X-MC-Loop-Signature: 1578116240867:3212793526
X-MC-Ingress-Time: 1578116240867
Received: from pdx1-sub0-mail-a62.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a62.g.dreamhost.com (Postfix) with ESMTP id 7872E804D0
        for <git@vger.kernel.org>; Fri,  3 Jan 2020 21:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=qrpff.net; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=qrpff.net; bh=J8U7GBAia2q/sIUJw4LJYD3NiOk=; b=i
        rieF9pM/eVXhpN0P2nFoC1RK73Zl54THCQI9EbC450Hooz71a77thlZ9/mZtPKbp
        FUJ82QRxJfbKipHQgKTeDaMrbVAYbkCumOkI3vYhtCWVO5ZcrjjNU2KeZPRlk1DE
        8+IKDiNp7SNfsXYwNXQmO5MeIkZv0N+YBih5Ata4Oc=
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stevie@qrpff.net)
        by pdx1-sub0-mail-a62.g.dreamhost.com (Postfix) with ESMTPSA id 1C698804C9
        for <git@vger.kernel.org>; Fri,  3 Jan 2020 21:37:16 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id y4so31420293ljj.9
        for <git@vger.kernel.org>; Fri, 03 Jan 2020 21:37:15 -0800 (PST)
X-Gm-Message-State: APjAAAVR5x8RbIDucYOYBouVKdlbEbzk0S841DTwWjdxUiC/XLv82rhL
        dz+0j6PC87BzOYbYhfCnsnKGgTJXTEVjzEXZuHk=
X-Google-Smtp-Source: APXvYqynGh8AVX7vPzW/9LPCg7Jt682hB2+9cn+s89nhhl3Zh1Byqtz2x9+TrVjUal/3ajToZ6bdDBIaWwUR7hag/YE=
X-Received: by 2002:a2e:868c:: with SMTP id l12mr10521221lji.194.1578116234058;
 Fri, 03 Jan 2020 21:37:14 -0800 (PST)
MIME-Version: 1.0
References: <20200103043027.4537-1-stevie@qrpff.net> <20200104012230.GD130883@google.com>
In-Reply-To: <20200104012230.GD130883@google.com>
X-DH-BACKEND: pdx1-sub0-mail-a62
From:   Stephen Oberholtzer <stevie@qrpff.net>
Date:   Sat, 4 Jan 2020 00:37:02 -0500
X-Gmail-Original-Message-ID: <CAD_xR9ch4M3i0tPgR1uOvkC=xpXo2nPHA71A1nwmZqtb_YCMsw@mail.gmail.com>
Message-ID: <CAD_xR9ch4M3i0tPgR1uOvkC=xpXo2nPHA71A1nwmZqtb_YCMsw@mail.gmail.com>
Subject: Re: [RFC PATCH] bisect run: allow inverting meaning of exit code
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: -100
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdeggedgkeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftfghnshhusghstghrihgsvgdpffftgfetoffjqffuvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepgghfjgfhfffkuffvtgesthdtredttddtjeenucfhrhhomhepufhtvghphhgvnhcuqfgsvghrhhholhhtiigvrhcuoehsthgvvhhivgesqhhrphhffhdrnhgvtheqnecukfhppedvtdelrdekhedrvddtkedrudejudenucfrrghrrghmpehmohguvgepshhmthhppdhhvghlohepmhgrihhlqdhljhduqdhfudejuddrghhoohhglhgvrdgtohhmpdhinhgvthepvddtledrkeehrddvtdekrddujedupdhrvghtuhhrnhdqphgrthhhpefuthgvphhhvghnucfqsggvrhhhohhlthiivghruceoshhtvghvihgvsehqrhhpfhhfrdhnvghtqedpmhgrihhlfhhrohhmpehsthgvvhhivgesqhhrphhffhdrnhgvthdpnhhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan,

Thanks for your feedback!

On Fri, Jan 3, 2020 at 8:22 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> (+cc: Christian Couder, bisect expert)
(noted)

> >
> > * '--' can be used as an option list terminator,
> >   just as everywhere else.
>
> Could this part go in a separate commit?  That way, it can go in
> more quickly while we figure out the rest. :)

Done!  That one was simple enough I didn't tag it RFC.

>
> Initial thoughts:
>
> - it's not immediately clear to me that this is common enough
>   to need the short-and-sweet name "-r".  Could it have a long
>   form only?

Of course; I was just trying to be thorough.

> - I think I agree with you that "git bisect run --expect=5" might
>   be more clearly written as "git bisect run --success=5".  Or even
>   something explicitly referring to exit status, like
>   --success-status=5.

That's not quite what I had here (although it touches on another idea
I've been mulling over.)
My patch adds "--success=<term>", meaning

git bisect run --success=foo ./myscript.sh

does: run myscript.sh, and if the script succeeds -- that is, exits
with status 0 -- then do 'git bisect foo'; otherwise, do whatever the
other one is.

WIthout any specialized options, the behavior today is equivalent to
"--success=good" (where status 0 means 'git bisect good', otherwise
'git bisect bad'.)

>
> - This has an interesting relationship to the "alternate terms"
>   feature (--term-old / --term-new).  I don't know if there's a
>   good way to make that more explicit --- maybe just some notes
>   with examples in the relevant parts of the manpage?

I actually had this detail spelled out in the blurb I had been writing
in Documentation/git-bisect.txt:

+The "good/bad" interpretation can be reversed by specifying -r,
+--invert, or --success=bad (or, if the bisect was started with
+--term-bad specified, the appropriate string.) In such circumstances,
+an exit code of 0 is taken to mean 'bad', while an exit code of 1-124
+or 126-127 is treated as 'good'.  The meaning of all other exit codes
+is unaffected by this option.

That's why my initial version called it "expect": my thinking was that
I was "expecting" the script to say that the version was bad, rather
than that it was good.

> - the name --invert doesn't make it obvious to me what it is
>   inverting: good versus bad, ones complement of the status
>   code, revision range passed to "git bisect start"?
>
>   Are there other commands we can try to make this consistent with?
>   "find" supports arbitrary expressions involving '!' and '-not'.
>   "git grep" has --invert-match: perhaps a name --invert-status
>   would be clear enough?

"--invert-status" would work for me (or "--negate-status", perhaps?)

>
> > You're not allowed to specify more than one expectation.
>
> Usual convention would be "last specified option wins".

That's fine, I can make such a thing work.

> As you said, this needs docs.  Writing docs often helps make the UI a
> bit better since it forces one to think about the various ways a tool
> would be used in practice.

I'd started writing them even before you replied; I didn't want to
write *too* much and have to do a lot of replacing on option names.

> > +     while [ "$1" != "${1#-}" ]; do
>
> Might be simpler to do 'while true', and in the *) case to break.

I went with `test -n "$1"` after Junio pointed me at the coding guidelines :)

> It's more idiomatic to use eval_gettext here.  See
> "git grep -e die -- '*.sh'" for some examples.

Yeah, I hadn't yet learned about about eval_gettext before sending the
patch.  Once I saw it referenced in other code, it was easy to make
happen.

> "set -e" has
> enough exceptions that it hasn't been worth using for this.

Exceptions? Like what? As my comment pointed out, I don't know how the
test suite managed to make 'set -e' _not_ work (although I can see
that it has, in fact, managed this.) In fact, I suspect the fact that
it managed it is actually a bug in dash.

> The test
> harness is able to detect a missing "&&" so this is less error-prone
> than it sounds.)

'set -e' should be functionally equivalent to using '&&' between all
pipelines, except it also handles loops.
(also, all of those &&s are awkward to write.)

> Thanks for a clear and pleasant description of the problem being
> solved.  I would like to say "here's a simple shell construct to use
> instead of ! that makes this all redundant" but lacking that, for what
> it's worth this set of new options seems like a good idea to me. :)

Well, yeah, if there was a simple shell construct to use instead of !,
I wouldn't have bothered to code this up in the first place :)

Here's what got me started on this stuff in the first place:

I was trying to bisect an kernel issue I was having. However, I had
two problems: (a) the affected machine is not powerful enough to build
a kernel in less than a day, and (b) my most reliable way to detect
the issue had to be initiated from an external system.

I wrote a script that would: build the kernel, install it onto
affected machine, boot new kernel on affected machine, and run some
tests to see if the problem occurs.

There were four possible outcomes from each attempt:

1. Kernel fails to build or boot: correct action is 'git bisect skip'
(this was mapped to exit code 125)
    (note that, since there was no way to automatically determine if
the kernel booted correctly, that situation actually manifested as
case 4)
2. Problem is not present: correct action is 'git bisect good' (mapped
to exit code 0)
3. Problem is present: correct action is 'git bisect bad' (mapped to
exit code 99)
    (also: need to reboot the machine back to a working kernel.)
4. Something unexpected went wrong: correct action is to hit the
emergency stop and let me fix it manually (mapped to exit code 255)

Situation #4 probably happened about five or six times, in all. (One
memorable instance was during the 16th or 17th revision, when the
target machine ran out of disk space while copying the new kernel
over.  A couple of times, ssh had an error trying to connect.  And
several times, for reasons beyond my understanding, the 255 failsafe
kicked in on exit code 99.)

I had to map a _lot_ of failure cases to 255. In essence, I did this:
(That's why I used 99 to indicate failure; it was unlikely to produce
a false positive.)  I used a bunch of ultimately-not-very-reliable
techniques to try and map all exit codes other than 0, 99, or 125 to
255.  I'm thinking of adding a "--fail-status=" option, which would
let you specify the explicit status code or codes to treat as 'bad',
with all other nonzero codes being hard errors and causing 'run' to
bail immediately.  Such a thing would have made several aspects of my
script far less error-prone.

It took most of a day (much better than most of a month) but I found
the offending commit.

Later, I noticed that, in one of the recent -rc builds, the problem no
longer seemed to manifest.  But then the question became: was the
problem truly fixed, or was the problem being masked otherwise?
That's when I discovered that properly adjusting the exit status from
my script was... complicated: I needed to reverse the behavior for
cases 2 and 3 above, but leave the behavior for cases 1 and 4
unchanged. And I figured that, if I had this problem, someone else
surely did as well.

-- 
-- Stevie-O
Real programmers use COPY CON PROGRAM.EXE
