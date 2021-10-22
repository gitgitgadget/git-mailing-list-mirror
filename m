Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58D3C433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 09:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6CEF611F2
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 09:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbhJVKAC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 06:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbhJVKAA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 06:00:00 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294ABC061764
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 02:57:43 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z20so93752edc.13
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 02:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=igVnvRwqBjGTrhFAx4eKl8pHRnthmjQTJ0B2kGBDB8w=;
        b=GuKK8rJRzWpMboDwwM/xdgdbjej0EXRtt3zepRVGB2z1FRr9zJ1hBNzsWXO0Uabs+b
         Jy6gstxZhexobki5epC8x7Cuz6qwxSC7K/EG8tSQK7fJj6VTRtPoEe+Xm+/kENZPAZlD
         lxvOXANpupfhYvso2Lk/9GnOnkwNNQ7H20TgcTcM6ZuPF54CZKBmh3Hk6W2Z/Dt8wc/W
         nT5JLhzpjZ94Sn6eZiA5mpN+6/sn1iuRz98jFJDZq939fCxaUVUXoQpcXBEZJhNiADK0
         Bd9MsCowlFNLXSKT8/mafv8xrmf/f2u67fIkZH1YkNb90veepk7fMHzmQizcwkF9yFX2
         hnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=igVnvRwqBjGTrhFAx4eKl8pHRnthmjQTJ0B2kGBDB8w=;
        b=jIv+A7RDHYdvptIEoMdw+PVeVFes/K4vUWKM2hgpkTaCWAGTpxagFrpv2AExQK0va3
         Ye6iD3P/XHi7Xy1YACaOGUx9WeXdIBORNm64/1hTtMuu1YyqkqSfk29wommayLB/CWv/
         tqtTFrMv66pv68rCa58q/FkFVFU1ARgdUFqKFBNkEHpP8w/68ZSW/E+92RSReTI3hitL
         HCM8cjLzKk7/7bH7INiqKWTTAVZAnbqYicL0kjP/LGzgljWMaMgUA/b1BtGhrEVhHX94
         W3ZrVmNBlCsESsrWtUFKYsVt8BhWiLNHVSuL6wpdZ2Eh6gGd8c6408YyhyxKGKroY7qP
         B5Zw==
X-Gm-Message-State: AOAM532aig5Y2R0XXlxpiV6E+302l5OuVS3j8fUWgSiByNbdLfBeq1Wq
        g1KqejjjQvyCW4dttM/qid4uDPYJlLB3aw==
X-Google-Smtp-Source: ABdhPJyv2kMluE4tcINMqHv+9z2N4xkZPR3mmMKNyswXb6x0oeufwlD9z4V8GvPR07DCGNcXMh69SA==
X-Received: by 2002:a05:6402:51d0:: with SMTP id r16mr15561740edd.353.1634896661581;
        Fri, 22 Oct 2021 02:57:41 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bw25sm3593450ejb.20.2021.10.22.02.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 02:57:41 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mdrIy-001997-G5;
        Fri, 22 Oct 2021 11:57:40 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, peff@peff.net
Subject: Re: [PATCH 00/11] midx: clean up t5319 under 'SANITIZE=leak'
Date:   Fri, 22 Oct 2021 10:23:26 +0200
References: <cover.1634787555.git.me@ttaylorr.com>
 <211021.861r4emv7b.gmgdl@evledraar.gmail.com>
 <YXJAfICQN8s5Gm7s@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <YXJAfICQN8s5Gm7s@nand.local>
Message-ID: <211022.86sfwtl6uj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 22 2021, Taylor Blau wrote:

> On Thu, Oct 21, 2021 at 01:50:55PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>
>> On Wed, Oct 20 2021, Taylor Blau wrote:
>>
>> > I tried to separate these out based on their respective areas. The las=
t 10% are
>> > all from leaking memory in the rev_info structure, which I punted on f=
or now by
>> > just UNLEAK()-ing it. That's all done in the last patch. If we choose =
to take
>> > that last patch, then t5319 passes even under SANITIZE=3Dleak builds. =
But it's a
>> > little gross, so I'm happy to leave it out if others would prefer.
>>
>> I'll defer to you, but I've got a mild preference for keeping it out. An
>> upcoming series of patches I'm submitting (I'm waiting on the current
>> leak fixes to land) will fix most of those rev_info leaks. So not having
>> UNLEAK() markings in-flight makes things a bit easier to manage.
>
> If you don't mind, I think keeping this in (as a way to verify that we
> really did make t5319 leak-free) may be good for reviewers. When you
> clean these areas up, you'll have to remember to remove those UNLEAK()s,
> but hopefully they produce conflicts with your in-flight work that serve
> as not-too-annoying reminders.
>
> I would certainly rather not have to UNLEAK() those at all, so I am very
> excited to see a series from you which handles freeing these resources
> appropriately. It was just too big a bite for me to chew off when
> preparing this quick series.

Having looked at this a bit more carefully I've upgraded that a bit from
"I'll defer to you" to strongly objecting to this specific approach (but
read to the end, I think you can have your cake and eat it too).

I just glanced at this series in my previous pass-over, and evidently
didn't read the CL to the end. I thought based on the commit subject
that it was just a change to some midx code impacting t5319.

But it's a bigger change across the whole test suite than that.

If you run:

    rm .prove; GIT_SKIP_TESTS=3Dt0027 prove -j8 --state=3Dsave t[0-9]*.sh :=
