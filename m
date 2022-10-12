Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C6AC4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 21:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiJLVta (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 17:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJLVt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 17:49:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383F31217E0
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665611365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R1iUItIlrudufjPJy0n8S2Rm4iWf/F2RRk71zfea03w=;
        b=ag6+ZLqKJ4XAHWZrSZRoraPp0g/ljjwHKnvfzsb44/ADk2mD/6GEjXKzkiNmfdZwT3ynaR
        7N2VmCoPT/zkZw9gE21e02RROp8/TQDCWi8hY0Mm05yX70ZlmNwlBwzTf/tLq8YAcE1HLH
        jZmBWw5wWtRPStlo9TgpUQ4qQbsKuUg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-81-KmVcgCTENUWg3sLxPVHJLw-1; Wed, 12 Oct 2022 17:49:24 -0400
X-MC-Unique: KmVcgCTENUWg3sLxPVHJLw-1
Received: by mail-wm1-f72.google.com with SMTP id 133-20020a1c028b000000b003c5e6b44ebaso1751126wmc.9
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1iUItIlrudufjPJy0n8S2Rm4iWf/F2RRk71zfea03w=;
        b=Qxysr5bWpnqiYR2Xp9e9XLenbThY+ubP6qnEAh8Fd3TbkPDH7iFXn7aJXyWBMgBjba
         p6prFKHo+iHND5b4LuCrSg1XVLxDFnXRQqsTXkTL9idKJS9toZakM52gJVCNjQ/cYPeE
         hdMFOq+PcMIc8caWEXRAqErT9CanqtU/tgbeR56kO5d8oEhsLlRwfSWEpW3AUVXMBteK
         V0PogVcUfLs7eHIqHEdv+Ago0MzUtBp1h4LU8HkSa6sH8aoc07VI/0eN4CIow7y+nl1i
         31opk0x5Da6bSJccep2gxBucgZ5qKNWVZftNZKIFzvkmOxiapKS3vIdLR9u147eZBoue
         x9yQ==
X-Gm-Message-State: ACrzQf1d7Nw1l9hN+efoI8xtSSNcdneabyM0Z3noVuDjJqohHp07p6SU
        sRVlCDaHhdtv3lv/gC+tzX7S+hSNw8/LkFnbzH5DjEQDqnjJLjQhPbXdEM4XDIj2/+/TK8RQIj5
        xx7I74JIK6hvA
X-Received: by 2002:a5d:6701:0:b0:22e:6545:995d with SMTP id o1-20020a5d6701000000b0022e6545995dmr19232752wru.301.1665611361770;
        Wed, 12 Oct 2022 14:49:21 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM681FS4Ox37BNwwkoASUGvsM4faP8zOMxiislkKLwQO2sGgvKUxerYyHSpbG2T0ylhTghLPPA==
X-Received: by 2002:a5d:6701:0:b0:22e:6545:995d with SMTP id o1-20020a5d6701000000b0022e6545995dmr19232744wru.301.1665611361566;
        Wed, 12 Oct 2022 14:49:21 -0700 (PDT)
Received: from redhat.com ([2.54.162.123])
        by smtp.gmail.com with ESMTPSA id e10-20020a05600c4e4a00b003b4935f04a4sm3482815wmq.5.2022.10.12.14.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 14:49:21 -0700 (PDT)
Date:   Wed, 12 Oct 2022 17:49:18 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: sudmodule.<name>.recurse ignored
Message-ID: <20221012174742-mutt-send-email-mst@kernel.org>
References: <20221007060713-mutt-send-email-mst@kernel.org>
 <221007.86wn9bq458.gmgdl@evledraar.gmail.com>
 <20221007085334-mutt-send-email-mst@kernel.org>
 <kl6lpmf3wdk6.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqq35bze3rr.fsf@gitster.g>
 <20221011182119-mutt-send-email-mst@kernel.org>
 <kl6lfsft0ylu.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kl6lfsft0ylu.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 12, 2022 at 09:56:45AM -0700, Glen Choo wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > Fundamentally the problem we encounter regularly is this:
> > 	qemu is superproject, ui/keycodemapdb is subproject.
> >
> >
> > 	I have a change on master setting the submodule commit:
> >
> > 	qemu$ git show master | grep +Sub
> > 	+Subproject commit 7381b9bfadd31c4c9e9a10b5bb5032f9189d4352
> >
> > 	and check it out:
> >
> > 	qemu$ git submodule update --init ui/keycodemapdb
> > 	Submodule 'ui/keycodemapdb' (https://gitlab.com/qemu-project/keycodemapdb.git) registered for path 'ui/keycodemapdb'
> > 	Submodule path 'ui/keycodemapdb': checked out '7381b9bfadd31c4c9e9a10b5bb5032f9189d4352'
> >
> >
> > 	In another branch I have a different commit:
> >
> > 	qemu$ git show sub-foo  | grep +Sub
> > 	+Subproject commit 57ba70da5312170883a3d622cd2aa3fd0e2ec7ae
> >
> >
> > 	Now I switch branches and nothing happens, the submodule
> > 	is marked as dirty:
> >
> > 	qemu$ git checkout sub-foo
> > 	M       ui/keycodemapdb
> > 	Switched to branch 'sub-foo'
> >
> > 	qemu$ (cd ui/keycodemapdb && git show | head -1)
> > 	commit 7381b9bfadd31c4c9e9a10b5bb5032f9189d4352
> >
> >
> > it is now very easy to generate incorrect code:
> > - git commit -a  will commit the change to submodule
> > - any build will use a mix of super and subproject that
> >   is completely untested
> >
> >
> > As a result people are basically saying avoid using submodules
> > but I am wondering whether git can be tweaked to do the
> > right thing by default.
> >
> 
> It sounds like you want submodule.recurse [1] :)

yes. unfortuntely there is no way to set it by default
for cloned repos. users have to remember to set it.

> With that enabled, your
> "git checkout" should behave like "git checkout --recurse-submodules",
> which should make ui/keycodemapdb check out the correct commit as long
> as the submodule commit is present locally. If is is _not_ present
> locally, you will have to run "git submodule update".
> 
> Unfortunately, you typically won't know whether the commit is present
> before running the command. This is yet another of those things that are
> painful with submodules.
> 
> [1] https://git-scm.com/docs/git-config#Documentation/git-config.txt-submodulerecurse
> 
> > I understand we can work around it by asking everyone to
> > create a correct config, but can't we make it DTRT by default
> > to reduce friction?
> 
> You might be interested in the proposed 'new' Submodule UX [2]; one of
> the goals is to make manual submodule management via "git submodule"
> unnecessary.
> 
> As a part of that, you should be able to set "submodule.recurse = true"
> and have high confidence that all necessary submodules and submodule
> commits are present.

Hmm. How about only doing this for active submodules? Possible?

> Work on that is still ongoing, but this situation
> should have improved as of [3].
> 
> [2] https://lore.kernel.org/git/YHofmWcIAidkvJiD@google.com/
> [3] https://lore.kernel.org/git/20220308001433.94995-1-chooglen@google.com/
> 
> >
> >
> > -- 
> > MST

