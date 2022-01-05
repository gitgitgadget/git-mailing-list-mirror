Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22B5C433EF
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 00:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236678AbiAEAqA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 19:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbiAEAp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 19:45:59 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D5BC061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 16:45:59 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id g11-20020a17090a7d0b00b001b2c12c7273so2539583pjl.0
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 16:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=EtvQJvxoR153yfqXjqyorI68qWlTLFNqKjrP2ogSr7s=;
        b=aKw27dTwCfJQHnaaUzGnQ4XScAYfjmxy3iqjb98YfDvHY6RkrkRhnSX0ZWxHHY5aLv
         xdPAvbeaBzZfBZyXjT9cXaLNJoLbDktIbAUARQ7mVtFs9oiMAF2Cvc2U7JJ8qoWpcxR1
         d+p5kNr3QJxxdVy3jYOoeaehJRBnrFL/ZkvCP7gpbCN95UjXrUInEW8Wi9W1vofWWcrG
         XheKmesudjJcgaIMOjflvvJ35z0EHG4ML8Meix7KlvnZBMNDPdEzyVmKhs+4AuduTfkS
         tyl02rDCzTOve5L6Cf1IOdX9Nb20cTFKSniBg2z5xctAS3I+gYtkHeETHGvGQkTmlBp7
         gKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EtvQJvxoR153yfqXjqyorI68qWlTLFNqKjrP2ogSr7s=;
        b=KOMVdT5jgQ3tTeC+CSTr52e/Wr+Re3X3/gFKajGXcDpZ0VTI9h/3k0vDo0u3kAvBcS
         7UsAUKUpXAMHEhaDutrQ2SoVPQbKUyOJtFmCnWNQeMCr+48+d1/yW1nPtqlimGBha+Go
         2k3Cqzu2RKEY4LCQenr3Lh2GAGYnr/tJcn08O18bMcnJvnY/iTp3uIeBmbEo+AECI0Ax
         9parC/h68Vuq+Cr1n76rGGRoMnlQy6dtGX1Hrc9MknomUkR6t7WScfc7oVbEMFCkkDYI
         oQQXASdFZyuQTwguJdTEY5xA8U3rstSV/lBlZddbv878byEEMtS6GnSSjWZhuYY/Jfs1
         Bx6g==
X-Gm-Message-State: AOAM532p5Iu9kdFIeMmztJ9odoCMoRO0/wyo7hRpisAAz3O7az5RMPoI
        ghQknV4cNuvvW8uD+14xmTI2Jbvbb6Hos8ii
X-Google-Smtp-Source: ABdhPJwMxSrDE1wKWxGYxIFm1GgIKxQG/Tudb0ZG/xcNw6wGAsPEjfv/zG0VZj4RED0rJvR7pdgpLA==
X-Received: by 2002:a17:90b:1a92:: with SMTP id ng18mr1136582pjb.238.1641343558103;
        Tue, 04 Jan 2022 16:45:58 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:be91:68f:b87b:8d7a])
        by smtp.gmail.com with ESMTPSA id e11sm450149pjh.14.2022.01.04.16.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 16:45:57 -0800 (PST)
Date:   Tue, 4 Jan 2022 16:45:52 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, jonathantanmy@google.com, steadmon@google.com,
        chooglen@google.com, calvinwan@google.com,
        konstantin@linuxfoundation.org, stefanha@redhat.com,
        avarab@gmail.com, gitster@pobox.com, fs@gigacodes.de,
        broonie@kernel.org, christian.couder@gmail.com,
        sandals@crustytoothpaste.net, sunshine@sunshineco.com,
        JoaoVictorBonfim+Git-Mail-List@protonmail.com,
        rsbecker@nexbridge.com
Subject: Re: Review process improvements
Message-ID: <YdTqQDnHLY7oUTja@google.com>
References: <YbvBvch8JcHED+A9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YbvBvch8JcHED+A9@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 16, 2021 at 02:46:21PM -0800, Emily Shaffer wrote:

Reshuffling context....

