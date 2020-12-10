Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF84C433FE
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 20:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AB522332A
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 20:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404606AbgLJULV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 15:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404551AbgLJULU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 15:11:20 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B9AC0613CF
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 12:10:39 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id m19so10081716lfb.1
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 12:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=J/eHCUUwXVEwWmbcEUEPbIMgtSvXjzAbs289qCMmqbQ=;
        b=llFKiaPusxGK0MnC31e9W86RNpDwVnkLPMbDafdp6Vz/ba9oxGOAU9ZZC6u5gHfVZ1
         1AYPodxpdVKCIxheg1RQPnUY6ASZTO+d8OmhA53O89YFWqB4V6GRpRNjFt+TDXk6JAYP
         iCL3jKwyImBl2xxZlvFf+dsGeOUFAamkewvbnoKAUsBtvtCJbEuvC/Bdus95dH3FIE84
         oLsl9vXNgDjkvB8HdBv1LHsbgotjKAVq0qaCH7A/Wf1DMlWXC+nCUASrqIy2LG3ee/px
         d4Ns29ZrI5SlFbCXrfGcY1mOVXcwFKScMGNFzOvZ6F/wt8n9Dhi7JzqUX/WjYzrZceea
         el5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=J/eHCUUwXVEwWmbcEUEPbIMgtSvXjzAbs289qCMmqbQ=;
        b=QdoNdDLedFfQUuyxDZBk7D2u0Ptk79TJ4Onnd0ybgHnmnsf9mxvEgHXFNroNuAjFJT
         eKIyEqf/+8A6WT7NSlYBmStG6UWxSAEvwhCIXNac/408tc/mjmNay1xjDXb8TNLKMYa3
         jd9z78wW5Jidm99U25pmOCiooUH5q7hgtKIEOBH2n50anGFrgP9XT08fEOWDFlrBKvoc
         4jMqr05sRZkATOnEP934YqOLgtiDSEpqwinkbkSavf3hYaeLfIlogc+U5UkX7fhaZQ/R
         CQ+KKTfxjy6pLJvft8VlNRUKLoAVxoco3ejurxCnOg2acHZbSn7kVROb75s3zSxXxusu
         //DQ==
X-Gm-Message-State: AOAM531DSwnJA8VibC77dcGrjYxl68a94J7yEfSphbAt3yiszU/mugEe
        SCQp7ZhmJt0jiNCayQqGi8JUT2fB6j8=
X-Google-Smtp-Source: ABdhPJyFR4n+35H+qPehhlWGXxB+P/s7Xmh2Os2qaZvHmrjdni+Pu+EwZfXLnKbQyhFfABWs+ESLSg==
X-Received: by 2002:a19:6108:: with SMTP id v8mr3451951lfb.429.1607631037846;
        Thu, 10 Dec 2020 12:10:37 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id a15sm631828lfo.299.2020.12.10.12.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 12:10:36 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 00/26] git-log: implement new --diff-merge options
References: <20201101193330.24775-1-sorganov@gmail.com>
        <87y2i8dptj.fsf@osv.gnss.ru>
        <CABPp-BGuLX8Msghbo6L7vB2Wqys=Xg_uvV2Aui-1q4-+ijuNEw@mail.gmail.com>
        <87y2i8c4mr.fsf@osv.gnss.ru>
        <CABPp-BE3D7ifQx6MZCT_ntRnG0QZm1Ga10SJ=DN+6bpF6mX2GQ@mail.gmail.com>
        <xmqqtusv4w2g.fsf@gitster.c.googlers.com>
        <CABPp-BHCtrKAWR1v3OrUgX8iSfxvDwN8p+yiJy=G1BFfnSopjw@mail.gmail.com>
        <xmqq7dpr4qa0.fsf@gitster.c.googlers.com>
        <CABPp-BHWhiUZ=wCSz1f0oxtHiRzAKCPVmoUYDf+mvvm63ykCEw@mail.gmail.com>
        <xmqq360f4npg.fsf@gitster.c.googlers.com>
        <CABPp-BEAmB9DA7RXrf6vJGbHfGU37V4sE0d1CW+2vRwp_uAudw@mail.gmail.com>
        <xmqqtusv362t.fsf@gitster.c.googlers.com>
        <xmqqpn3j32ka.fsf@gitster.c.googlers.com> <87k0tqdasa.fsf@osv.gnss.ru>
        <CABPp-BE7r4iUc6VD60Bdi+fF2bBn6_ZwVPrz_niFpY=LTZMXzw@mail.gmail.com>
Date:   Thu, 10 Dec 2020 23:10:35 +0300
In-Reply-To: <CABPp-BE7r4iUc6VD60Bdi+fF2bBn6_ZwVPrz_niFpY=LTZMXzw@mail.gmail.com>
        (Elijah Newren's message of "Wed, 9 Dec 2020 23:26:44 -0800")
Message-ID: <87tust777o.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:


[...]

> As such, I suspect rev->diffopt.flags.exit_with_status will be 0 most
> of the time and that the relevant check at the top of log_tree_diff()
> really is the "if (!opt->diff)" part of it.

Right, but *why* is it needed? If I do set opt->diff to 1 but don't set
opt->diffopt.output_format I get no diff, so the question essentially
is: which caller of log_tree_diff() would need to set
opt->diffopt.output_format but leave opt->diff to be 0, and why?

Even if such caller exists, it will get no diff, so it seems to be
entirely pointless.

>
>> Is rev->diff an optimization, does it play another significant role, or
>> is it a remnant?

I still don't see what's the correct answer to this question, sorry.

Well, I did a crush-test: commented-out entire if() at the beginning of
the log_tree_diff() and ran all the tests. The result was entirely
surprising: all the tests pass except one:

Test Summary Report
-------------------
./t1410-reflog.sh                                  (Wstat: 256 Tests: 22 Failed: 1)
  Failed test:  4
  Non-zero exit status: 1
Files=912, Tests=23039, 278 wallclock secs (10.48 usr  2.12 sys + 1034.98 cusr 650.30 csys = 1697.88 CPU)
Result: FAIL

And now I wonder how comes none of specific test are able to notice the
difference, yet seemingly unrelated test fails?

Thanks,
-- Sergey
