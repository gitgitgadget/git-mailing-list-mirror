Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F299C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiHBPfE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiHBPfD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:35:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B930C245
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659454498;
        bh=oEDreISciVRGWbPCK7UiuMBddq4SjxB5xfCCUaLV+nk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KBXu+dLedpuafhzblMLFCeDWAs71u9KN1MRFDuQHo3Ve1bJsj5bLNi6XovJ6Jpl8f
         nzV924Ok8G5j/cgifJNm+qXpbXYX+qqzXeUw2PfTtusAZD1EnOFH+vJGmeojQ7TV6I
         N8kg5TjCj5WXLm8lOX9usaMukLVQxbSzECWhCOjE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.244.62] ([89.1.215.231]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mplbx-1ne7ih0e4b-00qAw4; Tue, 02
 Aug 2022 17:34:58 +0200
Date:   Tue, 2 Aug 2022 17:35:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v5 3/6] pack-bitmap-write: learn pack.writeBitmapLookupTable
 and add tests
In-Reply-To: <CAPOJW5xBUaAJtOvrefwbXv_WDTLa=6PTL5kEoOpRQfqqFAx3oA@mail.gmail.com>
Message-ID: <6s4n3600-q5p7-92sr-4206-non3s8rr3n46@tzk.qr>
References: <pull.1266.v4.git.1658325913.gitgitgadget@gmail.com> <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com> <59b465e5a7817c145172f25e73ad807c7ba67e84.1658342304.git.gitgitgadget@gmail.com> <p3r70610-8n52-s8q0-n641-onp4ps01330n@tzk.qr>
 <CAPOJW5xBUaAJtOvrefwbXv_WDTLa=6PTL5kEoOpRQfqqFAx3oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mqKgzCiGSh2zngdJTupOte2C2Mrcy/p+ieXKF1dtB7szSbBt81R
 dkbCLIxzIXMa4Ub+KFgctm9SL4odsshSXcrOIAyCqIHmipAqpfJ+YvW6Rmtw1/HFKM7kIbh
 4onayP3ssoJkAa0aBL3PMRxD4qft2ir5Tg2vzQkMSFxcqaLA71GuZhuFScyorVk+m+AHbcq
 e3urqVfO9fMepUtQlu1JA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SndGUAKJctY=:LJrOwOyaggwQ5mSLIOqBm3
 uuGi1hHFfmeY/RNAMLOrxmM/thkQRrlkXxA+4ye5ujVeMH858foLvmZznUjG1FNAqsgglcQY/
 1Tl+7YIzoWkfVrXFVP++vKVlOul0SI9vWUXt0dxj++EcC02akrs7gb5WJvcBJncuwAZhUcuxE
 eVKXqCFZoIA19fcJcOXZlp2VVeBGfHTw/mbaDQttIceShD7QIDOjr4lJxW7KLGR2sU0xWvxA5
 8T3LsIZqGC4yAfsK9IghK70M6/s/sHmAQJ2d5Ia7K08GgQRn6aB/LO9cSm1AZMQF9z1Cnb8+M
 mvhRZQtdF53qOg/Zcj6aUqNGHxFwWCpcwOhll4LaEmfOmvBjROxAzHaXHa8O/lAGE0ypwq0vE
 PDYgSVR+UqKHjuGPNrLvHoQyeRQ692BL3TLPK0QpJaOuD8kc0CFCZSPmLtoY9vDd+N67g1DGt
 tBUQtnZUFCu05yLEV89+IzPBZ5MuUJIrn1kE6iRbgwd6B68lU2AXa+8ygj/VgjgJfAW6/unj/
 WvQi5cNvBA2+bwxkp0+WHCoVIcTq9Ggi3Pqt6HAs4AY7A4MPF9camVvl1XsHwA4Jw2wT0WomA
 N1i4xLDRRSDqXaznma9zoWonRwjoCtXK/rzF0b2Y4UxFNCu9ZcZbV1XnIkyC0A1H/B8pDhGen
 YbXLj2MBL7dUTgc04xfelBBECiajVLw2bF+IMfY29oUG312jjs3DYtzqYhMoB1LpGcCUOf8Vx
 yueDZ3ipB01OV9z+nSMNxD0AimW1j9h1Kg9b0zDWZinstJdQjDzVetXuyewuCyGnolta6R5QH
 I5eIB4gG1bE+5DazkE7sRToWl3KTwS2A9879RuMJpAvzQcNxo5v4+ACClvduOrIjWuDJlFavT
 HbBXoaHoRPT+7M830YvcR+UQOmTvNWROKGqR72cVApAVgLCuv+AQBIAUBE3sfw0iWDbBGWCIH
 p2wg4791XNOkyO0aRj0zsPeiTT6cGmFj6aPnkoCex7Ib1CNso7kyyD1cqYhPGj91HWrbq10O2
 OhgOs8LD20aezknDeAFXnsbqQVIQJfcZ5pCIdJ6JGiEIoz6xdSg/y8kmcKo0xEm4WhCetF1kJ
 8Qk/6WjVEMZWup6Ks5Aoo8JOVMkJ40zG+2qBMb3pqLp2CDY2rulrBXg0g==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Abhradeep,

