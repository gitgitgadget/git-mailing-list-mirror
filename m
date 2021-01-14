Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F11C433DB
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 23:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCF9422C7D
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 23:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731052AbhANXxb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 18:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730755AbhANXxa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 18:53:30 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4457CC061575
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 15:52:49 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id y12so4030654pji.1
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 15:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BPKxqlzGnfjBP9Nrenou7VcjaONiLUu2SoTdkIIfhb8=;
        b=Uk+7rBkBnRaCYlpWarZcNl263TBenB0iRhl+CBE6+aMTBS4Lm6hqhkXmpiJFBnLecQ
         lROMIEi/sMqwieqYGj1tZwgzT9Num9Yyja6v8TIj6xXQSyPBHo/G+2Kx+iCy5gc9hbDk
         z0k6C+RlgTPC7lx7+ZT/iJWRqrB4Ml/XADHN8c3AXbLJTX1/grJ5zz59gopC5+OxLMOA
         IkqLjLy7wiGFVrqUJIKwfoaQymg7mIF4Bz+VBunJjYFzyUIYGYs7HrG79ZbmxamOrjGk
         AWUtiDF93T1ePLQ+YPooiZxIKUUdgOz9ZILbsg5S5oUUkOCx4sEj/9Wfa/J5vyNjF5Yp
         IAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BPKxqlzGnfjBP9Nrenou7VcjaONiLUu2SoTdkIIfhb8=;
        b=sMSNVkqebSBq9pgE+P/ewgDiaRPfRs9iN8YJBrd3xZhf29+j920R8Ci7yUSYViPV6+
         ZACWkdzeuHmLhZK3dgxG4xr0ztYtll6w5QtjwW++7YKr+JFQXgOFpI725WN9tBgAWN6y
         ANyw/cluxOTC9bJc+gNXVQgzs72g5ruhTJa72lVgpwXu0HAkGsU7YSqRYblW9m6xWjW8
         EQTwoMiwM5NvvZ9+v4GXgLy+cX1JIk7yil+vehkPDmxSl8GrhlFniVZK0vLWrwklQPGb
         3qJW/a6RQOOqnQgedwjW7r9FjOoJafsDl5F6yAQcw1LCO3whcb9vLuh2q827V8cupKqu
         wArA==
X-Gm-Message-State: AOAM531nanw6IAx0S7dfqVhssrecIG/b7Lh/H12ZyC8dUr3G1hDyweFY
        ftEDhkfcHpuPc7/tLQqz+vs+ng==
X-Google-Smtp-Source: ABdhPJxOM6wj1+d5NPHxGtthebrPDUg1o6lSTy291QdD7uHtcjzuPq2ufxGECKmQ7YIuidvWZIaViw==
X-Received: by 2002:a17:902:eccf:b029:de:72a2:f1f8 with SMTP id a15-20020a170902eccfb02900de72a2f1f8mr561049plh.17.1610668368581;
        Thu, 14 Jan 2021 15:52:48 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id a13sm6153474pfr.59.2021.01.14.15.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 15:52:47 -0800 (PST)
Date:   Thu, 14 Jan 2021 15:52:42 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2021, #02; Fri, 8)
Message-ID: <YADZSsVqyGnArF0n@google.com>
References: <xmqqk0sni68g.fsf@gitster.c.googlers.com>
 <871reu752k.fsf@evledraar.gmail.com>
 <xmqqk0slg5ph.fsf@gitster.c.googlers.com>
 <X/oosXBJlyt/IrOr@camp.crustytoothpaste.net>
 <xmqq4kjpelza.fsf@gitster.c.googlers.com>
 <X/uvhc5Hpu792qA/@camp.crustytoothpaste.net>
 <xmqqeeir8fdg.fsf@gitster.c.googlers.com>
 <87k0si5k75.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k0si5k75.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 12, 2021 at 03:00:30PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> On Mon, Jan 11 2021, Junio C Hamano wrote:
> 
> > "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> >
> >> On 2021-01-09 at 23:20:25, Junio C Hamano wrote:
> >>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> >>> 
> >>> > On 2021-01-09 at 21:28:58, Junio C Hamano wrote:
> >>> >> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> >>> >> > FWIW there was since a re-roll on 2021-01-03, but the discussion is
> >>> >> > sort-of outstanding, so maybe that's intentional...
> >>> >> 
> >>> >> I had an impression that those 4 or 5 patches haven't gained
> >>> >> concensus that they are good as-is.
> >>> >
> >>> > There will be another reroll.  I'm hoping to get to it this weekend.
> >>> 
> >>> Thanks.
> >>
> >> Having read Ævar's latest comment, I've decided instead to drop this, so
> >> feel free to do so whenever it's convenient.
> >
> > That's kind of sad.
> 
> Agreed. I mean, I'm just one contributor with an opinion. I certainly
> don't mean my "meh" on a patch to be some sort of veto.
> 
> If you follow this list you'll see that if you're going to take anyone's
> opinion on whether a thing should make it into git as a matter of
> empirical data on patches I submit that aren't changed meaningfully,
> then, uh, maybe pick someone else :)
> 
> > I view that this is the kind of topic where perfect easily can
> > become an enemy of good, as there is by definition no perfection
> > available to us without breaking existing Git.
> >
> > I do not know about Ævar, but to me, my initial impression while
> > reading the discussion from sideline was that the goal was to
> > prevent a mechanical scan of a recent version of .mailmap from
> > learning that Joe used to use Jane as his/her name, and that was the
> > reason why I asked to be convinced why encoding for obfuscation was
> > insufficient.  In the above, I meant "mechanical scan" as something
> > like "a web search engine crawls and finds a .mailmap---a query for
> > Joe produces a line with some garbage on it that is not Jane." and a
> > casual attacker would stop there.
> >
> > But of course, a casual attacker who knows urlencode or whatever
> > obfuscation in use can read that "garbage" once he/she knows that
> > "garbage" is worth attacking (i.e. it is known to be associated to
> > Joe, the person the attacker is interested in).
> >
> > If your goal is to make it harder than just urlencode, even though
> > we all have to accept that scanning "git log --all" for all names
> > that appear in the history and hashing them all to see what name
> > hashes to the "garbage" in question, then @sha256:<hash> approach
> > does make sense as a stopping point.  Perhaps we need to sell this
> > with a clear definition of what kind of attackes we are protecting
> > the name data from:
> >
> >     The attacker is required to obtain sufficient amount of history
> >     in the project to uncover the obfuscation; a more casual
> >     attackers will fail to uncover, and we declare that it is better
> >     than nothing and it is good enough in practice.
> >
> > or something like that?  I am not sure if I drew the line at the
> > level you intended to draw in the above, if I think that it is good
> > enough in practice, or if I agree to a change that is better than
> > nothing but not good enough in practice, but having such a statement
> > would help to see where we agree or disagree.
> 
> My reading of the general thread & brian's reply at [1] is that the
> difference in the minds of the users who want the feature (who're not
> on-list, and we're getting brian's's summary of their views) is closer
> to:
> 
>     We want the X-Y problem of "hide this data" solved with solution "Y"
>     because git's current tooling to retrieve the data is currently
>     rather tedious & obscure.
> 
> So when I asked whether those users would feel the same if the tooling
> was less tedious and suggested that I might patch it to be so brian
> replied with "[yes,] we do rely on this being inconvenient".
> 
> I do have a 20-something series patch to the mailmap code in my local
> queue that in the light of this series's status I think I'll submit
> soon.
> 
> It doesn't have anything to do with adding a "spew out a materialized
> map" feature currently, nor do I really plan to do that any time soon. I
> do genuinely think it would be a good addition to git for reasons that
> have nothing to do with trying to make a point about this
> series. E.g. you'd be able to more easily validate/check/fsck a mailmap
> that way. Or e.g. use a git repository's .mailmap as a source to export
> to your MTA rules or whatever.
> 
> The external tools I referred to which consume the exported .mailmap
> data are something I worked on at a previous job, but I no longer have
> that immediate itch to scratch personally.
> 
> The "march of history" point was rather that if the difference between
> URI encoding and this solution is current tooling, it seems all but
> inevitable that we'll bridge that gap sooner than later in a way that
> makes that difference useless to some of the users that want this now.
> 
> And not even because some people don't like this feature in particular
> and wish to submit patches to make it less useful. But just because we
> continue implementing stuff that's been talked about for years & is
> being generally slowly worked towards. E.g. more client<->server
> cooperation for expensive queries over protocol v2, or a filter clone
> mode where you get only commit objects.
> 
> It even seems like something brian's series itself could benefit
> from. I.e. having the hashed values in the history is a performance hit
> in some cases. The patch caches the computation.
> 
> Another way to do it would be to just save a
> ".git/objects/info/mailmap.{hash-of-original-file}". Either on the fly
> or generated by "maintenance" or whatever. It would guarantee a 0%
> performance hit. At that point we'd already have the plumbing to
> materialize the file & would need to go out of our way to make it
> inaccessible in porcelain.

I've got quite a few sporadic thoughts about this series and this
discussion, so I'll braindump and hopefully it turns into something
useful.

Firstly: this design comes from a conversation amongst a pretty small (4
people? 6 people?) group at the virtual inclusion summit some months
ago. At that time, we discussed the ease of brute-force decoding the
one-way-hashed mailmap and decided that, as long as Git didn't ship a
tool to do this for you for free, it was better than the current
solution for avoiding deadnames (i.e. "sorry"). I'm disappointed to see
the larger list feel otherwise, but not terribly surprised, since the
list contains more people than the group who came up with the design.

Secondly: it seems like a restatement of the goals of this patch would
help guide a discussion of designs; I would be so pleased to see a
cleaner solution than any that's been proposed so far, because I agree
that this feature is not perfect. So please append what I have missed:

Axiom: The current Git solution for avoiding deadnaming is insufficient.
Axiom: We want to improve Git's solution for avoiding deadnaming.
(That is, I don't think either of these statements are or should be up
for discussion.)

Goal: Projects which are contributed to by trans individuals who
transition during their contribution period should provide a good,
supportive experience, which does not deadname the individual.
Goal: Git's performance should not suffer unduly from any change unless
necessary.
Goal: Project maintainers should have an understanding of the threat
model (e.g. automated tools scraping for names, malicious individuals
with time on their hands and experience with the project, etc)
Goal: Audit trails required by e.g. SOB lines should exist for the
project maintainer, if necessary
Goal: Mailmap, in general, should work better than it does now
Goal: An imperfect solution should not disallow a more perfect solution
later down the road
Bonus goal: For the sake of Git project contributors, it would be nice
to avoid a troll storm on list.

Thirdly: As is stated elsewhere, I think this topic is falling victim to
perfect vs. good. Git is gaining increasing notoriety in circles I can
see about the ultimately crappy experience for people who change their
names and don't want to hear the old names (and don't want to know the
old names). In my opinion, literally anything we could do to improve
this experience would be better than doing nothing. So I feel sad to see
the topic dropped because of pushback, especially when that pushback is
"I'd like to write a tool to reverse this thing, because <vague reasons>
- and I don't mean that tool maliciously so that should be OK."

Fourthly: The perfect solution, as has been mentioned, is to stop using
user.name/user.email in commits and start using some generic ID instead.
I think I mentioned this during the summit as well, but one meh idea -
which maybe someone else can be inspired by and come up with something
better - may be to just start wedging genericness into those fields
anyways. That is, generating commits with user.name like "abc123def" and
user.email like "<requires-git-v2-31-or-later@generic.submitter>". I
don't like the idea of carrying that technical debt around forever, but
the experience it provides on older Git versions isn't terrible,
especially if you pair it with a mailmap entry from "abc123def" to
"Emily Shaffer <emilyshaffer@google.com>", for example.

Food for thought.
 - Emily

> 
> 1. https://lore.kernel.org/git/X%2FtxB8b3%2FqqbwbmC@camp.crustytoothpaste.net/
