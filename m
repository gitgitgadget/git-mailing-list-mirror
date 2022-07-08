Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD3EC433EF
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 22:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239758AbiGHWOg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 18:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240113AbiGHWOe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 18:14:34 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32DA57223
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 15:14:32 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id d2so39913329ejy.1
        for <git@vger.kernel.org>; Fri, 08 Jul 2022 15:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=iqx+ra1QTL4bz+S9H94qJP1BN2kwJC9M7td4nR0EoYw=;
        b=kM6Ggxr2U6lJnzV3cyxH+PC2SDigKdBT44wTnGUHxbq7fdFx/BwjdiVxmmWsxkyksl
         Fj+vtu1mHHZ+jqkIXhLSNsYbPW9FlYl7zjJErLEQNiTIRo+mfzupqsB2leHqHD+f+wXH
         EjrcXzdT27uEgEDG30wGIy2R/f+Y/1S6Ux8Jy8kugcZstxkvaL/n6ykunPbRp15pXI5k
         HP0fPHRsis1rjZfgsY8EJHdQt42U0nIuSxH4AAWygsDnE1fuFutNxBrACh8YBv8e9WyE
         AWmKXk+j7kt9CtedZVJPfpwuEbfahJufMibfR2p7s+1ZC2urgXRrZ6zHAxgWuYrxdAU3
         yFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=iqx+ra1QTL4bz+S9H94qJP1BN2kwJC9M7td4nR0EoYw=;
        b=634dBsWmM6W750S8/HeHYqK1T0i4AquCGJOKkfg5LrTv4UApBWBi6Lvp4RO2WR+EHr
         wxqYQjcfgmKzjpY65BEIO1QesuiO972HJesZC7kizHxCX3hNNDLBbrOAmzc5FRbAiK/V
         lOmiuJjwGDvp+Web1ytVCz1+zr4ksD9vA68p+590PNj9iCyqCYgUrDqPsTgow1vzJJYX
         EJGUClOiMwcOlRkUGbmtqEWMV3jsOGibK8jq1Aw5VSlDhhp7XEibEV0lV4pO9k7eWsqf
         uFOMtol4rLzihUPVmoGx+bf92NTYHzB/pt/7nce4g2Ds+SDwAA+4JP1kBMUOIeke9TOp
         oD7w==
X-Gm-Message-State: AJIora8cQhLB2uLSvqwLxffaSQWcQkQtwnYuPxJ0et2aTtAAs40JdH4j
        SJ4tnToecyStnP4FJya05I0=
X-Google-Smtp-Source: AGRyM1vL6lXMfSCOyWuoaAphCWFlxwJ9ye8uT9Qn8bx4v8RwRyFMojzrSyyDetCpBD9DcjTYd8ZZiQ==
X-Received: by 2002:a17:907:8a28:b0:726:a02a:5bea with SMTP id sc40-20020a1709078a2800b00726a02a5beamr5901571ejc.175.1657318471011;
        Fri, 08 Jul 2022 15:14:31 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id o19-20020a170906769300b0072b13a10477sm2564867ejm.108.2022.07.08.15.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 15:14:30 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o9wF3-0003Sd-Fu;
        Sat, 09 Jul 2022 00:14:29 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v6 0/5] config: introduce discovery.bare and protected
 config
Date:   Fri, 08 Jul 2022 23:58:22 +0200
References: <pull.1261.v5.git.git.1656354994.gitgitgadget@gmail.com>
 <pull.1261.v6.git.git.1656612839.gitgitgadget@gmail.com>
 <220701.861qv5d8v7.gmgdl@evledraar.gmail.com>
 <kl6lr134spi0.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <kl6lr134spi0.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <220709.86zghj8d6i.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 01 2022, Glen Choo wrote:

Sorry for the late reply, I see there's a v7, but this seems to also
apply to it, so...