On Tue, 2 Aug 2022, Abhradeep Chakraborty wrote:

> On Fri, Jul 29, 2022 at 12:52 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > That's quite a large a change, and unfortunately I pinpointed a flake =
to
> > this patch when running with GIT_TEST_DEFAULT_HASH=3Dsha256. The sympt=
om is
> > this:
>
> Hi Dscho, sorry for this long delay in response. I was quite busy for
> 3-4 days in hostel room shifting. So, I couldn't work properly during
> this time.
>
> > -- snip --
> > [...]
> > + diff -u expect.normalized actual.normalized
> > + rm -f expect.normalized actual.normalized
> > ok 317 - enumerate --objects (full bitmap, other)
> >
> > expecting success of 5326.318 'bitmap --objects handles non-commit obj=
ects (full bitmap, other)':
> >                 git rev-list --objects --use-bitmap-index $branch tagg=
ed-blob >actual &&
> >                 grep $blob actual
> >
> > + git rev-list --objects --use-bitmap-index other tagged-blob
> > + grep bff4ed5e839bd73e821f78b45a7fa34208aa85596535ec8e9ac5eab477ca6f8=
1 actual
> > bff4ed5e839bd73e821f78b45a7fa34208aa85596535ec8e9ac5eab477ca6f81
> > ok 318 - bitmap --objects handles non-commit objects (full bitmap, oth=
er)
> >
> > expecting success of 5326.319 'clone from bitmapped repository':
> >                 rm -fr clone.git &&
> >                 git clone --no-local --bare . clone.git &&
> >                 git rev-parse HEAD >expect &&
> >                 git --git-dir=3Dclone.git rev-parse HEAD >actual &&
> >                 test_cmp expect actual
> >
> > + rm -fr clone.git
> > + git clone --no-local --bare . clone.git
> > Cloning into bare repository 'clone.git'...
> > remote: Enumerating objects: 756, done.
> > remote: Counting objects: 100% (754/754), done.
> > remote: Compressing objects: 100% (281/281), done.
> > remote: Total 756 (delta 245), reused 740 (delta 234), pack-reused 2
> > Receiving objects: 100% (756/756), 77.50 KiB | 8.61 MiB/s, done.
> > fatal: REF_DELTA at offset 221 already resolved (duplicate base 4d3320=
72f161629ffe4652ecd3ce377ef88447bec73f05ab0f3515f98bd061cf?)
> > fatal: fetch-pack: invalid index-pack output
> > error: last command exited with $?=3D128
> > not ok 319 - clone from bitmapped repository
> > #
> > #                       rm -fr clone.git &&
> > #                       git clone --no-local --bare . clone.git &&
> > #                       git rev-parse HEAD >expect &&
> > #                       git --git-dir=3Dclone.git rev-parse HEAD >actu=
al &&
> > #                       test_cmp expect actual
> > #
> > 1..319
> > -- snap --
> >
> > On a hunch, I ran this through valgrind (took a while) but it did not
> > point out the problem.
> >
> > Again, this is only with SHA-256 (and somewhat flaky), it passes every
> > time with SHA-1. Maybe you can reproduce on your side with that
> > information?
>
> Yeah, I can reproduce it on my side.

Good.

> But I am sure it is not related to the lookup table implementation code.
> Because when I swap the order of calling  `test_midx_bitmap_cases
> "pack.writeBitmapLookupTable"` and `test_midx_bitmap_cases` (in
> t5326-multi-pack-bitmaps.sh), in that case, the error is being generated
> in  `test_midx_bitmap_cases` call. Generally speaking, the error is
> always being generated in the second call.

Indeed, it probably has something to do with the test tick (which gives
rise to the author/committer date of the commits that are generated, and
hence with the SHA order of said commits).

With this patch:

=2D- snip --
diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 3b206adcee6..a340f005b89 100755
=2D-- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -347,7 +347,11 @@ test_midx_bitmap_cases () {
 	'
 }

-test_midx_bitmap_cases
+# test_midx_bitmap_cases
+
+GIT_COMMITTER_DATE=3D'1112928553 -0700'
+GIT_AUTHOR_DATE=3D'1112928553 -0700'
+test_tick=3D'1112928553'

 test_midx_bitmap_cases "pack.writeBitmapLookupTable"

=2D- snap --

I can reproduce it quicker via

	GIT_TEST_DEFAULT_HASH=3Dsha256 sh t5326-*.sh --run=3D1,71,91,92,93,124,14=
