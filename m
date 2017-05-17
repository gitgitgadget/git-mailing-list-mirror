Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61020201A7
	for <e@80x24.org>; Wed, 17 May 2017 14:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753714AbdEQOw4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 10:52:56 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34413 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932121AbdEQOwu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 10:52:50 -0400
Received: by mail-pf0-f179.google.com with SMTP id 9so8648316pfj.1
        for <git@vger.kernel.org>; Wed, 17 May 2017 07:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ytBwqVz4IYoRRhMIi3qvnl6s4MYgbST/t7tVjDvrAAI=;
        b=XRAzgDdGz63FVzOWF6fFZUY4Xlt2TtiAGYTuuQWpgGaa48rjD7tbX/m7dwKYpB/lSS
         OJ93nffr2uukAhpxOMmkX0mNKEJFsFvqFbzQs2B43yMqSahJ2SMcFne2N9NkVV/Bu53h
         EETBBatUMwxDfn0M8DH6XqXO+1XOvE7daUDFZuaONLB43vlgku2W8QOt5SxNXJwIod9e
         LhuSM+BGoywgTmtWMKHe1SxzVOvaJFcxTxsULG4r+5R4haHi/1L2Jq21irl6qOdHzKfF
         GtdJvRBOXZcI6kv6vyx5wuIMkySPGfQhlBfks69zU/E8gTqW4i+XrZD/+/514jQIKkkr
         bEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ytBwqVz4IYoRRhMIi3qvnl6s4MYgbST/t7tVjDvrAAI=;
        b=PcW0qdBwOGggrklqi/1cXgpCBlBiuZMbMDuo6rjJf2s+8GO7YBiP4WTiQfNirNZP3u
         wdmxXGvGWXN9R1ElEGNpQuuY41RuDBkAlxQHZr4f7zby/iLaw43sJ/IHNejm7vErFrQK
         lwjx4D9GZKAT2XZVcRSK6MtCs8PEvip+N7Cy0echT6BGXvTxZRwi0zzSogMrLWRx/3X0
         OZqiGLixuyEj58fo+Tp84RANjgseyZ/8NksKJkENBeMxGqg4SGrQdRTA+IDT7u9rIkKp
         QlF8XAMYWirfzxPFb6YS3USo9QKGdi8+0UGMzxcqigMAfKbUD9O/CN999sCs1nE8BiAV
         8kYA==
X-Gm-Message-State: AODbwcA0B39vLeMo0LfzLMsLim88OqIkpsj84qTyBxACNfZAOkdGqnK+
        bfzabLLC/N8XdArQ
X-Received: by 10.98.76.76 with SMTP id z73mr4086301pfa.99.1495032762879;
        Wed, 17 May 2017 07:52:42 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:6c78:c1b9:36d1:fa23])
        by smtp.gmail.com with ESMTPSA id k86sm4695773pfk.125.2017.05.17.07.52.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 17 May 2017 07:52:41 -0700 (PDT)
Date:   Wed, 17 May 2017 07:52:40 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        j6t@kdbg.org, sbeller@google.com, e@80x24.org, jrnieder@gmail.com
Subject: Re: [PATCH v6 04/11] run-command: use the async-signal-safe execv
 instead of execvp
Message-ID: <20170517145240.GA185461@google.com>
References: <20170418231805.61835-1-bmwill@google.com>
 <20170419231327.49895-1-bmwill@google.com>
 <20170419231327.49895-5-bmwill@google.com>
 <xmqqfug4z0s0.fsf@gitster.mtv.corp.google.com>
 <20170517022602.jj26pf7eypxp2fjm@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170517022602.jj26pf7eypxp2fjm@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/16, Jeff King wrote:
> On Wed, May 17, 2017 at 11:15:43AM +0900, Junio C Hamano wrote:
> 
> > > +		if (errno == ENOEXEC)
> > > +			execv(argv.argv[0], (char *const *) argv.argv);
> > 
> > "/bin/sh" tries to run "/usr/bin/git" that was not executable (well,
> > the one in "usr/bin/" would have +x bit, but let's pretend that we
> > are trying to run one from bin-wrappers/ and somehow forgot +x bit)?
> > 
> > I think all of that is sensible, but there is one "huh?" I can't
> > figure out.  Typically we do "sh -c git cat-file -t HEAD" but this
> > lacks the "-c" (cf. the original prepare_shell_cmd()); why do we not
> > need it in this case?
> 
> I think this is the same case we were discussing over in the "rebase"
> thread. This isn't about running the user's command as a shell command.
> Note that this kicks in even when cmd->shell_cmd isn't set.
> 
> This is about finding "/usr/bin/foo", realizing it cannot be exec'd
> because it lacks a shebang line, and then pretending that it did have
> "#!/bin/sh". IOW, maintaining compatibility with execvp().

Exactly this is all about ensuring we do the same thing the execvp does,
because there isn't a portable variant which allows for passing in an
environment.

> 
> So the command itself isn't a shell command, but it may execute a shell
> script. If that makes sense.
> 
> -Peff

-- 
Brandon Williams