> Thanks for weighing in :) Despite the different proposed approaches, I
> think we actually are in broad agreement.
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Thu, Jun 30 2022, Glen Choo via GitGitGadget wrote:
>>
>>> This is a quick re-roll to address =C3=86var's comments on the tests (t=
hanks!).
>>
>> Thanks!
>>
>>> =3D Description
>>
>> Just more generally on this series & approach. I know this is a v6 by
>> now, but I haven't kept up with this topic, but to be fair I did mention
>> pretty much this in:
>> https://lore.kernel.org/git/220407.86lewhc6bz.gmgdl@evledraar.gmail.com/
>>
>> So...
>>
>>> There is a known social engineering attack that takes advantage of the =
fact
>>> that a working tree can include an entire bare repository, including a
>>> config file. A user could run a Git command inside the bare repository
>>> thinking that the config file of the 'outer' repository would be used, =
but
>>> in reality, the bare repository's config file (which is attacker-contro=
lled)
>>> is used, which may result in arbitrary code execution. See [1] for a fu=
ller
>>> description and deeper discussion.
>>>
>>> This series implements a simple way of preventing such attacks: create a
>>> config option, discovery.bare, that tells Git whether or not to die whe=
n it
>>> finds a bare repository. discovery.bare has two values:
>>>
>>>  * "always": always allow bare repositories (default), identical to cur=
rent
>>>    behavior
>>>  * "never": never allow bare repositories
>>>
>>> and users/system administrators who never expect to work with bare
>>> repositories can secure their environments using "never". discovery.bar=
e has
>>> no effect if --git-dir or GIT_DIR is passed because we are confident th=
at
>>> the user is not confused about which repository is being used.
>>
>> I'm not insisting that the entire approach here should be changed, but
>> in the above exchange you seemed to have performance concerns about the
>> "just walk up in setup.c" approach I mentioned, but it's not clear if
>> that's still the only thing that necessitates taking this approach.
>>
>> There may be security subtleties that I've missed, but from the
>> description here it seems like that would work equally well, and
>> wouldn't require configuration, except insofar as we'd need to opt-in to
>> reading config from bare repositores *that also exist in a parent tree*.
>>
>> And it would be a more narrow & more secure solution, since it would
>> e.g. allow you to intentionally navigate to /var/repos/git/git.git in a
>> server setup and read the config there, which it could distinguish from
>> a case of /var/repos/.git existing, and git/git.git being brought in as
>> a part of that "parent" repo.
>
> Performance is one major concern, yes, and I agree that your findings
> show that the "just walk up" approach is cheap enough to consider doing.
> Though in the few cases where it isn't cheap to walk, wouldn't it still
> be useful to be able to opt out of it?

Maybe, but until we at least have a reason to think that there is a
performance concern this all seems rather hypothetical.

In the thread(s) I linked to I noted that I tested my POC implementation
on AIX, which has a sloooooooow filesystem.

Why are you concerned about this having a performance impact?

> The other concern is simplicity and correctness. Are we confident that
> we'll get the design of "just walk up" correct (including edge cases
> like "bare repo in bare repo in non bare repo")? I'm 100% confident that
> we'll get it right eventually, and that this approach will be a good
> default for all users. But in comparison, "never" is so much easier to
> understand and implement that I don't see why we shouldn't start by
> presenting this option to the 0.1-1% of users who would find it useful.

If you run "git status" or whatever in a directory anywhere on your FS
now it'll confidently tell you if you're not within a git repository.

We're just talking about re-using that code, why would we be concerned
that:

 1. Finding a repo at a given <PATH>
 2. Appending "/.." to that <PATH>
 3. Feeding it to a "given a path, find me the git repo" (code setup.c
    already has)

Is something we'd get wrong?

> And on the topic of simplicity, there's significant interest in
> maintaining backwards-compatibility with repos with workflows that
> absolutely depend on embedded bare repos, e.g. libgit2 and Git-LFS.
> That's yet another special case that we'd have to get right. Stolee's
> "no-embedded" proposal [1] pretty much covers that, but I don't see the
> harm in simplifying the design space by making bare repo support a
> non-goal.
>
> [1] https://lore.kernel.org/git/5b969c5e-e802-c447-ad25-6acc0b784582@gith=
ub.com

Sure, and we could have a config know to still use such repos (for
config or otherwise) with the "walk up" method, does that address your
concern here?

>> The "more narrow" and "more secure" go hand-in-hand, since if you work
>> on such servers you'd turn this to "always" because you want to read
>> such config, but then be left vulnerable to the actual (and muche rarer)
>> exploit we're trying to prevent.
>
> The point that we're not defending bare repo users is fair, but maybe
> the group we're trying to protect isn't really dedicated Git-serving
> servers. This exploit requires you to have a bare repo inside the
> working tree of a non-bare repo. So I think this is less of an issue for
> a server, and more for "mixed-use" environments with both regular and
> bare clones.

