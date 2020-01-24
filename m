Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14B6C2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 21:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723E72077C
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 21:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LegJbaj9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbgAXVUS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 16:20:18 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44701 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgAXVUS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 16:20:18 -0500
Received: by mail-pg1-f195.google.com with SMTP id x7so1745656pgl.11
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 13:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JVy3/4x7sfxI21IAcKGokBSZ/i0YM5Mrt4TRm1kfVb4=;
        b=LegJbaj95M2O4jhrzgmtjcWCrVqgoBA5vBRuTFCZMkiF+0PZ6ftPVxBBUqSWi50+4j
         gk4o8ZLFBIwSPdnMLTLcI7uXwFz1U+hUMt+xrRY4qP4c5HKSt7+Ml966DCi80YAqPAh/
         EHbZWzni9TTVpGoaIjg0FQ6pQ901yX20cQujO3ChmNAUxMUZD9HM7SIuiQN3ShfYKylb
         aQqS418jzbnpZuK519fYAO45sS53z7cu/JgZnaxgO1CO83pyUsuxP1gKvuk4Ytbb4oX5
         nN/strwn/90l139kcfSp/ncoV8L55T+PDSBPQmncKewmF8cVU6bNmpYc+xKZ4ovPj6k3
         b+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JVy3/4x7sfxI21IAcKGokBSZ/i0YM5Mrt4TRm1kfVb4=;
        b=GtKlDiBd+UAY6JXEwSm5+yzeqPEM7Sp9lEce3acLcBVX10+O3v4UmgZLZfy7ER78lX
         w0HvquFSpKZpLi+P99+x9rPzeMLDhtAzc/WSP58XVrQIu7v6Sm9IWY2xYUx9HMd9SF2+
         v9P5ONgLWfQ9zAxnyMsk0ghrX4IsKGW5Lp41z+fWb7nDxIR7gmK3UBpKCR5Qu9WL2Jjt
         Brzs4B/sORUMo/+BQE0LRIO+xX1/DO0P9PoO1po11fajnHijuV+5BTZzwYyuweDGeP9E
         cfC0TRTu23UbadZQ14DHJBwWDlnwwCLfZReU/h/x2FnMNC8KtZ0xcPpODss0D/VrpIZy
         xmUw==
X-Gm-Message-State: APjAAAXdZHMKrjBtkCXt4YTGoZ/NLTVl4CaZMTdDCBT7clg6zF05A6HF
        TY7602Rziszt/oTj2LL2D6uBbJI4EcE=
X-Google-Smtp-Source: APXvYqyfWeFXqFtuitWxJLFLkhtSRYbyNEEWh1OYMbU9cgSuIDhe7jjbN4UdqOQ4zpp5Afzn4YDOzA==
X-Received: by 2002:a65:6454:: with SMTP id s20mr6541920pgv.59.1579900817731;
        Fri, 24 Jan 2020 13:20:17 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id i8sm7284059pfa.109.2020.01.24.13.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 13:20:17 -0800 (PST)
Date:   Fri, 24 Jan 2020 13:20:13 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v6] MyFirstContribution: add avenues for getting help
Message-ID: <20200124212013.GC140846@google.com>
References: <20200124210148.220007-1-emilyshaffer@google.com>
 <xmqqtv4ky2mr.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtv4ky2mr.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 24, 2020 at 01:18:36PM -0800, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > +This is the main Git project mailing list where code reviews, version
> > +announcements, design discussions, and more take place. The Git list
> > +requires plain-text-only emails and prefers inline and bottom-posting when
> > +replying to mail; you will be CC'd in all replies to you. Optionally, you can
> > +subscribe to the list by sending an email to majordomo@vger.kernel.org with
> > +"subscribe git" in the body. You can also browse the
> > +https://lore.kernel.org/git[archives] in your browser.
> 
> Let's not place a stress on non essential part (i.e. viewable in
> browser) over a more important stuff (i.e. this is where archive is
> available).  How about this as a replacement of the last sentence?
> 
> 	The archive of this mailing list is available at
> 	https://lore.kernel.org/git[archives] to view in a browser.

Sure. I'll send a reroll unless I hear from you before it's ready that
you took it with that change.