> As it's reaching the end of the year and the holiday season, I'm
> planning to spend the rest of the year with family and away from my work
> email as much as possible. Some other Googler Gitters will be working on
> and off and may chime in. But I am expecting to be able to engage more
> with this mail in the first week of January.

Having had a very restful couple of weeks off, I've now read through all
the replies to this mail - thank you! - and will summarize as much as I
can.

> 1. Draft a MAINTAINERS file
> One recurring theme from the conversations I had with the Google Git
> team was that selecting a topic to review in the first place can
> actually be pretty time-consuming. Choosing from the series subject line
> or the "What's cooking" mail isn't always straightforward - it can be
> hard to tell whether the series is working on a goal you are interested
> in or in a part of the codebase you care about. It's not feasible for
> someone wanting to get involved to review every single series that comes
> across the list - but it might be feasible for someone to review every
> series in a particular subsystem or topic.
> 
> In the first half of January, I'd like to have a review out to the list
> adding a kernel-style MAINTAINERS file with a few areas of interest. To
> that file, I'd like to add "R:" ("CC me!") lines to subsystem mailing
> lists and interested individuals. My hope is that that will make it easy
> for someone to either add themselves as an "R:" or to subscribe to the
> subsystem list, and then be able to filter their mail based on "stuff
> I'm CC'd to" or "stuff sent to git-partial-clone@linux.dev" - and then
> be able to review every patch in that list. I'd like to create lists on
> topics where it makes sense, too.

Summary: Everybody pretty much hated this idea. ;) I count at least five
replies saying "please let's not, it's too cumbersome".

That makes sense to me. As Ævar mentioned - just because he and I are
working on config a lot right now, doesn't mean we will still care in
2023. And remembering to remove yourself from the MAINTAINERS file is a
pain.

