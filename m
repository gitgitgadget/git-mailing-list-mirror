Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79650C433DF
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 22:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F088206F4
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 22:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=schrab.com header.i=@schrab.com header.b="bVVO5h9+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgGJWnh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 18:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgGJWnh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 18:43:37 -0400
Received: from pug.qqx.org (pug.qqx.org [IPv6:2600:3c02:e000:5::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0967C08C5DC
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 15:43:36 -0700 (PDT)
Received: by pug.qqx.org (Postfix, from userid 1000)
        id B097B204B4; Fri, 10 Jul 2020 18:43:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schrab.com; s=mail;
        t=1594421015; bh=2nzAUAVSSh75q8Cdhji3wElc+8hyT0xu1fjxdvHomUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bVVO5h9+sCTrtSudTzzJU9uZ3aw0/QgIHvatYrAeckGak+yMssS6m30rOnjBAIVVg
         mj3coNFvxT5Vs47Id3e3jwCxHMbar9J9i8aaAOUVQ+V5W4tTAaRZJF81wIxJe5KNbg
         xDQ4m1wWB3LaHyYZ2nOuYtxkRT52zRONLkZFGic7JYG5Hw0rWlYKXuFvjWBVJ8KSCj
         qUWzTBRoYVFau3vTgp4bSF7GH1R2tyLWcQy7yBsoTMGgeoBD7VgHVK1HAj/KbT6Dtq
         YZuEXEUTKHlThkUtPZFGEgRpSfC66lRiCABC3hGWTxGsSV4fRpJUDR3IQYmVLewrPz
         cEXss1FEJ3mSg==
Date:   Fri, 10 Jul 2020 18:43:35 -0400
From:   Aaron Schrab <aaron@schrab.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Tom Browder <tom.browder@gmail.com>, git@vger.kernel.org
Subject: Re: "git rm" could be safer and have a better help msg
Message-ID: <20200710224335.GB1346@pug.qqx.org>
Mail-Followup-To: Andreas Schwab <schwab@linux-m68k.org>,
        Tom Browder <tom.browder@gmail.com>, git@vger.kernel.org
References: <CAFMGiz97fcw_nvaa=Xo-roTtB1o25qO06=PHGSrBzv4k_zGqaw@mail.gmail.com>
 <878sfr1rdm.fsf@igel.home>
 <CAFMGiz8+pjskPpPqVgQUevKdWgxPvCKBcmx-07E2yizDqhm9mg@mail.gmail.com>
 <874kqf1n65.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <874kqf1n65.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At 16:04 +0200 10 Jul 2020, Andreas Schwab <schwab@linux-m68k.org> wrote:
>On Jul 10 2020, Tom Browder wrote:
>
>> If the existing file has been modified, with 'rm'  the '--cached'
>> option doesn't remove it from Git
>> unless one uses the '-f' option with it.
>
>It doesn't?  Worksforme.

It needs to be forced iff the cached version doesn't match either what's 
in HEAD or on the file system. So when there's potential to lose work 
similar to other situations which require specifying a force option.

     $ git rm --cached a
     error: the following file has staged content different from both the
     file and the HEAD:
         a
     (use -f to force removal)
