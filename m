Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AC5C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 16:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA63E60551
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 16:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbhHTQlf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 12:41:35 -0400
Received: from mail-ej1-f43.google.com ([209.85.218.43]:42709 "EHLO
        mail-ej1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhHTQle (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 12:41:34 -0400
Received: by mail-ej1-f43.google.com with SMTP id mf2so2877340ejb.9
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 09:40:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T6nj4nLR8lQNtGuT14J+M3SFihYJLPSr/TSHqpryc2U=;
        b=B5E6/7DgWHy/dIJ0LjKJurKWMS/PuJSV3BU6KzXvecCLKYWeP/z4IS0RvQbC/MD8iw
         OHaWBXjGeonfPjzIEcV2BbVhCURpnNJAegqjGk38AHi7DKMTxeKx9I9YmjlYO5P3YAJc
         rlx+/w4VzcHxkNfDGZjEt/ePOuPpWPZH0SKjtqdZ1AHeoSuu5L1B/XcTfyAixLr63u+D
         oS6Sbk9W+oOSav3RK79agVczlpqYCqNDExbP9yNuoBGaUAboTdySfArSpTRyAkiXPBAR
         c/Va8CLn8SY63AyCwNEue8MtXmCM9/8MLIG9fskGe6lgFiRehC2saWBLTrazOenDU4L4
         Yxlg==
X-Gm-Message-State: AOAM530V6LpbgsTnMvx35cE65EFcJSGAQKCn/VTtElVLPhY6DWIzM3Xr
        b3lROaVwFU0AFepRHDyzBP2CsTUJSFkLRPKz2V4=
X-Google-Smtp-Source: ABdhPJxDC/TwaJyW9igsmNGlMTtE7DH0AnepJKbnWXpg8F0e3YtuctlcTZCNn+kAhiVK2IEGRk+d7cjB06BviNvRnt4=
X-Received: by 2002:a17:906:2acc:: with SMTP id m12mr23245547eje.231.1629477655639;
 Fri, 20 Aug 2021 09:40:55 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>
 <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com> <e66106f7a99d94145eec983ea5e72b7cf8a8a479.1629206603.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2108190933210.55@tvgsbejvaqbjf.bet> <24b1b932-caf9-b709-baf4-a2f8669deb88@gmail.com>
In-Reply-To: <24b1b932-caf9-b709-baf4-a2f8669deb88@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 20 Aug 2021 12:40:44 -0400
Message-ID: <CAPig+cQM35GXQ_2ghi+c7zDOaNx3_ryCOCuXq7ib4Ej+fUeMEA@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] t7519: rewrite sparse index test
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 20, 2021 at 11:09 AM Derrick Stolee <stolee@gmail.com> wrote:
> On 8/19/2021 3:45 AM, Johannes Schindelin wrote:> On Tue, 17 Aug 2021, Derrick Stolee via GitGitGadget wrote:
> >> +    write_script .git/hooks/fsmonitor-test <<-\EOF &&
> >>              printf "last_update_token\0"
> >
> > Technically, the backslash needs to be escaped because it is within double
> > quotes and we do not want the shell to interpolate the `\0`, but `printf`.
> > Practically, all the shells I tried handle this as expected.

Technically, for a POSIX-conforming shell, `\0` is correct, and the
backslash does not need to be escaped. Of course, it doesn't hurt to
write `\\0` since it resolves to the same thing, but it isn't
necessary. See POSIX section "2.2.3 Double-Quotes":
https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_02_03

> I have no opinions on this one way or another. I will just point out that
> the pattern used in this test is also used throughout the test script, so
> any change to that format should be applied universally. The test has been
> operating without complaint since it was introduced in 5c8cdcf (fsmonitor:
> add test cases for fsmonitor extension, 2017-09-22), so compatibility is
> likely not a problem.

Since POSIX says that `\0` is correct and since we haven't encountered
any shells which handle this incorrectly, there seems little reason to
change it.
