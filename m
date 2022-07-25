Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81195C433EF
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 21:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236876AbiGYVrj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 17:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiGYVrh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 17:47:37 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AC011821
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 14:47:36 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id j63so1312932ybb.13
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 14:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bEe8a7NPAZAjZjCYOE/VmR9ijgMWjzyV643L4UuEwuE=;
        b=hoHgGf6iDc53NY/a1pIyYRJX/NtsPVXqqdUFiIUsgM2KXJPRMq/WUYdKbGOfddo7PO
         zjBjpjA/uh3Q2Z/b9op9Iabuz/7czavrZCCjpiNxsb+kl38Wm7QskbqAsxpHpptJ2avD
         Ty8F3hELGWtLhtT81u3UIEEMua5CMZU1GVExDKDkE0ajPXo4sINHZryyAP/g4b+6+rbf
         Winxjizi3+5P1YZIIUVhaEyKm0HrCy5p26n6oRwn/7NvjOqrYj/1NfsRFqlkXrTxCDs2
         SO0MtKIQpFvel9F/6TBXwng775l5bx6j3dzVzZH91EUvyecFmzl+mor6iIcn4JqjJ1NX
         368w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bEe8a7NPAZAjZjCYOE/VmR9ijgMWjzyV643L4UuEwuE=;
        b=ErRNlmUpJVAGwOa89YOiYj5avtKbNDRKJVS/MYyolrbOkUUyKGnulZKWT0LilnK40l
         Hi+RbKqPXMDNUqQ98z0czCOb92PsY9EAhOg9Q8z+6jmosQtBba4iY2bPMyJftvbiHF98
         qYI/rYKuRJn1CfaGTX5w3LLrwubdBajDL9lkJ33jpIh6QeeqmgvB4cae8/uDUW484UXB
         SDCE4QoYBDa4ZY/LlClERpfoa9RwdRdqr5iJ718oTSK0RLnILB6mzfi/MFyfEMCZLAXT
         jRf99jq3/eG+7VG4973MLZyvPHvvosgTGdW+j0g2KI3+U9O+ONi+m53e+3aJAtmZvRAo
         0Hdg==
X-Gm-Message-State: AJIora9OxNHe/O1RGLozXzylIorMIjcNVWPWPE/+Dnk0ySyQZpDM975G
        /YlExR+HKr2oSIGfaWhZjdv+ntIx6RHf4JfYVf4=
X-Google-Smtp-Source: AGRyM1u1R6rKjK23l4nz0L845Qv9eisYlcDb83eUxNMntT3YhRuVUonm3K3sTEiXSKwFRLGDzMThwENgV2fi2YdJ+Ec=
X-Received: by 2002:a25:f501:0:b0:670:82db:18d2 with SMTP id
 a1-20020a25f501000000b0067082db18d2mr10919563ybe.212.1658785655787; Mon, 25
 Jul 2022 14:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <bdbe9b7c1123f70c0b4325d778af1df8fea2bb1b.camel@that.guru>
 <220718.86ilnuw8jo.gmgdl@evledraar.gmail.com> <87a692e8vj.fsf@vps.thesusis.net>
 <CAE1pOi1pS76iXU8j=A54wPGHC7qofxrPDAO4uyy0d6yMxeQwvw@mail.gmail.com>
 <6426b5c3-0a09-f641-9876-3534b0abd96d@iee.email> <20220722203642.GD17705@kitsune.suse.cz>
 <CA+P7+xr+k35RXoGv-O96fsfOJ+sg65HrVvt-3JKYAzerA0TJRw@mail.gmail.com>
 <20220723070055.GE17705@kitsune.suse.cz> <CABPp-BEYQOtr6EZmi4emKRKNVXS3071Ud90jiLycdGXGG+YqgQ@mail.gmail.com>
In-Reply-To: <CABPp-BEYQOtr6EZmi4emKRKNVXS3071Ud90jiLycdGXGG+YqgQ@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 25 Jul 2022 14:47:24 -0700
Message-ID: <CA+P7+xoygnvi8_8JjOSftahKZFC3bZBkzA-LQ8-xAp9fkV79pw@mail.gmail.com>
Subject: Re: Feature request: provide a persistent IDs on a commit
To:     Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Philip Oakley <philipoakley@iee.email>,
        Hilco Wijbenga <hilco.wijbenga@gmail.com>,
        Phillip Susi <phill@thesusis.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stephen Finucane <stephen@that.guru>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 23, 2022 at 10:23 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Sat, Jul 23, 2022 at 12:44 AM Michal Such=C3=A1nek <msuchanek@suse.de>=
 wrote:
