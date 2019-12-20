Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805ACC2D0D1
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 01:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF3B227BF
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 01:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cczDSzEo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfLTBZb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 20:25:31 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42459 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfLTBZa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 20:25:30 -0500
Received: by mail-pf1-f194.google.com with SMTP id 4so4285726pfz.9
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 17:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c9JGWTcl2mlzGhtLRQzOwFRNMhGfZr4pjtPd1qF0ot8=;
        b=cczDSzEoC43jv5jJxzF04VeY3zj4wCHu6pMQ71fkYcM5NPYc5AyeJnRCckbvD3mvMH
         4IGRkEIaKWCK0mklLYhgOv6mfeLp9uFzFY18thppuXaPoSrsilWaS9+8tqhBVi+UYcvb
         FtXwF1ZR6pxKnmL0zT0D3xyGzJmpO6g1kKosnz14hgph1IfldEQ887KCMCrMunfbOIIh
         WlPTt0AkiInnkATUW38OyqtH9xuI3BO5Uk9ynLlbRA8ES9voj7D2CYAUDKW7L8Ge66xv
         hXiJm+E+Qn+IMvL3a3mDlGDYH5aOvPUTpKzUzjLWbbQ4G6nPBPEiaVjfZZ8yEfU0zByu
         vCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c9JGWTcl2mlzGhtLRQzOwFRNMhGfZr4pjtPd1qF0ot8=;
        b=AxXuSGoTxIwrEwxG23I3bTQM6mbALfceCViVx5z7zSa/lw/n4H3mqcIQG7bpkFtBQB
         tG7mB6UuC/+Zy+OMGeIKz+YgdOyz6lH5tQWY408Ec5w/VyZlNv2gedcHevEUUMaqIFMx
         /FloffGVcQbThuEArC8XGUFLOFQGgd79VezrLzk3YkKJrCgZ65lmsZslt0XVnvIW5HYe
         o8XcK6UuuisxwxXZutXMtnhn7RsWJPACPTnXRondSrH1GgNb29I7JGBpIcv/5qivqe3W
         iCVWfrpUNcHujSNhpuu1aPpSmwKYJGzBHnfyX5FMEGPjZrxAiaGncTO62suYJBPjPiFw
         7flw==
X-Gm-Message-State: APjAAAWgoXJbmqR9/z3OcM5mhrXQNOUQPEFRra5PtAIOMQHm5D8hvwMX
        SIWVcuKWhakgWLM35SqohQ7j5A==
X-Google-Smtp-Source: APXvYqw+lu/OmUP77czD/pgiNbN+wKQIqEpJjBxqAl6GetqMAXNJqtTjjXhIhsr9hdayprhnEuxGMg==
X-Received: by 2002:aa7:9522:: with SMTP id c2mr12947819pfp.43.1576805129728;
        Thu, 19 Dec 2019 17:25:29 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id p28sm8936770pgb.93.2019.12.19.17.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 17:25:29 -0800 (PST)
Date:   Thu, 19 Dec 2019 17:25:24 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v4 03/15] bugreport: gather git version and build info
Message-ID: <20191220012524.GB227872@google.com>
References: <20191213004312.169753-1-emilyshaffer@google.com>
 <20191213004312.169753-4-emilyshaffer@google.com>
 <nycvar.QRO.7.76.6.1912171941451.46@tvgsbejvaqbjf.bet>
 <xmqqfthig07m.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfthig07m.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 17, 2019 at 12:34:53PM -0800, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> +	if (build_options) {
> >> +		strbuf_addf(buf, "cpu: %s\n", GIT_HOST_CPU);
> >> +		if (git_built_from_commit_string[0])
> >> +			strbuf_addf(buf, "built from commit: %s\n",
> >> +			       git_built_from_commit_string);
> >> +		else
> >> +			strbuf_addf(buf, "no commit associated with this build\n");
> >
> > The "StaticAnalysis" job of the Azure Pipeline is not happy with this,
> > claiming that this should be an `strbuf_addstr()` call instead.
> 
> You mean the "else" clause, right?  That feels similar to say
> 
> 	printf("Hello world\n");
> 
> should better be written as
> 
> 	fputs("Hello world\n", stdout);
> 
> which I do not agree with at all.  IOW, I view the distinction more
> like "once it is written one way or the other way, it is not worth
> spending bits and braincycles to see if it is worth changing it"
> kind of minor stylistic preference.

I think I side with Junio here, although it's true that when
strbuf_addstr() exists it doesn't make that much sense to use
strbuf_addf(). Since there's some other comments, though, I'll change
this too to make your CI shut up. :)

 - Emily
