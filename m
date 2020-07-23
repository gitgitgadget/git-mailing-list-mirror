Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B0FC433E8
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 05:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FD33207E8
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 05:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgGWFlH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 01:41:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41492 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgGWFlH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 01:41:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id z15so3893499wrl.8
        for <git@vger.kernel.org>; Wed, 22 Jul 2020 22:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yipx8svqWL/hQNWrFJGRKvcvygnQHmY7gXoUaPY5mFQ=;
        b=JtD9BFF6LedWlOTXnqly6aH0w/ZQQaVDwR0QGRIF1ZH1t0/mKlm6PZB81cuOAfR5Kj
         7ab51ry1dMXwn/8gVPeI7AJcqbElcBvxS/968AJanJWiSnlLGJBOoEqigZSwkjYpUSfm
         /qb1YmVE/B2G+aYjN1ehf5ehfDcJRBMJkS0N79sv8v4/QSJMIX/vOx3OmmYqNUIp948r
         L1cScceLnWHuwZrYQykTvyybiFbetyLz6pDVs5+21zq1Osk3QH2O4XH+zCyfbWdf1HBB
         Gv75X8lIodZ5TE4dtQw/btZn52/VZtX3/ckV3bGeV2gigCt70VV66cEVMHezxz6WzDsp
         9H3w==
X-Gm-Message-State: AOAM533wbvAUJgw1fu7w64TDLsi3nMHaFPjbLfxX5OMDXODEVImkiog8
        t2uNXpQpBLxE7N0u2WDP8i+wAaBnyzoSleBP22U=
X-Google-Smtp-Source: ABdhPJzNC5R7OYLMONL+AuIJIUC8/fg7ybBW1FYwBThQ0A9VAM9l0V4qOgbqCr/LN6JBdDIHhsv8aRh2VNdWAgqgFYg=
X-Received: by 2002:adf:fc45:: with SMTP id e5mr2612212wrs.226.1595482865125;
 Wed, 22 Jul 2020 22:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
 <20200723010943.2329634-32-sandals@crustytoothpaste.net> <CAPig+cRWptYRJUpT71jW6_O9UZ1RK=FCbZj-+OkR_5kGqSWScg@mail.gmail.com>
In-Reply-To: <CAPig+cRWptYRJUpT71jW6_O9UZ1RK=FCbZj-+OkR_5kGqSWScg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 23 Jul 2020 01:40:54 -0400
Message-ID: <CAPig+cTPbu9NgJCqKEY9-qRrJYGPxBFb-acS=v72jC6GKEY-LQ@mail.gmail.com>
Subject: Re: [PATCH v3 31/39] bundle: add new version for use with SHA-256
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 23, 2020 at 1:31 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Jul 22, 2020 at 9:10 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > +test_expect_success 'git bundle v3 rejects unknown extensions' '

By the way, should this be s/extensions/capabilities/ ?

> > +       head -n2 bundle >new &&
> > +       echo "@unknown=silly" >>new &&
> > +       sed "1,2d" bundle >>new &&
> > +       test_must_fail git bundle verify new 2>output &&
> > +       test_i18ngrep "unknown capability .unknown=silly." output
> > +'
>
> I worry about passing binary bundle data through 'sed' like this.

Thinking on this further: Since you are only interested in whether or
not "git bundle verify" correctly complains about the unknown
capabilities, you really don't even need any of the binary bundle data
which follows the header. As such, you could just hand-craft the bogus
bundle, perhaps like this:

    cat >new <<\-EOF &&
    # v3 git bundle
    @object-format=sha256
    @unknown=silly
    EOF
    test_must_fail git bundle verify new 2>output &&
    test_i18ngrep "unknown capability .unknown=silly." output
