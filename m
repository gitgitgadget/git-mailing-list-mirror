Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC75C35242
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 05:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6324920873
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 05:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDi6xx13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgBNFPK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 00:15:10 -0500
Received: from mail-qt1-f169.google.com ([209.85.160.169]:39845 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgBNFPK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 00:15:10 -0500
Received: by mail-qt1-f169.google.com with SMTP id c5so6201369qtj.6
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 21:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HWOSzB42GRZHASe21QepzbE7MNjLJTBF/IB1Knb0Gao=;
        b=FDi6xx13fTUSNiNG+9shtDffb0xBNMoTaM+szG6mWu2O+66H9sAcCt2Nf+FHm8GC6d
         jW0sDod14BJmLlV99HzlfOUHp0wjaOQDL7LLKOwv06ptbjGPkuR17UnvSneohjvZVhyh
         l54GqFKQVrk6kPG5kaH2PCKLR1DIiHXjkmEJ/S2/cD/XQFzXV/f5dQ4G+ElcNWKjXJN7
         JAJYbBOCFSolf4dhj7Dr/pacgWI82hhM7h5APrXw0NGe/zAzIUZRa15MMpFxxQwhTMxC
         GbR/EFEwX4xJR2x3Aft3cvrU3Qo5tfvaP3mESiT3SM1Yh2qLA/cpfrgK9cqt1gh00oOg
         CMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HWOSzB42GRZHASe21QepzbE7MNjLJTBF/IB1Knb0Gao=;
        b=gDmsbUVsCGjK56U1KDS4B8jTk1NDiG4hmEQ5IBSY7yXETRokNSclwWBjFaptxbMWGi
         A+7Ohxq6d7Lb9gLCnPR/n9tu2zWovKtA4bxWgj4ZYYeuGUbidTEG34rarEbmo72aW0i+
         M8/rlXYlYqa5zyFiKblg8eacXX7kk4GpVsPB9eHOiUwoEs5HI9DMMnytsz3blY+ywqR4
         Portz7OQWUtNedkLQ0mZWjJX4ZjAELrpaVov9TI/9ePjd37yTrlVtHkPz9ykmypwY47M
         ujEanK9G4gDP2cZM94YBZEsDw59tuB/Wk7JNiTNnittQCSLl3Z5qL+/g8vkw8Vyeiy75
         IzDw==
X-Gm-Message-State: APjAAAWFNvRO+Uc5gzSfDVh9QZ7OXSblNfV3j+MBRDkH4ImcmVRuxAtd
        X/Zuv8j4z+MuCjvJCe27urc=
X-Google-Smtp-Source: APXvYqwa3vKStfafxmS8/cbZV+kkt/H4FqcMT9UHY3I+YK2iwJpfr2l32IVHIo6Bm+gDDEuUjvgjVg==
X-Received: by 2002:ac8:1b18:: with SMTP id y24mr1205115qtj.158.1581657308029;
        Thu, 13 Feb 2020 21:15:08 -0800 (PST)
Received: from generichostname ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id r6sm2651902qtm.63.2020.02.13.21.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 21:15:07 -0800 (PST)
Date:   Fri, 14 Feb 2020 00:15:05 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Yang Zhao <yang.zhao@skyboxlabs.com>, git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Ben Keene <seraphire@gmail.com>
Subject: Re: yz/p4-py3, was Re: What's cooking in git.git (Feb 2020, #03;
 Wed, 12)
Message-ID: <20200214051505.GA16130@generichostname>
References: <xmqqo8u3tqly.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.2002131401130.46@tvgsbejvaqbjf.bet>
 <xmqq7e0qtqsm.fsf@gitster-ct.c.googlers.com>
 <xmqqk14qqj7n.fsf@gitster-ct.c.googlers.com>
 <xmqqtv3tpzto.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtv3tpzto.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, Feb 13, 2020 at 08:17:39PM -0800, Junio C Hamano wrote:
> Now we are running some tests under py3, we seem to be failing the
> tip of 'pu'
> 
>     https://travis-ci.org/git/git/jobs/650160479
> 
> that is getting a SyntaxError.
> 
>     if message.find(separatorLine) <> -1:

This change comes from 'git-p4: restructure code in submit' in
'bk/p4-pre-edit-changelist' which introduced the use of the `<>`
operator. In Python 2, this is valid but in Python 3, it was removed.

We can simply replace the `<>` with `!=` which is the new way of
writing "not equals".