Yes, but this is only something that's even a question because of an
artificial limitation your proposal here suffers from.

I.e. in trying to detect nefarious repos where you've got "looks like
bare" content *tracked* in another repo you're conflating it with *any
bare repo*.

And the only reason we're doing that seems to me to be a premature
optimization.

>> Which, it seems...
>>
>>> This series does not change the default behavior, but in the long-run, a
>>> "no-embedded" option might be a safe and usable default [2]. "never" is=
 too
>>> restrictive and unlikely to be the default.
>>
>> This series has (since v3?) been noting aspirations to have a
>> "no-embedded" variant of this config, which your 5/5 here notes would be
>> better, but isn't implemented by this series.
>>
>> But your 5/5 also notes:
>>
>>     but detecting if a repository is embedded is potentially
>>     non-trivial, so this work is not implemented in this series.
>>
>> Hrm, well, the diff-stat isn't quite that trivial either :) :
>
> Well.. a lot of it is refactoring :P
>
>>> [...]
>>>  upload-pack.c                       | 27 ++++++----
>>>  12 files changed, 304 insertions(+), 47 deletions(-)
>>
>> In threads linked from the above ML link I linked to some POC code
>> showing how to hack a second .git discovery walk into setup.c. This was
>> as part of the "submodule parent dir" proposal, which is a different
>> feature, but also needs such "find the parent" code:
>> https://lore.kernel.org/git/211109.86v912dtfw.gmgdl@evledraar.gmail.com/
>>
>> Now, obviously that's a dirty hack, but it's not that hard to just
>> change the part of setup.c where we're satisfied that we've found the
>> git dir, then walk up "$THAT_DIR/..", and start our search again.
>>
>> Then:
>>
>> 	if (first_dir_was_bare() && found_parent_dir())
>>         	enforce_no_embedded();
>>
>> Isn't that what your proposed "no embedded" option would need to do?
>> Well, maybe we'd also check if the "first dir" is in the index of the
>> parent, as opposed to just being a bare .git somewhere in ~/Downloads,
>> e.g. if you have a ~/.git and keep your dot-files in git.
>>
>> But I think for an initial implementation just doing the walk would be
>> good enough, and would have a more narrow scope than this configuration
>> setting.
>
> A narrow scope is good, but I don't agree on this definition of
> "narrow". My preference is to give an obvious solution to a 'narrow'
> group of users, instead of a more tricky solution that affects all users
> in a 'narrow' set of cases.

We could still have an option to say "I never want to consider bare
repos from config", but if we're able to distinguish *tracked* bare
repos from non-tracked ones this is entirely unrelated to the initial
stated motivation for this series, isn't it?

I.e. to solve the security issue at hand.

I've got nothing against *also* providing a "I never want config from
xyz repos", but that seems to be orthagonal.

>> AFAICT the performance concerns aren't supported by any data, in the
>> case of the "submodule superproject" feature it turned out to not be the
>> directory walk, but us shelling out in a loop in git-submodule.sh.
>>
>> Well, *maybe* that's not the case, I think I have managed to read
>> between the lines of some of these past exchanges that there's some odd
>> propriterary internal NFS-like setup at Google where *parent dirs* are
>> auto-mounted and searched on access, so a "walk up" pattern would be
>> much more expensive.
>>
>> I do worry a bit about us ending up with design choices in git that we
>> wouldn't have ended up with, if not to cater to some in-house setup
>> somwhere that 99.99% of git users will never see.
>
> At the very least, I don't think you're saying that it's a bad idea to
> have "never", just that we might not have come up with it if not for
> some Google NFS thing.

I'm just speculating as to why we've ended up with this approach, but
maybe I'm wrong.

> Another use case I can think of is CI bots, which have no need for bare
> repos. To some folks (maybe in very security-sensitive environments),
> "never" might give more peace of mind than "no-embedded".

Sure, but again, I've got nothing against having *more config knobs*,
and I've often e.g. wanted some way to tell git to read no config at all
(which you can sort of do with the right environment variables, but it's
a hassle).

But I don't see how that's not unrelated to addressing the issue this
series aims to address, and what I'm pointing out that it's doing so
with a method that's less accurate than the "walk up" method, and less
secure.
