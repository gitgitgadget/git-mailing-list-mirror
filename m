Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2842CC2D0E4
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 00:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC58423A65
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 00:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xl9oCgvi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgKUAe3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 19:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbgKUAe2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 19:34:28 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671D5C0613CF
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 16:34:28 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id o15so12678667wru.6
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 16:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=oEHxEpVXSyqDtzBF1TvrFwEDSlEtZNuumxgE9QJrMH4=;
        b=Xl9oCgviW4eMDmD+FTFMXFd4xntJybHdwhB/wfM9+F7RV626/3AGRUi8tk4T9IYFb1
         8zzxxHt4RbDgp9i64Mho7PFnUJbytVqzEElPADmG9jaONNDLeLIQzAuANgxGHZ2wpDCc
         aYOqhxtp7K3F8PIootxxjqBE60cWjS6TPZCEQHNObxUoDkdz8q6ULM3Gh9k7sIyv+JbG
         NtmaBaiJDy7BIbN8L3LbR4t01GDJtQ/ZWAvr+SLCCXhmYO0h2mKwH6xmAww8Zta/PNJs
         /IPL5peu1j63zOMoiKfUpJJMYM7XIvcCJRt4dhl+lx/DVmQS3cItD1YSXTqL0z2BEaYy
         x1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=oEHxEpVXSyqDtzBF1TvrFwEDSlEtZNuumxgE9QJrMH4=;
        b=gAfys/p/0yQJIAk/m+W4EPu7/U3NKmwBu9nDtj7fP7Z4HIRsazCTHvyNnT5vSGgMAz
         su+R5gAnPfXCXo6hJoWUxnsVC7PI2aSliYbGHX26VWpxe2EReJ3apGoJPwAgcwLHz3k/
         PuwdCNPQiFW5NqYqKhxaBsz76YXlNnAVvp6lETxpHRX0squijkF/5xRriOJG5AxWz2s6
         kTPHgB3xsXbabTA4Tny7h5t0Dij7zrJIJxf4VlXADD/nyqHwsv192cCDW6OOXIrqUJzG
         yfMLtkR95IXkRXMaPEnBv6hKmHarW+OzmHdf1hzcLBdgalEuH++rxNSivRJlEQFXpslH
         SFhg==
X-Gm-Message-State: AOAM530tatDPHVJrL9b8yuW0PXWP8cD51kynEr5J8BGYN3NtmFZKjkMb
        3NDTvbZSV1og9lUkq9iouISKoHC/IEfbHNfqlw4nPQ7MQ4hChA==
X-Google-Smtp-Source: ABdhPJyNOGcAMZ/CVDEKK+s3FkztgXZiHKmKCwlRaVmXzbQQZZd3nSXyst81uSKomeHIcCsHozAbUB/2dO0tXlD9LY4=
X-Received: by 2002:a5d:474f:: with SMTP id o15mr18763454wrs.100.1605918866584;
 Fri, 20 Nov 2020 16:34:26 -0800 (PST)
MIME-Version: 1.0
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 20 Nov 2020 18:34:15 -0600
Message-ID: <CAMP44s08AzXt-+duXyFAvJpuke=XTKT=7cibxKKy4bXhAFqxtw@mail.gmail.com>
Subject: There is nothing wrong with the word "master"
To:     Git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?S=C3=A9rgio_Augusto_Vianna?= <sergio.a.vianna@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I want to state for the record my objection to the rename of the initial branch.

First of all, the burden of proof regarding the claim "the word
'master' is offensive" was never met. It was assumed to be the case
simply because some people (with political agendas) said it was the
case, but it was never established.

Until this burden of proof is met, the default position is that we
don't know if something is wrong with the word "master". Maybe there
is, maybe there isn't.

Second, not one person actually found the term offensive directly
towards them, personally. The people that found the term offensive did
so *by proxy*, in other words; they found the term offensive on behalf
of others, and not by their behest. Just like a man trying to be a
white knight and saying "please don't use vulgar language in front of
a lady", but the woman in question did not ask for this, and she can
speak for herself.

How many people complained that the term was offensive directly
towards them (not by proxy) in the mailing list? Zero, nil, zilch,
nadie, zip.

Third, this is a solution looking for a problem [1], not an actual
problem. It's not a coincidence that *nobody* found the term
problematic for 15 years, and suddenly in the height of wokeness--2020
(the year of George Floyd, BLM/ANTIFA uprising, and so on)--it
magically becomes an issue, and it does so precisely at the same time
The Masters Tournament [2] received attention for its name. The
Masters being more renowned than Git certainly got more attention from
the press, and plenty of articles have been written [3][4][5][6]
explaining why it makes no sense to link the word "masters" to slavery
in 2020 in this context (even though the tournament's history does
have some unconfortable relationship with racism). Nobody is betting
on The Masters actually changing its name.

