Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B44C433E1
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 08:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FD8F22B47
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 08:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4XF5qjG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgH0IbC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 04:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbgH0IbA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 04:31:00 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C834C061264
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 01:30:59 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u18so4350185wmc.3
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 01:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=K6U6IwPGouraUiskgezSPqWb3nQvx+MFcaaSJXdtiEc=;
        b=a4XF5qjGMss0ztALu4OL3/ZKnW+Zg3VUUkIhooCzAmENn3ru1nt/2h0Kc2dT0qn2h8
         vj2L536GrVuQCIm65QehexMTUckFNBTxljfRGTc317h3cA334mbprLtbyii/+0EIus9I
         vzdlXRh+uec6YBPsQzNGyQ7x2j1Ncs/SlmJKI53KB4Mmk3id6VMJkTUzUl8BzMlEGpj8
         W37eGI/XoQy4yiVvNxVxUB3Ho3JCKRJWgCJlF4QXAv+w+8xR3U/ceRXnFe4aGnt1j/na
         SXtQEuPEie1ps9CRkT1nSSxnMkoc9FXz0+U4+JZm/EoxXkWS0/oZ1aIrlEnTMpesoREd
         VaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=K6U6IwPGouraUiskgezSPqWb3nQvx+MFcaaSJXdtiEc=;
        b=VcMXW44PS2UwukuzWWfFjwFmXNNYFH5mH0MQXn8LP1Uss//csjm7wxVZOgMHu7Ix/d
         28xR9JXyHYZ6TKK/qPgz3jH32wM3F32zW1FKXhSLUqEFutsxX7KmKz6iNaNYmVFQwvYJ
         YEqBuE67Fyka4f2VCb26hLI8BDaJbAMgKA58OdqEdSTI3Dwa1LDl64MuXPc2dW3RjcYG
         LKxzkKCZuBDI9zjwFiSwQQU0UFcR99iE4u2rFmSK2htXB8MDpzkcNqIWNx6nW+7zga2h
         bD8IVbhZ2/fUQFDD4UC85YJhvD2mpCpQ5nRXX4YiUpRErRAvhyF1OR/aT+Xa3sEbBwX0
         9wqw==
X-Gm-Message-State: AOAM531AgpksaLUI9jaL23FFSetgWKYRlhPMTqcDXqhOfMObwygPcBXH
        xkeodR5K0yzxN7h5m0jwTZg=
X-Google-Smtp-Source: ABdhPJw+3Gjg422mMUTSZAEl5Ec7kD/GL8laK0EqHaxLCKr5FLP4vFhVF/cNNJQ0LCP/bGipMRFLlQ==
X-Received: by 2002:a1c:e0d7:: with SMTP id x206mr11638946wmg.91.1598517058157;
        Thu, 27 Aug 2020 01:30:58 -0700 (PDT)
Received: from szeder.dev (78-131-17-40.pool.digikabel.hu. [78.131.17.40])
        by smtp.gmail.com with ESMTPSA id n205sm3959776wma.47.2020.08.27.01.30.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 01:30:57 -0700 (PDT)
Date:   Thu, 27 Aug 2020 10:30:54 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ci: stop linking built-ins to the dashed versions
Message-ID: <20200827083054.GD25052@szeder.dev>
References: <pull.411.git.1597655273.gitgitgadget@gmail.com>
 <pull.411.v2.git.1598283480.gitgitgadget@gmail.com>
 <ea23ba5e269305b660a1722254e2a933c14e5b57.1598283480.git.gitgitgadget@gmail.com>
 <20200825134714.GC25052@szeder.dev>
 <xmqq364a3f6r.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2008260615280.56@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.2008260615280.56@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 26, 2020 at 06:19:52AM +0200, Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 25 Aug 2020, Junio C Hamano wrote:
> 
> > SZEDER Gábor <szeder.dev@gmail.com> writes:
> >
> > > I'm afraid I don't understand this patch or the previous one (or
> > > both?).  So this new Makefile knob stops hard-linking the dashed
> > > builtins _during 'make install'_, but it doesn't affect how Git is
> > > built by the default target.  And our CI jobs only build Git by the
> > > default target, but don't run 'make install', so setting
> > > SKIP_DASHED_BUILT_INS wouldn't have any affect anyway.
> >
> > Very very true.  Let's drop 3/3 if it is not testing anything new.
> >
> > I do understand the concern 2/3 wants to address, and it would be a
> > real one to you especially if you come from Windows.  People on the
> > platform wouldn't be able to use shell scripts written in 12 years
> > ago or written with the promise we made to our users 12 years ago,
> > and unlike hardlink-capable platforms it incurs real cost to install
> > these individual binaries on disk.
> 
> Actually, `SKIP_DASHED_BUILT_INS` does not _only_ have an impact on `make
> install`:
> 
> 	$ rm git-add.exe && make
> 	    BUILTIN git-add.exe
> 	    BUILTIN all
> 	    SUBDIR git-gui
> 	    SUBDIR gitk-git
> 	    SUBDIR templates
> 
> 	$ rm git-add.exe && make SKIP_DASHED_BUILT_INS=1
> 	    BUILTIN all
> 	    SUBDIR git-gui
> 	    SUBDIR gitk-git
> 	    SUBDIR templates
> 
> See how `git-add.exe` is linked in the first, but not in the second run?

Ah, ok, so I did indeed misunderstand the previous patch.  Thanks.