5

Without setting those variables, I cannot skip the first
`test_midx_bitmap_cases` invocation _and_ reproduce the failure.

For shiggles, I now also ran this command-line after deleting the
`"pack.writeBitmapLookupTable"` argument, and it fails in the exact same
way. So you're correct: this has nothing to do with the
`writeBitmapLookupTable` code, it's just a failure that is triggered by
those patches.

> For now, my understanding says that there is something fishy in the
> test script.

I do not actually think so. I believe that this just points out a bug in
the MIDX bitmap code.

> I am still not able to figure out the problem here. But let me further
> investigate.
>
> If anyone has some idea about what could be the culprit, I will be
> very happy to know.

So I noticed that the test will pass every 4th to 5th time over here,
which means that it is a racy condition that is the culprit.

I dug a bit deeper and reduced the reproducer even further, by running
this command with a trash directory just after above test script
invocation failed:

	bin-wrappers/git -C t/trash\ directory.t5326-multi-pack-bitmaps/ \
		-c pack.threads=3D1 pack-objects --revs --thin --stdout \
		--progress --delta-base-offset </tmp/a5 |
	bin-wrappers/git -C t/trash\ directory.t5326-multi-pack-bitmaps/ \
		-c pack.threads=3D1 index-pack --stdin -v --fix-thin \
		'--keep=3Dfetch-pack 12345 on labtop' \
		--check-self-contained-and-connected

where `/tmp/a5` contains these lines:

=2D- snip --
0ae5a358dcea86d81c0903aaec1e21857688cdb36c7fd89b04bd293fb2cceaa6
67df8a01ac84cf5f028855c48384eac3336bb02a52603bac285c4b31d66b3ab5
098a57f7753320c8a37cf0cb84526a9e50439d9f70fb673c91436a5283a7efe8
=2D-not
=2D- snap --

This allowed me to instrument the code with _many_ debug printf statements
(I actually use `error("%s:d: ...", __FILE__, __LINE__, ...)` calls) to
dive deeper into the weeds.

One relatively obvious difference I can see is that when the code reaches
builtin/pack-objects.c:1198, in the passing case after writing the reused
pack we're at offset 900 in the written pack file, but in the failing case
we're at offset 269.

Another difference I first saw was that the mtime of
`.git/objects/pack/multi-pack-index` was identical to the mtime of
`.git/objects/pack/multi-pack-index-2ec3c30357d2fff78db9b36cc749b393087e98=
9bffdd278771d6f62089406061.bitmap`
in the failing case, while the mtimes of the corresponding files were
different in the passing case.

But in another failing run, the mtimes were also non-identical. Meaning:
the race cannot be caused by identical or non-identical timestamps there.

One consistent difference, however, was the SHA-256 in that `.bitmap` file
name: In the failing case it was always
2ec3c30357d2fff78db9b36cc749b393087e989bffdd278771d6f62089406061, while in
the succeeding case it was always
0c275657a915eeff1f2a1c17e5ded43cc3b232b0e178923e44fc15c1970516fb.

My suspicion is that this `.bitmap` file is written out in an earlier test
case, and is already incorrect at that stage. Maybe it should have been
updated, but isn't, and the result is an incorrectly-reused partial pack
file.

I also noticed that deleting the `multi-pack-index-*.bitmap` file in the
failing case will "fix" the `pack-objects | index-pack` command I showed
above.

Hopefully this will help you dig in further because even if the bug is not
in your code, it needs to be fixed. And I suspect that it is a bug in the
code we already have in the main branch, so that fix is really, really
needed, now.

Since you are very familiar with the details of bitmaps now, I would like
to encourage you to work on some kind of validator/inspector, e.g.
something along the lines of a `test-tool midx-bitmap dump` (and later
`... verify`) that would help future you (and future me) investigate
similar breakages. Ideally, that tool will not only parse the `.bitmap`
file but immediately print out everything in a human-readable form.

The reason I suggest this: I got a bit tired of staring at the output of
`hexdump -C` and comparing it to the documentation in
https://git-scm.com/docs/pack-format, so I had to stop after looking too
long at one broken pack file (i.e. the output of the `pack-objects`
command I showed above, where already the first entry seems to have an
infinite delta chain that pretends that
4d332072f161629ffe4652ecd3ce377ef88447bec73f05ab0f3515f98bd061cf has
itself as delta base) before I even could analyze the MIDX bitmap files.

The proposed tool would make analyzing MIDX bitmaps substantially more
fun, and would also help stave off future breakages if it was taught some
`verify` mode that would essentially automate what right now has to be
done manually: to verify that the MIDX bitmap file contents are sound and
consistent with the contents of the pack files.

Obviously, this `verify` command should be called in strategic places of
t5326.

Thanks,
Dscho
