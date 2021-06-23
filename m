Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D175DC48BC2
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 22:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD16860FD9
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 22:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhFWXAl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 19:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhFWXAj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 19:00:39 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89144C061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 15:58:20 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id b8-20020a056a000a88b02902e97a71383dso2612108pfl.13
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 15:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vFxsZLo3jFUw+6ELE4Y0yHRGvIPwMtHrSbGjcG4iHWE=;
        b=luFzDexBzvvl3yx4PU+Q5VijkplaJrhkWUgLL9iCGjVxhkiHTUj/I11VJqKnsWBjd4
         5ixkX9cM1AsnG1yWOCWLWkelUFbCppDyhwcv080TYDTciZDxPQWOX6yeHfLalXZYFUS9
         wA/hUh2twomcd7o2jtf502uac2dgV63vSjWYP0GaMKu64TeonYUJ1v3Gl0QzWggyfRtd
         O4pmj3uW+D3AuAEuv3cZStl9+6Uhsni/D1I4GRuCq8yALlg0Pfil2MzwAyBEzRiO2N9l
         A4CgEHc6l1eS56ac51boD+A2BIh3OVqYoe+5g/1sLu7CNK3kDmJeKO205cAb7kVJm5DF
         EBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vFxsZLo3jFUw+6ELE4Y0yHRGvIPwMtHrSbGjcG4iHWE=;
        b=EtQyTe9uKuI2OmZ7hsIXNsNDHH7MmgnwRqDPuNcqg7OalJN71HSRGn7N9XZRjqeSF2
         bwY4gs/IcKJDX9SvNCdKXof+FznbPDSEj2k/Wj0SmnZejRomewYWzkCRxps8fT1cgKMW
         J7s0kiqi07eR9u2J0nU9u21GNCi2T6dgJHlp8Bbqrx2nXY2XgOBrJfwcoMwMjI63/BXu
         u/dSHOTn+Xm7fLKX9magfEqn224lg/TOclRvAh0WBFWU/06Vj0FUfdUWIYFdoJNTa7/K
         CqaxgfXsWeuXfuQ/AkjiG5iKe1r8r/Cnf7ePBkDwF6/ONB/GxyyUVsNXq/EBWnsL/Ojs
         D2Jg==
X-Gm-Message-State: AOAM530dAZprmKwNgLW328ZbAyfDObiQDMzsWNhqxCupErlMW8pV/PjM
        yAM7dW8dSyge4hU5b3ip2l/h2LtO6YvuSm97F4p1
X-Google-Smtp-Source: ABdhPJxjVuNtYZpDk1tr36vVc5fMIjtJIJMxmmD3R0KT84fuBl+0s3Z6HAoknFTlt2WIt7tP8C7DjF8baIM5wPbOfnpU
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:c796:: with SMTP id
 gn22mr185094pjb.0.1624489099566; Wed, 23 Jun 2021 15:58:19 -0700 (PDT)
Date:   Wed, 23 Jun 2021 15:58:09 -0700
In-Reply-To: <YNExhalSLWvmky55@camp.crustytoothpaste.net>
Message-Id: <20210623225809.4023571-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YNExhalSLWvmky55@camp.crustytoothpaste.net>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: Re: [RFC PATCH 0/2] MVP implementation of remote-suggested hooks
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sandals@crustytoothpaste.net
Cc:     git@vger.kernel.org, emilyshaffer@google.com, avarab@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > First, unlike brian I don't (I hope I'm fairly summarizing his view
> > here) disagree mostly or entirely with the existence of such a feature
> > at all. I mean, I get the viewpoint that git shouldn't bless what
> > amounts to an active RCE from the remote.
> 
> It's accurate that I'm generally opposed to such a feature.

From emails like [1], I think that you have understood both the pros and
cons, and decided that the cons outweigh the pros, which is fair. I'll
reply so that others can know what I think about these points.

[1] https://lore.kernel.org/git/YGzrfaSC4xd75j2U@camp.crustytoothpaste.net/

> I feel that
> suggesting people install hooks is likely to lead to social engineering
> attacks,

I think that this vector of social engineering attack already exists, as
there are projects that without malice recommend hook installation (so
an attacker could masquerade as such). It is true that Git itself
printing a message recommending hook installation perhaps could lend a
false sense of security, but at least we can control what that message
says (as opposed to a project recommending a third-party tool, all with
messaging out of our control).

> and it's also likely to lead to bad practices such as the
> expectation that all developers will install hooks or the use of hooks
> instead of CI or other effective controls.

I agree that hooks can be overused or misused, but there are still
legitimate uses of it that a project might want to use.

> If we do add this feature (which, as I said, I'm opposed to) and we
> decide to store it in a ref, that ref should not be a normal branch by
> default (it should be a special one-level ref, like refs/stash or such),

Any particular reason not to expose it as a branch (besides following
from your general idea that a user should seek out such a feature and
not have it presented to them up-front)?

> and the ref name should be configurable.  Not all developers use English
> as their working language and we should respect that.

That makes sense.

> In addition, there should be an advice.* option that allows people to
> turn this off once and for all, and it should be clearly documented.
> Ideally it should be off by default.

I don't think this would be considered "advice" like the other options,
but having an option to turn this off once and for all makes sense.
Making it off by default would probably mean that projects that use such
hooks would recommend cloning with "git -c my-config=1 clone $URL", but
perhaps that's OK.

> > I think I get why you want to do it that way, I just don't get why, as
> > mostly noted in those earlier rounds why it wouldn't be a better
> > approach / more straightforward / more git-y to:
> > 
> > 1. Work on getting hooks driven by config <this is happening with
> >    Emily's series / my split-out "base" topic>
> > 2. Have a facility to read an in-repo '.gitconfig'; have lots of safety
> >    valves etc. around this, I suggested starting with a whitelist of the
> >    N least dangerous config options, e.g. some diff viewing options, or
> >    a suggested sendemail.to or whatever.
> 
> This also makes me deeply nervous for much of the same reasons.  There
> are situations where e.g. ignoring whitespace can lead to security
> problems in code review (think Python), and in general it's hard to
> reason about all the ways people can do malicious things.  Typically
> adding untrusted config ends poorly (think of all the modeline
> vulnerabilities in Vim).
> 
> I'd definitely want support for this to be off with no prompting by
> default.

To use your example, the model we're proposing is more of only using the
modelines from sources we trust - as opposed to ensuring that all
possible options set by modelines are benign. Admittedly, the
administrator of the source may have difficulty ensuring that bad code
doesn't slip through code review, for example, but that is a problem
they already deal with (at least for projects with any form of
executable code in them, e.g. production code or a build script).
