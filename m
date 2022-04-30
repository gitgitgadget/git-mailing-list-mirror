Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AFFC433EF
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 01:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378646AbiD3BRk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Apr 2022 21:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237041AbiD3BRj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Apr 2022 21:17:39 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0EAD1CD8
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 18:14:19 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id f4so11437710iov.2
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 18:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uAu3r6bvSHmUV3cm6nRQmv7P/bEYWnRTfihRSklGtdk=;
        b=aEo1imJx1Oc79Cy8IjWh+C5XrF0pVEK6Q11+AcjmuYDjMDa3yBibhQRwioNsfCGzOm
         quD+4aSAG6wJEnwQF3kqqCOevDWuFRcg0OI0kNDg/8CRlKbGXZLKZkq80785ftZUWHR6
         DzpNslbP7UEVMKd623+juArG8SA6wuGucPSeN6p0m+L/biTW2FBdCnmLLbzhXv9k5SHh
         FYvHYzdMXT/6pfgLKJ3hUinLV4hu45WaX4gkslHlWS4lqTE2za00r1bm4ILY3yktnE2h
         dy83jq2LhJm39xPkj5n6BVC/f9JSjjG0FVrp04VICgKsEt6J240LkkZU+XQFaQxahljE
         MB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uAu3r6bvSHmUV3cm6nRQmv7P/bEYWnRTfihRSklGtdk=;
        b=a1IG9PN+F4q0TXXkpovjofNy5ALL7pSMukwRmISkQoYMrU5xffCw12CUWht1ENxB8m
         XbGl99IMu4tXvgV87lCHPZVm9x5zlXzA2Dss66NGRW7oLAfcCkRFvvw2NP5PR3wCANps
         kGClal9yzk9zGNzD7+LeY97krfcFqTT/hyQOXi+SvH+cKaYVlBJ5u8R3EgWfU0LtXqP1
         G3yDGjV1iauDXxnaU68fVw2yQ1luxOBk5XquYJWBP4egPNejEG/kzzeP73djQEjDx6jf
         soJEmGo1f476TcMBSMNXcl1BZcjAMS9KeLUtEWTI9QVjWNh0Q3mOgcTZqjNHAUSWVmw4
         83Uw==
X-Gm-Message-State: AOAM531hdEUzWWIYofqVD1Utc3LzjIV7/N4Fpw/7KAoFOGONAQPJ4dHD
        /MkbUqGNPEBZeFFT7VcZEZhI2FbagxAovOrz
X-Google-Smtp-Source: ABdhPJxf6gd5gLb26yDwepoVLh0k5T6WT8HKHTfQmAlWSDwzTjLqaPduEytsdlDMFfftgYHUfeMpjg==
X-Received: by 2002:a6b:3f05:0:b0:65a:431a:30cf with SMTP id m5-20020a6b3f05000000b0065a431a30cfmr789047ioa.117.1651281258446;
        Fri, 29 Apr 2022 18:14:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y17-20020a6bd811000000b0065a47e16f5dsm238086iob.47.2022.04.29.18.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 18:14:17 -0700 (PDT)
Date:   Fri, 29 Apr 2022 21:14:17 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        justin@justinsteven.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        rsbecker@nexbridge.com
Subject: Re: Bare repositories in the working tree are a security risk
Message-ID: <YmyNacEAiRl4zLW4@nand.local>
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
 <kl6lwnfp7tbc.fsf@chooglen-macbookpro.roam.corp.google.com>
 <Ylobp7sntKeWTLDX@nand.local>
 <kl6ly1zno328.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <kl6ly1zno328.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 29, 2022 at 04:57:51PM -0700, Glen Choo wrote:
> Thanks so much for the response - it's really helpful, and there's a lot of food
> for thought here.
>
> (Sorry that I didn't get back to you sooner, there really is a lot of
> great stuff here to think about :))

No problem, I'm glad that you found it helpful (and likewise!).

> So I'll leave behind this idea of "blocking embedding bare repos" for
> now; I think there are more promising proposals in this thread.

