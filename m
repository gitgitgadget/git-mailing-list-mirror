Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375B1C35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 02:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051592085B
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 02:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZJ4vjB1s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgBECbe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 21:31:34 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36584 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbgBECbd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 21:31:33 -0500
Received: by mail-pj1-f66.google.com with SMTP id gv17so293355pjb.1
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 18:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=G/xLany6+ykjD4mOwdivqbCoYFVhfV4r7dk6WQVIqHc=;
        b=ZJ4vjB1sYhS9lwJxT/VUqlEO1kXx6IXhX7L9wT5lnHqC6XWJoy077N7z1q8EPS69Ew
         diDpGuKlP1A3Bon/vdU7GzdXzC4bU3mi/bTYR9YvQbaV9lTgRj7cyUCt82y8QrK6lh41
         F10HsZoZQLIBRKG8mgvZ7FudOvWWxzL1b1/S1P06Xa7K2rpiey8Sl4AgYk0aYg2hZ0IC
         wRxe9wdXINPcAKZCuVZI5R8HI9H38clUpZRVBuTtkyV69olGQM2XJS5XqgD+s9Jmymzm
         2UqtsudP0Qp/jI3LAOq/WCGdLD4abT0g9/Xow99V/XCQEHSAiwuFkF6y3b9907fEv4fU
         YSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=G/xLany6+ykjD4mOwdivqbCoYFVhfV4r7dk6WQVIqHc=;
        b=NHA4VOCXt8kFggkNJIG/B8z3vcAsj5YR4jKM5oEa3d2MUhZbCVb67PCnRpTjkfvQOk
         Abb91nlQ9pbwwB74Y0ivx9b0WvL3VG07bfe/gmV4hIwru/Cwo9+PBY+Trf3fEs0aI7Lm
         tNJLJbpakRbl/Uxjcv7mTeMhlqggkpDOCsYSFy4IrUMohVMHvK/MtcKuJqaaaFtz4SyJ
         wWzrEAv7YX7Q2LQNn1nM/APRaD7pau0DQIZR20KvfN/Vvqt2GTvZRavCRDRHkVmeGp68
         aoHejW3wAl/IPTZ979QDa8QXa+Onb4IzeaqtF2gPY4vgefQxJQxklCky3QHnyTCzgL5N
         5v3w==
X-Gm-Message-State: APjAAAVc8KoJfjQcOaZ+nOXG8sEtTihN45yQo/CxO36EbRUDr5CMZ093
        BZH4bukPGgtPUJrmrf7Hy7Aegg==
X-Google-Smtp-Source: APXvYqwk8zVSrlSD2FfU6oOMxgc75qhGsVlLeZBeQ/xNUX6+/0TGxZQXtqusrhDuL1GFlGqwnvp20w==
X-Received: by 2002:a17:90b:289:: with SMTP id az9mr2759645pjb.23.1580869892910;
        Tue, 04 Feb 2020 18:31:32 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id g21sm26628489pfb.126.2020.02.04.18.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 18:31:32 -0800 (PST)
Date:   Tue, 4 Feb 2020 18:31:27 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v5 10/15] bugreport: add config values from safelist
Message-ID: <20200205023127.GL87163@google.com>
References: <20200124033436.81097-1-emilyshaffer@google.com>
 <20200124033436.81097-11-emilyshaffer@google.com>
 <CAN0heSo_Ois83gqNrHvNn2HSMMTXvKShxTb_RdG2qY6D7rnthA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSo_Ois83gqNrHvNn2HSMMTXvKShxTb_RdG2qY6D7rnthA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 31, 2020 at 10:25:06PM +0100, Martin Ågren wrote:
> On Fri, 24 Jan 2020 at 04:40, <emilyshaffer@google.com> wrote:
> > Taking the build-time generated array and putting it into a set saves us
> > time - since git_config_bugreport() is called for every option the user
> > has configured, performing option lookup in constant time is a useful
> > optimization.
> 
> I'm sympathetic to your sending out what you have to obtain comments,
> knowing that it's not perfect. It would have saved me some time and
> effort if I'd known that this was the case though. An "[RFC]" tag,
> perhaps. Or at least tweaking the above part of this commit message to
> say that this might be over-engineered, with a reference to [1].
> 
> [1] https://lore.kernel.org/git/20200124032905.GA37541@google.com/

Yeah, you are right, and thanks for the feedback. I think I had wrapped
up the series before I realized there were those significant outstanding
comments, but I definitely should have said so in this patch.

> 
> > +       int safelist_len = sizeof(bugreport_config_safelist) / sizeof(const char *);
> 
> I was going to suggest ARRAY_SIZE, but then I realized there are some
> outstanding questions around whether you need this stuff in the first
> place. I'd be inclined to guess that the first version of this would be
> "for each safelisted item, obtain it and include", ignoring any "a.*.b"
> business. In which case you wouldn't really need this hashset stuff.

Regardless, I think it's worth doing nicely for now.

It seems to me that supporting wildcarding in the config safelist is a
superset of supporting static strings in that safelist - that is, if I
write it simply to support static strings, a later change to support
wildcards would be welcome and non-breaking.

So I'm going to clean this up without making it more featureful, for
now.

Sorry about the confusion!
 - Emily
