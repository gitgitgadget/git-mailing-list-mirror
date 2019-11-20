Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942C8C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 02:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6841421939
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 02:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CU4pgBIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfKTCJk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 21:09:40 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:34036 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfKTCJk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 21:09:40 -0500
Received: by mail-pj1-f65.google.com with SMTP id bo14so3472702pjb.1
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 18:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HItpsXwQ/7rDRd9g+JiazWo4haSSS30FrIedYVRmUe4=;
        b=CU4pgBIeDcOcsuaxl2VOpPKSfOLY7Xwj0kxje0xoumaQIdo8bZX6XIgnV7+tokZeli
         xf+nzb02pxrqTzDV9w+R3hg5VUYCbQ3MnhtE9nVkaPodhjiWA7bxDK0g3sSXd/JGuiWk
         s8zUyUYCKpiWZhEhR8B9HtM5QEHqCgygpg1j1Ua94K/Mcg4jS2a0CWX6xqAqRXDpHmZt
         L5OXa1uPQPRi+Hphvnsp/sXx6A3dqhzQeFjtvxKeRDEwx/rloIvxQaLJ/P1KGk/yeqDP
         PrDi4Wr/XL+sKBthEUAq3nLGYzOUVcMF52Pe0Dq9FzCHXaHm+ntrIRsDX7foeflXLYwA
         vbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HItpsXwQ/7rDRd9g+JiazWo4haSSS30FrIedYVRmUe4=;
        b=BbBMXfXW1xaG0vLY6sneHt3Lnvw05MDv+c25ujP7arzR4hSWGWgIw1jRyHTEO7mMDT
         Vi5+UExllpJk06S6hk4Tobisvuwx6ohMOPnVITMDGbhuY5w+NuL7ukw0A0FA7tQXPgBF
         aiIlDHrUtJVsiym0yeszjtKBa34c5sUnJwHY0lT58RrTnW8Jaa7brv0sa44UxI7VbM54
         H46PlkmdDOJYbWeXPG9jubR1IuABx+pGCs32JYttndtnQzbIX2mUbcKxOoBhYUW7f5Zl
         SxmjaHRNtAcHDze+MDVRE0X6Jm9Qhb1+JTVcks5ZhifMBevNWO1rSebbNV8rjkSQX9wT
         bo8g==
X-Gm-Message-State: APjAAAW2ghcliCsNZIMYNpwx3t8rjXeCO63DNpg+dPZbGE8sh4ro9B0c
        2BcIEKdMrR5bDxc3jsxwtuK9Qg==
X-Google-Smtp-Source: APXvYqxz0lghyyWd7jqRev6jrwOOwqOw5RNGxSpK+PUOidgXI/mlSocOde3INqzC0seuzLiQPZlRZQ==
X-Received: by 2002:a17:902:a618:: with SMTP id u24mr362166plq.296.1574215778979;
        Tue, 19 Nov 2019 18:09:38 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id k24sm28700633pfk.63.2019.11.19.18.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 18:09:38 -0800 (PST)
Date:   Tue, 19 Nov 2019 18:09:33 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 1/9] bugreport: add tool to generate debugging info
Message-ID: <20191120020933.GD36377@google.com>
References: <20191025025129.250049-1-emilyshaffer@google.com>
 <20191025025129.250049-2-emilyshaffer@google.com>
 <xmqqr2284is5.fsf@gitster-ct.c.googlers.com>
 <20191119202542.GB36377@google.com>
 <nycvar.QRO.7.76.6.1911200027460.15956@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1911200027460.15956@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 20, 2019 at 12:31:42AM +0100, Johannes Schindelin wrote:
> Hi Emily,
> 
> On Tue, 19 Nov 2019, Emily Shaffer wrote:
> 
> > [...] some other issues (needing to link against curl to get the curl
> > version, which is exactly what you implied) [...]
> 
> I did suggest on IRC to teach `git-remote-https` an option where it prints
> the cURL version (and build options) and exits.
> 
> This would have the further advantage of making sure that the correct
> information is included. If you have two separate binaries that both link
> to cURL, they could still be linked statically, to different versions of
> cURL (this could happen e.g. if you have a `git-remote-https` from a
> different build in your path).

Yeah, it's a good point and an angle I hadn't thought of. Thanks.

> In short: I still think that it would make for a much better idea to query
> the `git-remote-https` executable for the version information than to link
> `bugreport` to libcurl.

Will do - the git-bugreport standalone will invoke the git-remote-https
standalone to ask for version info.

 - Emily
