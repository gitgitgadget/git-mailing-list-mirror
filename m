Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5159DC10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 17:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24EBE206B1
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 17:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sDNWSTtF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgCLRmQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:42:16 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:33712 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgCLRmP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 13:42:15 -0400
Received: by mail-pg1-f169.google.com with SMTP id m5so3425537pgg.0
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 10:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7eWHbyKUW61CVUwUb1iRJW8v/hZDYkc02lj3qH/QqEU=;
        b=sDNWSTtF2HD4JcmeOrd0G8XtZmMu4LIj3+u+2ZyQ7Q0ubKJSx2FoQlG614brokU2qF
         Eo6yPNYFdD+9l78MRrH/v2c0Ixjt3WypjiAVrNiVBRFm80kwzr0qVHKxweZ/A4sFG12q
         594G7GYb/DPoz43m6yoPGJj4Rxi3t72X1myP/6vGKw4v31kCpFgwP11NZvLcZgWoJiSF
         qgpzyJxaffL5U/bBH+F5URaqXJsxmQ2rxYNuoaw2W2Fb7kt8TyYNIV8hEhl7r/w8M5ZZ
         ooRzWheF/Yxtnet32uL5Rquld2IrpNBUJSav3A5UD/C8xpeMgjGCvprWtFs3NPlFsZXl
         LNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7eWHbyKUW61CVUwUb1iRJW8v/hZDYkc02lj3qH/QqEU=;
        b=YHE8fAl+C3DDsmLlOYzIaX495IxxnHKoA4sv8DJO0mfCjiYujqx5NQ/tsp1AwSNr7Q
         8HmLljyIq/Ak3C9QCCd2EaGBLaPuXDZB/opWF+Qh+wdCsj5rzfyqrq9Q5LYgeoB8ATdB
         DezUIZql0/bbAr7a6K9Rzb/G70lL6IX+mcg3MiS6MoENiZpg6PcAON0WsrNRXnKZusIt
         Cn0mVsYi+T3PE2rN4ASyd3ke1mCzEb+Z8+DOkEe9kXWJdrE7nzbWj6LqhyZNxlxziG5z
         /eNHJgm+XCdOVCYSMlGbjXU0fOt3gKtlz6/K3Bdvsjl4M0aMBL33s2PUOE+TBcMM7HLQ
         IPrQ==
X-Gm-Message-State: ANhLgQ3UvVmTT3BPl++fxAVZjPKjOjYLwxRqdSb5Yj1TbAoSCTtbfe5L
        tiPQhCik/S2DMxUEaIJAk9w=
X-Google-Smtp-Source: ADFU+vtvS6Pwv3dquubSaF4Pnd7D6aelnStVtCgoqZpeAAhqfISDuUSHQ1ErpDd0w0mOyzLrI7lwyQ==
X-Received: by 2002:a63:4cc:: with SMTP id 195mr8906662pge.93.1584034934249;
        Thu, 12 Mar 2020 10:42:14 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id w31sm28554931pgl.84.2020.03.12.10.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 10:42:13 -0700 (PDT)
Date:   Thu, 12 Mar 2020 10:42:12 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        James Ramsay <james@jramsay.com.au>, git@vger.kernel.org
Subject: Re: [TOPIC 16/17] =?utf-8?B?4oCcSSB3YW50?=
 =?utf-8?Q?_a_reviewer=E2=80=9D?=
Message-ID: <20200312174212.GA120942@google.com>
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
 <6DAC1E49-9CA0-4074-867E-F22CD26C9FEB@jramsay.com.au>
 <20200312133127.GK212281@google.com>
 <20200312173134.bpflnl6n3w6mywlg@chatter.i7.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312173134.bpflnl6n3w6mywlg@chatter.i7.local>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

Konstantin Ryabitsev wrote:
> On Thu, Mar 12, 2020 at 06:31:27AM -0700, Emily Shaffer wrote:

>> We've actually got a meeting with some Patchwork folks today - if
>> anybody has a burning need they want filled via Patchwork, just say so,
>> and we'll try to ask.
>
> Just to highlight this -- a long while ago someone asked me to set up a
> patchwork instance for Git, but I believe they never used it:
>
> https://patchwork.kernel.org/project/git/list/

That was me.  In fact, we are using it, but mostly read-only (similar
to lore patchwork) so far.  I'm hoping we can learn more about how to
automatically close reviews when a patch has landed, assign delegates
to reviews, set up bundles, etc and write some docs so it becomes
useful to more people.

Thanks,
Jonathan
