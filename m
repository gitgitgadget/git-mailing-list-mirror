Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705A4C433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 01:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2526064F75
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 01:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhBCBFN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 20:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhBCBFK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 20:05:10 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89044C061573
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 17:04:30 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 11so24992784ybl.21
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 17:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=cSi81dWNHRLLyabrKcJi1ckp2m21Gy8/c3y9vix+xXY=;
        b=oSB6aMls5QLWbVHEn/v75FIYgenMjwCp0gxRKgYgv+PYElWbfg6MvhwS5hfnP8xVY/
         M98IYKfv+PByLIec77MtqnjStvlog4a+2785Fsi6Ctn8iuvFC3StEdUBi/xt5AA4u0kX
         Rx14kgdwyiiuvxe5YBraghgmih0Z/4jlNaC4qHJfZt3rmfBCfmhLySsvf9j5Z5Gdk2kf
         cZ6pdXL1McMQk4GhQPynEfz3WJoyzHyTtqHVA33XtkyEcCQnVONBgjND4leQgWhGjn7M
         009WACOuvMlHYSW4kag8N2FVfU0jkysx0WJkLYuBr+ObWz3QlU/2zYuPCTCcZc9dZkxV
         8w4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cSi81dWNHRLLyabrKcJi1ckp2m21Gy8/c3y9vix+xXY=;
        b=tqcs9kI9YWd4DeeZWJxPAeudshhLElYy+iUdYd1eiEvdjeMyFK/Le6Ps5wXdgndzlL
         N2S7RhGa2qsNZLKPwFvCnbWgpX92xnuPNy94nGLwhYVX7k1etEW8MMDM20nD64p/mPhC
         K0Q21Vyzr42Owp7b5i+t9OIislIIKdTruQKePerNx1Ag/HsjYGgk0pPzU3rjTQ+JYIAU
         hI9L7fa8KQrK25m608+vUq9bJd7hvcOKHNY3r3resHNmXGwKR2BVdH+PFSo5vut1cvct
         Fy3aOwR/drIbAUyPPgCX/51tQpfZgPWUOVrtiqcwsbW8dPoi5hyi54XEnEMGAa+4+nMZ
         L98g==
X-Gm-Message-State: AOAM5317oCIiywU6hs/K+9D5PTHit6/sBOvB7a/uyjuVu6f9s/W4so26
        1sx4AeltO7LSFE3OssD78EJS3PlHso0E2AIEUs06
X-Google-Smtp-Source: ABdhPJyYDaEK5SkWP3K5uc3f59VnWJzfr5q/d3StyOnp0Gpq5wcb7aa0VyJeWnQIaN+vKlv1pWbHvNZ+JMaLo2CaqBIV
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:1fc5:: with SMTP id
 f188mr879887ybf.389.1612314269795; Tue, 02 Feb 2021 17:04:29 -0800 (PST)
Date:   Tue,  2 Feb 2021 17:04:25 -0800
In-Reply-To: <xmqq1rdyf71k.fsf@gitster.c.googlers.com>
Message-Id: <20210203010425.2097136-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq1rdyf71k.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: Re: [PATCH v6 1/3] ls-refs: report unborn targets of symrefs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > I'm not sure what the ideal endgame state is, but I could see how
> > sending all symlinks would be useful (e.g. if a client wanted to mirror
> > another repo with more fidelity). Right now I don't plan on adding
> > support for dangling symrefs other than HEAD, though. Maybe I'll update
> > it to something like:
> >
> >   If HEAD is a symref pointing to an unborn branch, the server may send
> >   it in the form "unborn HEAD symref-target:<target>". In the future,
> >   this may be extended to other symrefs as well.
> 
> Unless you plan to add support for symbolic refs that are not HEAD
> in immediate future, "In the future, ..." is not even necessary to
> say.  The users cannot expect to exploit the missing feature anyway,
> and they cannot even plan to use it in near future.
> 
> I've been disturbed by the phrase "the server may send it" quite a
> lot, actually.  In the original before the rewrite above, it was a
> good cop-out excuse "no, we do not send symbolic refs other than
> HEAD because we only say 'the server may' and do not promise
> anything beyond that".  But now we are tightening the description
> to HEAD that we do intend to support well, it probably is a good
> idea to give users a promise a bit firmer than that.
> 
>     unborn If HEAD is a symref pointing to an unborn branch <b>, the
>     server reports it as "unborn HEAD symref-target:refs/heads/<b>"
>     in its response.
> 
> It would make it clear that by sending 'unborn' in the request, the
> client is not just allowing the server to include the unborn
> information in the response.  It is asking the server, that has
> advertised that it is capable to do so, to exercise the feature.

That makes sense. OK, I'll make the promise firmer.

> > I think that there is a discussion point to be decided
> > (advertise/allow/ignore vs allow/ignore), so I'll wait for that before
> > sending v7.
> 
> What is the downside of having three choices (which allows phased
> deployment, where everybody starts as capable of responding without
> advertising in the first phase, and once everybody becomes capable
> of responding, they start advertising) and the reason we might
> prefer just allow/ignore instead?  Too much complexity?  It does not
> help the real deployment as much in practice as it seems on paper?
> 
> I am not advocating three-choice option; I am neutral, but do not
> see a good reason to reject it (while I can easily see a reason to
> reject the other one).

Here's a reason from Peff's email [1] against advertise/allow/ignore (the "code
change" is a temporary hack that teaches Git to accept but not advertise
report-status-v2). Granted, he does say that this may be an oversimplification,
and in the overall email, he was arguing more for having this feature on by
default (whether we have advertise/allow/ignore, allow/ignore, or no config at
all) rather than for any specific configuration scheme.

  - one nice thing about the code change is that after the rollout is
    done, it's safe to make the code unconditional again, which makes
    it simpler to read/reason about.

    This may be oversimplifying it a bit, of course. On one platform, we
    know when the rollout is happening. But if it's something we ship
    upstream, then "rollout" may be on the jump from v2.28 to v2.29, or
    to v2.30, or v2.31, etc. You can never say "rollouts are done, and
    existing server versions know about this feature". So any upstream
    support like config has to stay forever.

To balance that out, from the same email [1], a slight argument against no
config at all:

  (I know there was also an indication that some people might want it off
  because they somehow want to have no HEAD at all. I don't find this
  particularly compelling, but even if it were, I think we could leave it
  the config as an escape hatch for such folks, but still default it to
  "on").

[1] https://lore.kernel.org/git/X9xJLWdFJfNJTn0p@coredump.intra.peff.net/

And an argument against the allow/ignore [2]:

  If we are not going to support config that helps you do an atomic
  deploy, then I don't really see the point of having config at all.
  Here are three plausible implementations I can conceive of:
  
    - allowUnborn is a tri-state for "accept-but-do-not-advertise",
      "accept-and-advertise", and "disallow". This helps with rollout in a
      cluster by setting it to the accept-but-do-not-advertise.  The
      default would be accept-and-advertise, which is what most servers
      would want. I don't really know why anyone would want "disallow".
  
    - allowUnborn is a bool for "accept-and-advertise" or "disallow". This
      doesn't help cluster rollout. I don't know why anyone would want to
      switch away from the default of accept-and-advertise.
  
    - allowUnborn is always on.
  
  The first one helps the cluster case, at the cost of introducing an
  extra config knob. The third one doesn't help that case, but is one less
  knob for server admins to think about. But the second one has a knob
  that I don't understand why anybody would tweak. It seems like the worst
  of both.

[2] https://lore.kernel.org/git/YBCitNb75rpnuW2L@coredump.intra.peff.net/
