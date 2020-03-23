Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D778C4332E
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 18:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88DE20663
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 18:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nd92pggo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbgCWSua (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 14:50:30 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40610 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbgCWSu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 14:50:29 -0400
Received: by mail-pl1-f193.google.com with SMTP id h11so6288406plk.7
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 11:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R0LwILojUFHfDnPICXJYjY7ZqunsMyeogNZOtQuSMFg=;
        b=Nd92pggoH5fbtYajbo24pdnBRGWqVakrPlK2JryaAb59xvpRb1QtOJ5JLRaGJh7XoX
         rtjJYCMl1Ekvou4y4toMwn3YhwSKqn1ZO97O/d9DudtRBIuhkChmedy9CQvbKviDlMn+
         9vtrAknkTmsn/yHz5DyxtaMYAjZp/0a0kFkafXh2T6yk5HFEe6/DKhCA3fw69asxN0z4
         8kQk3l46Ii0NnZ6IbNy2LsBMe2gfIpbDv43UOEK4Nc94++Kg9vEf0YgFWd/CCQvZ+F1W
         aOGjmMe3i0nMmMhb+6fyY3D5c/Z2y6Eyt6f4gCX13MjEy+4Cf7+M4HUv40gRS4L2AHan
         boAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R0LwILojUFHfDnPICXJYjY7ZqunsMyeogNZOtQuSMFg=;
        b=oREhCjzl64GeclXTw2x7Aj090+8RofqcTKozaW3PACZsFZBSAL9em6la2HdStTCzcc
         U5On6PqKJwyn67zz3szrg6PpBMXJMfZiYn9lafV1gYIYdE9OGMNGppBIqL2Gzsx6+0aO
         jE8gXLD4IZf/s9XxAB8/Zo8b4Y92qxU5+m+rLkfw02Rq2X3FKSMTIktxznSViC8HR1Aj
         C3FZQqKCDi10qV46DQte9Nn/wnjnKz39F/NwtXSptUZewFfJZNwhJwKButJ/u2yseMvf
         OY6ywkttso0fkBlJKtFGr50n1q10MkmeVQP24OT3PoMj92Q/29pYtuEmNSd/k0QOfGlF
         KLiA==
X-Gm-Message-State: ANhLgQ02zFOfgYUCpPVklmXA6Z64E6yMcGvjY6DDsBfLxGGmIRqYfVox
        XA17OvW5J0ohXpVmg6UvbpzI/w==
X-Google-Smtp-Source: ADFU+vsXGOeFIpqJL+wg5jjgV7c3N5hQd2Qs9hftlqPMXPZrh4Px1iW2CzHs2SO3/m26NcgKO+H6xg==
X-Received: by 2002:a17:90a:252b:: with SMTP id j40mr767413pje.189.1584989428145;
        Mon, 23 Mar 2020 11:50:28 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id y131sm14207652pfb.78.2020.03.23.11.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 11:50:25 -0700 (PDT)
Date:   Mon, 23 Mar 2020 11:50:21 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v9 2/5] bugreport: add tool to generate debugging info
Message-ID: <20200323185021.GC45325@google.com>
References: <20200302230400.107428-1-emilyshaffer@google.com>
 <20200302230400.107428-3-emilyshaffer@google.com>
 <nycvar.QRO.7.76.6.2003042232340.46@tvgsbejvaqbjf.bet>
 <20200319213902.GB45325@google.com>
 <nycvar.QRO.7.76.6.2003201636040.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2003201636040.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 20, 2020 at 04:42:36PM +0100, Johannes Schindelin wrote:
> Hi Emily,
> 
> On Thu, 19 Mar 2020, Emily Shaffer wrote:
> > I'll hold off on sharing my own preference until after we've got some
> > benchmarking to look at, so I can understand the whole picture.
> 
> Why? Why not strong-arm your preference? Junio and I are not shy doing the
> same, and those are _your_ patches. Junio is clearly not interested in the
> command at all, but you are clearly interested in it [*1*]. You should
> have more than just the final say over this.

We are different people, and we approach problems and disagreements
differently. I am almost never the type to strong-arm my preference; I'd
rather listen to other arguments and look at data, which is why I
proposed the experiments I mentioned here. As for you and Junio not
being shy, as you put it, I found most of the discussion offputting, and
the tone used absolutely contributed to me finding other things to work
on instead of coming back to this minefield sooner.

 - Emily
