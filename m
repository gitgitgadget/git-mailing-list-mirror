Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED27C433EF
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 20:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378797AbiFPUtZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 16:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378892AbiFPUsj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 16:48:39 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCC95EDED
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 13:48:30 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id x190so1157241vkc.9
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 13:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RK6wC1XHi8PpNHal2ZyPx9YXJfSQ4NcJH/SuRPXq2AU=;
        b=PjLT8Zft0PkhykzrAMguszHaXx5H/8uNwVVru2vpBpAJiOC0M7vecesLPIjnkTRX7r
         do8ZHTFjSeobibe5Exp/46/RDrI73j3MhqxqkkoYufRc5f9P/TQmBd39kBRIJ5mv6rxr
         ayf5YJDymwbfg3LsDh5oLd8ex+4EfrHrWIMkCqeXKbo7K4Z2fD+OOn61m5Q1MeuRQBPh
         Pxm5ICMoTh0hdy46EBO5wfxxYUZyrxbE81l8CcBRsLlbPV9N3WvLzu56+5G0a0rAXH8x
         o6MhOnJMHqHEve5EiEvusftB1DV0VJ97++KJKsf9IXYzwtv+5Wq4m5QncYCPJBZ179f3
         6dcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RK6wC1XHi8PpNHal2ZyPx9YXJfSQ4NcJH/SuRPXq2AU=;
        b=24xjmBMzaiyHD1vnezdb+rI33J9/evCXMdd6Oyyhv7k736S17kD7+V7Y8wkP3Y16vZ
         EIWaW9uen9WOoG2f9gQb70uEAZj2kbNEYU6UTZFanmE5hCZ84BtOeRXNg3IZbnCHRNXz
         AofHxq0k0x1zeVfzwNgv/uH98F240SW40LhQSVdrV8OjZLFei3Qnj2Pjvc/z0HP6GXEB
         JZnmqCjX39rvp490tx8kDJFjvpwLtT717AbDNNZPg1yCySi72ln9HqkVwhSkDUK7J4Dy
         AihC8XNeqeSztl++NBNKD/0ojlcoSRAEuB2tcs9WZU5NDIWiIvR1NHyLf9box+vl5Qx6
         uD0A==
X-Gm-Message-State: AJIora80NneZI2u1nxjorzkX8tDo0zrC9jG3KUmqiXcHtKe8aC6tYmz5
        0LsKh5gvoFnqBWSAYYycoPwPApDWT2trW1aohlg=
X-Google-Smtp-Source: AGRyM1uHhCDk/tFn3r/yAgAaLzh3zlyfpK1Cqitneo7iFdB+u66tjJMdzbolpenAbc4zVyrUqlNAFORgrTq7voNegbU=
X-Received: by 2002:a1f:4d83:0:b0:35d:a9bf:1a30 with SMTP id
 a125-20020a1f4d83000000b0035da9bf1a30mr3489964vkb.20.1655412509048; Thu, 16
 Jun 2022 13:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220614003251.16765-1-jacob.e.keller@intel.com>
 <Yqfec9yvT3LKomNK@nand.local> <CA+P7+xrgWVh_GPMiziiMnsrESH_Z+HzB+D2un8FWSs0dpcDFdA@mail.gmail.com>
 <Yqfx3P8qUpQ7Y0ux@nand.local>
In-Reply-To: <Yqfx3P8qUpQ7Y0ux@nand.local>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 16 Jun 2022 13:48:19 -0700
Message-ID: <CA+P7+xpzH_PiTKk4wb25pBJOCXwTE6_RYKhpRQj84gknNqV0Kg@mail.gmail.com>
Subject: Re: [PATCH] remote: handle negative refspecs in git remote show
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Pavel Rappo <pavel.rappo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 13, 2022 at 7:26 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Mon, Jun 13, 2022 at 06:56:55PM -0700, Jacob Keller wrote:
> > > > +test_expect_success 'show with negative refspecs' '
> > > > +     test_when_finished "git -C test config --fixed-value --unset remote.origin.fetch ^refs/heads/main" &&
> > > > +     (
> > > > +             cd test &&
> > > > +             git config --add remote.origin.fetch ^refs/heads/main &&
> > >
> > > Doing "git config --unset" outside of the subshell could be avoided by
> > > ditching the subshell altogether, perhaps with something like:
> > >
> > >     test_config -C test remote.origin.fetch ^refs/heads/main &&
> >
> > We need "--add" semantics here which test_config doesn't seem to
> > support at the moment.
>
> Makes sense, thanks for explaining. This patch looks good to me.
>
> Thanks,
> Taylor

I ended up digging into this, and have now additionally added some
patches to clean these tests up:

1) drop all the subshells in t5505 where possible
2) modify test_config and test_unconfig to handle options, including
--global, --add, and --fixed-value
3) make test_config use --fixed-value with test_unconfig so that only
the keys with the exact value are removed
4) use test_config more so that we don't have config values from
previous tests kept around
