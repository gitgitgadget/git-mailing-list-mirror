Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18039C77B61
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 10:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjDXKt7 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 24 Apr 2023 06:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjDXKt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 06:49:57 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86960B7
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 03:49:56 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-74e1aec175eso203517585a.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 03:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682333395; x=1684925395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A1xcDY+njwwgvcCxCotcjLV9+ci/NOxQqw9CX3k7gtA=;
        b=HV/XPMUu6LYlTqArq7RD0RqX1BprNN4rDTiZ63+LeLdqSAhwoRc4y2dx7eMBVifDYR
         7lwC5LbkOV2V84FESTmLGPKZB09OG6sbZEoCq3z8xGp2cZeyOr2KLd1bK3Y+uB2oj2cx
         jRC4WrhzBN/nHNsNj3tYNgHSfqFpUqNk7rbwU3n9NQIRNq2EFGAkfJU30eUncVZCC1M4
         IKmqDBaspTbmNsduqQzjVjSyrB5t87DdjlCI0KizvtUVsDSC0wbY/wthg157H6k0AjUZ
         na4JQkdK5/O50LJ6FCwTPC6Ns5yNKYJTIQxseZsx9/AsrKndkkDDyySZF/YRre1FKLPC
         uRHw==
X-Gm-Message-State: AAQBX9eZeQv2yUog9dLBzg/jkgqrwDOEi3aNEiSyX/ex7C/y2UnmBjQB
        fC7Mw5ao/wQxnBKLACG3TC3GDmFOOPc+6ndKuNc=
X-Google-Smtp-Source: AKy350Z4kvqpJ2YskPTyrGJk60oTib2/kmCeqXc0QJG2rTu5Q0PybHUK3is57I5Ojyjdx9JfFIrXArbrhRnyqJ3DsRg=
X-Received: by 2002:ac8:5884:0:b0:3f0:a3b6:7c32 with SMTP id
 t4-20020ac85884000000b003f0a3b67c32mr1858483qta.46.1682333395599; Mon, 24 Apr
 2023 03:49:55 -0700 (PDT)
MIME-Version: 1.0
References: <8fe188a9-c01f-9fb5-5877-8ff508094b22@game-point.net>
 <CAPx1Gvdc6bqzt2PpqD1Z4e5w+b=8gZhUSyfUQC1n8QazdBacEw@mail.gmail.com> <74a361fd-4ee6-f362-8d49-92417f0e2dac@game-point.net>
In-Reply-To: <74a361fd-4ee6-f362-8d49-92417f0e2dac@game-point.net>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Mon, 24 Apr 2023 12:49:19 +0200
Message-ID: <CA+JQ7M-1YvZFzE_CtBQa5_eEXa1sPqK4xsTxdwpAQo_YcmW+-A@mail.gmail.com>
Subject: Re: Proposal: tell git a file has been renamed
To:     Jeremy Morton <admin@game-point.net>
Cc:     Chris Torek <chris.torek@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 24, 2023 at 12:21 PM Jeremy Morton <admin@game-point.net> wrote:
>
> I'm surprised --follow isn't the default, actually... isn't the whole
> point of detecting renames to allow content history to be tracked back
> through renames?

You can set log to --follow by default
  If true, git log will act as if the --follow option was used when a
single <path> is given.
  This has the same limitations as --follow, i.e. it cannot be used to
follow multiple files
  and does not work well on non-linear history.
  https://git-scm.com/docs/git-log#Documentation/git-log.txt-logfollow

The reason it's not default is probably those limitations.

>
> Another one that jumped to mind for me is bisect.  As rename-only
> commits are liable to create broken builds, it should skip over them
> to the 'content' commit.
>

I always find this to be the main dilemma.
I try to make commits as discrete changes but it's not always possible
with renames.
Sometimes, renaming a file changes it so much that the rename
detection doesn't work by default.
There are also other problems that arise when reordering commits and
changes in a feature branch.
I've found that the safest thing is to split renames out into discrete
commits and only do 100% renames.
