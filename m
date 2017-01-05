Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B422C1FEB3
	for <e@80x24.org>; Thu,  5 Jan 2017 06:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965401AbdAEGyL (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jan 2017 01:54:11 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:57182 "EHLO
        hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965340AbdAEGwq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jan 2017 01:52:46 -0500
Received: from homiemail-a1.g.dreamhost.com (homie.mail.dreamhost.com [208.97.132.208])
        by hapkido.dreamhost.com (Postfix) with ESMTP id 2544181C4D
        for <git@vger.kernel.org>; Wed,  4 Jan 2017 22:52:46 -0800 (PST)
Received: from homiemail-a1.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id 4543F34806C
        for <git@vger.kernel.org>; Wed,  4 Jan 2017 22:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=bit-booster.com; h=
        mime-version:in-reply-to:references:from:date:message-id:subject
        :to:content-type; s=bit-booster.com; bh=CWsJswx5cZKkR5w2xr+LHglH
        BGw=; b=XuXCJjqWdPuakfyN2t3lrZC8jETYfTogGNsttMEVFwf0kPxwwqE2NIKF
        kdXypms1hvHMv6ZBB0i3khxCK0BIV3tj6otGfgeaf82gSvvv2WhhPrh4tTNllVSd
        y3gTr2vlKPXFprJsaGMMr+qASshpfMd7CgNTdD8CT56brusanPY=
Received: from mail-yw0-f180.google.com (mail-yw0-f180.google.com [209.85.161.180])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sylvie@bit-booster.com)
        by homiemail-a1.g.dreamhost.com (Postfix) with ESMTPSA id 2C1E9348062
        for <git@vger.kernel.org>; Wed,  4 Jan 2017 22:52:45 -0800 (PST)
Received: by mail-yw0-f180.google.com with SMTP id r204so335358468ywb.0
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 22:52:45 -0800 (PST)
X-Gm-Message-State: AIkVDXJZBcnUnsBqU1Kg0uHvaJ83+mxYhzoay1SLc22lYGEgpugzTIE867OjHfjMh3/hRPd4FfRGV7a5f2hMxA==
X-Received: by 10.13.253.6 with SMTP id n6mr71056994ywf.26.1483599164561; Wed,
 04 Jan 2017 22:52:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.56.132 with HTTP; Wed, 4 Jan 2017 22:52:44 -0800 (PST)
In-Reply-To: <CAAj3zPz-jMVoxNTRZ0iR1ZPTFh873gEo33QjynBE1vaHsMmg3A@mail.gmail.com>
References: <CAAj3zPz-jMVoxNTRZ0iR1ZPTFh873gEo33QjynBE1vaHsMmg3A@mail.gmail.com>
From:   "G. Sylvie Davies" <sylvie@bit-booster.com>
Date:   Wed, 4 Jan 2017 22:52:44 -0800
X-Gmail-Original-Message-ID: <CAAj3zPx4uMXhV7t86Cnn8SgmpXb2SGththYN7sHetOqL_JosMg@mail.gmail.com>
Message-ID: <CAAj3zPx4uMXhV7t86Cnn8SgmpXb2SGththYN7sHetOqL_JosMg@mail.gmail.com>
Subject: Re: RFC: --force-with-lease default behaviour
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 4, 2017 at 6:34 PM, G. Sylvie Davies <sylvie@bit-booster.com> wrote:
> Right now the default variant does this:
>
>> --force-with-lease alone, without specifying the details, will protect all remote refs that are going to be updated by requiring their current value to be the same as the remote-tracking branch we have for them.
>
> The problem is people sometimes run "git fetch".   And so "git push
> --force-with-lease" is going to do the push even if the local version
> is stale.
>
> Instead I think the default behavior should require that the remote
> ref's current value be equal to the merge-base of the local-branch and
> remote-tracking-branch.
>
> Here's an example (password is "test" for the push):
>
> git clone http://test@vm.bit-booster.com/bitbucket/scm/bb/a.git
> cd a
> git checkout bugfix/TKT-123
> git reset --hard HEAD~1   (to simulate situation where local is stale,
> but remote is up to date)
>
> At this point "git push --force-with-lease" is going to work.   But I
> think it shouldn't.   (Note: I use push.default = simple).
>
> Here's how I think it should work:
>
> git push --force-with-lease=bugfix/TKT-123:$(git merge-base HEAD
> origin/bugfix/TKT-123)
> To http://vm.bit-booster.com/bitbucket/scm/bb/a.git
>  ! [rejected]        bugfix/TKT-123 -> bugfix/TKT-123 (stale info)
>
>
> For now I'm happy with this alias:
>
> git config --global alias.please '!sh -c "git push
> --force-with-lease=$(git rev-parse --abbrev-ref HEAD):$(git merge-base
> HEAD @{u})"'
>

Nevermind!   I realize this essentially removes the "--force" and
turns it into the original non-forced "fast-forwardable" only style
push.   [BLUSH!]

I wonder if there's anything one could do to help those who type "git
fetch" and still want to enjoy "--force-with-lease"...


> But I'd like to put together a patch if people are interested in a
> tweak like this to the --force-with-lease default behaviour.  I
> haven't written much C in my life, but thought this might make a good
> force-myself-to-learn-C exercise.
>
>
> - Sylvie Davies
>
> ps.  I never thought about the fetch problem with --force-with-lease
> until reading https://developer.atlassian.com/blog/2015/04/force-with-lease/
> and https://buddyreno.me/git-please-a182f28efeb5#.s291gh5jn , so
> thanks to them!
