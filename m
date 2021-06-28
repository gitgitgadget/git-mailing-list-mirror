Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FC6C2B9F4
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 10:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F12F619B5
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 10:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbhF1KnF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 06:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbhF1KnF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 06:43:05 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D635FC061574
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 03:40:38 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id n2so18052831eju.11
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 03:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=qsek8b8sRgEzwvOvqPMpvEVhnAz274Psql9SnIaRQf0=;
        b=gGwRfEO7ymge1yaNTCD436FzZwvLL0AHeXwM/3RHp04tjiE5haJq26HtZVsc4dshAg
         dtyz2vwj1ohTnktDOw+CjP8HDER64qgi5L1YnI0tiUC2ZhEQc6h7tkeSuRUI6bO4oMxG
         iRNSyWohOxZF2rdLjjyDVi/B67U8h55sTXwfvT4IiPilD6UKdwH+Bl2neFDscvlATx0R
         X2z4qZ9GecEAuxUDdVhsRzpdFFwxcwW01J1A/Gn+YZ2h5SWHP3zZIxbdq0X5xoU072pM
         kg+STSDd2M9e5jySVGokmyOdNlCUVTA1DsCN1cMJYZT7R1fXp5GW/GDe1kISdIhGeZIi
         MV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=qsek8b8sRgEzwvOvqPMpvEVhnAz274Psql9SnIaRQf0=;
        b=KW7r/HXxxLb3e/PPUEleLnRxAtQnTSe0Q9QpvfDRRjAu3pdROxvsA/j75BowweBpMC
         kICUCh9cVh2uZBToZfmWyVM0rs+5soqGTth9rPzKInGV+/mgvGVuhFPdUtZydCVLbjbS
         iEd5uMdbYja+PLhRoa96VgPzfwbi9rBv8ro6NeVO8ohMXp2Xa5YaEekuUocqa0aRzbF5
         un0/TAAf1HnU/xFoGZAocO+yp5/CDKd4EQH1qxY1s/aeuNCFZePEjup0AweOZyBHtVdw
         SKRd8SJaRLetJUy8+tWQ4zbEAp9Ef13ycpk7VkglrbDuKpQXoLd3qL2k2n5qHx2pPu0+
         NWgQ==
X-Gm-Message-State: AOAM531AxjZMVkVv2+h4BldqjSg4MnDhaw7bYpWiqZlTiZD82i1FSx1u
        jffdJ/tk3oadoMXduKRtZPU=
X-Google-Smtp-Source: ABdhPJwCGnC4297370P66BCCu5nT5lQILGjg+fCddChVInbozE+OjJw2SMNpoZu7vyQRwp19eD3L9A==
X-Received: by 2002:a17:906:2513:: with SMTP id i19mr22852023ejb.164.1624876837442;
        Mon, 28 Jun 2021 03:40:37 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id o21sm3573157eds.10.2021.06.28.03.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 03:40:36 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pull: abort by default if fast-forwarding is impossible
Date:   Mon, 28 Jun 2021 12:31:52 +0200
References: <20210627000855.530985-1-alexhenrie24@gmail.com>
 <CABPp-BGko7BP6ZMyRKwKrv0xz7FM9ehe67HSAtzgHF9eV2TD3A@mail.gmail.com>
 <60d7fbb770397_b8dfe2087d@natae.notmuch>
 <CABPp-BGXQ4vbFf6Gx21X-Ms+1VQsZfod1waNJZQxVmB7b-gD7Q@mail.gmail.com>
 <60d8ab7fe0761_ba5a2208b@natae.notmuch>
 <CAMMLpeQaY0z_baVQspJhAX0wanaJwneFoM5rG=xwFUmLEE-QaQ@mail.gmail.com>
 <60d8edbb3803f_70e20886@natae.notmuch>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <60d8edbb3803f_70e20886@natae.notmuch>
Message-ID: <87k0megtlo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jun 27 2021, Felipe Contreras wrote:

> Alex Henrie wrote:
>
>> On Sat, Jun 26, 2021 at 10:12 PM Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>> >
>> > Also, a bunch of tests are broken after this change:
>> >
>> >   t4013-diff-various.sh
>> >   t5521-pull-options.sh
>> >   t5524-pull-msg.sh
>> >   t5520-pull.sh
>> >   t5553-set-upstream.sh
>> >   t5604-clone-reference.sh
>> >   t6409-merge-subtree.sh
>> >   t6402-merge-rename.sh
>> >   t6417-merge-ours-theirs.sh
>> >   t7601-merge-pull-config.sh
>> >   t7603-merge-reduce-heads.sh
>> >
>> > If you didn't mean this patch to be applied then perhaps add the RFC
>> > prefix.
>> 
>> I actually did run `make test` before sending the patch, but when so
>> many seemingly unrelated tests failed, I foolishly assumed that they
>> were pre-existing failures. I should have run the tests on master for
>> comparison, sorry. Or at least put "RFC" in the subject instead of
>> "PATCH" as you suggest. I sincerely apologize for my lack of due
>> diligence and I know that I need to do better at self-reviewing
>> patches before sending them.
> I personally don't see any need for apologies, we all make mistakes,
> just keep it in mind for the future.

Yes, for someone joining the project it's not obvious what the status of
the tests is. No problem.

Alex: To elaborate, our exists tests should pass, and should pass on
every commit (both as a matter of fact and future coding practice). We
also have CI, so if you e.g. have a fork of git/git and push to your
fork you'll find that CI is run for you on several platforms.

See below for a one-liner to possibly speed up the testing for you.

> Personally I prefer to run prove instead, because the output is less
> verbose, and there's a nice summary at the end:
>
>   prove t[0-9][0-9][0-9][0-9]-*.sh

I also like "prove" better (well, I added the support for it, so
...). It's generally better to use e.g.:

    make test DEFAULT_TEST_TARGET=prove GIT_PROVE_OPTS="--jobs $(nproc)"

Since we do some basic checking via the Makefile that effectively form a
part of our tests.

FWIW for your one-liner it can be just:

    prove t[0-9]*.sh

Alex: You might also find that if you specify --root as the path to a
ramdisk the tests are much faster, e.g. on my Linux boxes I set
--root=/run/user/`id -u`/git.