Ævar suggested leaning in harder to improving the tooling around "who do
I CC?"
(https://lore.kernel.org/git/211220.86fsqnwkzs.gmgdl%40evledraar.gmail.com)
and I think that's a reasonable approach, if we pair it with updating
SubmittingPatches and MyFirstContribution to include recommending
running the "who do I CC?" script.

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
>     Documentation/git-submodule.txt, anything else adding a feature involving
>     submodules
>   R: git-submodules@example.com
>   R: emilyshaffer@google.com
> 
>   Config improvements
>   Documentation/config/*, config.[ch], builtin/config.c, changes which add new
>     config options
>   R: emilyshaffer@google.com
>   R: avarab@gmail.com
> 
> It would be extremely useful to hear other suggestions from the mailing
> list about subsystems which deserve a MAINTAINERS line and possibly a
> subsystem mailing list.

Randall suggested using a prefix/tagging approach to make it easy for
reviewers to filter by topic. I think that's a pretty good idea! But I
also think for it to be useful as a filtering tool we'd want to
formalize "this topic goes to this tag" - which brings us back along to
the cumbersome-ness of the MAINTAINERS file.

I see a couple options:

1) Eat the maintenance overhead of having a checked-in file mapping
filespec/topic to subject line tag, like the sample Randall gave
(https://lore.kernel.org/git/00b901d7f2d3%24c0d2ca20%2442785e60%24%40nexbridge.com)
but minus the "Reviewers:" section:

Submodules:
  Prefix: SUBM
  Files:
    submodule.[ch], git-submodule.sh, builtin/submodule.c,
    Documentation/git-submodule.txt
Platform:
  Linux:
    Prefix: LINUX
  NonStop:
    Prefix: NS

Having these mails all still delivered to git@vger.kernel.org means that
it's not such a big deal if the prefix becomes obsolete, and not
including an individual CC list means that nobody needs to remove
themselves from CC list after they stop caring about some part of the
codebase.

An alternative to subject lines like "Subject: SUBM: share config
between blah blah" might be possible. Some providers (at least Gmail,
and based on João's reply-to address, protonmail as well) allow mails
addressed to e.g. "my-name+from-git-list@example.com" to be delivered to
"my-name@example.com" regardless of what follows the +; if vger allows
this kind of thing, we could save some visual space by adopting the
convention that e.g. submodule topics should go to
"git-subm@vger.kernel.org" and allow folks to write their mail filters
accordingly. (I took a poke through IETF RFC5322 to see if this +
comment/tag/whatever-it-is is standardized and didn't see anything
promising, so maybe this alternative is a bad idea. Or maybe I didn't
Google well enough.)

2) Put that kind of mapping into an easier-to-modify place, like a wiki. The
downside is that, as far as I'm aware, we don't have or maintain an
existing git.git wiki, so it'd probably end up going unused as people
don't want to start looking at yet another discussion area.



Either way, "Check this file/page and determine what additional tag to
add to your outgoing patches" would need to be called out in
documentation like SubmittingPatches//MyFirstContribution - and modeled
by veteran prolific contributors in their own patches.

If we're generally happy with the idea of tagging rather than additional
lists, then I think there's nothing in the way of beginning to draft
changes to either of those docs in order to agree on the standard we
want to adopt. But I'd like to make sure that we are in agreement first.
Maybe the best way to find that agreement is via the doc patches
themselves?

> 2. Draft a ReviewingPatches doc
> Another theme we discussed was the general ambiguity around the act of
> performing code review. How detailed should the review be? Who should be
> examining interoperability with the rest of the codebase? Is it OK to
> reply with only "I don't know what you're trying to do, rewrite your
> commit message please"?
> 
> Sometime in January I'd like to have a review out with an outline with
> agreement on the content and organization for a ReviewingPatches doc.
> I'm hoping that it can give some structure to review by including:
>   - How to give different types of review (maintainer vs. individual vs.
>     drive-by nits)
>   - Review best practices (Sage Sharp's article on stages of review[4],
>     CCing experts/lists from MAINTAINERS file above, short-circuiting by
>     sending comments early instead of reviewing a patch in-depth when
>     the idea seems so-so or unclear)
>   - Checklists for new contributors to use or to help make in-depth
>     review more thorough
> 
> Since this is intended to be checked into Git's codebase, I expect that
> we'll want to discuss a lot and make sure we all buy into the contents
> of that doc.

This idea seemed generally well-received. I noticed that João was
curious to hear more about Google's review process; I'll state that
there is less magic than you might think, and whatever we do know will
certainly make it into a draft.

I think there is nothing standing in the way of sending out an outline
and/or first draft of such a document for us to all discuss and quibble
over. :)

> 
> 3. Google Git team will review cover letters and commit messages
>    internally before sending series to the list
> I often find that when I send a patch to the list, reviewers reply
> without understanding the point of what I was trying to achieve in the
> patch. It sounded like this happens to some other Google Gitters as
> well. Luckily, that's fixable by the patch author.
> 
> To try and make sure we're sending patches that are easy to understand
> and decide whether to review, we're adding a step to our process ASAP to
> require commit messages, cover letters, and "---" notes to be reviewed
> and approved by at least one other Googler before a topic goes to the
> mailing list. Those reviews don't need to be formal, but do need to
> happen for every reroll of a series. We also will intentionally *not*
> review the diff of changes in this private setting - reviews for code
> correctness, etc. should continue to happen upstream, in public.
> 
> I'm mentioning that takeaway in this email to say: if you find you don't
> understand the purpose of a patch from a Googler, please let us know! It
> would be really valuable for us to receive a review saying "I think you
> might be saying X but it's still confusing because you wrote Y"
> so that we can incorporate the source of your confusion as we continue
> to review each other's "accompanying context".

It seems that folks liked this idea, and furthermore, that it would be
worth suggesting such a process - "ask your friend to read your commit
message!" - in one or both of SubmittingPatches and MyFirstContribution.

> 
> 4. Documentation changes to encourage commit message quality

I think I didn't hear much response to this other than "sure, sounds
fine" - so I expect that with the changes themselves will come more
detailed discussion. I also don't think there is anything stopping these
changes from happening.

---

In general, I think everybody seems enough on board for us to begin
sending doc patches. So the next step for me is to work out which of we
Googlers will handle which, and for us to start sending stuff for
review. Thank you to everybody who contributed on this thread and thanks
in advance for reviews on the patches to come.

 - Emily
