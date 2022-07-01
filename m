Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4C8C433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 02:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbiGAC55 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 22:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiGAC54 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 22:57:56 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C495C955
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 19:57:53 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id c13so1244867eds.10
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 19:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bCLHF/tW5d/3U7s0B6zbzwgmLeiUfVxQrgEmW9ea+TI=;
        b=LGSG/+CQg5+9XU8RniUBBBwIFvog45tzX/aVgCTq/fPAnNB4D/TYR4tBiWsSEn52Il
         zSbhD7F/Hep08LMt0xf0LrapW6pDDcwpxtJe6Nkma1MNDlV4ppUrneHNMMM1LuQ6NwRL
         n1qgTKyjTttTVPXX5+5ZwZ3rBjW5GYDcJnLNFUOydyemxG+ax70e8otBZxOAS2pWpqrD
         2M6+tGnVGSydiyP/OUCrZ1KXqf2K7jjfmKKGGVnTX2UNNMfB5JwvhKEoPvi+qCrEk26Q
         doX5tOIOX2R2LLx5SsdFhmRn8fS0qjp2ljLLiFa8xkRtD0lS6A+NSiBaX+6H+jeaFy2y
         i2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bCLHF/tW5d/3U7s0B6zbzwgmLeiUfVxQrgEmW9ea+TI=;
        b=7KDjpdpV3XCigkgCwHdJyObhsd0jwK4TRuDQvWDUv4nHGwikyhq+kz556oGgRdEzwo
         /3EFlougmDio2tQiaa1Kb8RPVWG+psRaOwWg8CLenLckXLwJTuqkN/CTH4ud4PayrzPj
         NyZ86XVV3HdpPK0qC0ySDr1F/qgSPygBVzu6L8HyV0NSgZwpCpDD30ZItop0MR1tHsPW
         koaLCKRzGfyLyle51o/V2x8BBiKiZy/7RdAFFjiFI5V2f4c2IlvIEQ1YMDpba/p0atps
         8pW7k+0RaK9ZaWWc3g9Ocweb3Cr1ZKEtkDs91M3xd/o1MBOPfjF9U4gZdOQqalhLhfdb
         PNhg==
X-Gm-Message-State: AJIora9rJRO5O0kalmJRclX7ZKPH6/pENV7dPGQy8IgwxnhzsVBBT3jz
        DBRTFoUshq0qMAmvrkodb4leqEQ8349pKZrXvmY=
X-Google-Smtp-Source: AGRyM1tJtb8wpiCsRjYj4VuzCQZWNg9ZgkiRq4aosaAIM2mW4t0AkfO0444hd1lveXCC87jYJXcwSBgq7IEVMYZxcp8=
X-Received: by 2002:a05:6402:4242:b0:437:7771:982c with SMTP id
 g2-20020a056402424200b004377771982cmr16340967edb.146.1656644272473; Thu, 30
 Jun 2022 19:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1268.git.1655871651.gitgitgadget@gmail.com>
 <pull.1268.v2.git.1656572225.gitgitgadget@gmail.com> <bf4c03d01d5730503eb710e92a80136d5caa981a.1656572225.git.gitgitgadget@gmail.com>
 <220630.86tu82e9b8.gmgdl@evledraar.gmail.com>
In-Reply-To: <220630.86tu82e9b8.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 30 Jun 2022 19:57:41 -0700
Message-ID: <CABPp-BEcojvfeuhp7rSi-O+9oEu4KpwPDwbKS-MiD1qCKde-CA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] t6423: add tests of dual directory rename plus
 add/add conflict
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 30, 2022 at 3:26 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Thu, Jun 30 2022, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
>
> > +test_setup_12l () {
> > +     test_create_repo 12l_$1 &&
>
> Can & should just be "git init", see f0d4d398e28 (test-lib: split up and
> deprecate test_create_repo(), 2021-05-10).

I've switched to "git init" and even encouraged others to do the same
in other test scripts, but since literally every other test in this
file uses test_create_repo, I think they should all be converted at
once and just be consistent here.  But, so we can stop having this
conversation, after this series lands, I'll send one in to update the
various merge testfiles that make heavy use of test_create_repo and
convert them over.

> > +     (
> > +             cd 12l_$1 &&
> > +
> > +             mkdir -p sub1 sub2
>
> The "-p" here isn't needed, you're not creating recursive directories.

Indeed; will fix.

> > +             git ls-files -s >out &&
> > +             test_line_count =3D 5 out &&
>
> Can't this just use test_stdout_line_count? Except...

Ooh, new function from late last year that I was unaware of.  Yeah,
I'm happy to start using it.

> > +
> > +             git rev-parse >actual \
> > +                     :0:sub3/file :0:sub3/newfile :0:sub3/sub2/other \
> > +                     :2:sub1/sub2/new_add_add_file \
> > +                     :3:sub1/sub2/new_add_add_file &&
> > +             git rev-parse >expect \
> > +                     O:sub1/file  B:sub1/newfile O:sub2/other \
> > +                     A:sub2/new_add_add_file \
> > +                     B:sub1/sub2/new_add_add_file &&
> > +             test_cmp expect actual &&
> > +
> > +             git ls-files -o >actual &&
> > +             test_write_lines actual expect out >expect &&
> > +             test_cmp expect actual
>
> This test seems a bit odd, here we're just checking that we've created
> scratch files for the internal use of our test, why is it important that
> we have an "out" file, when the only reason we have it is because we
> needed it for checking the "ls-files" line count above?

Nah, you've misunderstood the purpose of the check.  It isn't "make
sure that these untracked files are present among whatever else might
also be present", it's "make sure the merge step did not introduce
*any* untracked files" (something the recursive backend periodically
did, and they weren't cruft untracked files but stored actual merge
results).  There wasn't a nice easy check for that, the closest was to
translate the requirement to "make sure the only untracked files are
the ones explicitly added by this test script", which is the check you
see here.  I don't actually care about "actual", "expect", or "out", I
just care that there aren't any _other_ untracked files.
