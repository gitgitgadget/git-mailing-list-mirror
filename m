Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDDEC05027
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 22:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbjBHWu0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 17:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjBHWuY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 17:50:24 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60393C20
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 14:50:23 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id q4so239465ybu.7
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 14:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9avpVgVTP/m2GNdSk2zcxqwi9ehR4dcdDN93r2utwY=;
        b=qkpJe+M3smv9n21zwD9gImQ5PGP4HRIM9cSh2qEj0vd9AX4fZoQH3QwtySfrGfqcNF
         vmAcgcbgs8S/36tUxwCRUOuGfxSQ75++Q8vc5VzuD02CD3VbNSrHSWQzHKCSjtonxvVu
         DQgDAAvdp6ezasbNPEDCrB+4EKoi8tAGqXUciH8h0l8XPIYeKW1sLpc+g8LQzLj4V8JG
         FINNIAW+QYGjpn3vL8qfZ58vM9eNVQWSIGhs8diBygxuHTUfajJ3YDtcyYYFHgFgeboe
         MFCHuOFGKYRllodqzO7FBdiEPXGOuwAgHmUXhQQHXNLUY1CHXyb8wDH4ssgTfb12hgMd
         F0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z9avpVgVTP/m2GNdSk2zcxqwi9ehR4dcdDN93r2utwY=;
        b=xBwu0865T+cFYg5+wZzUCgPomdkF9DQN5cRDWkzd/a3/72sNs32IxRXHAOEX2/iLyw
         lnyrSdAIVwiwegkZ7G3i+ES130ko7kyQujzivy8qjFgIt9SrwL/27Jc5NG3SO9VoCNNP
         hRWLcHnC7Tgl87O3yj2CRZhJnt7GMdI7bRqYEEojc0zTYneqoAoVEnct1utRrwZd2hj+
         XPV2T/Q0VVF3kwhudVuXLnanOad+VMcnAhRAtxQXM3fvLkEEE/qxPXeU7qIi+HZIsWAe
         V0GK9icBnWAvJtFrQo2WGIm2mU2E0E+iY3zpkpfZ8013SfSo8eujJBG6fAGezspP9A1Z
         d2jg==
X-Gm-Message-State: AO0yUKV1poJX9PwWan3j9sP/4XAzuWRLvhJ06dQ7KnsnIBz2x+hY0r38
        4vEB7fd97GNN6cHhCFhkuiutt8oLzFdSvhnVcMXowg==
X-Google-Smtp-Source: AK7set8QptmcEeRNohO3ZZR5RleXSfIKU3dAiJQ7/B0gONJmOnPKpGvH2M2DK5vHjot/gEfJXhmsQuvrkd1B4tqEDLI=
X-Received: by 2002:a5b:bcf:0:b0:86f:ccf1:bf7a with SMTP id
 c15-20020a5b0bcf000000b0086fccf1bf7amr953078ybr.392.1675896622721; Wed, 08
 Feb 2023 14:50:22 -0800 (PST)
MIME-Version: 1.0
References: <20230117193041.708692-1-calvinwan@google.com> <20230207181706.363453-2-calvinwan@google.com>
 <230207.86y1p914ci.gmgdl@evledraar.gmail.com>
In-Reply-To: <230207.86y1p914ci.gmgdl@evledraar.gmail.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Wed, 8 Feb 2023 14:50:11 -0800
Message-ID: <CAFySSZCX=tySZf1xSd59GH0qS9PWtUC6ekLB1bWtZR3c09+ttw@mail.gmail.com>
Subject: Re: [PATCH v7 1/7] run-command: add duplicate_output_fn to run_processes_parallel_opts
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, chooglen@google.com, newren@gmail.com,
        jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> But would ou mind if this addition of yours were instead:
>
>         if (opts->ungroup) {
>                 if (opts->duplicate_output)
>                         BUG("duplicate_output and ungroup are incompatible with each other")
>         }

I don't see why not -- will change.

> > @@ -1645,14 +1648,21 @@ static void pp_buffer_stderr(struct parallel_processes *pp,
> >       for (size_t i = 0; i < opts->processes; i++) {
> >               if (pp->children[i].state == GIT_CP_WORKING &&
> >                   pp->pfd[i].revents & (POLLIN | POLLHUP)) {
> > -                     int n = strbuf_read_once(&pp->children[i].err,
> > -                                              pp->children[i].process.err, 0);
> > +                     ssize_t n = strbuf_read_once(&pp->children[i].err,
> > +                                                  pp->children[i].process.err, 0);
>
> This s/int/ssize_t/ change is a good on, but not mentioned in the commit
> message. Maybe worth splitting out?

I'll call this and the style change out in the commit message instead of
splitting it out.

> And why is this thing that wants to prove to us that we're capturing the
> output wanting to strip successive newlines?

I added it as a sanity check originally, but you're right that this is
unnecessary. Thanks for your comments on the other stylistic nits. I've
gone ahead and fixed them all.