I am in strong agreement with you here, but I would add an additional
point which is that even if we encouraged submodules over embedded bare
repos, or suggested storing bare repos on CDNs or what have you, there's
significant momentum in the "do nothing" category which we have to take
into account, too.

So even if we made it as easy as possible to convert to, for e.g., using
submodules, getting the millions (?) of repositories with embedded bare
repositories in them that have accumulated over the years to actually
change seems virtually impossible to me.

> >>   1. Prevent checking out an embedded bare repo.
> >>   2. Detect if the bare repo is embedded and refuse to work with it.
> >>   3. Detect if the bare repo is embedded and do not read its config/hooks, but
> >>      everything else still 'works'.
> >>   4. Don't detect bare repos.
> >>   5. Only detect bare repos that are named `.git` [1].
> >>
> >>   (I've responded with my thoughts on each of these approaches in-thread).
> >
> >   1. Likely disrupts too many legitimate workflows for us to adopt
> >      without designing some way to declare an embedded bare repository
> >      is "safe".
> >   2. Ditto.
> >   3. This seems the most promising approach so far. Similar to (1), I
> >      would also want to make sure we provide an easy way to declare a
> >      bare repository as "safe" in order to avoid permanently disrupting
> >      valid workflows that have accumulated over the past >15 years.
> >   4. Seems like this approach is too heavy-handed.
> >   5. Ditto.
>
> If I understand you correctly, it seems like we can ship any of the options from
> 1.-3., provided there is an easy way to opt-in known, "safe" bare repos.

After thinking about it some more, I think that we should probably try
to ship (3) of the ones that we agree are viable, but more on that
below...

> Yes, that's good to keep in mind. After mulling about it some more, I don't have
> a clear direction on the fsck patch to be honest, I'll leave this alone for now
> and I'll return to it if I get a clearer picture.

Sounds good. I'm happy to have ideas bounced off of me in the meantime ;).

> I really like the `safe.embeddedRepo` idea, though I'm not convinced about
> "respect only the safe parts of the embedded repo". I'll address the latter
> first.

To be clear, I am advocating for "only the safe parts" insofar as "read
repository extensions, core.repositoryFormatVersion and literally
nothing else". I'm definitely not suggesting we go and enumerate every
configurable value, determine whether it's safe or not, and then read
only the safe ones. That approach seems doomed to fail, since no matter
how clever we are, there will always be some slightly-cleverer attacker
who can find a vector that we missed.

> I think brian m. carlson was coming from a similar direction, and the "respect
> only the safe parts of the embedded repo" part of the proposal sounds similar to
> his [1]. Both seem to be motivated by your second point - protect as many
> workflows as we can. It's a good guiding principle, and I think it's a good
> place to start from. That said, I'm not sure that this proposal serves these
> users that well:
>
> - Not reading the config might break the embedded bare repos in ways we don't
>   expect (e.g. not reading core.repositoryformatversion).

I'm hoping that if we include this among the list of essential- and
known-safe config values that we'll mitigate this reasonably well.

> - Users who use embedded bare repos as test fixtures presumably want their tests
>   to mimic real-world scenarios as closely as possible; running in this
>   half-state of "use some parts of the repo but not others" doesn't seem a good
>   fit for that use case.

It's hard to estimate how many of these tests will get broken. But I
think the important trade-off to consider between "abort all Git
operations in embedded bare repositories" and "warn, and avoid reading
config/hooks" is how disruptive the change will be. The latter seems far
less disruptive to me, so I would rather us favor that over an
overly-conservative approach.

> - This complicates the rules significantly for the user, who now has to figure
>   out which parts of the bare repo are respected and which are not.

On this point I disagree, but I suspect we weren't on the same page
about what "only the safe parts" meant when you wrote this. To be
extra-extra clear, I don't think we should read some parts of config and
not other, I mean we should read _only_ the above listed parts (the
format version and extensions) and nothing else.

> - I'm also of the opinion that changing the rules like this actually does affect
>   workflows, even if it doesn't break libgit2's tests.
>   - A diligent user still has to convince themselves that the tests are passing
>     for the right reasons, possibly adapting to the new rules (e.g. by
>     selectively enabling `safe.embeddedRepo` on the right test fixtures).
>   - A less diligent user might not even realize the change has happened and
>     end up with difficult to debug results somewhere down the line.

I am sympathetic to what you're saying, but I (a) think there's still a
tradeoff here that doesn't obviously point us in one direction or the
other and (b) we should equally keep in mind other workflows besides
just test fixtures. Does that change our thinking at all? I'm not sure.

> I'm also not keen on it for other reasons:
>
> - This expands the attack surface significantly, and I'm pessimistic that we
>   can maintain a list of the 'safe' parts of a bare repo. A lot of attention has
>   been focused on config/hooks, but I wouldn't be surprised if a creative
>   attacker finds some other avenue that we missed (maybe a buffer overflow
>   attack on a malicious index file?).

I disagree, though again I suspect we were thinking of different thing
when saying "only read safe parts of the config". Still though, I would
argue that it limits the attack surface at the right level, which is to
say any vector that we _did_ miss is something that we should just fix
(e.g., preventing a buffer overflow) and not "oops, this config value
does specify an executable".

(We shouldn't have to deal with the index file, though, since a bare
repository would not read the index, no?).

> - I expect that this is also going to be really complex to implement and
>   maintain; instead of looking in a single gitdir for everything, we now look in
>   two gitdirs.

I'd think that any approach we take that has different behavior
for bare repositories depending on whether or not they are embedded has
to do a similar check, so I don't think this adds significant
complexity. Though not having written any code here yet, I'd take what I
say with a huge grain of salt ;-).

