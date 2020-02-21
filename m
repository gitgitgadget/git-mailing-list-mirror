Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B93C11D00
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 02:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8652F24673
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 02:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aTQcaRMQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbgBUCxM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 21:53:12 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40266 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729290AbgBUCxM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 21:53:12 -0500
Received: by mail-pg1-f193.google.com with SMTP id z7so235303pgk.7
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 18:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PRMhYLVs5h1ZsZpiXevZFxArg/nlDuNzZU0ECG7LUYU=;
        b=aTQcaRMQjgR117B1aAmoKK53kFQxQ3bNqr0m/hR16kE5aY/N2ZUkSaJyx7whP1kAge
         e5q/GzBdEDRIO8/6MRSZKsA3xo6+M/RoCsn8toIpDq1vtv+DxlpwVnfz0TtsusqiaTnk
         ydEQ1QrZ6nXmeCGHLOhwtvMYRXnv3C6f646gbdoEK1fGQJTw6TJqgDg+9vCRNAOthCcY
         xQgBUS3LzZVmQPxruhXoRISawa+zy8AS8f8RnKhegO6Awa5GhcUVfv8omIQnFxJWOEAl
         oNEsNjVPaMp/TrTVSMXM2kVQB3kGAryQexcNmBn85CffdLxjmJafDY7DDh7TXprHbit9
         5dMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PRMhYLVs5h1ZsZpiXevZFxArg/nlDuNzZU0ECG7LUYU=;
        b=fk94n00dqg00YKr9trAZzb3qQpHwhU2sb7uWlP5aZTMv5U6nFNnz6/2Mxapam6oZEX
         /A4PwJNQM2i+u+1PaGjTjqKgf4oRaDPzStXWhx7lpoBKo5iGl4MGDXsAOwWBnHycIvUN
         J4vcUyyAoDsyZUtuQBR1D0Ief7i8b5w/PhtaCxXuTwx7SK2o3JsIkaq/i7NwBZMc59YV
         o1JOnT1mpjWDkDF125BopRZahiLlhLNxpn160BHAOqOA+TrpYazub1YqRHitvj+RXP4G
         bmnBMxya5dHRsQL7Vc53C01e9Eee6j1qzS6Ena48Svzh7OscMHJmjDc7Hs797UHIQHhY
         CjkA==
X-Gm-Message-State: APjAAAX4m07ihxEBDPKZppWolrMQZiUjDPFFbfv6E2cjuBlxhy0x3bpS
        U9qMAaSokrDx4O4hPNncDY9IBJHGGXg=
X-Google-Smtp-Source: APXvYqxFrJSupTHRfeygZi172hpEGK9qE2n8AkmvS9C4rzJquOqmminIHissZbzaCQHgjksX5hA6yQ==
X-Received: by 2002:aa7:8552:: with SMTP id y18mr35360915pfn.176.1582253591155;
        Thu, 20 Feb 2020 18:53:11 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id b18sm952450pfd.63.2020.02.20.18.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 18:53:10 -0800 (PST)
Date:   Thu, 20 Feb 2020 18:53:06 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] clone: pass --single-branch during
 --recurse-submodules
Message-ID: <20200221025306.GK2447@google.com>
References: <20200108231900.192476-1-emilyshaffer@google.com>
 <20200128221736.9217-1-emilyshaffer@google.com>
 <20200130102303.GD840531@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130102303.GD840531@coredump.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 30, 2020 at 05:23:03AM -0500, Jeff King wrote:
> On Tue, Jan 28, 2020 at 02:17:36PM -0800, Emily Shaffer wrote:

Ouch. I forgot about this review for some time. Sorry :)

> 
> > Previously, performing "git clone --recurse-submodules --single-branch"
> > resulted in submodules cloning all branches even though the superproject
> > cloned only one branch. Pipe --single-branch through the submodule
> > helper framework to make it to 'clone' later on.
> 
> This makes sense to me, bearing in mind that I'm not at all a good
> person to point out subtleties with submodules that could bite us.

I wonder if it makes sense to ship this to our submodule-using masses
here for a little while and see how it works / whether anybody yells?
This might be too small for that kind of thing.

> 
> > As discussed in the thread for v1 of this patch, in cases when the
> > submodule commit referenced by the specified superproject branch isn't
> > the same as the HEAD of the submodule repo known by the server side,
> > this still works in kind of a non-obvious way. In these cases, first we
> > fetch the single branch that is the ancestor of the server's HEAD; then
> > we fetch the commit needed by the superproject (and its ancestry). So
> > while this change prevents us from fetching *all* branches on clone, it
> > doesn't necessarily limit us to a single branch as described.
> 
> Is it worth adding a test that we do the right thing here? Not so much
> to prove that it works now, but to protect us against future changes. It
> seems like the sort of thing that could get subtly broken.

What did you have in mind beyond the test I added already?

> 
> The patch looks mostly good to me (my, that was a lot of plumbing
> through that option); here are a few minor comments:
> 
> > -update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|--force] [--checkout|--rebase|--merge] [--reference <repository>] [--depth <depth>] [--recursive] [--jobs <n>] [--] [<path>...]::
> > +update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|--force] [--checkout|--rebase|--merge] [--reference <repository>] [--depth <depth>] [--recursive] [--jobs <n>] [--single-branch] [--] [<path>...]::
> 
> This line is horrendously long. Not new in your patch, but I wonder if
> the time might have come to break it up.

I dug around in Asciidoc doc and couldn't find a good way to do so. The
trailing :: means this command listing is done as a "definition list",
and I just didn't see any way to multiline an entry for such a thing. :(

> 
> > +--single-branch::
> > +	This option is only valid for the update command.
> > +	Clone only one branch during update, HEAD or --branch.
> 
> For some reason my brain insists on parsing this second sentence as a
> 3-item list without an Oxford comma. I wonder if it would be more clear
> as:
> 
>   Clone only one branch during update: HEAD or one specified by
>   --branch.
> 
> or similar.

Took it verbatim, I agree.

> 
> >  #define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
> >  	SUBMODULE_UPDATE_STRATEGY_INIT, 0, 0, -1, STRING_LIST_INIT_DUP, 0, 0, \
> > -	NULL, NULL, NULL, \
> > +	NULL, NULL, NULL, 0,\
> >  	NULL, 0, 0, 0, NULL, 0, 0, 1}
> 
> Wow. Also not new in your patch, but I think we're moving towards the
> use of C99 named initializers, which would make this a bit less
> daunting (all of the NULL/0 items could be omitted!).

Hrm. Yeah, I'll add a quick patch before this one to do so. It's pretty
gross :)

> > +test_expect_success 'clone with --single-branch' '
> > +	test_when_finished "rm -rf super_clone" &&
> > +	git clone --recurse-submodules --single-branch "file://$pwd/." super_clone &&
> > +	(
> > +		cd super_clone/sub &&
> > +		git branch -a >branches &&
> > +		test_must_fail grep other branches
> > +	)
> > +'
> 
> Don't use test_must_fail with non-Git commands; you can just say "!  grep".
> 
> We usually try to avoid scripting around git-branch output (although I

ooof

> find it pretty unlikely that future changes would break this particular
> case). git-for-each-ref would be a better pick, but I wonder if:
> 
>   git rev-parse --verify origin/master &&
>   test_must_fail git rev-parse --verify origin/other
> 
> might express the expectation more clearly.

Sure, done.

Sorry again for the long wait, and thanks for the effort on the review.
New revision coming momentarily.

 - Emily
