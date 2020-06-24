Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D241FC433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 19:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A80702077D
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 19:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikTs9FOP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405162AbgFXTPr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 15:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404563AbgFXTPr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 15:15:47 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA83C061573
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 12:15:46 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id x18so3842473lji.1
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 12:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=W5ulQNFDy/1Dafc6K8uZk77w7ATkSFR7xcfWNMfD1lE=;
        b=ikTs9FOPLed/Z2AKbm1GnY+FikMdv25MWoI27uq+2r9V0uwWBafw66D1KO3Us1FC6w
         w9315dkY5mUAd0MHpxu4lEKy85yC1sqsXy3DBnOcUK5DQSziQGmFCPo4TsiNaShBQ3GH
         CnEPLTKlpz/7FX4FzGrjdwVvwP7F3/LBcPLNYD3QKY4wskKahJ0/pF9ogtluIWwGWpAk
         l62fv1AergnZoiS7M2hd49O7CjYzRvMOS2y7inBP4o3vUXjsDh9xZbR/AN3mFj2bIPHj
         BAz2p1PGVvT1NOnnzKBTVb8IIzuaAKkTZGnZJVTqbtr2ZUkgMyv/NUiwyutxPq/QPKrg
         OexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=W5ulQNFDy/1Dafc6K8uZk77w7ATkSFR7xcfWNMfD1lE=;
        b=HeV5s+DxbN2rDn2NtFzgLHrE0NJM3eJVIphDPv50ywCinJSneDMwPYa/7AoM6ybgYZ
         pKKczeeM/Xrrg/Igv45pb/nrhcpaEKe6JSyhNYIlegBWBUff052lBR794OiR92ZgPAMn
         t7LKpaQgxwPDHpaahF1z6L2BD87RvonlbUe08mdEukpv2T2R+bsdCMnqupvgIAlAjTLh
         UywHQaIbjsRMFFooavlsodqns1rZZm+DExEQQhMtWfHhYXTUR0NQ2d69E3jx9EwR7am4
         R4eknC2MX2RGgI5KC4bWPMKLxRUswojqbR4m+GC/qMF6YTEP7BAvt4IYM9TEiiK0o7ti
         IqSQ==
X-Gm-Message-State: AOAM532RzcQ1BdmwIAfrNVP51fV02u1D+0MmBTW6gbS0wA+rRzZMxfEg
        8/vZFIa7gvtaLoxtzFQK4p8=
X-Google-Smtp-Source: ABdhPJxkORd4VnKlFUSwi4+bLSSnrpFEEnJSv9jQml8kDCoIT6yr2Ybgsc/VsaW5wdDqcGkX/Ai34A==
X-Received: by 2002:a2e:8041:: with SMTP id p1mr14214194ljg.99.1593026144798;
        Wed, 24 Jun 2020 12:15:44 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id j17sm4369542lja.30.2020.06.24.12.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 12:15:43 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Tiran Meltser <Tiran.Meltser@mavenir.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Amir Yosef <Amir.Yosef@mavenir.com>
Subject: Re: Request for adding a simple mechanism to exclude files from Git
 merge operation
References: <DM6PR11MB27958B80E3994CEEF13971ECE5990@DM6PR11MB2795.namprd11.prod.outlook.com>
        <20200622194122.GN6531@camp.crustytoothpaste.net>
        <871rm6x86y.fsf@osv.gnss.ru>
        <CABPp-BHa=jppGtoDiTz_NCXrd2zhTfALb_UrQjcF-VDcv+vuNA@mail.gmail.com>
        <87sgelpmb2.fsf@osv.gnss.ru>
        <CABPp-BFwNnD-zZvHjCAvvmzy1wTT3yy-smK5nCtQ937apaNmkQ@mail.gmail.com>
