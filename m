Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C79FC433F5
	for <git@archiver.kernel.org>; Fri, 29 Apr 2022 23:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352439AbiD3ABP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Apr 2022 20:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359141AbiD3ABO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Apr 2022 20:01:14 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF5B443F4
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 16:57:54 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id w3-20020a17090ac98300b001b8b914e91aso4743382pjt.0
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 16:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EkbEubdCBIgME9OC2J6bIimA0CLFnqqMZ0VQLdTP8hY=;
        b=KHiC8VVe7Fqk0tR5OWuMpC0iTeHcyY1kkXeZP5alzNvHUhPAjDxzIz9TUr35TeIMtL
         N1xRuAG1UnKxyf9QnO93ye2YPRHG/Uz9j3b1Ald1JmZouqFAwxP5wCT3W2OGLLJdczlr
         Jc8WLa58yY9WJlk7zyCEt4JrPlVOOf9IF1yuFAf37dLcC3DA0UxPWK/3/dNE2LZJ+UF+
         A5LShPt9HnuFwfXg+OFZjl29eGIcKDlTHdMq2sQy8GEUlFSDa20oEjB61vdd+cdzIjew
         dDiqkmGCUslHwHZHT2MgYtbtlwSq26MYQhpk2dsrxke1YRl0O0Dc+4DV/JKvs6WAX2Iy
         V3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EkbEubdCBIgME9OC2J6bIimA0CLFnqqMZ0VQLdTP8hY=;
        b=rWW/maAfwrlWExYexRJNAyFoh3M8lF0nL+5duNERzcKE4EBOuHCO8C6FU9UftBX8uw
         HJNi5c2P5xYwTM4bH/dI5ka6dksJf+CwB5GGvO8MpegVgmdmwTbtFZYfKEFEr4vUtybT
         J4yAKjGG4kZi2PsyOKCKrXRaji+skcM42LaX4qiVWaoYlazJd5TlPerIuNOzAKavTlI2
         cA5pFQrCS5l2A9DD0ipYumKu03gKkLF36EkOQ/GQTNxiZgg4PnJ3ZRKux1UlPv1Xu+BI
         mHwH0dWTeAuM1uFmwld3Aaws9vyG2OihEatOO2V+xMGJQhNLSodpVAi8dn/uOUv755j7
         ubjQ==
X-Gm-Message-State: AOAM532/dTxISUIeOQXet53H10oEwWndh/ZqcLJ7BH+NMFamyBFp0rJV
        paxJ0M5ZcqoztE1g7MjVY6fX/7TlbweFvQ==
X-Google-Smtp-Source: ABdhPJyJv6JUwsesIw2v5HWqnF6tpXctmqj+ikzH/kNDyy2t4L9VRakLoncUPwJ+B0Kr/oC4PUiWfAf1QIvSMQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:d4cc:b0:15d:5246:e4de with SMTP
 id o12-20020a170902d4cc00b0015d5246e4demr1670665plg.68.1651276673622; Fri, 29
 Apr 2022 16:57:53 -0700 (PDT)
Date:   Fri, 29 Apr 2022 16:57:51 -0700
In-Reply-To: <Ylobp7sntKeWTLDX@nand.local>
Message-Id: <kl6ly1zno328.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
 <kl6lwnfp7tbc.fsf@chooglen-macbookpro.roam.corp.google.com> <Ylobp7sntKeWTLDX@nand.local>
Subject: Re: Bare repositories in the working tree are a security risk
From:   Glen Choo <chooglen@google.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        justin@justinsteven.com, Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason" 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        rsbecker@nexbridge.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks so much for the response - it's really helpful, and there's a lot of food
for thought here.

(Sorry that I didn't get back to you sooner, there really is a lot of
great stuff here to think about :))

Taylor Blau <me@ttaylorr.com> writes:

