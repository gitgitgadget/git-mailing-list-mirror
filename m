Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EAEC433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 22:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237109AbiDMW1I (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 18:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbiDMW1H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 18:27:07 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75801286C8
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 15:24:44 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id p4-20020a631e44000000b00399598a48c5so1761640pgm.1
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 15:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8N3t/pI0zJd/Y+Gcqg7NZDm05gyhLtOdCv+TDcQV1pk=;
        b=GN4ivQMtn8fjwk1bsdbpx7DgKzaHD+wM1sFMK5sCnP/A4pOMj2RVuqK9298dF8u/tD
         uUulP3S+yGlzJXTs2446Ugmq8Mq63NvtgAbYbjJ7QWSe/3jf5IabeQZftY7UzGwnYuzI
         +vu/x1ZL9+KbiBdhdd8flXwT80yyQhdun0nbLRFLVJkcOE+IoE3Ng4jvefPYZDSBM/KI
         v4/Myx2A+TtkmzaHvLtl1UeePgxzP1jgQbRpPJyjc6XYfBdnGRR0qJwbklIxquB4tL2n
         JzWJ49iSfCG8/zufbe5LtOMtD9SPBTKS2aia1Zn3jNoppghXswuKepLhRH4nuzr6NcX6
         RDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8N3t/pI0zJd/Y+Gcqg7NZDm05gyhLtOdCv+TDcQV1pk=;
        b=Gva0wG5umDMAvyvffKrTXdmyU0Cw3Gs6elrDPVzr6ta8MmsPz+SOrWru2fQGOEhnwE
         4mhyT45xr92YkRb3Cv4iZ9k0oWFKdT3dfcrsOOn3v5JsajlFlUa2LFo2l0CPD57S5PHt
         h74TlQVFzBkOs1fN8C7qdhJhwwttYW7xQUysdZ9etd2VL807AhiMGeUooNZffqWrT65v
         61eBsufQCnRHcQ0wmRil3FSVRDUIUazT5kU/A92vY9qKpPBRlJb9Kh2I/kyF3WFy/SZR
         vEbgnhJW2aBE0KE1oJ643POCMsqqeVxIO74iLMBjz0IP1ztNuJsucrvH7ouzPxeogAZR
         ZzZw==
X-Gm-Message-State: AOAM530BuFVEqmU129TBvfzSGdP9BriRwFIx0ccnG1AN+E5Liy2pp/mV
        Zbrb3TSr5w3dlGC0ki3VhgeSx1UF6TxzSQ==
X-Google-Smtp-Source: ABdhPJwzNuFNdjTRd8wwpm2+y55rRXGAUSbRh5Nbjgp3tZ4l0fVCZ5KbWDOgANioDTObhdva1aKRx9pJET/vCA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:4d0d:b0:1cb:9dac:7ed0 with SMTP
 id c13-20020a17090a4d0d00b001cb9dac7ed0mr960839pjg.198.1649888683862; Wed, 13
 Apr 2022 15:24:43 -0700 (PDT)
Date:   Wed, 13 Apr 2022 15:24:42 -0700
In-Reply-To: <e81cdc6e-da42-d1d1-5d66-7d5e2a8aebbe@github.com>
Message-Id: <kl6lsfqg8vv9.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
 <20220406232231.47714-1-chooglen@google.com> <nycvar.QRO.7.76.6.2204071440520.347@tvgsbejvaqbjf.bet>
 <e81cdc6e-da42-d1d1-5d66-7d5e2a8aebbe@github.com>
Subject: Re: [PATCH] fsck: detect bare repos in trees and warn
From:   Glen Choo <chooglen@google.com>
To:     Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Derrick Stolee <derrickstolee@github.com> writes:

> On 4/7/2022 8:42 AM, Johannes Schindelin wrote:
>> Hi Glen,
>> 
>> On Wed, 6 Apr 2022, Glen Choo wrote:
>> 
>>> Git tries not to distribute configs in-repo because they are a security
>>> risk. However, an attacker can do exactly this if they embed a bare
>>> repo inside of another repo.
>>>
>>> Teach fsck to detect whether a tree object contains a bare repo (as
>>> determined by setup.c) and warn. This will help hosting sites detect and
>>> prevent transmission of such malicious repos.
>>>
>>> See [1] for a more in-depth discussion, including future steps and
>>> alternatives.
>>>
>>> [1] https://lore.kernel.org/git/kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com/
>> 
>> Out of curiosity: does this new check trigger with
>> https://github.com/libgit2/libgit2? AFAIR it has embedded repositories
>> that are used in its test suite. In other words, libgit2 has a legitimate
>> use case for embedded bare repositories, I believe.
>
> It is definitely good to keep in mind that other repositories have
> included bare repositories for convenience. I'm not sure that the behavior
> of some good actors should outweigh the benefits of protecting against
> this attack vector.
>
> The trouble here is: how could the libgit2 repo change their project to
> not trigger this warning? These bare repos are in their history forever if
> they don't do go through significant work and pain to remove them from
> their history. We would want to have a way to make the warnings less
> severe for special cases like this.
>
> Simultaneously, we wouldn't want to bless all _forks_ of libgit2.

Yes, that makes sense. Thanks for the thoughtful reply.

>  2. Suppress warnings on trusted repos, scoped to a specific set of known
>     trees _or_ based on some set of known commits (in case the known trees
>     are too large).

Since Junio mentioned downthread that we'd need (2), I'll focus on this.
I'm not sure I follow, though, so let me try to verbalize my thought
process to see what I'm not understanding...

By "Suppress warnings on trusted repos", I assume this is done on the
hosting side? (Since I can't imagine a built-in Git feature that could
selectively trust repos.)

"scoped to a specific set of known trees" sounds like fsck.skipList
i.e. as a host, I can configure a list of "good" libgit2 trees that I
will trust and those will be skipped by fsck.

So from my _very_ naive reading of (2), it seems like we already have
all of the pieces in place for hosts to do (2) on their own, _unless_
we think that fsck.skipList is inadequate for this use case. e.g. I
personally can't imagine any way to list every "good" tree and still
have a cloneable fork of libgit2, so we might to teach fsck to do
something smarter like "skip any objects reachable by these commits".

