Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C5AC43217
	for <git@archiver.kernel.org>; Sat, 16 Apr 2022 02:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiDPCJI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 22:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiDPCGv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 22:06:51 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1FF3983E
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 19:03:21 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id c1so7495557qvl.3
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 19:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=grn7Mjoj2H071/KUwSiqBjCTYSLsxiessfTEoahFcaU=;
        b=djN1uZ0ybE5nB3geA7vZhDqQm0EZodkyPgxRrJK4hhmSQ/4PBfnk+aKcr/F51bNzfX
         EJtS3FpAiHgsGcUvvnbiW/tZM4Z6626fvrfFLz1mibngCRSWEIEYf3HrkfG7utPcIjR2
         hkJIHTXiteRaI6BZWlTP4XyepssMFC04K1HlOEK17qETW3omW9mS0MRuYctIbYFUAUR5
         vWPZ8ymbUABojJMkgN+DEPeA+nuXdlC024jx8CfopidZOmM083AxRgCUr/szcbggFPIH
         5q8Bm3YC349hNK7jslo1+0DMpHjHx4D9h//Q/ZCjqWQaa1qCQ4/7LZ23i6Nh+nONNNnb
         XU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=grn7Mjoj2H071/KUwSiqBjCTYSLsxiessfTEoahFcaU=;
        b=RVeHC5DXTdgseZzWUGK8cBpx5ZtQQXon8Nnfo8y1YAxBA3PcXr6JULL1BUu0m89PoW
         Ubi9/nqqZaNPv3wFlfqsrURb+t10k9V0Sk9+Fj9yfuKbYeqlO+HrtFha26vJ3JhOckLs
         a4rXeTQ+ThfVK1lEuuv/+WdwezQ2D829VoAB8XvpZx39MecI+vAUX27QUznaNepquRou
         viebcL19ZnC56NSNrZGveDbc2X6z3lUnmJXKNOiBHiMRCoa0aS9JCjBFvEKjMP5bmKfT
         oR4a0Gq1Xtl9TEQ4+rssfyl0J9WwA5Qkaobm1jlADubUiG1d6F5OMF6rC1eZ0PLmsy/U
         QNOA==
X-Gm-Message-State: AOAM533fAORNNZ7zOeLJ6ivKHKYR2RXwmc3tLextHBo81UMDBEXbLRjU
        7f5uRBm/ZFGAZW/wN6dXYO6Wsfl1TrvD//Dp
X-Google-Smtp-Source: ABdhPJwSoFQTXakXOrJzMiA1+5uNqDZxcmo+kRqmeZlYJc1csoosoarYjEqt2nc0p2yk5XtScZMotA==
X-Received: by 2002:ad4:5b89:0:b0:441:6e09:dbeb with SMTP id 9-20020ad45b89000000b004416e09dbebmr1026790qvp.53.1650072488271;
        Fri, 15 Apr 2022 18:28:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y12-20020a05622a164c00b002e1e277885esm3868329qtj.8.2022.04.15.18.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 18:28:07 -0700 (PDT)
Date:   Fri, 15 Apr 2022 21:28:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        justin@justinsteven.com, Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        rsbecker@nexbridge.com
Subject: Re: Bare repositories in the working tree are a security risk
Message-ID: <Ylobp7sntKeWTLDX@nand.local>
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
 <kl6lwnfp7tbc.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <kl6lwnfp7tbc.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 15, 2022 at 05:41:59PM -0700, Glen Choo wrote:
> * We all agree that something needs to be done about embedded bare repos. This
>   is a pretty good starting point IMO, because we agree that 'do nothing' isn't
>   a good response.

To be totally honest, I am not absolutely convinced.

I agree that it's sub-optimal that Git is an attack vector for remote
code execution, but I think there is significant social engineering
required in order to meaningfully exploit this. Particularly because an
attacker must convince their victim to:

  - clone the repository,
  - cd into the embedded bare repository, and
  - run a git command

Scripting around the output of git commands in your PS1 makes the latter
more likely, so I think it's worthwhile to explore how to either prevent
this type of attack or make it substantially less likely to have a user
run git commands that execute parts of the config opportunistically.

That said, I think there are other approaches that we could take that
would hopefully disrupt fewer existing workflows.