> On Fri, Apr 15, 2022 at 05:41:59PM -0700, Glen Choo wrote:
>> * There are use cases for embedded bare repos that don't have great alternatives
>>   (e.g. libgit2 uses bare repos in its tests). Even if this workflow is frowned
>>   upon (I personally don't think we should support it), I don't think we're
>>   ready to categorically declare that Git should ban embedded bare repos
>>   altogether (e.g. the way we ban .GiT).
>
> I think there are a handful of legitimate reasons that we might want to
> continue supporting this; for projects like libgit2 and Git LFS, it's
> useful to have repositories in a known state to execute tests in. Having
> bare Git repositories contained in some "test fixture" directory is a
> really easy way to do just that.

If I were designing Git from scratch, I would probably block embedded bare repos
from being committed altogether - if an embedded bare repo doesn't behave
particularly differently from `.git` (which we pretty much agree we should not
support), then this is just an inherently dangerous way to work.

But yes, we have historically allowed embedded bare repos, and I don't think we
should stop supporting them altogether. For instance, I don't see a good
alternative for the test fixture use case:

- Submodules aren't a good fit because they only allow you to include the
  contents of a submodule's tree, whereas in a test fixture, you really do want
  the gitdir internals to be source controlled so that you get nice predictable
  results.
- Users could store the repos in some other form e.g. CDN, tarball. It's fine
  when running from a test script, but it's pretty awful to author/review any
  changes.
- Perhaps the users could munge the bare repo at commit time e.g. instead of
  storing (refs/, objects/, HEAD), they could store (test_refs/, test_objects/,
  test_HEAD), which would later get turned into the bare repo in the test
  script. It's a little silly, but not unreasonable for a test script, I think.

So I'll leave behind this idea of "blocking embedding bare repos" for
now; I think there are more promising proposals in this thread.

>>   1. Prevent checking out an embedded bare repo.
>>   2. Detect if the bare repo is embedded and refuse to work with it.
>>   3. Detect if the bare repo is embedded and do not read its config/hooks, but
>>      everything else still 'works'.
>>   4. Don't detect bare repos.
>>   5. Only detect bare repos that are named `.git` [1].
>>
>>   (I've responded with my thoughts on each of these approaches in-thread).
>
>   1. Likely disrupts too many legitimate workflows for us to adopt
>      without designing some way to declare an embedded bare repository
>      is "safe".
>   2. Ditto.
>   3. This seems the most promising approach so far. Similar to (1), I
>      would also want to make sure we provide an easy way to declare a
>      bare repository as "safe" in order to avoid permanently disrupting
>      valid workflows that have accumulated over the past >15 years.
>   4. Seems like this approach is too heavy-handed.
>   5. Ditto.

If I understand you correctly, it seems like we can ship any of the options from
1.-3., provided there is an easy way to opt-in known, "safe" bare repos.

After some more reflection, I tend to agree that 4.-5. are too heavy-handed for
the general population because they would break nearly all bare repo users. The
performance cost of detecting an embedded bare repo isn't ideal either, but that
can be easily fixed via GIT_CEILING_DIRECTORIES or an allow-list of "safe"
repos, and it's a lot gentler than just ignoring bare repos altogether.

I suspect that there is a subset of the user population who would love to
disable bare repo detection because they a) never expect to see bare repos in a
given environment and b) want to be defensive about the possibility of
unexpected bare repos. Since this really heavy-handed, I don't think this fixes
the embedded bare repo problem for everyone, but that subset of users will be
very well-served :) I think that there must be some coherent framework that
encompasses this idea + the allow-list you proposed, but I haven't come up with
one yet.

>> With that in mind, here's what I propose we do next:
>>
>> * Merge the `git fsck` patch [2] if we think that it is useful despite the
>>   potentially huge number of false positives. That patch needs some fixing; I'll
>>   make the changes when I'm back.
>
> If there are lots of false positives, we should consider downgrading the
> severity of the proposed `EMBEDDED_BARE_REPO` fsck check to "info". I'm
> not clear if there is another reason why this patch would have a
> significant number of false positives (i.e., if the detection mechanism
> is over-zealous).
>
> But if not, and this does detect only legitimate embedded bare
> repositories, we should use it as a reminder to consider how many
> use-cases and workflows will be affected by whatever approach we take
> here, if any.

Yes, that's good to keep in mind. After mulling about it some more, I don't have
a clear direction on the fsck patch to be honest, I'll leave this alone for now
and I'll return to it if I get a clearer picture.

