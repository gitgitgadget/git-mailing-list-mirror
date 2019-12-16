Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23081C43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 23:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD2922464
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 23:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fRFzjHFN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfLPXvi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 18:51:38 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44183 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfLPXvi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 18:51:38 -0500
Received: by mail-pl1-f195.google.com with SMTP id az3so5191455plb.11
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 15:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5xa7ih3JZdaTUxsg6hEyz9rg5xwk6qvSgnY7NiS4Bk4=;
        b=fRFzjHFNmqDe0/IyrKAjU+7eB+pFvjFBVgK/POITqr4aijtpBfwBVcyvMvMjD5LShb
         HxJZsTPbsXkefVR70Oh1YkGsv4/zUuMT98pElS7uJvOnT+RL26L9WCKHOaaNVvFm2Iun
         eW/13Ktra+tINo9Yp0aky92ZvQ2+m/L5125BIZ/YsFeGSjU/L0YC5ROJT3LLP4lOBA0L
         XtSODh8vrdu4hGpiBmYsALScEx9nAl4VUQi2AR4tEXq6yh2oL1XDwC00IrQ9ICV/8ZYv
         BlAVFeAp0NRnfN2lIqCUPnhgGVqUznz4hHKQEYgeW5wy4vDtnB3NAHH0cIjDtUurYOpO
         PTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5xa7ih3JZdaTUxsg6hEyz9rg5xwk6qvSgnY7NiS4Bk4=;
        b=eNDkEg+1XYTBW93yTV250rKPh3iBjp4FgS3b/tHO+952Wrw9J4/hjCLmGAlL1Q6Gsj
         gHJyQU3v+68KbdAN1PWglJ/bHqfjSEh3xu/dcsnFepFw/bxbyRfyibznToyAmO24GBW+
         sCyAy8b3ZCYVkszw+e0QpWNJkLJk5oXrB5feZ4Dvsx9CCVbrwwjIXquVWtgEDObiOc2r
         Kk/SROXEWODqvPkRjyKRucAg9dIHMz0gLz/GMEgJzY9ztz7XMxUjALX+MgYkg3H9IHpX
         Yc3JvP4KWZVZRMO5Gy2o6LLlkB4hkPmwOa4e7Zu21CLrMfbp2qnMjfvQJ3/EJxVhUdxv
         63cA==
X-Gm-Message-State: APjAAAWB/lbOpMMdAggt7lNe0y+uBaXbSPNF9hgY2rlTFvfKMrCFB8km
        rIduIS9gLLopWWna98jvQgJrorz8ucg=
X-Google-Smtp-Source: APXvYqyNbtVD+jZ4uSF7Ytl/bs4JCWE9iWScMKww8pzHl1UjcOMog5ahnMSIL+UILKN7Yuz8h2zu5g==
X-Received: by 2002:a17:902:bd41:: with SMTP id b1mr14100084plx.82.1576540296846;
        Mon, 16 Dec 2019 15:51:36 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id h5sm24223903pfk.30.2019.12.16.15.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 15:51:36 -0800 (PST)
Date:   Mon, 16 Dec 2019 15:51:31 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 11/15] bugreport: collect list of populated hooks
Message-ID: <20191216235131.GL135450@google.com>
References: <20191213004312.169753-1-emilyshaffer@google.com>
 <20191213004312.169753-12-emilyshaffer@google.com>
 <xmqqzhfvhp8w.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzhfvhp8w.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 13, 2019 at 01:47:27PM -0800, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > +	/*
> > +	 * Doesn't look like there is a list of all possible hooks; so below is
> > +	 * a transcription of `git help hook`.
> > +	 */
> 
> We probably would want to employ technique similar to what you used
> for the list of safe configuration we saw in an earlier patch in the
> series.  What's not even documented is not worth reporting ;-)

I somewhat slightly would rather not, since I hope to include a list of
the available hooks in my work with git-hook:
https://lore.kernel.org/20191211205114.GD107889@google.com

It's true that the way this patch is written now is prone to bitrot.
It's also true that I could win the lottery tomorrow and never finish my
hopes of git-hook implementation. And it's finally true that I don't
want to write a fourth build-time-generated header which scrapes docs,
especially if I also plan to delete it two months from now.

I wonder whether a better approach might be to drop hook support
entirely here, and add it later on when this particular bit of tech debt
(no canonical list of hook names) is solved, one way or another.

Another approach may be to just list all contents of $(core.hookdir)/
which doesn't end in ".sample", which is what the bash first attempt of
bugreport did. This does mean that those who have something like:

  .git/hooks/
    pre-commit
    pre-commit.d/

  pre-commit:
    sh pre-commit.d/a
    sh pre-commit.d/b

will have their multihook config exposed, although the contents of those
hooks won't be.

I'm interested to know everyone else's opinion, because mine is biased
by my hope that I can solve all the world's problems with git-hook ;)

 - Emily
