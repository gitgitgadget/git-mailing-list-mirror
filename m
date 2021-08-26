Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D988EC432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 22:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B851A60E93
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 22:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243748AbhHZWZc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 18:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbhHZWZc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 18:25:32 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D3AC061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 15:24:44 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id t35-20020a05622a1823b02902647b518455so3035396qtc.3
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 15:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8IagBg7Xmj7kfOV5x9isrqPI7rznhmutdeCGFJk5Pmk=;
        b=P1hJT8u17IeHMRFWJ8sngWLrRsSXws084uS1dO8p+YPpzJiG11ZOUGnZkFMwXZxjOe
         MJvl/mkcVbuTdDE3j9Lk6y/snFQNHaZps5/je7bkMtM/RsCJ+EvliFCJjUEYy/ZvJcG2
         cBbLLj0Ai0Ad/jrdMciWh65L4Brzq5ZA8Mn+GqhaadB4icBn2mvm5kgsmIupFrKsAU0f
         6lYNcp3yjmIfSzb1GboowEofxdjR6ADwbj1wP8RB2JdbOCFIgLxr/1IKEv/y0TmQ8zEY
         mpV7uDy/lxCpcC5w3Gru7Cvliyv0z1CCQPHa6VTtnkucn31stX1j5TtNztrvTBPGFJ/F
         30bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8IagBg7Xmj7kfOV5x9isrqPI7rznhmutdeCGFJk5Pmk=;
        b=hApaa50PN5BWlaw9MSur1ktxXcokdMHeRmeVgNyk/KaBTqRK5/2snfF9qlQ49EnzqJ
         jFKdAFcI91LVgGfRsmdqkNuHkvp4CwXXk20MPipaSDrHcziqzwYxQl/vgXIV+U6dG2+X
         Zyg26Mx/uskWcF27grdjkB5SH0eeYrrnTDH0S2wLaOsdQJVSaglMyKb8+hWIqeqIiZ4u
         HqpIftd+s1gcuPhCeFXcNj9w6Fk/kk2yqj1iK+LtXFLv1wqfGlB8fyBCFoDjJHAukXJw
         QOaVkBfFFB1dC6yk2cKqQeXoJzlRmHRtpPGWQrSDiP0S5k0in/9UMbr8YCkC94HENukM
         dygg==
X-Gm-Message-State: AOAM531fldq5Ahb9M8vzANlkkOZlLiIq3Zg1Bc88CIvbk0wD0NJFDzSh
        cXaLYSnuoR24slGl/3U9fd/1OLhebY/pG5ibqyav
X-Google-Smtp-Source: ABdhPJyzjQcS2Rlm8Z6d4f55/4+IMJNUgmDE/hM57sa0TzTxQjFpX/GlIJkc5qaiCL1vu2a6e1oes+/8l9y7tSXO2xtc
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:c23:: with SMTP id
 a3mr6666658qvd.34.1630016683640; Thu, 26 Aug 2021 15:24:43 -0700 (PDT)
Date:   Thu, 26 Aug 2021 15:24:39 -0700
In-Reply-To: <CAFQ2z_PKKZJY1kC1QJo8Zwq_yNh5QNGc3S5bq1jBfSfK3vQwRQ@mail.gmail.com>
Message-Id: <20210826222439.3915402-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CAFQ2z_PKKZJY1kC1QJo8Zwq_yNh5QNGc3S5bq1jBfSfK3vQwRQ@mail.gmail.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: Re: [RFC PATCH 1/2] refs: make _advance() check struct repo, not flag
From:   Jonathan Tan <jonathantanmy@google.com>
To:     hanwen@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> from a design perspective, it would be nice if the ref backend
> wouldn't need to know about the object store. Can't this be hidden in
> the layer in refs.c that calls into the backends?

Thanks for taking a look.

The answer requires additional context, so I'll answer this at the end
of this email.

> If they have to know about the object store, have you considered
> passing the repository pointer
> in xxx_ref_store_create() ? Then there is no possibliity to mismatch
> the repository pointers and with the ref store.

I thought about that, but didn't want to make things worse - the effort
in this patch set is, after all, to attempt to increase the dissociation
between the ref stores and a certain object store (that is,
the_repository's object store), and I thought that reintroducing an
association (albeit to arbitrary object stores instead of a hardcoded
object store) would be a step back.

But this may be the way to go - the ref stores already have a gitdir
field that we could replace with a struct repository field.

> > - Making all ref stores not access the object store during their
> >   _advance() callbacks, and making ref_iterator_advance() be responsible
> >   for checking the object store - thus, simplifying the code in that the
> >   logic of checking for the flag (current) or the pointer (after the
> >   equivalent of this commit) is only in one place instead of in every
> >   ref store's callback. However, the ref stores already make use of this
> >   flag for another reason - for determining if refs are resolvable when
> >   writing (search for "REF_STORE_ODB"). Thus, I decided to retain each
> 
> I looked, but I couldn't figure out how this flag is used.

I was thinking of files_ref_iterator_begin() setting a local variable
required_flags. Somehow I thought that files_pack_refs() relied on
files_ref_iterator_begin() setting that variable, but now I see that
that's not true - both functions are independently checking that the
underlying ref store supports ODB access, so I can remove ODB from
files_ref_iterator_begin() if I want to.

To go back to the question at the top, now I agree that hiding the ODB
access in _advance() in the layer in refs.c is possible. The last part
still accessing the ODB is files_pack_refs(), I think. Refactoring that
is possible, but I'll leave that to another patch set.

If you or anyone else has more questions or comments, please reply - and
in the meantime, I'll update this patch set to move the ODB access in
_advance() to the layer in refs.c.
