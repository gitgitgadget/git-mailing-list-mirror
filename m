Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DBCC433F5
	for <git@archiver.kernel.org>; Sun,  2 Oct 2022 01:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiJBBaB convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 1 Oct 2022 21:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiJBB34 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Oct 2022 21:29:56 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA22112ACA
        for <git@vger.kernel.org>; Sat,  1 Oct 2022 18:29:54 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-353fbfa727cso77661417b3.4
        for <git@vger.kernel.org>; Sat, 01 Oct 2022 18:29:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=M1xchUUpaCdA+mAuaN/SVAYbhXZHzfTHdxlHKdf3wcs=;
        b=6sF3Scsy0aSPzyqle1sy1KYwOY7oSOMIdUR8CY4RgZ9dUSDYH11vRWVRsgPPJnMoeZ
         mc9NLS/1L1hb8z6CKVT54JPdLxbKGIYOqHZ+zXxoXprJhMB7e10g1FAbGUWwdsboIrRw
         1OTdCzMzlCoIfUmaCLuuyJ6GtX7aWhVo9LNsTA3kLy39IX8Eu//sHrq9S1ee4UnEZA9o
         cuX/oc1YQ+LT2IE3FHBI2grlwEFvmtyeo8/Q75YnM1lcLlYxeXkC770/xY3iyuE6szWN
         t+vNj6zEEGGhs0b8Yd0qAO8XruVWAN1h8ERhaZW7znwhky8Plxih5PjYqiAO/uhoba6D
         R4qA==
X-Gm-Message-State: ACrzQf2Wg5WihnHGhRmnNTY+gbqnE6W4mZ3PeknBxibHAmymbDH+z/Iq
        YqPt7tqT4LicH9um1sX124aRR/mUWUhoWvCZeKw=
X-Google-Smtp-Source: AMsMyM7okMWPvWDQ3YRlYm44riUD1WqqWYYUzTTHcjQivQf+iqPUe4G+tMckb1d5CXxjB0o9nylbdSa0e9dIKF7wI80=
X-Received: by 2002:a81:4848:0:b0:355:3b4e:412a with SMTP id
 v69-20020a814848000000b003553b4e412amr13082062ywa.494.1664674193900; Sat, 01
 Oct 2022 18:29:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
 <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com> <patch-v3-36.36-b56113dd620-20220930T180415Z-avarab@gmail.com>
In-Reply-To: <patch-v3-36.36-b56113dd620-20220930T180415Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 1 Oct 2022 21:29:43 -0400
Message-ID: <CAPig+cThkXgkfgeBe5g3f4Mw2HFXeX0M5W4p9NbF7-G_cGB40Q@mail.gmail.com>
Subject: Re: [PATCH v3 36/36] tests: assert consistent whitespace in -h output
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>, Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 30, 2022 at 2:10 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Add a test for the *.txt and *.c output assertions which asserts that
> for "-h" lines that aren't the "usage: " or " or: " lines they start
> with the same amount of whitespace. This ensures that we won't have
> buggy output like:
>
>    [...]
>    or: git tag [-n[<num>]]
>                [...]
>        [--create-reflog] [...]
>
> Which should instead be like this instead, i.e. the options lines
> should be aligned:

Too many "instead"s.

>    [...]
>    or: git tag [-n[<num>]]
>                [...]
>                [--create-reflog] [...]
>
> It would be better to be able to use "test_cmp" here, i.e. to
> construct the output we expect, and compare it against the actual
> output.
>
> For most built-in commands this would be rather straightforward. In
> "t0450-txt-doc-vs-help.sh" we already compute the whitespace that a
> "git-$builtin" needs, and strip away "usage: " or " or: " from the
> start of lines. The problem is:
>
>  * For commands that implement subcommands, such as "git bundle", we
>    don't know whether e.g. "git bundle create" is the subcommand
>    "create", or the argument "create" to "bundle" for the purposes of
>    alignment.
>
>    We *do* have that information from the *.txt version, since the
>    part within the ''-quotes should be the command & subcommand, but
>    that isn't consistent (e.g. see "git bundle" and "git
>    commit-graph", only the latter is correct), and parsing that out
>    would be non-trivial.
>
>  * If we were to make this stricter we have various
>    non-parse_options() users (e.g. "git diff-tree") that don't have the
>    nicely aligned output which we've had since
>    4631cfc20bd (parse-options: properly align continued usage output,
>    2021-09-21).
>
> So rather than make perfect the enemy of the good let's assert that
> for those lines that are indented they should all use the same
> indentation.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
