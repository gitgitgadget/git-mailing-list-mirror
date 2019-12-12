Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E347CC43603
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 03:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B266D214D8
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 03:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bo6P2A0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfLLDpx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 22:45:53 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41654 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbfLLDpx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 22:45:53 -0500
Received: by mail-pf1-f196.google.com with SMTP id s18so13073pfd.8
        for <git@vger.kernel.org>; Wed, 11 Dec 2019 19:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QIeSJnDVbZoBhZNuBdYge4nY7IoamCuEPWak71gIeMk=;
        b=bo6P2A0sVjQUfZK/BIsNWBBRSSHwupK8KWE09B45dmunANU1JPLkP4QQkQ6WpILdNC
         L1l/6C/ZA3uvGjkK/+mFEN9pjCs7Cp3zdVvOnoYjUSQ3f7EsfcRbcISDsqA7VLRJm4/b
         7yMfRzf64JfYBZU8411YX0QHeX/XnxBM1XcZQFWw9zgUPifVog8Ng+P0p2qMn8/xA6HB
         6Tk3k/+YyLnZt0K12c+b6EswMMBeXprJrVXKlOZt66Ah6iiJylVuqcFyPDZXVU6rCLqM
         93DlJS2vXDZdrT1gFBvQS5xzTz00I7kkE+VRw6E3P3Rqr8E2H0p0cQG3mFYHwJ82N9hT
         OVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QIeSJnDVbZoBhZNuBdYge4nY7IoamCuEPWak71gIeMk=;
        b=DVRKpLfjS+PNG+FIVKHI1TYL7FBnE5/Sus9wJM1PyMOtHmg6UmwcJaycM6NAbxyM0P
         ZN2cYCn2mnT43RZ4sLI7wK7x2IXeUSMqOIkn91GMeJ0NOm6Liq3v121/9q9nIO+gwZZn
         mLiCIdvlOerXmGS0dm/2yCkBA9QPfSoCr9/2HOvYepP7S3XWZCdLbWNGMxj3UOfxCZSw
         zKkAe9DO1SZyjDsYTUWHPtjPr2dKog5WvCfGE6TbIOde63IrD9+a+WGtXzZiatXYxqAj
         5D8nD7s8b/317O4D9vG53d4YPa2mmQK8dRYdN40vVcb/mwFSuZe1MTmlzfXONyibvjSj
         LwEw==
X-Gm-Message-State: APjAAAUrfNEbzfLLtm4WBDyHGIkwRmyEHUYf2IoY5upQj05DgvNepCVt
        SIrimf+HzzeltmjoRwvcTnQhuw==
X-Google-Smtp-Source: APXvYqyBhgdJ9/uL68k0A602NBbtn/EZOPCSmkA7g35MHlShWo1biCR6XCqthIHDNxagNegZ7r3SdQ==
X-Received: by 2002:a63:bc01:: with SMTP id q1mr8534847pge.442.1576122352361;
        Wed, 11 Dec 2019 19:45:52 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id b21sm4942377pfp.0.2019.12.11.19.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 19:45:51 -0800 (PST)
Date:   Wed, 11 Dec 2019 19:45:47 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Matthew Rogers <mattr94@gmail.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v2] config: add string mapping for enum config_scope
Message-ID: <20191212034547.GA226275@google.com>
References: <20191211233820.185153-1-emilyshaffer@google.com>
 <20191212031003.GA1196215@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212031003.GA1196215@coredump.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 11, 2019 at 10:10:03PM -0500, Jeff King wrote:
> On Wed, Dec 11, 2019 at 03:38:20PM -0800, Emily Shaffer wrote:
> 
> > If a user is interacting with their config files primarily by the 'git
> > config' command, using the location flags (--global, --system, etc) then
> > they may be more interested to see the scope of the config file they are
> > editing, rather than the filepath.
> 
> I don't mind adding this in, but I think we did discuss this same
> concept when we did "config --show-origin", and ended up showing the
> whole path, to help with a few cases:
> 
>   - you know you're getting a value from the "system" config, but you
>     don't know where that is (e.g., because the baked-in sysconfdir path
>     is something you didn't expect)
> 
>   - you're in a scope like "global", but the value actually comes from
>     an included file
> 
> Of course there's a flip-side, which is that showing "/etc/gitconfig"
> doesn't tell you that this is the "--system" file; the user has to infer
> that themselves.
> 
> There are no callers added here, so I'm not sure exactly how the new
> function is meant to be used. But I'd caution that it might be worth
> showing the scope _and_ the path, instead of one or the other.

Yeah, I hear you - I had added this originally to the config-based hooks
topic to get an output like this:

$ git hook --list pre-commit
001	global	~/foo.sh
002	local	~/bar.sh

That's a scenario where it might be handy to add the path, especially if
it's coming in via an import, sure. (For brevity I think I'd want to
turn it on via an argument.)

As I was working through the comments on v3 of git-bugreport, though, I
saw a request to add the origin of the configs - and that's a case where
I don't necessarily want someone to see, say:

[Selected Configs]
user.name (/home/emily/robot-revolution/stairclimber/.git/config) : Emily Shaffer

when I mail that bugreport to the Git list.

So, I think I hear what you're saying - use wisely - but I think it's OK
for a user to say:

  printf("%s (%s): %s = %s\n",
         current_config_name(),
	 config_scope_to_string(current_config_scope()),
	 var,
	 value);

That is, I don't think the right solution is to make
current_config_name() provide a stringification of
current_config_scope() as well.

Or, I guess we can decide that the bugreport scenario is different
enough that this helper should exist only there, and everybody else
should use current_config_name().

 - Emily
