Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAEEC433DB
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 04:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7B5C64E12
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 04:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbhA3EzT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 23:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbhA3Evi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 23:51:38 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C4FC061756
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 20:41:45 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id bc11so6745324plb.17
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 20:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=xtSGcXhc6SVN3HHfI1EDr/bMkmN8hxlIx1h/0Kd5Gs4=;
        b=pdckufNUeulbdwJFz6OZ8tntiYN4BN0yeODuN3Wpe6nXJBigLN9Woyy8jwriAvLAvU
         OCWOPGunsnwA5Lwjpe7DwVlVDrtaupwYakbbRb3Y1/gGYV1mB9Tdv23pfRI29RYymwsT
         gWHe00J5ByCORkffIXBcol1ZZ03MQyiG7uJQp59Z/nJZHAs3CgO2cpayaYVk41HAmS+o
         JnH5zr395X06XuG2WguWswDbwIYBJorJkzbZ+cr1cbB/2XyLOyYOdrXVUhpvvHSs0SgJ
         aeqZd+l+DDWRES8AGGGk0Fy1oNLx7clbnKfrJl30UMxAhJHYoL82b73YfSIkp41wlnzT
         yJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xtSGcXhc6SVN3HHfI1EDr/bMkmN8hxlIx1h/0Kd5Gs4=;
        b=hI62psT4M8KhKVxqUdyNy1zBigpIEw5prNpYC7T1Y9Y+c7FaOQdoTNYqZbovX4Z41Z
         eG+G302XVS/XMY3vRyQ8qEFbUP+IOuwibZn1Zz59U64Nez5eks5Zb/UITgYs187Kyt+I
         8d4RFrWdqCgB/xT35xDXs/ozG886hhpcC9tDzqD6rgUm5AkUyEsFF5UDGGc056s9Xyli
         Tevd0tPIOSNfWZXPgpHA2YeC/4AHlvTcG828+2bIJFz2+mp1+4sUFfTSQBCtiXNipvqV
         bxlhE/QzyC3nJCCaUgT3pFN2qgKs1Q9HL0a7fr/FzzWzo4czp7N8bbOuLtrIdzEAr5yE
         YoPg==
X-Gm-Message-State: AOAM531HOCyZVJRCZ+oR0FpfStDfnyFYwFN91HdL1hf8XjcnHVEK+LW4
        CnCgt4U6hzWtf6eQ0kTTjlGlwWy17MTIcNZ7r1+B
X-Google-Smtp-Source: ABdhPJzOKTPSC9OFRpOg+VMMagFB7NHoIav4g9c0TyfmOhGJBhvhXoV1Z/9ZCJ0CliVNcrYgrA5wSGE3mCKrfPGk7Cge
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:8f1c:0:b029:1c0:60c7:f7c5 with
 SMTP id x28-20020aa78f1c0000b02901c060c7f7c5mr7229021pfr.59.1611981705185;
 Fri, 29 Jan 2021 20:41:45 -0800 (PST)
Date:   Fri, 29 Jan 2021 20:41:42 -0800
In-Reply-To: <87h7n3p363.fsf@evledraar.gmail.com>
Message-Id: <20210130044142.808860-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <87h7n3p363.fsf@evledraar.gmail.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: Re: [PATCH v5 0/3] Cloning with remote unborn HEAD
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, peff@peff.net,
        felipe.contreras@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Tue, Jan 26 2021, Jonathan Tan wrote:
> 
> [For some reason the patches didn't reach my mailbox, but I see them in
> the list archive, so I'm replying to the cover-letter]
> 
> >  Documentation/config.txt                |  2 +
> >  Documentation/config/init.txt           |  2 +-
> 
> Good, now we have init.defaultBranch docs, but they say:
>     
>      init.defaultBranch::
>             Allows overriding the default branch name e.g. when initializing
>     -       a new repository or when cloning an empty repository.
>     +       a new repository.
> 
> So this still only applies to file:// and other "protocol" clones, but
> not "git clone /some/path"?

Ah...that's true.

> Re my reply to v1, do we consider that a bug, feature, something just
> left unimplemented?
> 
> I really don't care much, but this really needs a corresponding
> documentation update. I.e. something like:
> 
>     init.defaultBranch::
>         Allows overriding the default branch name e.g. when initializing a
>         new repository or when cloning an empty repository.
>     
>         When cloning a repository over protocol v2 (i.e. ssh://, https://,
>         file://, but not a /some/path), and if that repository has
>         init.defaultBranch configured, the server will advertise its
>         preferred default branch name, and we'll take its configuration over
>         ours.

Thanks - I'll use some of your wording, but I think it's best to leave
open the possibility that cloning using protocol v0 or the disk clone
(/some/path) copies over the current HEAD as well.

> Which, just in terms of implementation makes me think it would make more
> sense if the server just had:
> 
>     uploadPack.sendConfig = "init.defaultBranch=xyz"
> 
> The client:
> 
>     receivePack.acceptConfig = "init.defaultBranch"
> 
> And in terms of things on the wire we'd say:
> 
>     "set-config init.defaultBranch=main"
> 
> You could have many such lines, but we'd just harcode only accepting
> "init.defaultBranch" by default for now.
> 
> I.e. we set "init.defaultBranch" on the server, and the client ends up
> interpreting things as if though "init.defaultBranch" was set to exactly
> that value. So why not just ... send a line saying "you should set your
> init.defaultBranch config to this".
> 
> Makes it future-extensible pretty much for free, and I think also much
> easier to explain to users. I.e. instead of init.defaultBranch somehow
> being magical when talking with a remote server we can talk about a
> remote server being one source of config per git-config's documented
> config order, for a very narrow whitelist of config keys.
>
> Or (not clear to me, should have waited with my other E-Mail) are we
> ever expecting to send more than one of:
> 
>     "unborn <refname> symref-target:<target>"
> 
> Or is the reason closer to us being able to shoehorn this into the
> existing ls-refs response, as opposed to some general "here's config for
> you" response we don't have?

It's not the same - from what I understand, what you're suggesting is
setting a config in the repo that has just been cloned, but this patch
set does not set any such config. Also, it may be strange for the server
to be able to change the config of a currently running command - I would
expect such a thing to only take effect on future runs of Git on that
repo.