> What is promising is an allow-listing scheme like `safe.embeddedRepo` that can
> be enabled on a per-repository basis. . Using an allowlist to selectively choose
> *entire* embedded bare repos preserves the first and third attributes you
> described, and it keeps things simple(-ish) for us and users. Breaking libgit2
> and Git LFS this way is pretty harsh, but it will give us the confidence that we
> have communicated the behavior change (and fix!) to the relevant users, rather
> than having them find out the wrong way.

Hmm. I still am pretty convicted that this (avoid working with unknown
embedded bare repositories) is too harsh of a change to
make the default. Replace "Breaking libgit2 and Git LFS" with "breaking
many hundreds of thousands of repositories" [1], and I think that we
would need to come up with something more lightweight.

> Some extra thoughts (in case they're helpful):
>
> - It's pretty important to get the format of `safe.embeddedRepo` 'correct', but
>   what 'correct' is is up for debate. For example, should we allow '*'? (I think
>   so, but I know some don't ;)).

Stolee (cc'd) will have an interesting perspective here (at least as it
relates to the 2.35.3 release), I think.

> - There might be some unifying principles behind "allowlisting certain embedded
>   bare repos" and "disabling/enabling bare repo detection" that can guide our
>   fix.
>   - Perhaps we could allow different 'levels' of bare repo protection, like
>     'allow all bare repos', 'allow only non-embedded bare repos', 'allow no bare
>     repos', 'allow embedded bare repos but not their configs".
>
>   - If we do want to discourage embedded bare repos (and flip the default), this
>     kind of gradual roll-out might give projects a way to incrementally migrate.

Ah! Are you suggesting a global configuration setting that controls the
behavior of embedded bare repositories that _aren't_ listed in a
repositories safe.embeddedRepo list?

That sort of thing could work, though I'd argue strongly that any Git
2.x.y release should make the default behavior "avoid config/hooks"
as opposed to "refuse to work". We could consider changing that default
in Git 3.x.y, but I feel strongly that any Git 2.x.y release should
cater as much to existing workflows as possible without significantly
compromising on attack surface area.

Thanks,
Taylor

[1]: I have no idea if that figure is right, but I suspect it's in the
right order of magnitude. I could look into it further, though.
