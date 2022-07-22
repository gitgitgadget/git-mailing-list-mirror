Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5C7C433EF
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 20:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbiGVUgt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 16:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiGVUgs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 16:36:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACAB82453
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 13:36:47 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BF4B9200E4;
        Fri, 22 Jul 2022 20:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658522205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OpPXH2kyKZubJdpYbI5DhC1ttDmZZyMc+9G0UD4QVk4=;
        b=wJMcWrgVo7N2dC/3ZMKtYQIxpYpWrrBj7wNTq+68RLCaQ4rVcVr8N27A45R8SW1PSx7WMF
        oclKWzJQz6+gzA53VgBJBlswoWQERhy0FpDG2+8d1Tk83ysHc64rseNa/3f7k9QjzNkhck
        ihwC9hC4FnLekELvVIjVLJ930VI1MUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658522205;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OpPXH2kyKZubJdpYbI5DhC1ttDmZZyMc+9G0UD4QVk4=;
        b=8ybr8mbbUsa2J6qHsDzapQozjxU5gFJnL1ZW4bo8gpH8V9DCJDO3WMiCspvIBFtLfSsmuv
        JVPsoaDaXwEH4zCg==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D02622C161;
        Fri, 22 Jul 2022 20:36:44 +0000 (UTC)
Date:   Fri, 22 Jul 2022 22:36:42 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Hilco Wijbenga <hilco.wijbenga@gmail.com>,
        Phillip Susi <phill@thesusis.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Stephen Finucane <stephen@that.guru>,
        Git Users <git@vger.kernel.org>
Subject: Re: Feature request: provide a persistent IDs on a commit
Message-ID: <20220722203642.GD17705@kitsune.suse.cz>
References: <bdbe9b7c1123f70c0b4325d778af1df8fea2bb1b.camel@that.guru>
 <220718.86ilnuw8jo.gmgdl@evledraar.gmail.com>
 <87a692e8vj.fsf@vps.thesusis.net>
 <CAE1pOi1pS76iXU8j=A54wPGHC7qofxrPDAO4uyy0d6yMxeQwvw@mail.gmail.com>
 <6426b5c3-0a09-f641-9876-3534b0abd96d@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6426b5c3-0a09-f641-9876-3534b0abd96d@iee.email>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 22, 2022 at 09:08:56PM +0100, Philip Oakley wrote:
> On 21/07/2022 19:58, Hilco Wijbenga wrote:
> > On Thu, Jul 21, 2022 at 9:39 AM Phillip Susi <phill@thesusis.net> wrote:
> >> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> >>
> >>> This has come up a bunch of times. I think that the thing git itself
> >>> should be doing is to lean into the same notion that we use for tracking
> >>> renames. I.e. we don't, we analyze history after-the-fact and spot the
> >>> renames for you.
> >> I've never been a big fan of that quality of git because it is
> >> inherently unreliable.
> > Indeed, which would be fine ... if there were a way to tell Git, "no
> > this is not a rename" or "hey, you missed this rename" but there
> > isn't.
> >
> > Reading previous messages, it seems like the
> > after-the-fact-rename-heuristic makes the Git code simpler. That is a
> > perfectly valid argument for not supporting "explicit" renames but I
> > have seen several messages from which I inferred that rename handling
> > was deemed a "solved problem". And _that_, at least in my experience,
> > is definitely not the case.
> 
> Part of the rename problem is that there can be many different routes to
> the same result, and often the route used isn't the one 'specified' by
> those who wish a complicated rename process to have happened 'their
> way', plus people forget to record what they actually did. Attempting to
> capture what happened still results major gaps in the record.

Doesn't git have rebase?

It is not required that the rename is captured perfectly every time so
long as it can be amended later.

Thanks

Michal