: --immediate

Without this patch (t0027 will take forever), and then:

    GIT_SKIP_TESTS=3Dt0027 prove -j8 --state=3Dfailed

You'll see that (I use GNU screen's logging feature to get the output)
we made these tests pass, not just your t5319:
=20=20=20=20
    $ grep -w ok screenlog.11=20
    t0056-git-C.sh .................................... ok=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
    t1060-object-corruption.sh ........................ ok=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
    t4212-log-corrupt.sh .............................. ok=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
    t4207-log-decoration-colors.sh .................... ok=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
    t5313-pack-bounds-checks.sh ....................... ok=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
    t5506-remote-groups.sh ............................ ok=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
    t5513-fetch-track.sh .............................. ok=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
    t5319-multi-pack-index.sh ......................... ok=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
    t5532-fetch-proxy.sh .............................. ok=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
    t5900-repo-selection.sh ........................... ok=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
    t6011-rev-list-with-bad-commit.sh ................. ok=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
    t6100-rev-list-in-order.sh ........................ ok=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
    t6114-keep-packs.sh ............................... ok=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
    t6131-pathspec-icase.sh ........................... ok=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
    t6003-rev-list-topo-order.sh ...................... ok=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
    t7702-repack-cyclic-alternate.sh .................. ok=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
    t9108-git-svn-glob.sh ............................. ok=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
    t9109-git-svn-multi-glob.sh ....................... ok=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
    t9127-git-svn-partial-rebuild.sh .................. ok=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
    t9133-git-svn-nested-git-repo.sh .................. ok=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
    t9168-git-svn-partially-globbed-names.sh .......... ok=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20

I've got subsequent patches on top of what's now in-flight that fix
those bigger leaks incrementally, and as part of that add
"TEST_PASSES_SANITIZE_LEAK=3Dtrue" to /all/ the relevant passing
tests.

I.e. there isn't a 1=3D1 correspondance between all current passing tests
and "TEST_PASSES_SANITIZE_LEAK=3Dtrue" markings (some are still left
unmarked). But there has been a 1=3D1 mapping between freshly pasing tests
as a result of leak fixes and tests that get that
"TEST_PASSES_SANITIZE_LEAK=3Dtrue" marking.

I think it helps a lot to review those patches & assess their impact if
code changes can be paired with relevant test suite changes, which isn't
the case if we've got simultaneous UNLEAK() markings for major leaks
in-flight.

So the practical effect of that is that I'll need to rebase all that,
change my testing setup to test those one-at-at-time with "git rebase -i
--exec" before submission (which I do anyway), but now with some
selective revert of an earlier UNLEAK() to assert that I'm still fixing
the things I expected.

Then either drop the parts of the commit messages that say "this fixes
leak XYZ, making tests A, B, C pass" to omit any mention of "A, B, C",
or reword it for the earlier now-landed UNLEAK() markings.

These are also just the fully passing tests I ran as a one-off for this
E-Mail. For those I do more exhaustive runs where I'll e.g. spot if a
test goes from N failing to N-X, and note it if that gets us much closer
to 0.

But on the "cake and eat it too" front I also realize that it sucks to
not be able to mark tests you made leak-free as passing just because
I've got some larger more general leak fixes planned, and even if none
of your code leaks, it might just be "git log" or whatever.

But we can just use LSAN_OPTIONS with a suppressions file for that. This
diff below (assume my SOB yadayada) makes your tests pass if I eject the
11/11 and replace that with this:

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index a3c72b68f7c..3f6d716f825 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -1,8 +1,23 @@
 #!/bin/sh
=20
 test_description=3D'multi-pack-indexes'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
+test_expect_success SANITIZE_LEAK 'setup LSAN whitelisting' '
+	suppressions=3D".git/lsan-suppressions.txt" &&=09=20=20=20=20
+	cat >"$suppressions" <<-\EOF &&
+	leak:add_rev_cmdline
+	leak:cmd_log_init_finish
+	leak:prep_parse_options
+	leak:prepare_revision_walk
+	leak:strdup
+	EOF
+	LSAN_OPTIONS=3D"$LSAN_OPTIONS:suppressions=3D\"$PWD/$suppressions\"" &&
+	export LSAN_OPTIONS
+'
+
 GIT_TEST_MULTI_PACK_INDEX=3D0
 objdir=3D.git/objects
=20
I think that would be a much better approach here, and would really
prefer if we went for some version of that if you really want to test
these right away with the linux-leaks job.

I think the better thing to do here is to just leave it, i.e. we've got
tons of these tests that don't leak themselves, but leak due to "git
log" or whatever already, but anyway, if what you're doing in
t5319-multi-pack-index.sh doesn't cause much more work for me as noted
above I really don't mind.

If you want to pick that approach up and run with it I think it would
probably make sense to factor that suggested test_expect_success out
into a function in test-lib-functions.sh or whatever, and call it as
e.g.:
=20=20=20=20
    TEST_PASSES_SANITIZE_LEAK=3Dtrue
     . ./test-lib.sh
    declare_known_leaks <<-\EOF
    add_rev_cmdline
    [...]
    EOF

Then pipe it through sed 's/^/leak:/' and have it set LSAN_OPTIONS for
you.

Doing it that way would be less boilerplate for each test that wants it,
and is also more likely to work with other non-LSAN leak appoaches,
i.e. as long as something can take a list of lines matching stack traces
we can feed that to that leak checker's idea of a whitelist.
