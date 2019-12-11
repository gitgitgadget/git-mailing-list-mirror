Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CEFC43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 23:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775D72073D
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 23:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rkcgW19I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfLKXLw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 18:11:52 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35658 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfLKXLw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 18:11:52 -0500
Received: by mail-pl1-f193.google.com with SMTP id s10so198749plp.2
        for <git@vger.kernel.org>; Wed, 11 Dec 2019 15:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ORZ1zZV7McH/B8SfQT1a1nsoqzQQvvCtEWNaFBYsZbQ=;
        b=rkcgW19ISiyxbs/CjkWrfUijbV1MqvtyNesy46Myu7mO85qm7SRGCgt7TSHpL1Vspf
         YoJbWy4DimHxFZvEeoZE/zXVx5xGMsbr9ZO4qHeYhT+M2CeQ8J12LCRiW5NhgN65CFGk
         xGn8GnUunNpbh5yOk8rvHz8mZtd1t62usAMQsqr0QASFXIiXrIcj7olbofQaBwD4yNyB
         EbFyts/+Vcm8INXJRzRpW6GlMf7e8UweTkbCoGqEIBI45Okec9yR9FR/4CEvdQAclDZr
         0P6EUQssCnSDuZo0LqppzibtXGUDVlDvhlvFetrC1TrGP5x0sODK4ZrfTx1Of7Dr8Q/u
         L3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ORZ1zZV7McH/B8SfQT1a1nsoqzQQvvCtEWNaFBYsZbQ=;
        b=ED20Ybb+6FGpLRVY5ut4NGDWdHEiG4xkX7TXM8QJFO8HiDAh6SMb9IMVUF6VM0DmuA
         qihNy56htZ8lUMzs+M+Ac+Gqeeqjq+EZp1wAt7eJQiAebPgpqOm8L/c+1LEPHNPlutyH
         Kp9EwA6pkWIMO17+vM4TbO3a50Hb0tmxjwV0VKxiWLsn24LEUJLSnNGAjDGlTXQaWMWw
         YvlSL35drw2URNGr15g0lPuemZORFiROAPaN6mvAl7HHIRCR4je5B8J9dTB88fE5GHSD
         itx4Blellt9INAww6bkA8F87mW1bQGjkx34OO7Sf09a8Njf2arN3/FWCWxp+dtsYM0D7
         MFaw==
X-Gm-Message-State: APjAAAUoFHvbsIm6MIzE+Da1KPMXXscX6MGAUupJGsNab+WRE210jDYd
        JvaNtq/ItXlbNdHlj+ov76ITrg==
X-Google-Smtp-Source: APXvYqzJYR8gioINM+XgO1YLbvqR3R3EAIRhJWxycZ+a+rdpLZ6HmTf+M1s2dX0YwRW+Z9vGbosINA==
X-Received: by 2002:a17:902:203:: with SMTP id 3mr6154068plc.170.1576105911351;
        Wed, 11 Dec 2019 15:11:51 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id k18sm4462106pfe.7.2019.12.11.15.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 15:11:50 -0800 (PST)
Date:   Wed, 11 Dec 2019 15:11:46 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Matthew Rogers <mattr94@gmail.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH] config: add string mapping for enum config_scope
Message-ID: <20191211231146.GC8464@google.com>
References: <20191211220933.48678-1-emilyshaffer@google.com>
 <xmqqsglqmrn6.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsglqmrn6.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 11, 2019 at 02:19:57PM -0800, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > If a user is interacting with their config files primarily by the 'git
> > config' command, using the location flags (--global, --system, etc) then
> > they may be more interested to see the scope of the config file they are
> > editing, rather than the filepath.
> >
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> > Note: This commit has been cherry-picked out of the "configuration-based
> > hook management" topic, at
> > lore.kernel.org/git/20191210023335.49987-1-emilyshaffer@google.com
> >
> > It turned out that I wanted to use it for git-bugreport as well - to
> > explain the origin of the configs we are printing in the bugreport,
> > without directly exposing the user's home directory path.
> >
> > This seems to have similar work to https://github.com/gitgitgadget/git/pull/478
> > which I believe hasn't been mailed yet; but that change is targeted
> > towards the builtin config command, rather than the config library.
> > Since I wanted to use the library, I'm sending on my own now. Maybe
> > this commit will be useful to that change's author.
> 
> One thing I wondered about this in the original version was if the
> returned value should be localized.  In the context of the original,
> the --porcelain mode refused to give this information in its output,
> so it was OK to always localize the returned value to satisify the
> other caller who wanted end-user-facing output.
> 
> But as a more general helper, I am not sure if this is the most
> useful way to implement it.  Shouldn't the function rather return
> the machine-readable tokens and allow callers to localize it as
> needed with its own _() around the returned value?  I dunno.
> 
Hm. I think that's a good point, and allows this helper to be used for
something silly like putting together a sample invocation to 'git
config' if desired. It's meant to mirror the scope given to 'git config'
- which makes me think that no, it shouldn't be localized, since the
argument isn't localized either.

Ok, I'll take the locale marker off.

 - Emily
