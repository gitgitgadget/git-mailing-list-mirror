Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784CCC433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 20:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5391460E90
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 20:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbhJLUtk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 16:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbhJLUtj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 16:49:39 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940A3C061570
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 13:47:37 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id p13so1401036edw.0
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 13:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=KlJ4yYWfqoowM0F9NQ5VAGa1wGCqD7b6grrzEI3nHw4=;
        b=aMDSvUzdg3uzlAs5Q34Gj8nzFGAvs3edVEugdnx50HghCzFBXDhRsb0DEUZwACrjh+
         C8jUKlno5cmdPPeVaDOPy+jOdYB860PTdL/idzREv70idBzOE/0HmHqfwcEjHM+4wjOB
         c9g5BOTMZvheAtVXbYY5oKSpBd4/rZmm+az//2xjZF/7ma5Uj1iyo1RcH8BARtB4D7S/
         z9fwR1vAXXZLr6vc4zf0FXfDCx+yHVzfi5o+SmL5wjMedFCRiwfpdLlykyHLd673cDjv
         I/d8VrC5re4aXS05ktJx7lhZz5MABAGwx0f763v0qUKTYwwW79WJPWGXjX5DKcYdCXzu
         NGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=KlJ4yYWfqoowM0F9NQ5VAGa1wGCqD7b6grrzEI3nHw4=;
        b=W0qEMYhdeiV/mxBzlV1Vh+6vVOL1hTQJkJzFTTFfMDGALgisVibQkY4gLh1nen7L8d
         DKBlGrlF3/5suHwrYjQxIHl17MG7nrCTeXoXBRiVmC82q3HWaU+aBAekIrraJ6Fx9yyf
         Q6+0CMMGu/jlUU7b2d0yrviyVYB90Ib2UEeY4ax54mIIORL74XKYTP8967858SO8oZdI
         xz6XbEmQat9bK5BMiQ2RpFwhCDa0SHL2YopDMzBk3DMn3HGDnaMjQpSaEqsSU30OLPNX
         t5V8jn3gCQIvKnfOIjm5P3yMrxLA1Fkra7dNnGUiWOqTSIL3FQRK+mRO5SOuE9/vjH3k
         ELAA==
X-Gm-Message-State: AOAM533yPZJH9xi2SY7t+cSNWWaUsSspYLeLv0D10mmOo2yKPAXNI2D9
        u0w1Tus/K6uxgkcNitijrYp5w6m9uf3Obw==
X-Google-Smtp-Source: ABdhPJx28YGKixhHEEdsTpjcHJwFenjn5pMKIfkmsDJZEnBI6zcdX77i7VLv0nW9DXfI5KKAvEv0AQ==
X-Received: by 2002:a05:6402:50d0:: with SMTP id h16mr2915173edb.303.1634071656071;
        Tue, 12 Oct 2021 13:47:36 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g9sm5452618ejo.60.2021.10.12.13.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 13:47:35 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v4 0/3] Use default values from settings instead of config
Date:   Tue, 12 Oct 2021 22:34:59 +0200
References: <20211005001931.13932-1-chooglen@google.com>
 <20211012174208.95161-1-chooglen@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20211012174208.95161-1-chooglen@google.com>
Message-ID: <87wnmihswp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 12 2021, Glen Choo wrote:

> Hi everyone! This patch was created in response to something we observed =
in
> Google, where fsck failed to detect that the commit graph was invalid. We
> initially assumed that fsck never checked the commit graph, but it turns =
out
> that it does so only when core.commitgraph is set, even though we set def=
aults
> for "whether to use the commit graph" in the repository settings.
>
> Instead of using the config, let's use repository settings where
> available. Replace core.commitGraph and core.multiPackIndex with their
> equivalent repository settings in fsck and gc.
>
> This re-roll is primarily motivated by the CI failures noted by Junio in =
[1].
> The underlying cause is that GIT_TEST_COMMIT_GRAPH=3D1 (enabled in the li=
nux-gcc
> job) causes commands like "git commit" to write commit-graphs, but certai=
n tests
> like t/t0410-partial-clone.sh and t/t3800-mktag.sh intentionally create
> corruptions that cause commit-graphs to become out-of-sync/invalid. Patch=
 1
> fixes a bug where fsck did not check commit-graphs by default, which mean=
s that
> these tests will now fail because they have invalid commit-graphs. The ea=
siest
> solution I found is to disable this confusing and noisy behavior with
> GIT_TEST_COMMIT_GRAPH=3D0.

That's easy, but...

> And since I am re-rolling, I incorporated =C3=86var's feedback regarding =
the commit
> messages (thanks!). I considered combining patches 1 and 2, but patch 1 h=
as a
> grown a little to fix the CI issues, so I've decided to keep patches 1 an=
d 2
> separate.
>
> This series has also seen a healthy amount of interest in test style and
> coverage. We haven't converged on a path for the future, but I'd like to =
think
> that the tests here are still a step in (approximately) the right directi=
on.
> Hopefully this version LGT us while we figure out what to do with tests :)
>
> [1] https://lore.kernel.org/git/xmqqfstafyox.fsf@gitster.g/
>
> Changes since v3
> * Disable GIT_TEST_COMMIT_GRAPH in tests that intentionally corrupt thing=
s in a
>   way that is incompatible with commit-graphs.
> * Make patch 1 and 2's commit messages more concise (thanks =C3=86var!).

...how isn't disabling those t3800-mktag.sh tests just plasting over
corruption that we're noticing because of your changes to (rightly) fix
the bug where "fsck" wasn't checking the graph at all?

IOW haven't we just found exactly the sort of bug that
"GIT_TEST_COMMIT_GRAPH" is put in place to find for us, but now instead
of fixing it we're hiding it?

If I comment yout your addition of GIT_TEST_COMMIT_GRAPH=3D0 in that file
I see that we fail N number of tests, but all of them are actually
fallout of just this test:

        git replace $head_parent $head &&=20
        git replace -f $tree $blob=20

I.e. we've created a replacement object replacing a tree with a blob, as
part of tests I added to test how mktag handles those sorts of weird
edge cases.

This then causes the graph verify code to throw a hissy fit with:

    root tree OID for commit 0ddfaf193ff13d6ab39b7cbd9eed645e3ee2f050 in
    commit-graph is da5497437fd67ca928333aab79c4b4b55036ea66 !=3D
    0fbca9850869684085d654f9e1380c9780802570

I.e. when we wrote the graph we somehow didn't notice that the root tree
node we wrote is to an object that's not actually a tree? Isn't this a
bug where some part of the commit graph writing should be doing its own
extended OID lookup that's replacement-object aware, it didn't, and we
wrote a corrupt graph as a result?

If there is a legitimate reason why we're not just hiding a bug we've
turned up with these fixes let's disable that one test, not the entire
test file.

If you don't run the one test that fails (which is split up into 3
individual pieces) there's still 143 other tests that are run, all of
those presumably benefit from finding future bugs with
GIT_TEST_COMMIT_GRAPH=3Dtrue, particularly since the test file seems to
just have turned up one just now...
