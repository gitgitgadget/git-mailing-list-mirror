Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B4BC433FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 20:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EC1F2312D
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 20:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgLHUQm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 15:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731149AbgLHUQY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 15:16:24 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C64C0613CF
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 12:15:38 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id e11so7698441pld.0
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 12:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=HV2qav3Uk6wRIqRBNDQZpY7X69OrCVCrs1uuCaIvwEQ=;
        b=G8J12Ub2U6mp7A/91xXBHrss2zOemg01dIdtWcs3IJYxxObzBr+s62VsnumPpO1VYA
         d0M/TMs5Z7ApXjHCcxAQUibYUCOQd0doFji24gcXfqYWfWy4yYU1frbmkeTyUg+5dht1
         H4CbcX+fdziobZB5VFvaiAVUXaBlUYtwqIjdMFoEJsNLByP+NO0MdLURqhStfd5900Ir
         suWGMWXU8TFX6eaS6en5BXDrnWunaeyGBsf+z0Pa8Y/THbHp0JDrS9Odd1b+6WG4hDrG
         1M3mGV7jmmAFKkPUDk4YVXxJ4HLUVOfBL7WPF7B0v0udk41b9UWnHJ8b3PKRzIVWfdl6
         zRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HV2qav3Uk6wRIqRBNDQZpY7X69OrCVCrs1uuCaIvwEQ=;
        b=hhUHPdFM3oNfrKS4HzdPaOLUd9ZIH/G0CWXrAhMLk+QzEcGHDRX2wiRbhTvCqLcslm
         KftbGib+fz9K44giUXdPtco2QePuy3WqR/LoPji5tR+Z16x9j1kn+olfxkHpKQD7NgAt
         SiLCTQUhgiYhEytXc+cHmY7nZzdW6q2/asRKD0NozRosCCuvUMCExEbwXqcgXwsEMgr4
         WyVjYNNmDTPqvY5lq+YvZsJapVKzfP4SSYN6nVabsNiyKfM1Jt+e2tgweMtfz1mPDvDj
         bv9FAR8wT70FcagrM+5z6dlLa2KJlIZTXHTBzU84md7fb3zeBQFp23zfiNJS1Llv1Mwp
         vWjA==
X-Gm-Message-State: AOAM53235ulRMFZhhTbopFI1CDr+UBfPC0H0PAQnObAwAqHMNKnKevY5
        ziGLIhr67/TZ8C3D71+NnzG0BpWVszCo3yDbu55S
X-Google-Smtp-Source: ABdhPJz7i0yMZ5oQPPY+FbH/wiyTbbHRNNba3iaeZX5WLkztWNN+IZnM0/39FRlyKWj/mwBeMpRpuNH7Z60wgP0bQ6yE
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:7858:0:b029:19d:c011:1cfe with
 SMTP id t85-20020a6278580000b029019dc0111cfemr20168111pfc.47.1607458011855;
 Tue, 08 Dec 2020 12:06:51 -0800 (PST)
Date:   Tue,  8 Dec 2020 12:06:49 -0800
In-Reply-To: <X8+iu/0nPfd0lrSn@coredump.intra.peff.net>
Message-Id: <20201208200649.998740-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <X8+iu/0nPfd0lrSn@coredump.intra.peff.net>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: Re: Cloning empty repository uses locally configured default branch name
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Mon, Dec 07, 2020 at 05:31:20PM -0800, Jonathan Tan wrote:
> 
> > When cloning an empty repository, a local branch is created. But its
> > name is not the name of the branch that the remote HEAD points to - it
> > is the locally configured default branch name. This issue arose at
> > $DAYJOB and, from my memory, it is also not an uncommon workflow to
> > configure things online on a repo host and then use "git clone" so that
> > things like remotes are automatically configured.
> > 
> > Has anyone looked into solutions for this? Both protocol v0 and v2 do
> > not send symref information about unborn branches (v0 because, as
> > protocol-capabilities.txt says, "servers SHOULD include this capability
> > for the HEAD symref if it is one of the refs being sent"; v2 because
> > a symref is included only if it refers to one of the refs being sent).
> > In protocol v2, this could be done by adding a capability to ls-remote
> > (maybe, "unborn"), and in protocol v0, this could be done either by
> > updating the existing "symref" capability to be written even when the
> > target branch is unborn (which is potentially backwards incompatible) or
> > introducing a new capability which is like "symref".
> 
> We discussed this a few years ago, and I even wrote a small patch (for
> v0 at the time, of course):
> 
>   https://lore.kernel.org/git/20170525155924.hk5jskennph6tta3@sigill.intra.peff.net/
> 
> A rebased version of that patch is below (it needed updating to handle
> some namespacing stuff). Coupled with your patch here for the truly
> empty repo case, it makes the server side of v0 do what you'd want.
> 
> But the client side needs to handle it, too. See the linked thread for
> some discussion.

Thanks for the pointer.

> I wouldn't be too worried about the backwards incompatibility of sending
> a symref line in the capabilities that doesn't point to a ref we're
> sending. Old clients are quite likely to ignore it. But...
> 
> > A small issue is that upload-pack protocol v0 doesn't even write the
> > blank ref line ("000...000 capabilities^{}") if HEAD points to an unborn
> > branch, but that can be fixed as in the patch below.
> 
> I would worry how clients handle this bogus entry in the ref
> advertisement. It looks like the actual Git client is OK, but what about
> jgit, libgit2, etc? That's not necessarily a deal-breaker, but it would
> be nice to know how they react.

That bogus entry is defined in the protocol and JGit both produces and
consumes that line. Consumption was verified by patching Git with my
patch and running the following commands in separate terminals:

~/git/bin-wrappers/git daemon --port=9425 --base-path=. .
sudo tcpdump -i any port 9425 -w -
~/jgit/bazel-bin/org.eclipse.jgit.pgm/jgit ls-remote git://localhost:9425/empty

And production:

~/jgit/bazel-bin/org.eclipse.jgit.pgm/jgit daemon --port=9426 .
GIT_TRACE_PACKET=1 git ls-remote git://localhost:9426/empty

(Note that the JGit CLI does not have a separate --base-path parameter.)

I have not checked libgit2, but quite a few servers use JGit out there,
so it presumably should be able to interoperate with them and hence
support the bogus entry.

> It also only helps with v0 (and I agree with the sentiment that it would
> be OK to ignore v0 at this point). For v2, we'd have to issue a HEAD
> line like:
> 
>   0000000000000000000000000000000000000000 HEAD symref=refs/heads/foo
> 
> That probably would break clients, but the unborn capability should take
> care of that.

Yes - or a special string like "unborn" in place of the 000.000.