For more woke debates, take a look at the 2 + 2 = 5 debate [14] (also in 2020).

Fourth, I think it speaks volumes that the change was *demanded* by a
person unrelated to the project, had not participated in any thread
before that, nor has participated in any thread since. He had only one
goal.

This is the true context of the proposal/demand. We must not forget
that if we are going to change the expectations of hundreds of
thousands of developers--potentially millions--there must be *a good
reason* for it, and an unsupported assumption is not it.

I cannot stress this enough: the burden of proof for the claim that
the word "master" is offensive has *NOT BEEN MET*.

---

Now that I have made clear that the ball should be in the court of the
anti-master camp (they need to prove guilt), I am going to defend the
word "master" (even though I don't have to prove innocence).

The first thing I want to highlight is a misunderstanding many people
have of language, since most people are not linguists; they don't know
the difference between prescriptive and descriptive language [7]. In
prescriptivism words are dictated (how they ought to be used). In
descriptivism words are simply described (how they are actually used).
Dictionaries can be found on both camps, but they are mainly on the
descriptive side (especially the good ones).

This misunderstanding is the reason why many people think (wrongly)
that the word "literally" should not mean "virtually" (even though
many people use it this way today). This is prescriptiveness, and it
doesn't work. Words change meaning. For example, the word "cute" meant
"sharp" in the past [8], but it slowly changed meaning, much to the
dismay of prescriptivists. It does not matter how much prescriptives
kick and scream; the masses are the ones that dictate the meaning of
words.

So it does not matter what you--or anyone--thinks, today the word
"literally" means "virtually". Good dictionaries simply describe the
current use [9], they don't fight it (i.e. prescribe against it).

You can choose how *you* use words (if you think literally should not
mean virtually, you are free to not use it that way). But you cannot
choose how *others* use language (others decide how they use it). In
other words; you cannot prescribe language, it doesn't matter how hard
you try; you can't fight everyone.

Language evolves on its own, and like democracy; it's dictated by the masses.

So, what do the masses say about the word "master"?

According to my favorite dictionary [10]:

= Noun =

1. A male teacher
2. A person holding an academic degree higher than a bachelor's but
lower than a doctor's
3. The degree itself (of above)
4. A revered religious leader
5. A worker or artisan qualified to teach apprentices
6. An artist, performer, or player of consummate skill
7. A great figure of the past whose work serves as a model or ideal
8. One having authority over another
9. One that conquers or masters
10. A person licensed to command a merchant ship
11. One having control
12. An owner especially of a slave or animal
13. The employer especially of a servant
14. A presiding officer in an institution or society
15. Any of several officers of court appointed to assist a judge
16. A master mechanism or device
17. An original from which copies can be made

= Adjective =

1. Having chief authority
2. Skilled, proficient
3. Principal, predominant
4. Superlative
5. Being a device or mechanism that controls the operation of another
mechanism or that establishes a standard
6. Being or relating to a master from which duplicates are made

= Verb =

1. To become a master of
2. To become skilled or proficient in the use of
3. To gain a thorough understanding of
4. To produce a master recording of

These are not all the meanings, just the ones I found relevant to
today, and the world in general.

Yes, *one* of the meanings might be offensive--on certain contexts,
although certainly not all. But by following this rationale the word
"get" can be offensive too; one of the definitions is "to leave
immediately". If you shout "get!" to a subordinate, that might be
considered offensive (and with good reason)--especially if this person
is a discriminated minority. Does that mean we should ban the word
"get" completely? No, that would be absurd.

Also, there's another close word that can be considered offensive: git.

Prescriptives would not care how the word *is* actually used today,
all they care about is to dictate how the word *should* be used (in
their opinion).

But as we saw above; that's not how language works.

People will decide how they want to use the word "master". And thanks
to `init.defaultbranch`, they can decide how *not* to use that word.

If and when the masses of Git users decide (democratically) to shift
away from the word "master", that's when the Git project should
consider changing the default, not before, and certainly not in a
prescriptive way.

Moreover, today the term is used in a variety of contexts that are
unlikely to change any time soon (regardless of how much prescriptives
complain):

1. An important room (master bedroom)
2. An important key (master key)
3. Recording (master record)
4. An expert in a skill (chess master)
5. The process of becoming an expert (mastering German)
6. An academic degree (Master of Economics)
7. Arguably an academic degree (Master of Business Administration [MBA])
8. Golf tournaments (Masters Tournament [The Masters])
9. Famous classes by famous experts (MasterClass Online Classes)
10. Online tournament (Intel Extreme Masters [IEM])
11. US Navy rank (Master-at-Arms [MA])
12. Senior member of a university (Master of Trinity College)
13. Official host of a ceremony (master of ceremonies [MC])
14. Popular characters (Jedi Master Yoda)
15. A title in a popular game (Dungeon Master)
16. An important order (Grand Master)
17. Vague term (Zen master)
18. Stephen Hawking (Master of the Universe)

And many, *many* more.

Why should the Git project inflict pain on its users unnecessarily
(and developers too), when it's clear society at large has not decided
there's anything wrong with the word?

---

So far I have only stated *facts*. Now I am going to explain my opinion.

As stated above; different words have different meanings depending on
the context. What meaning does the word "master" have in Git?

In my mind the closest description is given by Merriam-Webster [10]:

  master noun
  5 b : an original from which copies can be made

For example: if a mad scientist makes a copy of you (or
copies)--otherwise referred to as "cloning"--are the other copies just
as equal as you? In my mind the other clones are not the same: *I* am
the original, I am the master copy.

In the context of Git--which is a *distributed* version control
system--it is common to have a hierarchical forest of repositories,
each one with multiple branches. The original branch, from the
original clone, which is present in *all* the clones, is the master
branch; the branch from which all other copies are made (usually; when
not starting an orphan branch).

In this context it has absolutely nothing to do with master/slaves.
The opposite of a master branch is either a descendant (most
branches), or an orphan (in rare cases).

The word "main" may describe correctly a special branch among a bunch
of flat branches, but not the hierarchical nature of branches and
distributed repositories of clones of clones.

In my opinion, even if it was 2005, I would pick "master" over "main"
in a heartbeat.

---

I already explained in another thread [11] why I think the impact
towards end users has not been considered enough, but there's another
more pernicious impact which has not been realized yet; the impact
towards the culture of the project.

Regardless of your personal preference for init.defaultbranch, your
opinion of the word "master", and your political stance, one thing
that cannot be denied is that this change has caused an outcry among
users (even though most aren't even aware of it, so we are likely to
receive more).

So numerous and blatant have been the complaints that the topic has
been banned from reddit [12], and Hacker News. The particular case of
reddit's r/git is interesting, since there's only three rules: 1. Be
nice 2. No spam, and 3. No complaining about the change to "main"
(since November 13). The top most voted comment in the ban post seems
to convey perfectly the sentiment of many users: "this change does
hurt people" [13].

So it is pretty much an undeniable fact that this change is controversial.

I cannot explain all the ways stifling freedom of speech is a big
no-no, but I will attempt to condense them as this: censoring dissent
is bad.

---

In summary:

1. The anti-master camp has not established there's anything wrong
with the name "master"
2. Not a single user has stated they find the word directly offensive
(not by proxy)
3. The Git project is collateral damage from the main targets of the
woke movement
4. Prescribing language does not work in practice
5. Society at large sees nothing wrong with the current usage of the
word "master"
6. The term "master" is better than "main"
7. We should be careful with the cultural impact of this controversial change

Note: this mail is not intended to target any person, or group; it's
simply an attempt to state things that in my opinion have not been
said, and I think should be said.

Cheers.

[1] https://en.wikipedia.org/wiki/Wikipedia:Solutions_looking_for_a_problem
[2] https://en.wikipedia.org/wiki/Masters_Tournament
[3] https://www.outkick.com/no-the-masters-does-not-need-renaming/
[4] https://www.si.com/college/tmg/herb-gould/masters-name-controversy
[5] https://www.sportsbettingdime.com/news/golf/odds-masters-augusta-renamed-blm-movement-favorite/
[6] https://www.dailymail.co.uk/sport/golf/article-8456979/Rallying-cry-Masters-revert-Augusta-National-Invitational.html
[7] https://www.merriam-webster.com/words-at-play/descriptive-vs-prescriptive-defining-lexicography
[8] https://theculturetrip.com/europe/articles/10-english-words-that-have-completely-changed-meaning/
[9] https://www.merriam-webster.com/dictionary/literally
[10] https://www.merriam-webster.com/dictionary/master
[11] https://lore.kernel.org/git/CAMP44s3BJ3dGsLJ-6yA-Po459=+m826KD9an4+P3qOY1vkbxZg@mail.gmail.com/
[12] https://www.reddit.com/r/git/comments/jtrx1k/announcement_posts_complaining_about_renaming/
[13] https://www.reddit.com/r/git/comments/jtrx1k/announcement_posts_complaining_about_renaming/gc8rsej
[14] https://thepostmillennial.com/two-plus-two-does-not-equal-five-no-matter-what-twitter-says

-- 
Felipe Contreras
