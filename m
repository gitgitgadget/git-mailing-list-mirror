Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E956C43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 23:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F2EE214AF
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 23:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nbd7w/+d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfLKXPn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 18:15:43 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42907 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfLKXPn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 18:15:43 -0500
Received: by mail-pf1-f193.google.com with SMTP id 4so60786pfz.9
        for <git@vger.kernel.org>; Wed, 11 Dec 2019 15:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EGNOZN1SeGhhi3p9cTIxH9hrX4/oLIw+GbzKG2gtPeo=;
        b=nbd7w/+dIGNyj5P2CAOGX+z4F/EstHVM6fb8KFgYFLGeQwMqKgb7MyYSOkieTHac9l
         +gnMc9MhtbRsZRZidephboMdQh8FI/Nvad5IZI6nQC4Bckrxa9cuzXN7MGNMPS8DilQR
         FnZeSOf84DMRbK7mA5zd+dITelk8NkbRirSYQ1+kqeuAn+u2RdcOLYJSxpqjiD8h6u6n
         JKDJXbzf1m8e/lAIKGXkjb4QBRufF2po4qjfMQmCNrErILDJ6OHcYRT6C9IwPZTJIz9p
         yLndvJFD2DvEqewddz7sM9F3Sgf32WIpVdvutzLc0ZVul1wq6Ty665zQmbsDTbdwdwFK
         mGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EGNOZN1SeGhhi3p9cTIxH9hrX4/oLIw+GbzKG2gtPeo=;
        b=fmI2CMEOcWZmC82xlUqg3qV+C9jRztXy+itGsQ/4G04DlkXJrUWIg2iFrAm2e5wdGZ
         5r8M1pSWqqylq5RNwSJtjhFOdHY9v6SLbFR/88Qy1b7sazIMXWJwiBfXTJZq2vYS//EX
         5oxyTY5arGZw+lDviO65qpWdoEUGLapn6wn6R6RuorWiBLr9JWgMYzhjXVDfBG8aofIA
         7TOXhacPhfBYpQuRzs62Dgnx7nypGWBROwlhszy3+nLdQjMZxPEaJ0oNR4R+yWjeDgjA
         hPICRCQrd/kTZi6BGVvoUUVMfeJJ/4dIndGE5Z20purdJTO6LMaq0XCTRpkvleP1bnSu
         I18Q==
X-Gm-Message-State: APjAAAWgqKlUlcmc/iLQprAaUNt/lcMScGC23kJCO1ZrNDV3Ue5M2Kms
        jvaIXI+HfCzP3RRhkLC6N7wtcg==
X-Google-Smtp-Source: APXvYqzyQcF3S9t7J87WVAqdlsfGEnuStl9uRW6UYmT5z0PriItKJBqQ6a6roU51cl3AjE1X7Z+h5g==
X-Received: by 2002:a63:4e0e:: with SMTP id c14mr6975780pgb.237.1576106140833;
        Wed, 11 Dec 2019 15:15:40 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id p24sm4252176pff.69.2019.12.11.15.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 15:15:40 -0800 (PST)
Date:   Wed, 11 Dec 2019 15:15:35 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/6] hook: teach --porcelain mode
Message-ID: <20191211231535.GD8464@google.com>
References: <20191210023335.49987-1-emilyshaffer@google.com>
 <20191210023335.49987-7-emilyshaffer@google.com>
 <xmqqimmmodwt.fsf@gitster-ct.c.googlers.com>
 <20191211220039.GB8464@google.com>
 <xmqqwob2ms7i.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwob2ms7i.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 11, 2019 at 02:07:45PM -0800, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> >> So, a Porcelain script cannot learn where the hook command comes
> >> from,
> >
> > Not as I had envisioned.
> >
> >> or what the precedence order of each line of the output is?
> >> 
> >
> > They're printed in the order they should be executed; the explicit order
> > isn't provided.
> >
> >
> > I suppose I had considered really just the one use case listed in the
> > commit message, especially since other inquiry into the hooks to be run
> > can be done against the config files themselves. But - I'm of course
> > open to use cases. What did you have in mind?
> 
> A tool to diagnose why the hooks are not firing in the order the
> user intended them to, for example?
> 
> Or a tool to help editing the list of hooks.
FWIW, the next step for this 'git hook' tool is just such a mode,
although I certainly won't argue with anybody who wants to interact with
them somewhat differently.

Does allowing a format string solve this, then? Maybe it's less
Git-idiomatic, but it seems to me to be a very explicit format contract
that the scripter can write, and probably more useful than guessing what
info one might want when scripting. It also doesn't paint us into a
corner if we add other interesting info later.

Unless you have a complaint about it, I'll try to add that kind of
argument instead of --porcelain for this command.

 - Emily
