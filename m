Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEE1C11D00
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 23:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B577206F4
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 23:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MQheOptU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbgBTXUu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 18:20:50 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40465 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbgBTXUu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 18:20:50 -0500
Received: by mail-pl1-f196.google.com with SMTP id y1so40093plp.7
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 15:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=puKbuoe7GzBXO3yPoJgvjiPzgkMx6Qa6Kps/TzlS2Ps=;
        b=MQheOptUI7n8rYFKvVWVHi7MoxGMCHI6v1F4QY8EJnQoNajS/SnoacQZl2aFbH20z5
         gMAXjWBpVhIpzfdn10Ssy2TxqE75PZQd/EYj+C2zOzG9Lg0zro3Lsa29P2x1gSteeG+K
         23SRmFJ7P2ru1+gqSYdBmmitymkbfJ6tCwNTV9aaYFACgAES7722B/QflNIdnk4Ja2oj
         vgyqEIPrJqsn4ADl5LRSczCFU2fqJ6ghIZoLeQZ0ZhnYuOrcOS61kEDiupIKqhZl3u0L
         N0NROBVbKSoQ7gKEpUC7jEjPK5XB93IZTZV2CjSPHFnaoBdf/ZNt5BdV/qGXGrDTyTIU
         /0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=puKbuoe7GzBXO3yPoJgvjiPzgkMx6Qa6Kps/TzlS2Ps=;
        b=kJgdf2oh4j8eDT6Kqd62hbU2K3Sj5qdqAtBLiuFgiTe8MpF44dY2C+7nPhX0plI8EV
         ocHl4Qm01gkpN9SrfQkgspkiM3/qQVTleR+WtHoNI0W8XolqnP+fh1KHqvc91aiTtnyw
         tunP7qfrs2uUgYDw4YC6F83t1e/+VVCBTpaRtD3gisaxb+9PClCVKyyuo/2rcU2+GAHp
         tIoaqdwi7QG/ZfGRHH6djOBb1nWUZs+4dt2roGrMnnEo0wIs4teDxdQWh1e4nW3ZyDnO
         qMJO2AhtmCH3csy/9y/OXJ0Sxihri5xjtChZ55lX7QOrnn1WKHr1tfuSkKUh8nwt9uvH
         l43Q==
X-Gm-Message-State: APjAAAXRIS6lpsm0FyhDtJTkeqOApyLoIVCXyeMaMKicDdS9YPhmCE3a
        RLQ9hOgNBiKPFnrnCzUlrwA4Vw==
X-Google-Smtp-Source: APXvYqztV3FSq7W0BspMk92R9HVsyeS98lRUEbLnYrfIoTCAYwPEe7XVGHtPDoXWsI+W/CC2agiDjg==
X-Received: by 2002:a17:90a:fe8:: with SMTP id 95mr6258469pjz.98.1582240849227;
        Thu, 20 Feb 2020 15:20:49 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id k2sm356936pgk.84.2020.02.20.15.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 15:20:48 -0800 (PST)
Date:   Thu, 20 Feb 2020 15:20:44 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 05/15] bugreport: add uname info
Message-ID: <20200220232044.GF2447@google.com>
References: <20200220015858.181086-1-emilyshaffer@google.com>
 <20200220015858.181086-6-emilyshaffer@google.com>
 <xmqqzhdd9fw5.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzhdd9fw5.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 20, 2020 at 12:12:58PM -0800, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > +	/* system call for other version info */
> > +	strbuf_addstr(sys_info, "uname -a: ");
> 
> Is that "-a" portable across systems?  That is, when given "-a",
> would "uname" on all platforms show sysname, release, version and
> machine in that order and nothing else?
> 
> If we are merely saying "in this section, we are showing a selected
> subset from what we learned about the system with uname(2)", perhaps
> just stop at saying "uname: "?

Sure, that's good enough for me. I think actually 'uname -a' on a GNU
system isn't going to match what's output here anyways, since I don't
show the nodename and 'uname -a' would.

> 
> > +	if (uname(&uname_info))
> > +		strbuf_addf(sys_info, "uname() failed with code %d\n", errno);
> 
> i18n/l10n?  Don't we want to use strerror() here?

Much much earlier[1] in the series, you suggested not i18n/l10n the
contents of the bugreport, as this list would probably be ill-equipped
to process such a report. Since it's being added to sys_info, that means this line
is bound for the finished report, not for the user.

Speaking of locale, strerror() will print the error in the current
locale; if we're still assuming "the list only takes reports in English"
should I be explicit and use strerror_l()? Should I print strerror() in
current locale and include the errno, e.g. ("uname() failed with '%s'
(%d)\n", strerror(errno), errno)?

[1] https://lore.kernel.org/git/xmqqzhka2tbv.fsf@gitster-ct.c.googlers.com
