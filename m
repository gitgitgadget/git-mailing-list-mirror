Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37461C43334
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 20:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236221AbiGGUz6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 16:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiGGUz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 16:55:57 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B79D2ED5F
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 13:55:56 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id f73so3801908yba.10
        for <git@vger.kernel.org>; Thu, 07 Jul 2022 13:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WfjlGDtYSmIQb8tHF4J6G/EPMB3IuFT61lu1ODCEsmk=;
        b=msbcSBXf/nA0kfHPV3E0mAfhUC5wWGYym1U0S2Pbwco4EfU6TUxdYjNd4DHzcMDe7C
         phHaQ77yjxz2uL7l9nRLCuJ97xvFtmjPhKDQ0JMmTn5GZ7Pq0kYCVDqsZvWJvqhgtZN0
         PM87UL8TOKyjhuR2acmKMmGjT7Yr0RW6JwhOnOK3azCNPIvTyu44rqDPy4UatBH8r0wb
         pz2MLro2CuEmekK6RoPKYHMfKpMuEEaiIPHn1RApy3ZTovzLFXM6vTzm05QgszN/iTfa
         65OriSV5uN2WnS3pfzrN35IpGMUWeQdu1hrr2ht+xRNAV0lAYxrJpQRCznmz+l4uR4wX
         CVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WfjlGDtYSmIQb8tHF4J6G/EPMB3IuFT61lu1ODCEsmk=;
        b=j6mxurhokCmvNhgL1mj/CSMw7UE9+tdxpmNHbbHnxJ4qgZNlmaTy8HNU4t4BkRwG2y
         4QibsyD06Ke0S2iUsrYNNEnMqs/nIROZIf6PmkhT/X0ZEAGoczCC/tW+wjYG3zA3pFgy
         o4qcAOFVn6EtqGpdgSmC6RKFOSKjR2eeK2H0aFWSEccnQbE6bzP7h/VdIhPOqEfHmE4V
         kU47OqkRmu7papR/DXJtjmxpiHW+PXbKZRpBuYGhoe504HXGQL0xERgK/xWE5I0cif7c
         J6yvrygsznU0aZRZtnhl9H7RpYCpWq5JZlqMAsVv2Y9dr6DPAeEIs2bXmoa6So4Y8KVx
         3Esg==
X-Gm-Message-State: AJIora/Q9d0oyd1lMBZqxnINgFf32lHK2wE1XCIOEjM9IS0PGocaJhc8
        YJDBiFF53903Gp8KncidVDbAZaVcXqvR4lz5kD3Jr2KTP3svLA==
X-Google-Smtp-Source: AGRyM1vwwftzfnBnTHW667DACDS39J6FuHhPVKmv0qXyzdYkt6kKTp2lUz5dOmnlDXC5pCwmz87ejvYVkqoT1tTdj0s=
X-Received: by 2002:a25:81c5:0:b0:66d:55b5:d250 with SMTP id
 n5-20020a2581c5000000b0066d55b5d250mr50225435ybm.501.1657227355213; Thu, 07
 Jul 2022 13:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAP4e5TNdvE1gmt9bERT5sL+D3r4Fbypk57KJJ+wYHD=M=T+uWA@mail.gmail.com>
 <xmqqa69mgdde.fsf@gitster.g> <220707.86tu7t84zh.gmgdl@evledraar.gmail.com> <xmqq4jzs3lp1.fsf@gitster.g>
In-Reply-To: <xmqq4jzs3lp1.fsf@gitster.g>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Thu, 7 Jul 2022 13:55:43 -0700
Message-ID: <CAJoAoZnpryUpOVHQ8sCkkF19so=OjS+B46UB1MwN=wmLqqn=Pw@mail.gmail.com>
Subject: Re: bug report: pre-commit & pre-push hook output is redirected differently
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Git List <git@vger.kernel.org>,
        Adam Zethraeus <adam.zethraeus@includedhealth.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 7, 2022 at 9:57 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
> > I may be missing something, but I think this report has nothing to do
> > with any recent changes or regressions, but is merely noting a behavior
> > change between pre-push and some other hooks that we've had since 1.8.2=
,
> > or since the "pre-push" hook was added in ec55559f937 (push: Add suppor=
t
> > for pre-push hooks, 2013-01-13).
>
> "behavior change" meaning a regression of a particular hook, or
> "behavior difference" between hooks, each of which never changed the
> behavior?
>
> > I tested this with a local v2.30.0, and the behavior was the same.
>
> I guess you meant the latter.  If so, the inconsistency may be
> unfortunate, but I agree that it is not cut-and-dried that it is a
> good idea to change pre-push to spew its output to standard error
> stream.
>
> > It *is* something we need to be careful of when converting the rest of
> > the hooks to the hooks API, i.e. we need tests for how stderr/stdout is
> > handled for each one.
>
> Absolutely.

On the one hand, we just had a particularly frustrating regression
around hook output direction, and it's likely none of us are
interested in repeating such pain anytime soon.

On the other hand, I wonder how worried we actually should be about
changing the behavior to normalize pre-push and other "oddball" hooks.
If the pipe used changes, what changes for the hook author? What about
for the person running the hook on their repository?

For the hook author, there is no change, in that the hook author
cannot control which pipe we decide to send their output to, and
should have written their hook with that in mind in the first place. I
found one example[1] of a hook which manually sends its only output to
stderr, everything else I saw just 'echo'es with abandon. I did notice
many hooks relying on colored output, but we've fixed that bug ;)

For the hook runner, the main difference has to do with parsing output
for scripts. That is, if I'm just looking with my human eyes, I don't
care which pipe is used, as long as it comes to the terminal. Of
course for scripting that is a different story, and if output I was
expecting on a certain pipe suddenly disappears (or vice versa) that
is a pain. However, I don't see much evidence that hook output can be
used in that way. In fact, I think that is the reason we shunt most
hook output to stderr; Git typically says "stdout is what you should
parse with your script, and stderr is what humans should look at with
their eyeballs." Through the very scientific method of looking at the
first 10 pages of GitHub search results[2], I didn't find any evidence
that pre-push hooks are being written with the intent for their output
to be parsed. That makes sense to me - I'd need to carefully
synchronize the output from my pre-push hook *and* the parser in my
script, and at that point it makes more sense to just teach the
pre-push hook to take whatever action it's trying to communicate to
the parser and cut out the interprocess communication, right?

Anyway, tl;dr - I think it would actually be a good and reasonable
thing to normalize the pre-push hook, either now or at the point where
it's converted to hook.c.

As for proc-receive, I think that one does something weird - the
hook's output is intended to be parsed by Git itself, and isn't shown
to the user. proc-receive is in fact such a weird and different hook
that it is completely exempt from the migration to hook.c. It does
bidirectional communication with the Git parent process and the parent
process decides how to act based on that communication, which means
that even if run_processes_parallel could support that (it doesn't) it
wouldn't make sense to configure more than one proc-receive hook
anyways. So proc-receive is intended to continue being an oddball and
not use the hook.c library (other than to check for the existence of 0
or 1 proc-receive hooks).

 - Emily

1: https://github.com/Kaliraj-hesabe/hesabe-reactnative-app/blob/3526fbe3fe=
d8f08dadf10483c1292b8cd8f7d4ed/node_modules/realm/vendor/realm-core/tools/p=
re-push
2: https://github.com/search?l=3D&p=3D9&q=3Dfilename%3Apre-push+-filename%3=
A%2A.sample&type=3DCode