>> * I'll experiment with (5), and if it seems promising, I'll propose this as an
>>   opt-in feature, with the intent of making it opt-out in the future. We'll
>>   opt-into this at Google to help figure out if this is a good default or not.
>>
>> * If that direction turns out not to be promising, I'll pursue (1), since that
>>   is the only option that can be configured per-repo, which should hopefully
>>   minimize the fallout.
>
> Here's an alternative approach, which I haven't seen discussed thus far:
>
> When a bare repository is embedded in another repository, avoid reading
> its config by default. This means that most Git commands will still
> work, but without the possibility of running any "executable" portions
> of the config. To opt-out (i.e., to allow legitimate use-cases to start
> reading embedded bare repository config again), the embedding repository
> would have to set a multi-valued `safe.embeddedRepo` configuration. This
> would specify a list of paths relative to the embedding repository's
> root of known-safe bare repositories.
>
> I think there are a couple of desirable attributes of this approach:
>
>   - It minimally disrupts bare repositories, restricting the change to
>     only embedded repositories.
>   - It allows most Git commands to continue working as expected (modulo
>     reading the config), hopefully making the population of users whose
>     workflows will suddenly break pretty small.
>   - It requires the user to explicitly opt-in to the unsafe behavior,
>     because an attacker could not influence the embedding repository's
>     `safe.embeddedRepo` config.
>
> If we were going to do something about this, I would strongly advocate
> for something that resembles the above. Or at the very least, some
> solution that captures the attributes I outlined there.

I really like the `safe.embeddedRepo` idea, though I'm not convinced about
"respect only the safe parts of the embedded repo". I'll address the latter
first.

I think brian m. carlson was coming from a similar direction, and the "respect
only the safe parts of the embedded repo" part of the proposal sounds similar to
his [1]. Both seem to be motivated by your second point - protect as many
workflows as we can. It's a good guiding principle, and I think it's a good
place to start from. That said, I'm not sure that this proposal serves these
users that well:

- Not reading the config might break the embedded bare repos in ways we don't
  expect (e.g. not reading core.repositoryformatversion).

- Users who use embedded bare repos as test fixtures presumably want their tests
  to mimic real-world scenarios as closely as possible; running in this
  half-state of "use some parts of the repo but not others" doesn't seem a good
  fit for that use case.

- This complicates the rules significantly for the user, who now has to figure
  out which parts of the bare repo are respected and which are not.

- I'm also of the opinion that changing the rules like this actually does affect
  workflows, even if it doesn't break libgit2's tests.
  - A diligent user still has to convince themselves that the tests are passing
    for the right reasons, possibly adapting to the new rules (e.g. by
    selectively enabling `safe.embeddedRepo` on the right test fixtures).
  - A less diligent user might not even realize the change has happened and
    end up with difficult to debug results somewhere down the line.

I'm also not keen on it for other reasons:

- This expands the attack surface significantly, and I'm pessimistic that we
  can maintain a list of the 'safe' parts of a bare repo. A lot of attention has
  been focused on config/hooks, but I wouldn't be surprised if a creative
  attacker finds some other avenue that we missed (maybe a buffer overflow
  attack on a malicious index file?).

- I expect that this is also going to be really complex to implement and
  maintain; instead of looking in a single gitdir for everything, we now look in
  two gitdirs.

What is promising is an allow-listing scheme like `safe.embeddedRepo` that can
be enabled on a per-repository basis. . Using an allowlist to selectively choose
*entire* embedded bare repos preserves the first and third attributes you
described, and it keeps things simple(-ish) for us and users. Breaking libgit2
and Git LFS this way is pretty harsh, but it will give us the confidence that we
have communicated the behavior change (and fix!) to the relevant users, rather
than having them find out the wrong way.

Some extra thoughts (in case they're helpful):

- It's pretty important to get the format of `safe.embeddedRepo` 'correct', but
  what 'correct' is is up for debate. For example, should we allow '*'? (I think
  so, but I know some don't ;)).

- There might be some unifying principles behind "allowlisting certain embedded
  bare repos" and "disabling/enabling bare repo detection" that can guide our
  fix.
  - Perhaps we could allow different 'levels' of bare repo protection, like
    'allow all bare repos', 'allow only non-embedded bare repos', 'allow no bare
    repos', 'allow embedded bare repos but not their configs".

  - If we do want to discourage embedded bare repos (and flip the default), this
    kind of gradual roll-out might give projects a way to incrementally migrate.

[1] https://lore.kernel.org/git/Yk9Wcr74gvhtyOi7@camp.crustytoothpaste.net

>
> I would be happy to work together with you (or anybody!) on developing
> patches in that direction, so let me know if you are interested in
> coordinating our efforts.

Thanks! Once again, I really appreciate the response. I think it's moved the
discussion forward in a meaningful way :) I think the easiest next step is for
me (or whoever :)) to propose patches and to hash out the details there.