> >
> > On Fri, Jul 22, 2022 at 03:46:22PM -0700, Jacob Keller wrote:
> > > On Fri, Jul 22, 2022 at 1:42 PM Michal Such=C3=A1nek <msuchanek@suse.=
de> wrote:
> > > >
> > > > On Fri, Jul 22, 2022 at 09:08:56PM +0100, Philip Oakley wrote:
> [...]
> > > > > Part of the rename problem is that there can be many different ro=
utes to
> > > > > the same result, and often the route used isn't the one 'specifie=
d' by
> > > > > those who wish a complicated rename process to have happened 'the=
ir
> > > > > way', plus people forget to record what they actually did. Attemp=
ting to
> > > > > capture what happened still results major gaps in the record.
> > > >
> > > > Doesn't git have rebase?
> > > >
> > > > It is not required that the rename is captured perfectly every time=
 so
> > > > long as it can be amended later.
> > > >
> > >
> > > Rebase is typically reserved only to modify commits which are not yet
> > > "permanent". Once a commit starts being referenced by many others it
> > > becomes more and more difficult to rebase it. Any rebase effectively
> > > creates a new commit.
> > >
> > > There are multiple threads discussing renames and handling them in gi=
t
> > > in the past which are worth re-reading, including at least
> > >
> > > https://public-inbox.org/git/Pine.LNX.4.58.0504141102430.7211@ppc970.=
osdl.org/
> > >
> > > A fuller analysis here too:
> > > https://public-inbox.org/git/Pine.LNX.4.64.0510221251330.10477@g5.osd=
l.org/
> > >
> > > As mentioned above in this thread, depending on what context you are
> > > using, a change to a commit could be many to many: i.e. a commit whic=
h
> > > splits into 2, or 3 commits merging into one, or 3 commits splitting
> > > apart and then becoming 2 commits. When that happens, what "change id=
"
> > > do you use for each commit?
> >
> > Same as commit message and any trailers you might have - they are
> > preserved, concatenated
>
> Exactly how are they concatenated?  Is that a user operation, or
> something a Git command does automatically?  Which commands and which
> circumstances?  If users do it, what's the UI for them to discover
> what the fields are, for them to discover whether such a thing might
> be needed or beneficial, and the UI for them to change these fields?
> This sounds like a massive UX/UI issue that I don't have a clue how to
> tackle (assuming I wanted to).
>
> > and can be regenerated.
>
> "can be".  But generally won't be even when it should be, right?
>
> Committer name/email/date basically don't even exist as far as many
> Git users are concerned.  They aren't shown in the default log output
> (which greatly saddens me), and even after attempting to educate users
> for well over a decade now, I still routinely find developers who are
> surprised that these things exist.
>
> Given that committer name/email/date aren't shown with --pretty=3Dfull
> but with the lame option name --pretty=3Dfuller, I can't see why it'd
> make any sense to show Change-Ids in the log output by default.
>
> But if it's not shown -- and by default -- then it doesn't exist for
> many users.  And if it doesn't exist, users aren't going to fix it
> when they need to.
>
> (Even if it were shown by default, it's not clear to me that users
> would know when to fix it, or how to fix it, or even care to fix it
> and instead view it as a pedantic requirement being foisted on them.)
>
> I think the "many-to-many issue" others have raised in this thread is
> an important, big, and thorny problem.  I think it has the potential
> to be a minefield of UX and a steady stream of bug reports.  And
> seeing proponents of Change-Id just dismissing the issue makes me all
> the more suspicious of the proposal in the first place.

I do think there is some value in having a sort of generic id like
change-id, but I do think we want to be careful about how exactly we
handle it.

As you say, if we hide it then users may not be aware of it, and if we
make it visible users who don't care may be annoyed. I don't think we
can fully automate it because of the nature of combining changes and
splitting changes require humans to decide which change keeps which
ID. Its not even clear when rebasing whether a split is going to
happen. A combine operation is easier to detect in rebase
(fixup/squash), but determining which id to keep is not. Would we even
want to have support for "this commit merges two and is now one, but
we keep both IDs because it really is both commits"? That gets messy
pretty fast.

Users such as gerrit already simply use the trailer with Change-id and
manage to make it work by enforcing some constraints and assuming
users will know what to do (because otherwise they fail to interact
with gerrit servers).

For cases where it helps, I think its very valuable. Being able to
track revisions of a series or a patch is super useful. Getting
external tooling like public-inbox, patchworks, etc to use this would
also be useful. But I think we would want to sort out the situation a
bit for how and when are they generated, when are they
replaced/re-generated, how this interacts with mailing etc.

Should rebase just always regenerate? that loses a lot of value. I
guess squashing could offer users a choice of which to keep? Fixup
would always keep the same one. And otherwise it becomes up to users
to know when they need to copy from an old commit or refresh an
existing commit... Thats pretty much what gerrit does these days, if a
commit doesn't have the trailer it gets added, and if it does, its up
to the user to know when to remove it or regenerate it... Since its a
commit message trailer it gets sent implicitly through the mailing
list unless removed.
