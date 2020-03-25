Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B1EC2D0E5
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 21:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1FD8207FC
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 21:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S/RRaFAg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgCYVKd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 17:10:33 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43373 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbgCYVKc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 17:10:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id u12so1760184pgb.10
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 14:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UWsNzHpSKhh85fV5KCs3mV7CPJr3TJGYk1FwP+1Y/os=;
        b=S/RRaFAgwAzxz9+3tlF2Fclho48Sy06yDFvZXLH8izUr8v4AP+E2syvvSwALT4fRh2
         BwwD8SkzatMrBIzggDGHg3CjEnu9Gui/vnIdZJFgOqHqgQt1pruczqcy3LcUQmVPAYSK
         Ad6cdIEQOczL3gqSM2hO4HNOQhfD17m169Z2wg3KIOiZJFAO9QexbSn3Gjajs6jmkBl7
         QLwCv38BGlnWiYvpH9hEADvtmQ0FDidxY10CgT24DoDCPzyXbtJa2b0kPjMlIAsLr/1O
         I9mXXIZ6gXkA4StYJoawTP62AAMxagFg2uTzWB/x/6smpZGAhgQ0E0Nb/w7Wn6G8sOjU
         IyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UWsNzHpSKhh85fV5KCs3mV7CPJr3TJGYk1FwP+1Y/os=;
        b=dqEJCF32eHfpzCYx3/6AvuIGaPE6Lyg32a33rEMaVl90jD7iFtvFeozvwkkoxJC1QC
         r1fWhhVgBkQCiipugEpAH2pOSYLX5jQ+YnX0b1K3ROOfrkJ+zKlGg+FCDfbQcZEYpDsJ
         //ZPIjR9gzTBkGsF7Od1l3NJcx1WzEv9vs4URFQNQEySP6khikxtH/Nj3BTfhV8vxhD4
         ERRrWfiFh1ef2qjkB/pXX8SleGBtPcK2HFb3sUbEvSr4V0XvCGW68iJVJHMCPAHB+trT
         1u/JcaRv3D1XM8HvTvfJpLn7deEq9Mp/1ZXl7MfWY4uCcdQutQZLZ3EceadxbuECWCUF
         6E/g==
X-Gm-Message-State: ANhLgQ0i3ghuvz3/ZTKuU4+dQ1aPN92mR4u0INff4PjiGroRqmmR2yFJ
        yxoTQEECOpEQqQrXBoju4F0bJg==
X-Google-Smtp-Source: ADFU+vuGwZdLAOkmcKNI2hjsgGFVlNwNqs7QPNXZXQ9/wEE5Al0p4JFCsOZJemWw+O1dFV/VIZUbIA==
X-Received: by 2002:aa7:8649:: with SMTP id a9mr5466776pfo.138.1585170629927;
        Wed, 25 Mar 2020 14:10:29 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id i20sm55018pfd.89.2020.03.25.14.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 14:10:29 -0700 (PDT)
Date:   Wed, 25 Mar 2020 14:10:24 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v10 5/5] bugreport: add compiler info
Message-ID: <20200325211024.GC53368@google.com>
References: <20200323214340.182724-1-emilyshaffer@google.com>
 <20200323214340.182724-6-emilyshaffer@google.com>
 <xmqqlfnq3bwc.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlfnq3bwc.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 23, 2020 at 04:10:59PM -0700, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > +#ifdef _MSC_VER
> > +	strbuf_addf(info, "MSVC version: %s\n", _MSC_FULL_VER);
> > +#endif
> 
> This part is a bit different from what Dscho suggested to be
> squashed (and I have had on top of v9 series).
> 
> Below is a diff between (v9 + SQUASH???) and v10.  I think the
> change in the strftime format is a strict improvement.

Hmph. This is different than what I have in local. Please ignore this
entire v10, I've made a mistake in my tooling. I'm sorry about the
noise and for not checking over my patches better before mailing.

 - Emily
