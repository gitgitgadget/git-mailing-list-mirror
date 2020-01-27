Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B08C33CB7
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 12:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8172214AF
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 12:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOV7jsfw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgA0M4E (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 07:56:04 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42545 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbgA0Mz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 07:55:58 -0500
Received: by mail-wr1-f68.google.com with SMTP id q6so11102370wro.9
        for <git@vger.kernel.org>; Mon, 27 Jan 2020 04:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nyIc4onKakRySHVehhccbBTu1AoWJ4TQP0BwjBoD/ps=;
        b=GOV7jsfwJHo1MFvSrx/5nGPjUqgB4dnDG0QTFYfnStrHbYDdfbiGArxNauwWYwJzNF
         MtZyyRj30k/FQ+mqxP301ApZcbkhtRNAw/53yfAF+eT5rozR6A964Be1wcqC1/SWGmKv
         sZizPjAO2vBl8noIJ2DrehKKx5RLXXR9O/u/MKD4sRv9OiDQ09q2dby+QtmGZcHWyv8Q
         n2zQS7/SIzMDpP9i+T8X9FGVBH/R2I0SjsxiRdv8i5hxKU3ccf80OTK7JO2o4jWzTaW5
         pHHbjMoXwwDYq12wa/HJ6I3jao2oQT3+TB5F8aN6uoJ4ojNAW6ac1WXnLAjKpTkmIKF6
         l9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nyIc4onKakRySHVehhccbBTu1AoWJ4TQP0BwjBoD/ps=;
        b=FaP7SjZbH9LSoeX5nKAyqQiVLKUcLtuBiRSn3dEvTPFOh9RKyWvHJxTkxmvdSrm8Pc
         Ge+r+QG945fivfj4EOgt8qM5PQlsa3I0mvSSBpZnF2tlE7yzvpQa4N/f21p6rH8vQ3jR
         tjDe84t0dUA4bGlZ75OK77dYtbh0bxFurAjzkZ8g8kyE7urqU3DgHTPPvJ75WcM4QLAd
         CNgTYRTxre3Bs0Y0+6CXN+gA5qVzlr01zLIbuKCQVQQ9gd/fLHjS+ZHxi8pblFxOqRug
         dLFlvhfPhtqnSnbDXySXKI9XdyG5fJsfSM4B5R+82s2zqEquz+vmo2zlPM0cN3Kc9AOL
         Xsng==
X-Gm-Message-State: APjAAAWkZBfQMqIX8Df153XIgekKb/idl9nGRerdCTzRiQFPGvlobafh
        fL7zu+Cgff15CXU6vYQiDOVZthui
X-Google-Smtp-Source: APXvYqwHE258vAVLU1IGO1F5ZdtlS+AaYLwEI/35J6S3pKtzNx7OI7QaniveDtuHeEj/DJfR8MG8+Q==
X-Received: by 2002:adf:c145:: with SMTP id w5mr22063759wre.205.1580129757236;
        Mon, 27 Jan 2020 04:55:57 -0800 (PST)
Received: from szeder.dev (x4db36537.dyn.telefonica.de. [77.179.101.55])
        by smtp.gmail.com with ESMTPSA id h8sm22978788wrx.63.2020.01.27.04.55.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jan 2020 04:55:56 -0800 (PST)
Date:   Mon, 27 Jan 2020 13:55:54 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Yang Zhao <yang.zhao@skyboxlabs.com>
Subject: Re: yz/p4-py3, was Re: What's cooking in git.git (Jan 2020, #04;
 Wed, 22)
Message-ID: <20200127125554.GC10482@szeder.dev>
References: <xmqqr1zr5e5e.fsf@gitster-ct.c.googlers.com>
 <20200122235333.GA6837@szeder.dev>
 <xmqqftg6671g.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.2001231306351.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2001231306351.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 23, 2020 at 01:11:52PM +0100, Johannes Schindelin wrote:
> on rare occasion, I have to restart
> the `linux-gcc` job because _one_ of those `git-p4` tests failed due to
> some reason or other, probably timing-related, I did not have time to
> investigate this.

I'm only aware of one timing-related issue in 'git p4' tests and
reported what I believe to be the cause of it a while ago.  Luke said
he'll have a look, but, alas, not much has happened since then, so
maybe you can poke him a bit as well?

https://public-inbox.org/git/CAE5ih78MV1qGTHBmCaN5k+VGv8Cy-RnFwOU0yuJBPEyn37C_4w@mail.gmail.com/


Or...  Yang Zhao mentioned somewhere planning further improvements to
'git p4', so he knows how it works.  Maybe we can trick him into
fixing this issue? ;)

