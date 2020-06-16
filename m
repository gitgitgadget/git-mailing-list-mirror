Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97703C433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 00:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74DD120786
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 00:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXkn59LQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgFPAUA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 20:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgFPAUA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 20:20:00 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15ABFC061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 17:20:00 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id d82so452075qkc.10
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 17:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yZ8XFU99V1RxJsDfNddbn7qIEVjAnVQ9i6hP+d3bF0U=;
        b=kXkn59LQ9qeHXQzCjIwjzhEjyDFgkCkYgMswumReuVdFIXypSiIA6impv2x0zZicEw
         S7vs+83ixdrgidy4qjffqH1tJv760aKSyI9wr/ptsPrqsVKQ6HigkHN97x1bUEv8ggF0
         tSADzDBeE9/piwNbiUiulEEHU0nGZRH7agJjvVc9flHSj1rm3an53QFOKI+bBPF6nWjS
         xk+MiyM+nUm6jR5zE7PX7Z0W32cZKiwCb+RTEdGOKW/TBTGWsSqkGxyTt/Dtj6eIDESd
         X1QgeiBkHHej+tzq+cAzt20XrSOOd0LUaUBMMyvA1P5J1iWZT6V5yyYD7fxLCS6wTtE+
         TeKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yZ8XFU99V1RxJsDfNddbn7qIEVjAnVQ9i6hP+d3bF0U=;
        b=Qb+nhxvR6d2K9sINpRQwvNZavrfbi8i0k47H7JIHm2p20T7mK2M+2qUh8GcF3wugZ/
         yHZlpJAaA30meLRAyAk4cIYu3B7MeJJ6MafSC4lPLzzelFhuUX4D8bTCFVYU31gUBFjb
         GGzhTLOnicMlWr9CI2+uuyLII+jbN9awRC24pnA1IqKwi+qOamQGnkpuDlCzHtQbRFiL
         wu2+QJrDbzwl9kYEkO+nZOeXD3eg5vIc6pHqnPWwN0ybRiRAYS4rrpWpup+vXakVtAL3
         8aG5q7WwEiOEhrc3QgoFf/FJDsqSyDxIljHF/Mzc6G4/KDIgxyfs2JISs5p+Vzh7N4o3
         wvbw==
X-Gm-Message-State: AOAM532SgkYkuxaYgHp4onZEXQi4uKhYYPGosoatHQBR5xP5MY4jzTfK
        2XwjlQ1qfw8EgkrKNMvgvdM=
X-Google-Smtp-Source: ABdhPJy3yn50930Nz8SiGbJ2oHEIF2yjoiK9x7LBbHKIO/XQ/3H3RCosaORyfuCtOrBgFQRM0Ob9aQ==
X-Received: by 2002:a37:64c2:: with SMTP id y185mr18585287qkb.186.1592266798994;
        Mon, 15 Jun 2020 17:19:58 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id g140sm13026632qke.98.2020.06.15.17.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 17:19:58 -0700 (PDT)
Date:   Mon, 15 Jun 2020 20:19:55 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net
Subject: Re: [PATCH 0/9] Allow overriding the default name of the default
 branch
Message-ID: <20200616001955.GA686455@generichostname>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
 <20200615100327.3mwft27oj7h2bixg@yadavpratyush.com>
 <nycvar.QRO.7.76.6.2006150011360.56@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2006150011360.56@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Mon, Jun 15, 2020 at 12:26:03AM +0200, Johannes Schindelin wrote:
> > For example, my vim plugins are submodules in the '~/.vim/bundle'
> > directory. When I want to update them, I run:
> >
> >   git submodule foreach 'git remote update && git reset --hard origin/master'
> >
> > With this change hitting a Git release, more and more people would call
> > their main branch different names they like. So what is the recommended
> > way to do something like this now? How do I checkout the tip of the main
> > branch? How do I push to the main branch? How do I pull from the main
> > branch? And so on...
> 
> ... has less to do with a new Git release, but more with the decision of
> an existing project to change their main branch name.
> 
> That's something users already had to deal with, of course. For example,
> projects switching to the Git Flow model will start to use the main branch
> name `development`.

I brought this concern up in a parallel thread but I'll bring it up here
too since it's relevant. Currently, in the .gitmodules file, if the
branch is not specified, it defaults to 'master'.

When I want to update my vim plugins, I run
`git submodule update --remote` which pulls in all of my submodules'
'master' branches. By convention, a lack of `branch` key in .gitmodules
conventionally means 'master'.

With your change, it becomes the value of git_main_branch_name(), which
is fine for now. However, if this value changes to something else, then
when I update my Git, suddenly `git submodule update --remote` will be
broken for me as all of the new repositories that I pull will be for an
incorrect (and possibly missing) branch.

This leaves us in a scenario where one developer running an older
version of Git would have submodule updates work perfectly fine while a
developer with a newer version would have it suddenly broken. This might
be hard to debug, especially for someone who doesn't follow the release
notes around Git and doesn't realise why the default has suddenly
changed.

This problem gets much worse if we allow the main branch name to be
configurable as then the *private* configurations that a developer has
may have an effect on the *publicly visible* behaviour of a repository.

I think I see three possible solutions to this:

	1. Special case 'master' in submodules to retain backwards
	compatibility.

	I don't think this is very appealing as if the change is made to
	use another default branch name, then the "default" branch for
	submodules would be "master" even though the new default
	everywhere else would be different. And in the future, someone
	who doesn't know the context behind all of this would be very
	confused where there are two different default branch names.

	2. Disable 'update --remote' support for submodules that don't
	specify a branch.

	If Git detects that a branch key is missing when trying to do an
	'update --remote', it should just quit out and refuse to do
	anything. Of course, this a very backwards incompatible change
	and it would require several release cycles to implement where
	we warn users about this impending change before we actually
	make it happen.

	3. Make 'update --remote' get HEAD.

	I argue that this is how it always should've been implemented
	but, alas, I can't go back in time and fix it. Regardless, it
	might be good to flip this to be the default if we're going to
	be making the change anyway.

	Unfortunately, this suffers from both the problems of 1 and 2.
	As with 1, we'll end up in a situation where users with
	different versions of Git may experience different behaviours
	given the same public repository and I think this is definitely
	undesirable. With 2, this change will also require a long
	deprecation period which I don't think it compatible with how
	people seem to want the default branch switch to happen this
	release.

So I dunno. I think my opinion leans on not changing the default branch
at all. Since it seems like the consensus is generally that it _will_
change, I think I would prefer options 3, 2 and 1 in that order.

Thoughts?
