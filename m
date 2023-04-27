Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CFEC77B61
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 23:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344398AbjD0XIP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 19:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344389AbjD0XIL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 19:08:11 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E80E4203
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 16:08:04 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f173af665fso60747255e9.3
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 16:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682636882; x=1685228882;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQWGgkDvpv15sXCl7HdyaVkGj2hpC2lp411B+AUM3kY=;
        b=EzzgGeaq9nNeCKHm4J73vdq4v6mUj9nS9vQEG23vYnb1ulu408c9tJvNIenKaTeatU
         zLNM05sGdV3zh6yBGNgDuX81JcPA4NMGGf7dB2GChWvYqrlrC6xLX3QzaubGXr7b1AXR
         cvdClZ96aaUXWLC4YJsZwKsnlE4UBtJmUoMsp2nyoaHIZ76CLJMf4IzWt93F0BxPVWWV
         09jtXLSO53bkxUH8OgrxCEuXznWV9V2y/3su44aKyqdysWFZfM8Q1ytu1P4ubu6ZA5cq
         bBHhp2J9GluExuG9cuKWpI/oThCT/S3rJ3T8tj8g2vk0zKl9BOmEGwzk9apXO3LX2ZNd
         ot8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682636882; x=1685228882;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cQWGgkDvpv15sXCl7HdyaVkGj2hpC2lp411B+AUM3kY=;
        b=Xu2IuHtmzJdLe4ICZdrXFlv0wYWhVk91piTR8EKHfbMp/9bTh09ShTHGnctjxETimC
         x+vmUIlz/jYiNybec5wReAt9Z1R3LvrQUgUXsE0ownC7nVYAtF6L5S0BpGm7lUtlRKYS
         dMIh7rg2C7E5EmV9UE1UBRXPBQ7EqBtd0SoQXA8e2UmcAWvJbsiZOiRAWxCxLZABvshp
         b2iJhgNXxN5Htrmz3NV/taqpO2f1Q94QDdIZq94BL0RaNxZEmSsxRPKgy+Rs9hhHGWaK
         uTjT9V6HfgODSk8JaqGF2EUPfPKcbll8G85ejJOkTI0Vu8aNS25HnB2l9F+8r59Y0+2g
         fswA==
X-Gm-Message-State: AC+VfDw/G8QnAB0p9HXERKdf583ZCkheLn3aKgrXus8MHSHpPDLVl+b6
        5kREB8hmBroGELSRCMBe2fc=
X-Google-Smtp-Source: ACHHUZ6azo75W078bckQ45fabwkkgMkpAInr0d4CnizROCMVeFBsvyjDNeW3v0/FwGrQAqXiXpvObQ==
X-Received: by 2002:a1c:ed01:0:b0:3ed:2e02:1c02 with SMTP id l1-20020a1ced01000000b003ed2e021c02mr2460924wmh.23.1682636882269;
        Thu, 27 Apr 2023 16:08:02 -0700 (PDT)
Received: from [192.168.2.52] (60.red-88-14-214.dynamicip.rima-tde.net. [88.14.214.60])
        by smtp.gmail.com with ESMTPSA id t26-20020a05600c329a00b003f17f9965a7sm25951424wmp.1.2023.04.27.16.08.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 16:08:01 -0700 (PDT)
Subject: Re: [PATCH 2/3] worktree: warn when removing a worktree with orphan
 commits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <f702476a-543a-da9b-ccd9-4431c80471e1@gmail.com>
 <1897dff1-bb4d-9715-dd1c-86763c052589@gmail.com> <xmqq5y9lc9ep.fsf@gitster.g>
 <51adbbcb-bbfa-58cc-03a4-82809c0c555e@gmail.com> <xmqqwn1xnahy.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <592c7265-c8af-bd3c-561d-be22e34d61d6@gmail.com>
Date:   Fri, 28 Apr 2023 01:08:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqwn1xnahy.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26-abr-2023 22:46:01, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:

The message: "Previous HEAD position was", which we have since dc9195ac78
(Let git-checkout always drop any detached head, 2007-02-03), describes
a detached HEAD that has been left behind.

In 8e2dc6ac06 (commit: give final warning when reattaching HEAD to leave
commits behind, 2011-02-18) we moved this message to a new function,
orphaned_commit_warning().  We still show the message if the HEAD left
behind is detached.  However, if the HEAD left behind is detached _and_
_not connected_ to any ref, instead of the original message, we show a
warning.

In this series, we want to use that function to show the same warning
when the user removes a worktree whose HEAD is detached and _not
connected_ to any ref.  However, if the HEAD is detached but connected,
the original message introduced in dc9195ac78 needs to be adjusted.

> > Maybe "HEAD position was" fits for both usages.  This is how it would
> > look like:
> > ...
> > I think, if there are no objections or better suggestions, I'll re-roll
> > with "HEAD was at". 

This is about the message introduced in dc9195ac78, but...

> But does it convey the more important point?  The reason why "HEAD

I think you are referring to the warning.

Starting from a situation like:

   $ git checkout -b foo
   Switched to a new branch 'foo'

   $ git checkout --detach
   HEAD is now at 47ab99a

   $ git commit --allow-empty -m dangling
   [detached HEAD 398a1b0] dangling

   $ git worktree add --detach foo-wt
   Preparing worktree (detached HEAD 398a1b0)
   HEAD is now at 398a1b0 dangling

If we switch to 'foo' in the current worktree, the message is:

   $ git checkout foo
   Warning: you are leaving 1 commit behind, not connected to
   any of your branches:
   
     398a1b0 dangling 
   
   If you want to keep it by creating a new branch, this may be a good time
   to do so with:
   
    git branch <new-branch-name> 398a1b0
   
   Switched to branch 'foo'

And -- this is what we are adding in this series -- the same message if
we remove the worktree 'foo-wt':

   $ git worktree remove foo-wt
   Warning: you are leaving 1 commit behind, not connected to
   any of your branches:
   
     398a1b0 dangling 
   
   If you want to keep it by creating a new branch, this may be a good time
   to do so with:
   
    git branch <new-branch-name> 398a1b0

> > Maybe "HEAD position was" fits for both usages.  This is how it would
> > look like:
> >
> >    $ git checkout -
> >    HEAD position was 7906992 commit-b
> >    HEAD is now at 2efe05c commit-a
> 
> Here "git checkout" reports the lost HEAD and then the end result.
> 
> >    $ git worktree add test --detach && git worktree remove test
> >    Preparing worktree (detached HEAD 2efe05c)
> >    HEAD is now at 2efe05c commit-a
> >    HEAD position was 2efe05c commit-a

I apologize, the examples were confusing.  I though it was a good idea
to show the new message next to other messages where we also refer to
the HEAD position.
