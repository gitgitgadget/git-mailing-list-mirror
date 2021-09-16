Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAC7C433FE
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 19:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1B2660F38
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 19:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbhIPT6y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 15:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235963AbhIPT6x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 15:58:53 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26661C0613C1
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 12:57:32 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id b15so7807750ils.10
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 12:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3S72Wfj1J/FXUDgIBikSTQPrr0iCXfp13xLjrsZQEGM=;
        b=sIQrPT248Go7BSymuqeYpyhMYOLo97vBfqgOj9YCZu7sx0XICgILBLmqWj/tNHH9Hl
         HW9jjZpwqX6WJZSpthZOIfUSqyGsQdBNSxvIF3mEUw8Hcb6TmkEDVyVi7aqUMf4UwV53
         MAN1YGJmJnpTZa/uNaxmkTUJ0QRRNO5AY/ZqyIP2JDgXtlb6+jX//ff0tD13vxaaRFPU
         Ri6h0bxkcMSJ9v3i4YsVPGtF+jq32UA3SrYnhdAr4PWun0WRhYzqwxS/bLIKgbdsxHMf
         J8kwrg6DBZ7+sMoNccl2ByyN1ztg5gAf18OgfQY97XAAOlibEOISsez//FfhjxDR5heb
         pjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3S72Wfj1J/FXUDgIBikSTQPrr0iCXfp13xLjrsZQEGM=;
        b=Hxv2CeAMY49yiIwzMWMEgI7Qe/kvNm72PvSUQtvtb4DsJ3R+5pX0zYWokUH5aEFqpb
         7BVJU+GmOuvDfaUsX3Ns4dwRycroQdNQWCJawMlohTrHW6NVWbVa9pAy1H/W7ZYjCw0v
         rY+UAGpEm1/D5Xl4C+YnzV9KRlLYeLQaJHvFXvyEbieQa35MyYdwWkLjdC/okh31DHmH
         AKaVidX3zvbBhhcKtpAu0WplL0havuQgMGI68mhzoFlyZs6j7OsOI4JlTEdg6OKQeGqJ
         oJNK/6/TF/xvOtViO6h6SDIYOtDc93RKDL4a9Fjf/JzhJRKePkaJ1jSbATerXl3MQVWn
         kjww==
X-Gm-Message-State: AOAM5326SLFmMI5V8xIHofIHWduS5ADH24pthA/hDWj44cGksQnJdASA
        z+ix/Nks5/XH9J8w7Vb2zjF3JAFvpWTIPddf
X-Google-Smtp-Source: ABdhPJx+3U5lmO8JnTyqFr9L86KZmu5PCUn9r9yMsy2oo50pU1YLGg6gBZGWIrGCBfH73ONYDMNfdw==
X-Received: by 2002:a05:6e02:1c81:: with SMTP id w1mr5156677ill.112.1631822251075;
        Thu, 16 Sep 2021 12:57:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s5sm2191993iol.33.2021.09.16.12.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 12:57:30 -0700 (PDT)
Date:   Thu, 16 Sep 2021 15:57:30 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v6 03/22] cat-file tests: test for missing object with -t
 and -s
Message-ID: <YUOhqnj7vwr00Qap@nand.local>
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
 <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
 <patch-v6-03.22-d442a309178-20210907T104559Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v6-03.22-d442a309178-20210907T104559Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 07, 2021 at 12:57:58PM +0200, Ævar Arnfjörð Bjarmason wrote:
> Test for what happens when the -t and -s flags are asked to operate on
> a missing object, this extends tests added in 3e370f9faf0 (t1006: add
> tests for git cat-file --allow-unknown-type, 2015-05-03). The -t and
> -s flags are the only ones that can be combined with
> --allow-unknown-type, so let's test with and without that flag.

I'm a little skeptical to have tests for all four pairs of `-t` or `-s`
and "with `--allow-unknown-type` and without `--allow-unknown-type`".

Testing both the presence and absence of `--allow-unknown-type` seems
useful to me, but I'm not sure what testing `-t` and `-s` separately
buys us.

(If you really feel the need test both, I'd encourage looping like:

    for arg in -t -s
    do
      test_must_fail git cat-file $arg $missing_oid >out 2>err &&
      test_must_be_empty out &&
      test_cmp expect.err err &&

      test_must_fail git cat-file $arg --allow-unknown-type $missing_oid >out 2>err &&
      test_must_be_empty out &&
      test_cmp expect.err err
    done &&

but I would be equally or perhaps even happier to just have one of the
two tests).

Thanks,
Taylor