Date:   Wed, 24 Jun 2020 22:15:42 +0300
In-Reply-To: <CABPp-BFwNnD-zZvHjCAvvmzy1wTT3yy-smK5nCtQ937apaNmkQ@mail.gmail.com>
        (Elijah Newren's message of "Tue, 23 Jun 2020 14:46:22 -0700")
Message-ID: <87ftak1di9.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

Elijah Newren <newren@gmail.com> writes:

> Hi Sergey,
>
> On Tue, Jun 23, 2020 at 1:19 PM Sergey Organov <sorganov@gmail.com> wrote:

[...]

>> I don't see how rebases are affected. I only suggested enhancements to
>> the merge-the-procedure, the "git merge" user command. Once merge is
>> finished and result is committed, there is (fortunately) now way for git
>> to know how exactly the resulting content has been achieved.
>
> Sorry, the original email from Tiran wanted to be able to record
> "branch-specific" files and have merge automatically handle them
> differently.  You also alluded to that when you said
>
> """
> As a
> more generic solution, a new syntax for "git merge" to specify what
> merge strategy to apply to what files could be designed, and then
> ability to put that syntax into a file for "git merge" to pick would
> solve the problem of quasi-static configuration problem. Alternatively,
> even more generic .gitignore way of doing things apparently could be
> re-used to some degree by adding support for .gitmerge files.
> """
>
> Once you record the information for which files it applies to, then
> you want it to happen whenever the merge machinery fires, right?

No. I didn't mean it, no way. I wanted only "git merge" to be affected.

> Rebasing, cherry-picking, and reverting are all created via the merge
> machinery (even if they end up recording one parent instead of more).
> Said another way, if merge automatically handles these special files,
> either rebase/cherry-pick/revert also handle the special files
> automatically or you've just created a very inconsistent and weird
> design.

I disagree. The fact that all of the mentioned commands reuse internal
merge implementation is a good thing, but it's irrelevant to the case at
hand. I never merge side-branches with either of
rebase/cherry-pick/revert, so it's only logical to ask for specific
branch-merging functionality only from "git merge".

I don't even want to think for now if it could be useful in
rebase/cherry-pick/revert/whatever, as it's already difficult enough.

As a side note, if anything, in my POV, having both rebase and
cherry-pick in porcelain is an overkill. Effectively, 'rebase' is a
'cherry-pick' on steroids, so adding a --cherry option to 'rebase' seems
to be logical.

>
> If you're disclaiming your last paragraph and saying that this would
> only be a manual operation where the user specifies which files they
> want to specially merge, then a lot of my complaints go away.

Nothing to disclaim, I think. What I thought was that it will affect
things automatically, but only for "git merge". Apparently generic merge
machinery will need support for this, but it will be used only for "git
merge", at least for a start. Alternatively, there could be generic
option that will turn this handling on, and this option will be turned
on by default only for "git merge". I'm not familiar with Git
implementation enough to even try suggest the right way to implement it
though.

> Although...
>
>> Nor do I see why to limit decisions to "ours" vs "theirs". I meant to
>> support arbitrary merge strategies for different files. Generic feature.
>>
>> My thought was: if git at all supports different merge strategies, why
>> not to support different strategies for different files? I don't see any
>> inherent contradiction in adding of such a feature.
>
> If you're interested in re-merging specific files, why not just call
> `git merge-file` to handle each one?  It supports e.g. --ours/--theirs
> (similar to merge's -Xours/-Xtheirs) and could possibly add more if
> there are ones missing.  So, it seems like we already have a command
> for this, even if it's less well known?

merge-file is likely some low-level utility... check... yeah, it is.
Extremely low-level. Three-way merge of 3 /files/. How does it help? How
much error-prone scripting will I need to get to the point of any
suitable result?

To me what you suggest here is basically what I've described as kludgy
way of achieving the goal. I can probably also make merges with
different strategies in 2 different repositories, then copy files
between them. Does it mean I already have all the needed tools to get
the job done?

Please consider the problem: I did a regular merge, and by analysis of
the resulting conflicts I realized I'd need to visit a few tens of files
and resolve conflicts exactly the way -X ours would. Suppose, for
simplicity, that all these files are in some sub-directory <subdir>.

git merge --force -X ours -- <subdir>

would solve this immediately, if it existed. Honestly, I can't even
estimate what would I need to do to achieve it using "git merge-file". I
mean, I guess it's possible, yet I don't believe it's practical.

>> >   * The pathspec limiting is going to be a bug factory for renaming
>> > handling.  (The simplest form of which is just renaming a special path
>> > to a non-special path or vice-versa and modifying both sides of
>> > history.)  Rename handling can already get some pretty hairy corner
>> > cases without dumping more in the mix.  I'd rather have users decide
>> > what to do with paths that switched from being one of the special
>> > "ours" paths to being a normal 3-way-conflict marker path.
>>
>> I admittedly didn't dive into such details, but I didn't suggest to
>> attach any additional attributes to paths either, so there is no need to
>> care about renames, as far as I'm able to see.
>>
>> Apparently you talk about some other feature here that I didn't suggest.
>
> Perhaps your comments on creating a ".gitmerge" file means something
> different than I understood.  If it indeed does not record pathnames,
> then the rename issue goes away (though then I don't understand what
> its purpose is nor the rest of your comments in that paragraph where
> you suggested it).  But if your .gitmerge comments did imply something
> similar to .gitattributes which specified how certain paths were to be
> handled, then renaming issues would certainly arise.

Well, I had no use for .gitattributes, so I didn't even recall they
exist. Maybe it's where needed support could be defined, so that
existing renames handling machinery is simply reused without additional
efforts. Will it work right now if I define custom merge driver that
does "git merge -X ours" and then assign it to the set of files? It'd
still be a kludge, but one that proves the point that such support could
be implemented without much effort.

OTOH, as I already said, my own use-case doesn't need any permanent
configuration, so what I say about it is mostly just thinking aloud. In
particular, the .gitattributes trick above is again too complex to solve
a casual but heavy problem I sometimes have, though I think I'd still
use it lacking better way.

Thanks,
-- Sergey
