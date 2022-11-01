Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68283FA3741
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 01:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiKABOi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 21:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiKABOh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 21:14:37 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916D0167CB
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 18:14:36 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id n191so11198690iod.13
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 18:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N16lZ9d0o1mW7lsxtI25GF7hb5DRPbwLVRZXVptZbUE=;
        b=XQpOH55NJQAUOp3txEQkpGkdjIAYBj3wEC/VPAt31R2gK+P2pO0Zo+IiBw5jjlAHE8
         JDUTciArC0+12eKOMaa9qz2WGRzxFjHeIwFNymFLrW3SfhPQQKysRYRpTAGJzUhYVlqT
         ynAJJvPvCCaOa213xVGCrQacsuqqA+useydrAFHr7weS+3ymtzynESSWWb4fcHtna0XZ
         CHXAWBHn93MxStuk2wy4NCO++5O55+/EgbHf1xKhNAYbjOEtVBA5NV88UR8NbXx8SuQE
         aMVDzLwe1/QvOjuGiuNGAyOqQv3HbAz79KOrSAZZkSMLnG15VBJjAIEqZpOuw0SWwwzp
         lLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N16lZ9d0o1mW7lsxtI25GF7hb5DRPbwLVRZXVptZbUE=;
        b=tEmcyPqSXlZEziM2087MqYpRv1wwaWn+d3IssL5DQruXmo+JbDraaQLUytIQur8/Fp
         xgdRJ8euR78VXYvT3ENDfTwqdCZ6LxYgaHarmuy5Zsy+GJ+OA2gePo9EFglhOKk3G5I8
         Z6LJfPab8d5pX32vDkRGuwUhPkkuXTAfHhFJTrBHbvQzyKbFvF0ITMsmIv22KjOAWy7R
         apy6zqsm7cvLvXqoGPzKoRbeo2fcZwmmRcfrq74AOE+89zX2jFV5TA6ADqAybbkJkzyN
         9DzagqdpNfoXrnzNlKTwLYxpVaGuINv27qubfh7dGSB//hzxxr6YEQKZDfhwzLGGFnPb
         996w==
X-Gm-Message-State: ACrzQf2VIqiubhX/d+eyxp/PfFT03O5H578aPupqMIOhtI0nubai6F39
        w9dv99WU4+bnCLLmx0EMOqhhNuAbMnHnDoKu
X-Google-Smtp-Source: AMsMyM7tvnazsNKOC3wXcKrXXMRwk4LjZIZxS9B0b641hcltJvmSnA7Fy/9pDan8u5m+7rhVGxHWCg==
X-Received: by 2002:a05:6638:91:b0:363:cee0:84c with SMTP id v17-20020a056638009100b00363cee0084cmr9638554jao.52.1667265275969;
        Mon, 31 Oct 2022 18:14:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r30-20020a056602235e00b006bb7764890dsm3368140iot.45.2022.10.31.18.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 18:14:35 -0700 (PDT)
Date:   Mon, 31 Oct 2022 21:14:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Debra Obondo via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Debra Obondo <debraobondo@gmail.com>
Subject: Re: [PATCH] t7001-mv.sh:modernizing test script using function
Message-ID: <Y2By+vbn7dPrk+01@nand.local>
References: <pull.1372.git.git.1667150441883.gitgitgadget@gmail.com>
 <CAN0heSpvgtLG5o9i_cSbn0zHfNN+GJFYY6oBXmHUs8FniW5oOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSpvgtLG5o9i_cSbn0zHfNN+GJFYY6oBXmHUs8FniW5oOw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 31, 2022 at 07:04:20PM +0100, Martin Ågren wrote:
> Hi Debra,
>
> On Sun, 30 Oct 2022 at 18:35, Debra Obondo via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Debra Obondo <debraobondo@gmail.com>
> >
> > Test script to verify the presence/absence of files, paths, directories,
> > symlinks and other features in 'git mv' command are using the command
> > format:
> >
> > 'test (-e|f|d|h|...)'
> >
> > Replace them with helper functions of format:
> >
> > 'test_path_is_*'
>
> This is a good idea.
>
> The subject of this patch could use a space after the colon. You could
> also write "modernize" to give an order to the code base. So something
> like
>
>   t7001-mv.sh: modernize test script using function
>
> perhaps. "Function" is a bit vague, perhaps.
>
> I wanted to comment on this:
>
> >  test_expect_success 'mv --dry-run does not move file' '
> >         git mv -n path0/COPYING MOVED &&
> > -       test -f path0/COPYING &&
> > -       test ! -f MOVED
> > +       test_path_is_file path0/COPYING &&
> > +       ! test_path_is_file MOVED
> >  '
>
> It is my understanding that we prefer to only use such a helper when we
> really expect the file to exist. If the path is not a file, this helper
> prints a helpful message before returning with an error.
>
> Here, this means we will emit this 'helpful'
>
>   File MOVED doesn't exist
>
> on every test run, when really everything is as it should. And if the
> file is actually there, i.e., we have a bug, we'll emit nothing -- but
> that is precisely when we would want some diagnostics such as
>
>   Path exists:
>   ... MOVED ...
>
> to show us that the file actually exists, contrary to the test's
> expectations.
>
> Such output is precisely what `test_path_is_missing` would give us. :-)
>
> My gut feeling is that where this patch adds "! test_path_foo", it
> should use "test_path_bar" instead, for various values of "foo" and
> "bar". What do you think about that?

All good suggestions, thanks. I'll hold this back while we wait for a
rerolled version.

Thanks,
Taylor