> * There are use cases for embedded bare repos that don't have great alternatives
>   (e.g. libgit2 uses bare repos in its tests). Even if this workflow is frowned
>   upon (I personally don't think we should support it), I don't think we're
>   ready to categorically declare that Git should ban embedded bare repos
>   altogether (e.g. the way we ban .GiT).

I think there are a handful of legitimate reasons that we might want to
continue supporting this; for projects like libgit2 and Git LFS, it's
useful to have repositories in a known state to execute tests in. Having
bare Git repositories contained in some "test fixture" directory is a
really easy way to do just that.

> * We want additional protection on the client besides `git fsck`; there are
>   a few ways to do this:

I'm a little late to chime into the thread, but I appreciate you
summarizing some of the approaches discussed so far. Let me add my
thoughts on each of these in order:

>   1. Prevent checking out an embedded bare repo.
>   2. Detect if the bare repo is embedded and refuse to work with it.
>   3. Detect if the bare repo is embedded and do not read its config/hooks, but
>      everything else still 'works'.
>   4. Don't detect bare repos.
>   5. Only detect bare repos that are named `.git` [1].
>
>   (I've responded with my thoughts on each of these approaches in-thread).

  1. Likely disrupts too many legitimate workflows for us to adopt
     without designing some way to declare an embedded bare repository
     is "safe".
  2. Ditto.
  3. This seems the most promising approach so far. Similar to (1), I
     would also want to make sure we provide an easy way to declare a
     bare repository as "safe" in order to avoid permanently disrupting
     valid workflows that have accumulated over the past >15 years.
  4. Seems like this approach is too heavy-handed.
  5. Ditto.

> With that in mind, here's what I propose we do next:
>
> * Merge the `git fsck` patch [2] if we think that it is useful despite the
>   potentially huge number of false positives. That patch needs some fixing; I'll
>   make the changes when I'm back.

If there are lots of false positives, we should consider downgrading the
severity of the proposed `EMBEDDED_BARE_REPO` fsck check to "info". I'm
not clear if there is another reason why this patch would have a
significant number of false positives (i.e., if the detection mechanism
is over-zealous).

But if not, and this does detect only legitimate embedded bare
repositories, we should use it as a reminder to consider how many
use-cases and workflows will be affected by whatever approach we take
here, if any.

> * I'll experiment with (5), and if it seems promising, I'll propose this as an
>   opt-in feature, with the intent of making it opt-out in the future. We'll
>   opt-into this at Google to help figure out if this is a good default or not.
>
> * If that direction turns out not to be promising, I'll pursue (1), since that
>   is the only option that can be configured per-repo, which should hopefully
>   minimize the fallout.

Here's an alternative approach, which I haven't seen discussed thus far:

When a bare repository is embedded in another repository, avoid reading
its config by default. This means that most Git commands will still
work, but without the possibility of running any "executable" portions
of the config. To opt-out (i.e., to allow legitimate use-cases to start
reading embedded bare repository config again), the embedding repository
would have to set a multi-valued `safe.embeddedRepo` configuration. This
would specify a list of paths relative to the embedding repository's
root of known-safe bare repositories.

I think there are a couple of desirable attributes of this approach:

  - It minimally disrupts bare repositories, restricting the change to
    only embedded repositories.
  - It allows most Git commands to continue working as expected (modulo
    reading the config), hopefully making the population of users whose
    workflows will suddenly break pretty small.
  - It requires the user to explicitly opt-in to the unsafe behavior,
    because an attacker could not influence the embedding repository's
    `safe.embeddedRepo` config.

If we were going to do something about this, I would strongly advocate
for something that resembles the above. Or at the very least, some
solution that captures the attributes I outlined there.

I would be happy to work together with you (or anybody!) on developing
patches in that direction, so let me know if you are interested in
coordinating our efforts.

> Given that this embedded bare repo problem has been known for a long time, I
> don't think we need to rush out a fix, but (especially since I'll be OOO) I'm
> more than happy for someone to take my ideas (or any ideas) and run with them.

No rush. Regardless of your time out-of-office, we should take advantage
of the fact that this is a long-known wart to carefully craft a solution
that provides some additional safety while disrupting as few existing
workflows as possible.

Thanks,
Taylor
