Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484FEC433E2
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 20:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0215D2080C
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 20:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vatda2+g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgIOUbm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 16:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbgIOUbM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 16:31:12 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EC6C06174A
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 13:31:10 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w1so4377357edr.3
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 13:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=upkqPYCqm8CFuxhSRPKeY87qbN28IUfg4p4YT7ztYZU=;
        b=vatda2+gbSR9BMJgiTV7noTpkzYFNYGn34yogor/+ID5nfiLx8zqcYWsDyPqqthzLd
         5+P8znKvHWIf6wHNjD8ykNtOP9ZoIA9MgcUP63dyFn/NVGkiEt51EXaUGIA6TgDhGJiZ
         vMtc0SDdDYacrap0cFgFNwQKTjDlwwW6plNajXBQYE5jERxzigTIJrXqZSaHg1IGN3zV
         2KtL1UEmhnXyPCr8LVyj+LqzDSTnuWHUgCtaX+iiWdiS3OasaWyOJf+xYDbYV/3Fgru7
         tTctXVRlrLwaDjhFXcR/7UMW+baA3LVB7Dd+hIO6bLz30jG4uhERTEleJIyM+vcbmVeb
         6mBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=upkqPYCqm8CFuxhSRPKeY87qbN28IUfg4p4YT7ztYZU=;
        b=DNCnL/Z1cvKXYS2TmPFqY/TtCh/By09+rZMyoR1k2Jf1Y1iDDN66ak0R106SIArFto
         d8bJAT6nflGHn+6LyihGZEx6+idYSAwuTy/K/8hkGZsxHygR5Bl1ip8n8Srt7nTsLFbK
         ZOrqzhgMQK9StPzLStUpATSOufZPL7H/Cfejjk9wpHE6Id2GbbAUIRRrKAJCs32t8VwO
         9U+k5i42FIZc1ZwerjeCE8+AF79DbEF4bPO4PwwFq7TYcpKYeAUj75BwAPYQIc/26dW1
         VditG+li5ei3LFYpLTWaVDkC1vlIg5f2dgYIHBNpqAUEkEjfb59W4UuzItJ3oqn0ZqcR
         P1DA==
X-Gm-Message-State: AOAM532LYfwpnZagHUgZdojax9umjaAF7LSjCiOFbLryZOm0su+gxqtb
        cP96adL7zwB2YqNDgCn90pA=
X-Google-Smtp-Source: ABdhPJya7/ltcDZvb51suJdB6ks/hfZw5PErngBi3M28W8ZXvyOEopojzWaiPNdb8BXmD7OaFki2tA==
X-Received: by 2002:a50:9fe6:: with SMTP id c93mr24238757edf.151.1600201868144;
        Tue, 15 Sep 2020 13:31:08 -0700 (PDT)
Received: from szeder.dev (94-21-23-168.pool.digikabel.hu. [94.21.23.168])
        by smtp.gmail.com with ESMTPSA id a5sm12978471edb.9.2020.09.15.13.31.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 13:31:07 -0700 (PDT)
Date:   Tue, 15 Sep 2020 22:31:05 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?Q?J=C4=99drzej?= Dudkiewicz 
        <jedrzej.dudkiewicz@gmail.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Cannot run `git submodule init` on Cygwin from script with
 strict error checking
Message-ID: <20200915203105.GB23146@szeder.dev>
References: <CABJqhQNh2Qc2Btp==bGUbT-AaSjGdGEmhtphQQyX=nqjWOis0A@mail.gmail.com>
 <CA+kUOan0N32W22xkoYsGYqM7rJDnc=tjQe_2Hnh2H47=19bbeQ@mail.gmail.com>
 <CABJqhQMST-n6-uEDpFCUSsYueF_=7ZLPCtj_mQnu679oY99ZVg@mail.gmail.com>
 <20200911131943.GA23146@szeder.dev>
 <xmqqsgbonnco.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqsgbonnco.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 11, 2020 at 12:07:51PM -0700, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > Having said that, unlike 'git submodule', 'git-sh-setup' is meant to
> > be dot-sourced into users' shell scripts, and, therefore, should work
> > with the shell options set in users' scripts, including even 'set -u'.
> 
> Is it and should it?
> 
> git-sh-setup was meant to be an implementation detail for our own
> scripts and we know don't use "-u -e".  We never cared about
> backward compatibility for such use by end-users when we made any
> update to the git-sh-setup scriptlet.  We freely changed existing
> features and squatted on good names for variables and functions we
> used in it, because it is designed as a private helper library.

It has a manpage that it installed by 'make install-doc', and 'man
git' advertises it, so I use it in most of my git-foo shell scripts,
e.g. for 'require_clean_work_tree'.

> Having said that, we do protect from end-user misconfiguration like
> exporting CDPATH, and protecting ourselves from exporting SHELLOPTS
> is not something I would oppose.
> 
> Thanks.
