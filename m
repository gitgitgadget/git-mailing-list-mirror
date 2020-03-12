Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0DFC10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 19:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62CB6206FA
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 19:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lM5xglh2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgCLTMR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 15:12:17 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44608 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLTMR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 15:12:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id 37so3518405pgm.11
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 12:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oevakREtdLSj50/5ZUd/HWwTertLDv243Xr25tNFGZc=;
        b=lM5xglh205f1YhplP/RsY0v9saWkBRSANZnm5WEhBD92XPZxVMwB0WAt2snAikEoJL
         MXb31Gl4qv4dYCzwn5u+5Lnij7ypW7xmKIpsgYRCDDkTMRKBQij2OfjvyzGcyZGVr7Qo
         Dfa+BzqEDMb789Iqknog8+yhmExvIsUqIaBf93ND9hnFRSiR5+h5v2emQYrsKYTTww3R
         spcamweYSxB7ybZTYE8JG2Mc7wpl3n0nuWvKh6At/X73BDwLZ3FFxD4cIuwTHhIZoGdn
         X+tkiFxm1P9cQKGue4+rwknwLPwVuDyGwZ8DvAYb1G77Mhzzxgr7v93BbV4CxPM4iLCB
         6uhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oevakREtdLSj50/5ZUd/HWwTertLDv243Xr25tNFGZc=;
        b=dYGadIlwONxuw2cSu09F0L0H2DJ/9x+rx804DhBA7DL5Bgt/e/kCR3fUZQtR8rIiv1
         phgcv5soRV8FtuPxWkMnAojZJ9/Q+kQLoTFbVNCD5y3UUnlUzmKkn4xgQwGOX6y9hMZx
         DRvhzqTETFUTmSc8a2GjLiqNJTEdK85JPCUMnu5GlgNdej0LzvDahbow0rdMGy8E/hDR
         NxufaA+YgRFThlwAsB9KQ3+Z58EGMJxN5yyVL1/GLjO6lOeWhfr6LQm8nBe0OhdtE8+c
         lBZlYRmA3oAmdAcRT38RX5L3xXvHETxDW0mV7/fW2OFY9VjPXybto90nuVbpDs3EdlRK
         pYdw==
X-Gm-Message-State: ANhLgQ2q9fUFv6jxNEcFTMwtyxJyh1Zi+UKeoolK0wQLectEVDomfYO4
        c7+xm4JCv+cQGOrWhWUDY68=
X-Google-Smtp-Source: ADFU+vsjVAKeJV3YmsDPYk654Mn5bXDYiPbAlPyyWiYk27MVaW6r6NEp/UdFAcGVw2P0OspeBA6lwQ==
X-Received: by 2002:a63:180c:: with SMTP id y12mr9603554pgl.120.1584040335748;
        Thu, 12 Mar 2020 12:12:15 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id j24sm26158035pfi.55.2020.03.12.12.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 12:12:14 -0700 (PDT)
Date:   Thu, 12 Mar 2020 12:12:13 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Denton Liu <liu.denton@gmail.com>,
        Pavel Roskin <plroskin@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v5 20/20] rebase: rename the two primary rebase backends
Message-ID: <20200312191213.GE120942@google.com>
References: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
 <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
 <ad8339aebf28ec84c22ed59cef06614d204adb55.1581802602.git.gitgitgadget@gmail.com>
 <20200312151318.GM212281@google.com>
 <CABPp-BHyNvxQZ5q=9WXXESTPmxFe4fAiE5roGeV2H+XJ_cpDmg@mail.gmail.com>
 <xmqqk13pfl3m.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk13pfl3m.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:

>> I'm a little worried about ignoring the setting and just picking one;
>
> I am more than a little worried, too.  I think erroring out is
> warranted in this case for exactly the reason you gave here.

To avoid misunderstandings: have you read the proposal I made that aims
to avoid that problem?

Thanks,
Jonathan

>> if the setting has been marked and they set it to e.g. "appply" (one
>> too many p's), then does it really make sense to just show a warning
>> but continue using the backend they didn't want, especially since they
>> may miss the warning among the rest of the output?  I'd rather go the
>> route of improving the message, perhaps:
>>         _("Unknown rebase.backend config setting: %s")
